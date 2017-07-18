Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37681 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbdGROQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2017 10:16:31 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Jul 2017 09:06:50 -0500
Message-ID: <20170718140651.15973-6-ebiederm@xmission.com>
In-Reply-To: <87o9shg7t7.fsf_-_@xmission.com>
References: <87o9shg7t7.fsf_-_@xmission.com>
Subject: [PATCH 6/7] fcntl: Don't use ambiguous SIG_POLL si_codes
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20170718140650.Me9O0CWqJAFoEBAp_0k4TB0eKUsQPMkMcQJxgSX7qmA@z>

We have a weird and problematic intersection of features that when
they all come together result in ambiguous siginfo values, that
we can not support properly.

- Supporting fcntl(F_SETSIG,...) with arbitrary valid signals.

- Using positive values for POLL_IN, POLL_OUT, POLL_MSG, ..., etc
  that imply they are signal specific si_codes and using the
  aforementioned arbitrary signal to deliver them.

- Supporting injection of arbitrary siginfo values for debugging and
  checkpoint/restore.

The result is that just looking at siginfo si_codes of 1 to 6 are
ambigious.  It could either be a signal specific si_code or it could
be a generic si_code.

For most of the kernel this is a non-issue but for sending signals
with siginfo it is impossible to play back the kernel signals and
get the same result.

Strictly speaking when the si_code was changed from SI_SIGIO to
POLL_IN and friends between 2.2 and 2.4 this functionality was not
ambiguous, as only real time signals were supported.  Before 2.4 was
released the kernel began supporting siginfo with non realtime signals
so they could give details of why the signal was sent.

The result is that if F_SETSIG is set to one of the signals with signal
specific si_codes then user space can not know why the signal was sent.

I grepped through a bunch of userspace programs using debian code
search to get a feel for how often people choose a signal that results
in an ambiguous si_code.  I only found one program doing so and it was
using SIGCHLD to test the F_SETSIG functionality, and did not appear
to be a real world usage.

Therefore the ambiguity does not appears to be a real world problem in
practice.  Remove the ambiguity while introducing the smallest chance
of breakage by changing the si_code to SI_SIGIO when signals with
signal specific si_codes are targeted.

Fixes: v2.3.40 -- Added support for queueing non-rt signals
Fixes: v2.3.21 -- Changed the si_code from SI_SIGIO
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fcntl.c                         | 13 ++++++++++++-
 include/linux/signal.h             |  8 ++++++++
 include/uapi/asm-generic/siginfo.h |  4 ++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3b01b646e528..cfee2e084dbb 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -741,10 +741,21 @@ static void send_sigio_to_task(struct task_struct *p,
 			si.si_signo = signum;
 			si.si_errno = 0;
 		        si.si_code  = reason;
+			/*
+			 * Posix definies POLL_IN and friends to be signal
+			 * specific si_codes for SIG_POLL.  Linux extended
+			 * these si_codes to other signals in a way that is
+			 * ambiguous if other signals also have signal
+			 * specific si_codes.  In that case use SI_SIGIO instead
+			 * to remove the ambiguity.
+			 */
+			if (sig_specific_sicodes(signum))
+				si.si_code = SI_SIGIO;
+
 			/* Make sure we are called with one of the POLL_*
 			   reasons, otherwise we could leak kernel stack into
 			   userspace.  */
-			BUG_ON((reason & __SI_MASK) != __SI_POLL);
+			BUG_ON((reason < POLL_IN) || (reason > NSIGPOLL));
 			if (reason - POLL_IN >= NSIGPOLL)
 				si.si_band  = ~0L;
 			else
diff --git a/include/linux/signal.h b/include/linux/signal.h
index e2678b5dbb21..c97cc20369c0 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -380,10 +380,18 @@ int unhandled_signal(struct task_struct *tsk, int sig);
         rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
 	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
 
+#define SIG_SPECIFIC_SICODES_MASK (\
+	rt_sigmask(SIGILL)    |  rt_sigmask(SIGFPE)    | \
+	rt_sigmask(SIGSEGV)   |  rt_sigmask(SIGBUS)    | \
+	rt_sigmask(SIGTRAP)   |  rt_sigmask(SIGCHLD)   | \
+	rt_sigmask(SIGPOLL)   |  rt_sigmask(SIGSYS)    | \
+	SIGEMT_MASK                                    )
+
 #define sig_kernel_only(sig)		siginmask(sig, SIG_KERNEL_ONLY_MASK)
 #define sig_kernel_coredump(sig)	siginmask(sig, SIG_KERNEL_COREDUMP_MASK)
 #define sig_kernel_ignore(sig)		siginmask(sig, SIG_KERNEL_IGNORE_MASK)
 #define sig_kernel_stop(sig)		siginmask(sig, SIG_KERNEL_STOP_MASK)
+#define sig_specific_sicodes(sig)	siginmask(sig, SIG_SPECIFIC_SICODES_MASK)
 
 #define sig_fatal(t, signr) \
 	(!siginmask(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 9c4eca6b374a..9e956ea94d57 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -184,7 +184,7 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ,-3) /* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_SIGIO __SI_CODE(__SI_POLL,-5) /* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
 #define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
 
@@ -259,7 +259,7 @@ typedef struct siginfo {
 #define NSIGCHLD	6
 
 /*
- * SIGPOLL si_codes
+ * SIGPOLL (or any other signal without signal specific si_codes) si_codes
  */
 #define POLL_IN		(__SI_POLL|1)	/* data input available */
 #define POLL_OUT	(__SI_POLL|2)	/* output buffers available */
-- 
2.10.1
