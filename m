Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:2301 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423093AbXBUUYz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 15:24:55 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S216F90> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 21 Feb 2007 15:24:51 -0500
Date: Wed, 21 Feb 2007 12:24:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <20070221141040.1807a368.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
 <20070221141040.1807a368.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>


Hi Stephen,

+asmlinkage long compat_sys_epoll_wait(int epfd,
+                       struct compat_epoll_event __user *events,
+                       int maxevents, int timeout)
+{
+       long i, ret, err = 0;
+       struct epoll_event __user *kbuf;
+       struct epoll_event ev;
+
+       if ((maxevents <= 0) ||
+                       (maxevents > (INT_MAX / sizeof(struct 
epoll_event))))
+               return -EINVAL;
+       kbuf = compat_alloc_user_space(sizeof(struct epoll_event) * 
maxevents);
+       ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
+       for (i = 0; i < ret; i++) {
+               err |= __get_user(ev.events, &kbuf[i].events);
+               err |= __get_user(ev.data, &kbuf[i].data);
+               err |= put_user(ev.events, &events->events);
+               err |= put_user(ev.data, &events->data);
+               events++;
+       }
+
+       return err ? -EFAULT: ret;
+}


I don't think we can safely assume that we can access a potentially 
4-bytes aligned u64 on 64 bit architectures that require compat:

	put_user(ev.data, &events->data);

I thought again about the definition of "struct compat_epoll_event" and 
the only cases that we can have, are:

1) 8-bytes "data" member alignment on 32 bit and 64 bit (ie, SPARC)

   -> No need for compat

2) 4-bytes "data" member alignment on 32 bit and 64 bit (ie, X86-64 - 
   forced by "struct epoll_event" definition in eventpoll.h)

   -> No need for compat

3) 4-bytes "data" member alignment on 32 bit and 8-bytes on 64 bit
   (ie, IA-64)

   -> Need compat


So, the only case where we need compat, can be covered by the generic 
"struct compat_epoll_event" definition inside linux/compat.h. If we'd 
instead go for an asm/compat.h definition of "struct compat_epoll_event", 
then we'd probably need to define even special copy functions from/to 
"struct epoll_event" <-> "struct compat_epoll_event".
But that's not necessary IMO since the only case we can have is #3.
How does the patch below look to you (moved stuff to fs/compat.c and using 
CONFIG_HAS_COMPAT_EPOLL_EVENT)?




- Davide



diff -Nru linux-2.6.20/fs/compat.c linux-2.6.20.mod/fs/compat.c
--- linux-2.6.20/fs/compat.c	2007-02-21 11:47:00.000000000 -0800
+++ linux-2.6.20.mod/fs/compat.c	2007-02-21 12:04:26.000000000 -0800
@@ -48,6 +48,7 @@
 #include <linux/highmem.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
+#include <linux/eventpoll.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -2235,3 +2236,119 @@
 	return sys_ni_syscall();
 }
 #endif
+
+
+#ifdef CONFIG_EPOLL
+
+/*
+ * epoll (fs/eventpoll.c) compat functions follow ...
+ */
+
+#ifdef CONFIG_HAS_COMPAT_EPOLL_EVENT
+
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+		struct compat_epoll_event __user *event)
+{
+	long err = 0;
+	struct compat_epoll_event user;
+	struct epoll_event __user *kernel = NULL;
+	union {
+		u64 q;
+		u32 d[2];
+	} mux;
+
+	if (event) {
+		if (copy_from_user(&user, event, sizeof(user)))
+			return -EFAULT;
+		kernel = compat_alloc_user_space(sizeof(struct epoll_event));
+		err |= __put_user(user.events, &kernel->events);
+		mux.d[0] = user.data[0];
+		mux.d[1] = user.data[1];
+		err |= __put_user(mux.q, &kernel->data);
+	}
+	
+	return err ? err: sys_epoll_ctl(epfd, op, fd, kernel);
+}
+
+asmlinkage long compat_sys_epoll_wait(int epfd, struct compat_epoll_event __user *events,
+		int maxevents, int timeout)
+{
+	long i, ret, err = 0;
+	struct epoll_event __user *kbuf;
+	struct epoll_event ev;
+	union {
+		u64 q;
+		u32 d[2];
+	} mux;
+
+	if (maxevents <= 0 || maxevents > (INT_MAX / sizeof(struct epoll_event)))
+		return -EINVAL;
+	kbuf = compat_alloc_user_space(sizeof(struct epoll_event) * maxevents);
+	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
+	for (i = 0; i < ret; i++) {
+		err |= __get_user(ev.events, &kbuf[i].events);
+		err |= __get_user(ev.data, &kbuf[i].data);
+		err |= put_user(ev.events, &events->events);
+		mux.q = ev.data;
+		err |= put_user(mux.d[0], &events->data[0]);
+		err |= put_user(mux.d[1], &events->data[1]);
+		events++;
+	}
+
+	return err ? -EFAULT: ret;	
+}
+
+#endif /* CONFIG_HAS_COMPAT_EPOLL_EVENT */
+
+#ifdef TIF_RESTORE_SIGMASK
+
+asmlinkage long compat_sys_epoll_pwait(int epfd, struct compat_epoll_event __user *events,
+		int maxevents, int timeout, const compat_sigset_t __user *sigmask,
+		compat_size_t sigsetsize)
+{
+	long err;
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
+	 * signal mask yet, and we allow do_signal() to deliver the signal on the way 
+	 * back to userspace, before the signal mask is restored.
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
+
+#endif /* TIF_RESTORE_SIGMASK */
+
+#endif /* CONFIG_EPOLL */
+
diff -Nru linux-2.6.20/include/linux/compat.h linux-2.6.20.mod/include/linux/compat.h
--- linux-2.6.20/include/linux/compat.h	2007-02-09 16:14:20.000000000 -0800
+++ linux-2.6.20.mod/include/linux/compat.h	2007-02-21 12:06:04.000000000 -0800
@@ -234,5 +234,32 @@
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
 		const compat_ulong_t __user *new_nodes);
 
+/*
+ * epoll (fs/eventpoll.c) compat bits follow ...
+ */
+struct epoll_event;
+
+#ifdef CONFIG_HAS_COMPAT_EPOLL_EVENT
+
+struct compat_epoll_event {
+	u32 events;
+	u32 data[2];
+};
+
+asmlinkage long compat_sys_epoll_ctl(int epfd, int op, int fd,
+		struct compat_epoll_event __user *event);
+asmlinkage long compat_sys_epoll_wait(int epfd, struct compat_epoll_event __user *events,
+		int maxevents, int timeout);
+
+#else /* CONFIG_HAS_COMPAT_EPOLL_EVENT */
+
+#define compat_epoll_event epoll_event
+
+#endif /* CONFIG_HAS_COMPAT_EPOLL_EVENT */
+
+asmlinkage long compat_sys_epoll_pwait(int epfd, struct compat_epoll_event __user *events,
+		int maxevents, int timeout, const compat_sigset_t __user *sigmask,
+		compat_size_t sigsetsize);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
