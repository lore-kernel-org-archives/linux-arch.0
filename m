Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266805AbUHYVn3@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:15067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266782AbUHYVkc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:40:32 -0400
Message-Id: <200408252140.i7PLeR131578@mail.osdl.org>
Subject: [patch 7/8] pPC64 signal race fix patch
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:38:44 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>


From: Paul Mackerras <paulus@samba.org>

Compile-tested, but not boot-tested since I am still travelling.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/signal.c   |   45 +++++++++++++++++------------------
 25-akpm/arch/ppc64/kernel/signal32.c |   38 +++++++++++++----------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff -puN arch/ppc64/kernel/signal32.c~signal-race-fixes-ppc64 arch/ppc64/kernel/signal32.c
--- 25/arch/ppc64/kernel/signal32.c~signal-race-fixes-ppc64	2004-08-25 14:26:51.253903728 -0700
+++ 25-akpm/arch/ppc64/kernel/signal32.c	2004-08-25 14:26:51.259902816 -0700
@@ -641,7 +641,7 @@ int sys32_sigaltstack(u32 __new, u32 __o
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
  */
-static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
+static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka_copy,
 			       siginfo_t *info, sigset_t *oldset,
 			       struct pt_regs * regs, unsigned long newsp)
 {
@@ -687,7 +687,7 @@ static void handle_rt_signal32(unsigned 
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 	regs->result = 0;
@@ -700,7 +700,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -812,7 +812,7 @@ long sys32_rt_sigreturn(int r3, int r4, 
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal32(unsigned long sig, struct k_sigaction *ka,
+static void handle_signal32(unsigned long sig, struct k_sigaction *ka_copy,
 			    siginfo_t *info, sigset_t *oldset,
 			    struct pt_regs * regs, unsigned long newsp)
 {
@@ -837,7 +837,7 @@ static void handle_signal32(unsigned lon
 #if _NSIG != 64
 #error "Please adjust handle_signal32()"
 #endif
-	if (__put_user((u32)(u64)ka->sa.sa_handler, &sc->handler)
+	if (__put_user((u32)(u64)ka_copy->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
 	    || __put_user((u32)(u64)frame, &sc->regs)
@@ -852,7 +852,7 @@ static void handle_signal32(unsigned lon
 	regs->gpr[1] = (unsigned long) newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 	regs->result = 0;
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
+	struct k_sigaction ka_copy;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -950,7 +948,7 @@ int do_signal32(sigset_t *oldset, struct
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka_copy.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -969,7 +967,7 @@ int do_signal32(sigset_t *oldset, struct
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka_copy.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && (!on_sig_stack(regs->gpr[1])))
 		newsp = (current->sas_ss_sp + current->sas_ss_size);
 	else
@@ -977,17 +975,15 @@ int do_signal32(sigset_t *oldset, struct
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal32(signr, ka, &info, oldset, regs, newsp);
+	if (ka_copy.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal32(signr, &ka_copy, &info, oldset, regs, newsp);
 	else
-		handle_signal32(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal32(signr, &ka_copy, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
diff -puN arch/ppc64/kernel/signal.c~signal-race-fixes-ppc64 arch/ppc64/kernel/signal.c
--- 25/arch/ppc64/kernel/signal.c~signal-race-fixes-ppc64	2004-08-25 14:26:51.254903576 -0700
+++ 25-akpm/arch/ppc64/kernel/signal.c	2004-08-25 14:26:51.260902664 -0700
@@ -374,8 +374,8 @@ badframe:
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
-		sigset_t *set, struct pt_regs *regs)
+static void setup_rt_frame(int signr, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	/* Handler is *really* a pointer to the function descriptor for
 	 * the signal routine.  The first entry in the function
@@ -387,7 +387,7 @@ static void setup_rt_frame(int signr, st
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
@@ -406,7 +406,7 @@ static void setup_rt_frame(int signr, st
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr, NULL,
-				(unsigned long)ka->sa.sa_handler);
+				(unsigned long)ka_copy->sa.sa_handler);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto badframe;
@@ -416,7 +416,7 @@ static void setup_rt_frame(int signr, st
 	if (err)
 		goto badframe;
 
-	funct_desc_ptr = (func_descr_t __user *) ka->sa.sa_handler;
+	funct_desc_ptr = (func_descr_t __user *) ka_copy->sa.sa_handler;
 
 	/* Allocate a dummy caller frame for the signal handler. */
 	newsp = (unsigned long)frame - __SIGNAL_FRAMESIZE;
@@ -429,7 +429,7 @@ static void setup_rt_frame(int signr, st
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
 	regs->result = 0;
-	if (ka->sa.sa_flags & SA_SIGINFO) {
+	if (ka_copy->sa.sa_flags & SA_SIGINFO) {
 		err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
 		err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);
 		regs->gpr[6] = (unsigned long) frame;
@@ -446,33 +446,33 @@ badframe:
 	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (signr == SIGSEGV)
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			  siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+static void handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
 	/* Set up Signal Frame */
-	setup_rt_frame(sig, ka, info, oldset, regs);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+	setup_rt_frame(sig, ka_copy, info, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
-	return;
 }
 
-static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
+static inline void syscall_restart(struct pt_regs *regs,
+				   struct k_sigaction *ka_copy)
 {
 	switch ((int)regs->result) {
 	case -ERESTART_RESTARTBLOCK:
@@ -487,7 +487,7 @@ static inline void syscall_restart(struc
 		/* ERESTARTSYS means to restart the syscall if there is no
 		 * handler or the handler was registered with SA_RESTART
 		 */
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
+		if (!(ka_copy->sa.sa_flags & SA_RESTART)) {
 			regs->result = -EINTR;
 			break;
 		}
@@ -512,6 +512,7 @@ int do_signal(sigset_t *oldset, struct p
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka_copy;
 
 	/*
 	 * If the current thread is 32 bit - invoke the
@@ -523,14 +524,12 @@ int do_signal(sigset_t *oldset, struct p
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if (signr > 0) {
-		struct k_sigaction *ka = &current->sighand->action[signr-1];
-
 		/* Whee!  Actually deliver the signal.  */
 		if (TRAP(regs) == 0x0C00)
-			syscall_restart(regs, ka);
-		handle_signal(signr, ka, &info, oldset, regs);
+			syscall_restart(regs, &ka_copy);
+		handle_signal(signr, &ka_copy, &info, oldset, regs);
 		return 1;
 	}
 
_
