Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267251AbUHZAfp@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:42625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267212AbUHZAdH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:07 -0400
Message-Id: <200408260033.i7Q0X2132155@mail.osdl.org>
Subject: [patch 1/8] signal handling race fix
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:42 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>


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


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/signal.c |   24 ++++++++++--------------
 25-akpm/include/linux/signal.h    |    2 +-
 25-akpm/kernel/signal.c           |   12 ++++++++++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fix arch/i386/kernel/signal.c
--- 25/arch/i386/kernel/signal.c~signal-race-fix	Wed Aug 25 17:13:40 2004
+++ 25-akpm/arch/i386/kernel/signal.c	Wed Aug 25 17:13:40 2004
@@ -340,7 +340,7 @@ extern void __user __kernel_sigreturn;
 extern void __user __kernel_rt_sigreturn;
 
 static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+			sigset_t *set, struct pt_regs *regs)
 {
 	void __user *restorer;
 	struct sigframe __user *frame;
@@ -412,12 +412,12 @@ static void setup_frame(int sig, struct 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame(int sig, struct k_sigaction *ka,
+			siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	void __user *restorer;
 	struct rt_sigframe __user *frame;
@@ -493,7 +493,7 @@ static void setup_rt_frame(int sig, stru
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
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
@@ -534,9 +532,6 @@ handle_signal(unsigned long sig, siginfo
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
@@ -555,6 +550,7 @@ int fastcall do_signal(struct pt_regs *r
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -573,7 +569,7 @@ int fastcall do_signal(struct pt_regs *r
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -583,7 +579,7 @@ int fastcall do_signal(struct pt_regs *r
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 
diff -puN include/linux/signal.h~signal-race-fix include/linux/signal.h
--- 25/include/linux/signal.h~signal-race-fix	Wed Aug 25 17:13:40 2004
+++ 25-akpm/include/linux/signal.h	Wed Aug 25 17:13:40 2004
@@ -217,7 +217,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
diff -puN kernel/signal.c~signal-race-fix kernel/signal.c
--- 25/kernel/signal.c~signal-race-fix	Wed Aug 25 17:13:40 2004
+++ 25-akpm/kernel/signal.c	Wed Aug 25 17:35:08 2004
@@ -1724,7 +1724,8 @@ static inline int handle_group_stop(void
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1793,8 +1794,15 @@ relock:
 		ka = &current->sighand->action[signr-1];
 		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
-		if (ka->sa.sa_handler != SIG_DFL) /* Run the handler.  */
+		if (ka->sa.sa_handler != SIG_DFL) {
+			/* Run the handler.  */
+			*return_ka = *ka;
+
+			if (ka->sa.sa_flags & SA_ONESHOT)
+				ka->sa.sa_handler = SIG_DFL;
+
 			break; /* will return non-zero "signr" value */
+		}
 
 		/*
 		 * Now we are doing the default action for this signal.
_
