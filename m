Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262098AbUK3PAU@vger.kernel.org>
Received: from canuck.infradead.org ([205.233.218.70]:56581 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262094AbUK3PAU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Nov 2004 10:00:20 -0500
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
	 <20041112163442.45fc966f.akpm@osdl.org>
	 <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="=-oAiX17D+QajV8qVV0OxI"
Message-Id: <1101826791.26071.108.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 14:59:52 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, bstroesser@fujitsu-siemens.com, linux-arch@vger.kernel.org, jdike@ccure.user-mode-linux.org
List-ID: <linux-arch.vger.kernel.org>


--=-oAiX17D+QajV8qVV0OxI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-11-14 at 17:13 -0500, Jeff Dike wrote:
> 	sigmasking.c - Makes sure that when a signal is (not) delivered to
> a bogus stack, that a segfault is delivered then, and not after returning
> to userspace.  This is the test relevant to the patch that Andrew replied
> to.

Corresponding patch for ppc64. Are we actually going to fix this for all
architectures?

-- 
dwmw2

--=-oAiX17D+QajV8qVV0OxI
Content-Disposition: inline; filename=linux-2.6.10-ppc64-sigmasking.patch
Content-Type: text/x-patch; name=linux-2.6.10-ppc64-sigmasking.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/ppc64/kernel/signal.c 1.44 vs edited =====
--- 1.44/arch/ppc64/kernel/signal.c	2004-10-28 08:39:49 +01:00
+++ edited/arch/ppc64/kernel/signal.c	2004-11-26 14:13:18 +00:00
@@ -387,7 +387,7 @@
 	return 0;
 }
 
-static void setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
+static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
 		sigset_t *set, struct pt_regs *regs)
 {
 	/* Handler is *really* a pointer to the function descriptor for
@@ -452,7 +452,7 @@
 	if (err)
 		goto badframe;
 
-	return;
+	return 0;
 
 badframe:
 #if DEBUG_SIG
@@ -460,17 +460,19 @@
 	       regs, frame, newsp);
 #endif
 	force_sigsegv(signr, current);
+	return -1;
 }
 
 
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			  siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+static int handle_signal(unsigned long sig, struct k_sigaction *ka,
+			 siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
 	/* Set up Signal Frame */
-	setup_rt_frame(sig, ka, info, oldset, regs);
+	if (setup_rt_frame(sig, ka, info, oldset, regs))
+	    return 0;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
@@ -479,6 +481,8 @@
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
+
+	return 1;
 }
 
 static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
@@ -538,8 +542,7 @@
 		/* Whee!  Actually deliver the signal.  */
 		if (TRAP(regs) == 0x0C00)
 			syscall_restart(regs, &ka);
-		handle_signal(signr, &ka, &info, oldset, regs);
-		return 1;
+		return handle_signal(signr, &ka, &info, oldset, regs);
 	}
 
 	if (TRAP(regs) == 0x0C00) {	/* System Call! */
===== arch/ppc64/kernel/signal32.c 1.61 vs edited =====
--- 1.61/arch/ppc64/kernel/signal32.c	2004-10-28 08:39:49 +01:00
+++ edited/arch/ppc64/kernel/signal32.c	2004-11-26 14:13:18 +00:00
@@ -653,9 +653,9 @@
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
  */
-static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
-			       siginfo_t *info, sigset_t *oldset,
-			       struct pt_regs * regs, unsigned long newsp)
+static int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
+			      siginfo_t *info, sigset_t *oldset,
+			      struct pt_regs * regs, unsigned long newsp)
 {
 	struct rt_sigframe32 __user *rt_sf;
 	struct mcontext32 __user *frame;
@@ -704,14 +704,14 @@
 	regs->trap = 0;
 	regs->result = 0;
 
-	return;
+	return 1;
 
 badframe:
 #if DEBUG_SIG
 	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	force_sigsegv(sig, current);
+	return 0;
 }
 
 static long do_setcontext32(struct ucontext32 __user *ucp, struct pt_regs *regs, int sig)
@@ -822,7 +822,7 @@
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal32(unsigned long sig, struct k_sigaction *ka,
+static int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 			    siginfo_t *info, sigset_t *oldset,
 			    struct pt_regs * regs, unsigned long newsp)
 {
@@ -867,14 +867,14 @@
 	regs->trap = 0;
 	regs->result = 0;
 
-	return;
+	return 1;
 
 badframe:
 #if DEBUG_SIG
 	printk("badframe in handle_signal, regs=%p frame=%x newsp=%x\n",
 	       regs, frame, *newspp);
 #endif
-	force_sigsegv(sig, current);
+	return 0;
 }
 
 /*
@@ -984,11 +984,20 @@
 
 	/* Whee!  Actually deliver the signal.  */
 	if (ka.sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal32(signr, &ka, &info, oldset, regs, newsp);
+		ret = handle_rt_signal32(signr, &ka, &info, oldset, regs, newsp);
 	else
-		handle_signal32(signr, &ka, &info, oldset, regs, newsp);
+		ret = handle_signal32(signr, &ka, &info, oldset, regs, newsp);
 
-	if (!(ka.sa.sa_flags & SA_NODEFER)) {
+	if (!ret) {
+		/* Setting up the stack frame failed, but if we came here
+		   from sigsuspend we may already have masked signals. 
+		   Put back the old sigmask before forcing SEGV. */
+		spin_lock_irq(&current->sighand->siglock);
+		current->blocked = *oldset;
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+		force_sigsegv(signr, current);
+	} else if (!(ka.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked,
 			  &ka.sa.sa_mask);

--=-oAiX17D+QajV8qVV0OxI--
