Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:58790 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112AbXBUBBN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Feb 2007 20:01:13 -0500
Date: Wed, 21 Feb 2007 12:01:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
Message-Id: <20070221120145.419a03ee.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
	<20070221102027.52bf703a.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

Hi Davide,

> Reminder for Andrew ...
> We talked about having an asm/compat.h define the proper 
> compat_epoll_event structure, and having a define in there that triggers 
> the proper code inside kernel/compat.c. It looks like the better way to 
> go, as Stephen suggested.
> If that's accepted by everyone, I can go ahead and make a patch. Lemme 
> know ...

Like below?  I did the above and moved the code to fs/compat.c (from
kernel/compat.c).  Also MIPS already has a compat_sys_epoll_pwait, so I
had to add an #ifndef CONFIG_MIPS.

Compile tested on PowerPC.  No architectures are wired up yet.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Davide Libenzi <davidel@xmailserver.org>

Add epoll compat_ code to kernel/compat.c.  IA64 and ARM-OABI are
currently using their own version of epoll compat_ code.

An architecture needs epoll_event translation if alignof(u64) in 32 bit
mode is different from alignof(u64) in 64 bit mode.  If an architecture
needs epoll_event translation, it must define struct compat_epoll_event
in asm/compat.h and set CONFIG_HAVE_COMPAT_EPOLL_EVENT and use
compat_sys_epoll_ctl and compat_sys_epoll_wait.

All 64 bit architecture should use compat_sys_epoll_pwait.

[sfr: restructure and move to fs/compat.c]

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/compat.c            |  102 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h |   20 +++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 0ec70e3..ace84d5 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -48,6 +48,7 @@
 #include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
+#include <linux/eventpoll.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -2235,3 +2236,104 @@ long asmlinkage compat_sys_nfsservctl(int cmd, void *notused, void *notused2)
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
+#ifndef CONFIG_MIPS
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
+#endif /* !CONFIG_MIPS */
+
+#endif /* CONFIG_EPOLL */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 80b17f4..de4ba81 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -234,5 +234,25 @@ asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
 		const compat_ulong_t __user *new_nodes);
 
+/*
+ * epoll (fs/eventpoll.c) compat bits follow ...
+ */
+struct epoll_event;
+
+#ifndef CONFIG_HAS_COMPAT_EPOLL_EVENT
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

