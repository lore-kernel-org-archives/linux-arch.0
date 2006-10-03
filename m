Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:61655 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965455AbWJCImd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Oct 2006 04:42:33 -0400
Subject: Re: epoll_pwait
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1159862233.3438.45.camel@pmac.infradead.org>
References: <20061003002728.01133537.akpm@osdl.org>
	 <1159862233.3438.45.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 09:42:29 +0100
Message-Id: <1159864949.3438.55.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-10-03 at 08:57 +0100, David Woodhouse wrote:
> On Tue, 2006-10-03 at 00:27 -0700, Andrew Morton wrote:
> > 
> > I'm about to send this Linuswards.  Architectures which implement
> > TIF_RESTORE_SIGMASK can wire it up.
> 
> It needs compat_sys_epoll_wait() for the signal stuff though.

Something like the patch below ought to suffice, although it's not
tested further than just building it.

----
[PATCH] Provide compat_sys_epoll_pwait(), wire up on PowerPC.

Also add a comment trying to make sense of the definition of
struct epoll_event.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff -u a/fs/eventpoll.c b/fs/eventpoll.c
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -35,6 +35,7 @@
 #include <linux/mount.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/compat.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -745,6 +746,53 @@
 	return error;
 }
 
+#ifdef CONFIG_COMPAT
+extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
+
+asmlinkage long compat_sys_epoll_pwait(int epfd, struct epoll_event __user *events,
+				       int maxevents, int timeout,
+				       const compat_sigset_t __user *sigmask,
+				       compat_size_t sigsetsize)
+{
+	int error;
+	compat_sigset_t ss32;
+	sigset_t ksigmask, sigsaved;
+
+	/*
+	 * If the caller wants a certain signal mask to be set during the wait,
+	 * we apply it here.
+	 */
+	if (sigmask) {
+		if (sigsetsize != sizeof(compat_sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ss32, sigmask, sizeof(ss32)))
+			return -EFAULT;
+		sigset_from_compat(&ksigmask, &ss32);
+
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	error = sys_epoll_wait(epfd, events, maxevents, timeout);
+
+	/*
+	 * If we changed the signal mask, we need to restore the original one.
+	 * In case we've got a signal while waiting, we do not restore the signal
+	 * mask yet, and we allow do_signal() to deliver the signal on the way back
+	 * to userspace, before the signal mask is restored.
+	 */
+	if (sigmask) {
+		if (error == -EINTR) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		} else
+			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	}
+
+	return error;
+}
+#endif /* CONFIG_COMPAT */
+
 #endif /* #ifdef TIF_RESTORE_SIGMASK */
 
 
only in patch2:
unchanged:
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -304,3 +304,4 @@ SYSCALL_SPU(fchmodat)
 SYSCALL_SPU(faccessat)
 COMPAT_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
+COMPAT_SYS(epoll_pwait)
only in patch2:
unchanged:
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -323,10 +323,11 @@ #define __NR_fchmodat		297
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_epoll_pwait	301
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		301
+#define __NR_syscalls		302
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
only in patch2:
unchanged:
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -29,8 +29,11 @@ #define EPOLLONESHOT (1 << 30)
 #define EPOLLET (1 << 31)
 
 /* 
- * On x86-64 make the 64bit structure have the same alignment as the
- * 32bit structure. This makes 32bit emulation easier.
+ * On i386, the u64 won't be aligned to 64-bits. So on x86_64 we pack
+ * the structure to be compatible. It seems that other 32-bit architectures
+ * will align the u64 naturally anyway, so we don't have to worry there.
+ * For example, both ppc and ppc64 put an extra 32 bits of padding in 
+ * between the fields.
  */
 #ifdef __x86_64__
 #define EPOLL_PACKED __attribute__((packed))


-- 
dwmw2

