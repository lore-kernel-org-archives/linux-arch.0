Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:24457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262435AbUCWKUb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 05:20:31 -0500
Date: Tue, 23 Mar 2004 02:20:20 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: signal-race-fix.patch
Message-Id: <20040323022020.3972af1d.akpm@osdl.org>
In-Reply-To: <405B8BE5.4070602@acm.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
	<20040319154928.3b2d8820.davem@redhat.com>
	<405B8BE5.4070602@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: davem@redhat.com, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Corey Minyard <minyard@acm.org> wrote:
>
> Here's another patch with the SEGV problems handled and the ka's renamed 
>  to ka_copy.

Are there any remaining concerns with Corey's final patch?


 25-akpm/arch/i386/kernel/signal.c |   60 +++++++++++++++++---------------------
 25-akpm/include/linux/signal.h    |    2 -
 25-akpm/kernel/signal.c           |   12 ++++++-
 3 files changed, 39 insertions(+), 35 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fix arch/i386/kernel/signal.c
--- 25/arch/i386/kernel/signal.c~signal-race-fix	2004-03-23 02:18:54.810193056 -0800
+++ 25-akpm/arch/i386/kernel/signal.c	2004-03-23 02:18:54.817191992 -0800
@@ -312,7 +312,7 @@ setup_sigcontext(struct sigcontext __use
  * Determine which stack to use..
  */
 static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka_copy, struct pt_regs * regs, size_t frame_size)
 {
 	unsigned long esp;
 
@@ -320,16 +320,16 @@ get_sigframe(struct k_sigaction *ka, str
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
    See vsyscall-sigreturn.S.  */
 extern void __kernel_sigreturn, __kernel_rt_sigreturn;
 
-static void setup_frame(int sig, struct k_sigaction *ka,
+static void setup_frame(int sig, struct k_sigaction *ka_copy,
 			sigset_t *set, struct pt_regs * regs)
 {
 	void *restorer;
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
+static void setup_rt_frame(int sig, struct k_sigaction *ka_copy, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	void *restorer;
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
--- 25/include/linux/signal.h~signal-race-fix	2004-03-23 02:18:54.811192904 -0800
+++ 25-akpm/include/linux/signal.h	2004-03-23 02:18:54.814192448 -0800
@@ -213,7 +213,7 @@ extern int sigprocmask(int, sigset_t *, 
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
diff -puN kernel/signal.c~signal-race-fix kernel/signal.c
--- 25/kernel/signal.c~signal-race-fix	2004-03-23 02:18:54.812192752 -0800
+++ 25-akpm/kernel/signal.c	2004-03-23 02:18:54.816192144 -0800
@@ -1699,7 +1699,8 @@ static inline int handle_group_stop(void
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1768,8 +1769,15 @@ relock:
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
