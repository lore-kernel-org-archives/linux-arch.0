Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:4262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965418AbWJCH1n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2006 03:27:43 -0400
Date: Tue, 3 Oct 2006 00:27:28 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: epoll_pwait
Message-Id: <20061003002728.01133537.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Davide Libenzi <davidel@xmailserver.org>, David Woodhouse <dwmw2@infradead.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>
List-ID: <linux-arch.vger.kernel.org>



I'm about to send this Linuswards.  Architectures which implement
TIF_RESTORE_SIGMASK can wire it up.

David, do you have a test app which people can use?

Thanks.


From: Davide Libenzi <davidel@xmailserver.org>

Implement the epoll_pwait system call, that extend the event wait mechanism
with the same logic ppoll and pselect do.  The definition of epoll_pwait
is:

int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
                 int timeout, const sigset_t *sigmask, size_t sigsetsize);

The difference between the vanilla epoll_wait and epoll_pwait is that the
latter allows the caller to specify a signal mask to be set while waiting
for events.  Hence epoll_pwait will wait until either one monitored event,
or an unmasked signal happen.  If sigmask is NULL, the epoll_pwait system
call will act exactly like epoll_wait.  For the POSIX definition of
pselect, information is available here:

http://www.opengroup.org/onlinepubs/009695399/functions/select.html

Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <ak@muc.de>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: Roland McGrath <roland@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/syscall_table.S |    1 
 fs/eventpoll.c                   |   55 +++++++++++++++++++++++++++--
 include/asm-i386/unistd.h        |    3 +
 include/linux/syscalls.h         |    3 +
 4 files changed, 58 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/syscall_table.S~epoll_pwait arch/i386/kernel/syscall_table.S
--- a/arch/i386/kernel/syscall_table.S~epoll_pwait
+++ a/arch/i386/kernel/syscall_table.S
@@ -318,3 +318,4 @@ ENTRY(sys_call_table)
 	.long sys_vmsplice
 	.long sys_move_pages
 	.long sys_getcpu
+	.long sys_epoll_pwait
diff -puN fs/eventpoll.c~epoll_pwait fs/eventpoll.c
--- a/fs/eventpoll.c~epoll_pwait
+++ a/fs/eventpoll.c
@@ -105,6 +105,8 @@
 /* Maximum msec timeout value storeable in a long int */
 #define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ)
 
+#define EP_MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))
+
 
 struct epoll_filefd {
 	struct file *file;
@@ -497,7 +499,7 @@ void eventpoll_release_file(struct file 
  */
 asmlinkage long sys_epoll_create(int size)
 {
-	int error, fd;
+	int error, fd = -1;
 	struct eventpoll *ep;
 	struct inode *inode;
 	struct file *file;
@@ -640,7 +642,6 @@ eexit_1:
 	return error;
 }
 
-#define MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))
 
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
@@ -657,7 +658,7 @@ asmlinkage long sys_epoll_wait(int epfd,
 		     current, epfd, events, maxevents, timeout));
 
 	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0 || maxevents > MAX_EVENTS)
+	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
 		return -EINVAL;
 
 	/* Verify that the area passed by the user is writeable */
@@ -699,6 +700,54 @@ eexit_1:
 }
 
 
+#ifdef TIF_RESTORE_SIGMASK
+
+/*
+ * Implement the event wait interface for the eventpoll file. It is the kernel
+ * part of the user space epoll_pwait(2).
+ */
+asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout, const sigset_t __user *sigmask,
+				size_t sigsetsize)
+{
+	int error;
+	sigset_t ksigmask, sigsaved;
+
+	/*
+	 * If the caller wants a certain signal mask to be set during the wait,
+	 * we apply it here.
+	 */
+	if (sigmask) {
+		if (sigsetsize != sizeof(sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
+			return -EFAULT;
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
+
+#endif /* #ifdef TIF_RESTORE_SIGMASK */
+
+
 /*
  * Creates the file descriptor to be used by the epoll interface.
  */
diff -puN include/asm-i386/unistd.h~epoll_pwait include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h~epoll_pwait
+++ a/include/asm-i386/unistd.h
@@ -324,10 +324,11 @@
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
 #define __NR_getcpu		318
+#define __NR_epoll_pwait	319
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 319
+#define NR_syscalls 320
 #include <linux/err.h>
 
 /*
diff -puN include/linux/syscalls.h~epoll_pwait include/linux/syscalls.h
--- a/include/linux/syscalls.h~epoll_pwait
+++ a/include/linux/syscalls.h
@@ -431,6 +431,9 @@ asmlinkage long sys_epoll_ctl(int epfd, 
 				struct epoll_event __user *event);
 asmlinkage long sys_epoll_wait(int epfd, struct epoll_event __user *events,
 				int maxevents, int timeout);
+asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout, const sigset_t __user *sigmask,
+				size_t sigsetsize);
 asmlinkage long sys_gethostname(char __user *name, int len);
 asmlinkage long sys_sethostname(char __user *name, int len);
 asmlinkage long sys_setdomainname(char __user *name, int len);
_

