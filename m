Return-Path: <minyard@acm.org>
Received: from sccrmhc11.comcast.net ([204.127.202.55]:37104 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263183AbUCTAKP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 19:10:15 -0500
Message-ID: <405B8BE5.4070602@acm.org>
Date: Fri, 19 Mar 2004 18:10:13 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <20040319120151.380dcbc9.akpm@osdl.org>	<20040319141258.338c91b1.davem@redhat.com>	<405B773B.8010705@acm.org> <20040319154928.3b2d8820.davem@redhat.com>
In-Reply-To: <20040319154928.3b2d8820.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040701090107030308000709"
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040701090107030308000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>On Fri, 19 Mar 2004 16:42:03 -0600
>Corey Minyard <minyard@acm.org> wrote:
>
>  
>
>>BTW, here is a new patch that covers that problem.
>>    
>>
>
>This still doesn't cut it, next the code in handle_signal() performs operations
>on ka->sa.sa_mask if SA_{NOMASK,NODEFER} is not set,
>then a recalc_sigpending() is made.
>
>I think we really need to pull the locking up a level or something like that.
>  
>
I saw it using the sa_sigmask, but not modifying it.

But you still may be right, pulling up the lock a level may be more 
optimal.  It just may mess with latency.

Here's another patch with the SEGV problems handled and the ka's renamed 
to ka_copy.

-Corey

--------------040701090107030308000709
Content-Type: text/plain;
 name="sigrace-fix3-2.6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigrace-fix3-2.6.diff"

--- linux.orig/include/linux/signal.h	2004-02-19 19:28:23.000000000 -0600
+++ linux/include/linux/signal.h	2004-03-19 08:07:45.000000000 -0600
@@ -213,7 +213,7 @@
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
--- linux.orig/kernel/signal.c	2004-03-16 17:20:06.000000000 -0600
+++ linux/kernel/signal.c	2004-03-19 16:39:57.000000000 -0600
@@ -1692,7 +1692,8 @@
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1761,8 +1762,15 @@
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
--- linux.orig/arch/i386/kernel/signal.c	2004-03-16 17:19:41.000000000 -0600
+++ linux/arch/i386/kernel/signal.c	2004-03-19 18:04:43.000000000 -0600
@@ -312,7 +312,7 @@
  * Determine which stack to use..
  */
 static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka_copy, struct pt_regs * regs, size_t frame_size)
 {
 	unsigned long esp;
 
@@ -320,16 +320,16 @@
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
@@ -339,14 +339,14 @@
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
@@ -372,8 +372,8 @@
 		goto give_sigsegv;
 
 	restorer = &__kernel_sigreturn;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER)
+		restorer = ka_copy->sa.sa_restorer;
 
 	/* Set up to return from userspace.  */
 	err |= __put_user(restorer, &frame->pretcode);
@@ -394,7 +394,7 @@
 
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
-	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eip = (unsigned long) ka_copy->sa.sa_handler;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;
@@ -412,18 +412,18 @@
 
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
@@ -455,8 +455,8 @@
 
 	/* Set up to return from userspace.  */
 	restorer = &__kernel_rt_sigreturn;
-	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER)
+		restorer = ka_copy->sa.sa_restorer;
 	err |= __put_user(restorer, &frame->pretcode);
 	 
 	/*
@@ -475,7 +475,7 @@
 
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
-	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eip = (unsigned long) ka_copy->sa.sa_handler;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;
@@ -493,7 +493,7 @@
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -502,11 +502,9 @@
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
@@ -517,7 +515,7 @@
 				break;
 
 			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
+				if (!(ka_copy->sa.sa_flags & SA_RESTART)) {
 					regs->eax = -EINTR;
 					break;
 				}
@@ -529,17 +527,14 @@
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
@@ -555,6 +550,7 @@
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka_copy;
 
 	/*
 	 * We want the common case to go fast, which
@@ -573,7 +569,7 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -583,7 +579,7 @@
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka_copy, oldset, regs);
 		return 1;
 	}
 

--------------040701090107030308000709--
