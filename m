Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:2000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261159AbUCSUBs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 15:01:48 -0500
Date: Fri, 19 Mar 2004 12:01:51 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: signal-race-fix.patch
Message-Id: <20040319120151.380dcbc9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Corey Minyard <minyard@acm.org>, Roland McGrath <roland@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Kind sirs,

We have an SMP race in the signal code.  A fix for x86 is below.  All archs
need updating.

Could you please send me the arch patches for this when convenient?  Once I
have a decent collection I'll merge it all up.  Or you may choose to wait
until this hits Linus's tree post-2.6.5 sometime.  Up to you.

Thanks.


From: Corey Minyard <minyard@acm.org>

The problem:

  In arch/i386/signal.c, in the do_signal() function, it calls
  get_signal_to_deliver() which returns the signal number to deliver (along
  with siginfo).  get_signal_to_deliver() grabs and releases the lock, so
  the signal handler lock is not held in do_signal().  Then the do_signal()
  calls handle_signal(), which uses the signal number to extract the
  sa_handler, etc.

  Since no lock is held, it seems like another thread with the same
  signal handler set can come in and call sigaction(), it can change
  sa_handler between the call to get_signal_to_deliver() and fetching the
  value of sa_handler.  If the sigaction() call set it to SIG_IGN, SIG_DFL,
  or some other fundamental change, that bad things can happen.

The patch:

  You have to get the sigaction information that will be delivered while
  holding sighand->siglock in get_signal_to_deliver().

  In 2.4, it can be fixed per-arch and requires no change to the
  arch-independent code because the arch fetches the signal with
  dequeue_signal() and does all the checking.

The test app:

  The program below has three threads that share signal handlers.  Thread
  1 changes the signal handler for a signal from a handler to SIG_IGN and
  back.  Thread 0 sends signals to thread 3, which just receives them. 
  What I believe is happening is that thread 1 changes the signal handler
  in the process of thread 3 receiving the signal, between the time that
  thread 3 fetches the signal info using get_signal_to_deliver() and
  actually delivers the signal with handle_signal().

  Although the program is obvously an extreme case, it seems like any
  time you set the handler value of a signal to SIG_IGN or SIG_DFL, you can
  have this happen.  Changing signal attributes might also cause problems,
  although I am not so sure about that.

  (akpm: this test app segv'd on SMP within milliseconds for me)


#include <signal.h>
#include <stdio.h>
#include <sched.h>

char stack1[16384];
char stack2[16384];

void sighnd(int sig)
{
}

int child1(void *data)
{
	struct sigaction act;

	sigemptyset(&act.sa_mask);
	act.sa_flags = 0;
	for (;;) {
		act.sa_handler = sighnd;
		sigaction(45, &act, NULL);
		act.sa_handler = SIG_IGN;
		sigaction(45, &act, NULL);
	}
}

int child2(void *data)
{
	for (;;) {
		sleep(100);
	}
}

int main(int argc, char *argv[])
{
	int pid1, pid2;

	signal(45, SIG_IGN);
	pid2 = clone(child2, stack2 + sizeof(stack2) - 8,
			CLONE_SIGHAND | CLONE_VM, NULL);
	pid1 = clone(child1, stack1 + sizeof(stack2) - 8,
			CLONE_SIGHAND | CLONE_VM, NULL);

	for (;;) {
		kill(pid2, 45);
	}
}



---

 25-akpm/arch/i386/kernel/signal.c |   11 +++++------
 25-akpm/include/linux/signal.h    |    2 +-
 25-akpm/kernel/signal.c           |    8 ++++++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fix arch/i386/kernel/signal.c
--- 25/arch/i386/kernel/signal.c~signal-race-fix	2004-03-19 11:46:01.512324288 -0800
+++ 25-akpm/arch/i386/kernel/signal.c	2004-03-19 11:46:01.530321552 -0800
@@ -502,11 +502,9 @@ give_sigsegv:
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
+	      sigset_t *oldset,	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
@@ -555,6 +553,7 @@ int fastcall do_signal(struct pt_regs *r
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -573,7 +572,7 @@ int fastcall do_signal(struct pt_regs *r
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -583,7 +582,7 @@ int fastcall do_signal(struct pt_regs *r
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 
diff -puN include/linux/signal.h~signal-race-fix include/linux/signal.h
--- 25/include/linux/signal.h~signal-race-fix	2004-03-19 11:46:01.513324136 -0800
+++ 25-akpm/include/linux/signal.h	2004-03-19 11:46:01.518323376 -0800
@@ -213,7 +213,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
diff -puN kernel/signal.c~signal-race-fix kernel/signal.c
--- 25/kernel/signal.c~signal-race-fix	2004-03-19 11:46:01.515323832 -0800
+++ 25-akpm/kernel/signal.c	2004-03-19 11:46:01.529321704 -0800
@@ -1699,7 +1699,8 @@ static inline int handle_group_stop(void
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1768,8 +1769,11 @@ relock:
 		ka = &current->sighand->action[signr-1];
 		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
-		if (ka->sa.sa_handler != SIG_DFL) /* Run the handler.  */
+		if (ka->sa.sa_handler != SIG_DFL) {
+			/* Run the handler.  */
+			*return_ka = *ka;
 			break; /* will return non-zero "signr" value */
+		}
 
 		/*
 		 * Now we are doing the default action for this signal.

_
