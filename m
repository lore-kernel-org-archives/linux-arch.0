Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:41510 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030289AbXBUDKK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Feb 2007 22:10:10 -0500
Date: Wed, 21 Feb 2007 14:10:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH]add epoll compat code to fsl/compat.c
Message-Id: <20070221141040.1807a368.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
	<20070221102027.52bf703a.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
	<20070221120145.419a03ee.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

From: Davide Libenzi <davidel@xmailserver.org>

Add epoll compat_ code to fs/compat.c.  IA64 and ARM-OABI are
currently using their own version of epoll compat_ code.

An architecture needs epoll_event translation if alignof(u64) in 32 bit
mode is different from alignof(u64) in 64 bit mode.  If an architecture
needs epoll_event translation, it must define struct compat_epoll_event
in asm/compat.h, set CONFIG_HAVE_COMPAT_EPOLL_EVENT and use
compat_sys_epoll_ctl and compat_sys_epoll_wait.  I suspect that the only
architecture that needs CONFIG_HAVE_COMPAT_EPOLL_EVENT is IA64.

All 64 bit architecture should use compat_sys_epoll_pwait.

[sfr: restructure and move to fs/compat.c, remove MIPS version
of compat_sys_epoll_pwait]

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/mips/kernel/linux32.c |   46 --------------------
 fs/compat.c                |  100 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h     |   19 ++++++++
 3 files changed, 119 insertions(+), 46 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

On Tue, 20 Feb 2007 17:12:14 -0800 (PST) Davide Libenzi <davidel@xmailserver.org> wrote:
>
> I was thinking something different. Example:
> 
> [include/asm-XXX/compat.h]
> 
> 	struct compat_epoll_event {
> 		...
> 	} ATTR ...;
> 	#define NEED_EPOLL_EVENT_COMPAT 1

I am thinking the same except using CONFIG_HAS_COMPAT_EVENT_POLL
instead.  We seem to be putting stuff like this in Kconfig these days.

> That way we don't have arch-specific (MIPS, IA64, ...) ifdefs inside 
> common code.

The MIPS check was a temporary as I couldn't easily tell if the MIPS one was the same as the generic one.  Since Ralf has blessed it, this version of the patch removes the MIPS one and the checks for CONFIG_MIPS.

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index fc4dd6c..3432be5 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -737,49 +737,3 @@ _sys32_clone(nabi_no_regargs struct pt_regs regs)
 	return do_fork(clone_flags, newsp, &regs, 0,
 	               parent_tidptr, child_tidptr);
 }
-
-/*
- * Implement the event wait interface for the eventpoll file. It is the kernel
- * part of the user space epoll_pwait(2).
- */
-asmlinkage long compat_sys_epoll_pwait(int epfd,
-	struct epoll_event __user *events, int maxevents, int timeout,
-	const compat_sigset_t __user *sigmask, size_t sigsetsize)
-{
-	int error;
-	sigset_t ksigmask, sigsaved;
-
-	/*
-	 * If the caller wants a certain signal mask to be set during the wait,
-	 * we apply it here.
-	 */
-	if (sigmask) {
-		if (sigsetsize != sizeof(sigset_t))
-			return -EINVAL;
-		if (!access_ok(VERIFY_READ, sigmask, sizeof(ksigmask)))
-			return -EFAULT;
-		if (__copy_conv_sigset_from_user(&ksigmask, sigmask))
-			return -EFAULT;
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
-
-	error = sys_epoll_wait(epfd, events, maxevents, timeout);
-
-	/*
-	 * If we changed the signal mask, we need to restore the original one.
-	 * In case we've got a signal while waiting, we do not restore the
-	 * signal mask yet, and we allow do_signal() to deliver the signal on
-	 * the way back to userspace, before the signal mask is restored.
-	 */
-	if (sigmask) {
-		if (error == -EINTR) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-				sizeof(sigsaved));
-			set_thread_flag(TIF_RESTORE_SIGMASK);
-		} else
-			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-	}
-
-	return error;
-}
diff --git a/fs/compat.c b/fs/compat.c
index 0ec70e3..db1752f 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -48,6 +48,7 @@
 #include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
+#include <linux/eventpoll.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -2235,3 +2236,102 @@ long asmlinkage compat_sys_nfsservctl(int cmd, void *notused, void *notused2)
 	return sys_ni_syscall();
 }
 #endif
