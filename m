Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267360AbUHZAfa@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:48769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267294AbUHZAdM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:12 -0400
Message-Id: <200408260033.i7Q0X7132241@mail.osdl.org>
Subject: [patch 7/8] ppc64: signal race fix
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:48 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>


From: Paul Mackerras <paulus@samba.org>

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/signal.c   |   29 ++++++++++++++---------------
 25-akpm/arch/ppc64/kernel/signal32.c |   28 ++++++++++++----------------
 2 files changed, 26 insertions(+), 31 deletions(-)

diff -puN arch/ppc64/kernel/signal32.c~signal-race-fixes-ppc64 arch/ppc64/kernel/signal32.c
--- 25/arch/ppc64/kernel/signal32.c~signal-race-fixes-ppc64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/ppc64/kernel/signal32.c	Wed Aug 25 17:13:41 2004
@@ -700,7 +700,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -865,7 +865,7 @@ badframe:
 	       regs, frame, *newspp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -928,18 +928,16 @@ badframe:
 int do_signal32(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
 	unsigned int frame, newsp;
 	int signr, ret;
+	struct k_sigaction ka;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -950,7 +948,7 @@ int do_signal32(sigset_t *oldset, struct
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -969,7 +967,7 @@ int do_signal32(sigset_t *oldset, struct
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && (!on_sig_stack(regs->gpr[1])))
 		newsp = (current->sas_ss_sp + current->sas_ss_size);
 	else
@@ -977,17 +975,15 @@ int do_signal32(sigset_t *oldset, struct
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal32(signr, ka, &info, oldset, regs, newsp);
+	if (ka.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal32(signr, &ka, &info, oldset, regs, newsp);
 	else
-		handle_signal32(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal32(signr, &ka, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
diff -puN arch/ppc64/kernel/signal.c~signal-race-fixes-ppc64 arch/ppc64/kernel/signal.c
--- 25/arch/ppc64/kernel/signal.c~signal-race-fixes-ppc64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/ppc64/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -374,8 +374,8 @@ badframe:
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
-		sigset_t *set, struct pt_regs *regs)
+static void setup_rt_frame(int signr, struct k_sigaction *ka,
+		siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	/* Handler is *really* a pointer to the function descriptor for
 	 * the signal routine.  The first entry in the function
@@ -446,7 +446,9 @@ badframe:
 	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (signr == SIGSEGV)
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
@@ -454,25 +456,23 @@ badframe:
  * OK, we're invoking a handler
  */
 static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			  siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
 	/* Set up Signal Frame */
 	setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
-	return;
 }
 
-static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
+static inline void syscall_restart(struct pt_regs *regs,
+				   struct k_sigaction *ka)
 {
 	switch ((int)regs->result) {
 	case -ERESTART_RESTARTBLOCK:
@@ -512,6 +512,7 @@ int do_signal(sigset_t *oldset, struct p
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * If the current thread is 32 bit - invoke the
@@ -523,14 +524,12 @@ int do_signal(sigset_t *oldset, struct p
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		struct k_sigaction *ka = &current->sighand->action[signr-1];
-
 		/* Whee!  Actually deliver the signal.  */
 		if (TRAP(regs) == 0x0C00)
-			syscall_restart(regs, ka);
-		handle_signal(signr, ka, &info, oldset, regs);
+			syscall_restart(regs, &ka);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 
_
