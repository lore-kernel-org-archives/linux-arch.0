Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266138AbUHYV5w@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:59346 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269114AbUHYVb6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:31:58 -0400
Message-Id: <200408252131.i7PLVl129140@mail.osdl.org>
Subject: [patch 1/8] signal handling race fix
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:30:03 -0700
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

 25-akpm/arch/i386/kernel/signal.c |   64 +++++++++++++++++---------------------
 25-akpm/include/linux/signal.h    |    2 -
 25-akpm/kernel/signal.c           |   12 +++++--
 3 files changed, 41 insertions(+), 37 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fix arch/i386/kernel/signal.c
--- 25/arch/i386/kernel/signal.c~signal-race-fix	2004-08-25 14:26:46.505625576 -0700
+++ 25-akpm/arch/i386/kernel/signal.c	2004-08-25 14:26:46.513624360 -0700
@@ -311,7 +311,7 @@ setup_sigcontext(struct sigcontext __use
  * Determine which stack to use..
  */
 static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka_copy, struct pt_regs * regs, size_t frame_size)
 {
 	unsigned long esp;
 
@@ -319,16 +319,16 @@ get_sigframe(struct k_sigaction *ka, str
 	esp = regs->esp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ka_copy->sa.sa_flags & SA_ONSTACK) {
 		if (sas_ss_flags(esp) == 0)
 			esp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
 	/* This is the legacy signal stack switching. */
 	else if ((regs->xss & 0xffff) != __USER_DS &&
-		 !(ka->sa.sa_flags & SA_RESTORER) &&
-		 ka->sa.sa_restorer) {
-		esp = (unsigned long) ka->sa.sa_restorer;
+		 !(ka_copy->sa.sa_flags & SA_RESTORER) &&
+		 ka_copy->sa.sa_restorer) {
+		esp = (unsigned long) ka_copy->sa.sa_restorer;
 	}
 
 	return (void __user *)((esp - frame_size) & -8ul);
@@ -339,14 +339,14 @@ get_sigframe(struct k_sigaction *ka, str
 extern void __user __kernel_sigreturn;
 extern void __user __kernel_rt_sigreturn;
 
-static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static void setup_frame(int sig, struct k_sigaction *ka_copy,
+			sigset_t *set, struct pt_regs *regs)
 {
 	void __user *restorer;
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -372,8 +372,8 @@ static void setup_frame(int sig, struct 
 		goto give_sigsegv;
 
 	restorer = &__kernel_sigreturn;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER)
+		restorer = ka_copy->sa.sa_restorer;
 
 	/* Set up to return from userspace.  */
 	err |= __put_user(restorer, &frame->pretcode);
@@ -394,7 +394,7 @@ static void setup_frame(int sig, struct 
 
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
-	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eip = (unsigned long) ka_copy->sa.sa_handler;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;
@@ -412,18 +412,18 @@ static void setup_frame(int sig, struct 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame(int sig, struct k_sigaction *ka_copy,
+			siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	void __user *restorer;
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -455,8 +455,8 @@ static void setup_rt_frame(int sig, stru
 
 	/* Set up to return from userspace.  */
 	restorer = &__kernel_rt_sigreturn;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER)
+		restorer = ka_copy->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
 	 
 	/*
@@ -475,7 +475,7 @@ static void setup_rt_frame(int sig, stru
 
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
-	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eip = (unsigned long) ka_copy->sa.sa_handler;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;
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
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka_copy,
+	      sigset_t *oldset,	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
@@ -517,7 +515,7 @@ handle_signal(unsigned long sig, siginfo
 				break;
 
 			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
+				if (!(ka_copy->sa.sa_flags & SA_RESTART)) {
 					regs->eax = -EINTR;
 					break;
 				}
@@ -529,17 +527,14 @@ handle_signal(unsigned long sig, siginfo
 	}
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
+	if (ka_copy->sa.sa_flags & SA_SIGINFO)
+		setup_rt_frame(sig, ka_copy, info, oldset, regs);
 	else
-		setup_frame(sig, ka, oldset, regs);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		setup_frame(sig, ka_copy, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,&ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -555,6 +550,7 @@ int fastcall do_signal(struct pt_regs *r
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka_copy;
 
 	/*
 	 * We want the common case to go fast, which
@@ -573,7 +569,7 @@ int fastcall do_signal(struct pt_regs *r
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -583,7 +579,7 @@ int fastcall do_signal(struct pt_regs *r
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka_copy, oldset, regs);
 		return 1;
 	}
 
diff -puN include/linux/signal.h~signal-race-fix include/linux/signal.h
--- 25/include/linux/signal.h~signal-race-fix	2004-08-25 14:26:46.507625272 -0700
+++ 25-akpm/include/linux/signal.h	2004-08-25 14:26:46.513624360 -0700
@@ -217,7 +217,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
diff -puN kernel/signal.c~signal-race-fix kernel/signal.c
--- 25/kernel/signal.c~signal-race-fix	2004-08-25 14:26:46.508625120 -0700
+++ 25-akpm/kernel/signal.c	2004-08-25 14:26:46.515624056 -0700
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