+
+#ifdef CONFIG_EPOLL
+
+#ifdef CONFIG_HAS_COMPAT_EPOLL_EVENT
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+			struct compat_epoll_event __user *event)
+{
+	long err = 0;
+	struct compat_epoll_event user;
+	struct epoll_event __user *kernel = NULL;
+
+	if (event) {
+		if (copy_from_user(&user, event, sizeof(user)))
+			return -EFAULT;
+		kernel = compat_alloc_user_space(sizeof(struct epoll_event));
+		err |= __put_user(user.events, &kernel->events);
+		err |= __put_user(user.data, &kernel->data);
+	}
+
+	return err ? err : sys_epoll_ctl(epfd, op, fd, kernel);
+}
+
+
+asmlinkage long compat_sys_epoll_wait(int epfd,
+			struct compat_epoll_event __user *events,
+			int maxevents, int timeout)
+{
+	long i, ret, err = 0;
+	struct epoll_event __user *kbuf;
+	struct epoll_event ev;
+
+	if ((maxevents <= 0) ||
+			(maxevents > (INT_MAX / sizeof(struct epoll_event))))
+		return -EINVAL;
+	kbuf = compat_alloc_user_space(sizeof(struct epoll_event) * maxevents);
+	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
+	for (i = 0; i < ret; i++) {
+		err |= __get_user(ev.events, &kbuf[i].events);
+		err |= __get_user(ev.data, &kbuf[i].data);
+		err |= put_user(ev.events, &events->events);
+		err |= put_user(ev.data, &events->data);
+		events++;
+	}
+
+	return err ? -EFAULT: ret;
+}
+#endif	/* CONFIG_HAS_COMPAT_EPOLL_EVENT */
+
+#ifdef TIF_RESTORE_SIGMASK
+asmlinkage long compat_sys_epoll_pwait(int epfd,
+			struct compat_epoll_event __user *events,
+			int maxevents, int timeout,
+			const compat_sigset_t __user *sigmask,
+			compat_size_t sigsetsize)
+{
+	long err;
+	compat_sigset_t csigmask;
+	sigset_t ksigmask, sigsaved;
+
+	/*
+	 * If the caller wants a certain signal mask to be set during the wait,
+	 * we apply it here.
+	 */
+	if (sigmask) {
+		if (sigsetsize != sizeof(compat_sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&csigmask, sigmask, sizeof(csigmask)))
+			return -EFAULT;
+		sigset_from_compat(&ksigmask, &csigmask);
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+#ifdef CONFIG_HAS_COMPAT_EPOLL_EVENT
+	err = compat_sys_epoll_wait(epfd, events, maxevents, timeout);
+#else
+	err = sys_epoll_wait(epfd, events, maxevents, timeout);
+#endif
+
+	/*
+	 * If we changed the signal mask, we need to restore the original one.
+	 * In case we've got a signal while waiting, we do not restore the
+	 * signal mask yet, and we allow do_signal() to deliver the signal on
+	 * the way back to userspace, before the signal mask is restored.
+	 */
+	if (sigmask) {
+		if (err == -EINTR) {
+			memcpy(&current->saved_sigmask, &sigsaved,
+			       sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK);
+		} else
+			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	}
+
+	return err;
+}
+#endif /* TIF_RESTORE_SIGMASK */
+
+#endif /* CONFIG_EPOLL */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 80b17f4..ccd863d 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -234,5 +234,24 @@ asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
 		const compat_ulong_t __user *new_nodes);
 
+/*
+ * epoll (fs/eventpoll.c) compat bits follow ...
+ */
+#ifndef CONFIG_HAS_COMPAT_EPOLL_EVENT
+struct epoll_event;
+#define compat_epoll_event	epoll_event
+#else
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+			struct compat_epoll_event __user *event);
+asmlinkage long compat_sys_epoll_wait(int epfd,
+			struct compat_epoll_event __user *events,
+			int maxevents, int timeout);
+#endif
+asmlinkage long compat_sys_epoll_pwait(int epfd,
+			struct compat_epoll_event __user *events,
+			int maxevents, int timeout,
+			const compat_sigset_t __user *sigmask,
+			compat_size_t sigsetsize);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
-- 
1.4.4.4

