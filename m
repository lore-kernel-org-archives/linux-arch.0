Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266775AbUHYVnc@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:11483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266762AbUHYVk3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:40:29 -0400
Message-Id: <200408252140.i7PLeP131546@mail.osdl.org>
Subject: [patch 5/8] ppc signal handling fixes
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:38:42 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, mikpe@csd.uu.se
List-ID: <linux-arch.vger.kernel.org>


From: Mikael Pettersson <mikpe@csd.uu.se>

2.6.8-rc2-mm1 reintroduced the signal-race-fixes patch for i386, x86_64,
s390, and ia64, breaking all other archs.

The patch below updates ppc, following the pattern of i386.  Compiled &
runtime tested.  No observable breakage.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/signal.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff -puN arch/ppc/kernel/signal.c~ppc-signal-handling-fixes arch/ppc/kernel/signal.c
--- 25/arch/ppc/kernel/signal.c~ppc-signal-handling-fixes	2004-08-25 14:26:49.476173984 -0700
+++ 25-akpm/arch/ppc/kernel/signal.c	2004-08-25 14:26:49.480173376 -0700
@@ -350,7 +350,7 @@ restore_sigmask(sigset_t *set)
  * (one which gets siginfo).
  */
 static void
-handle_rt_signal(unsigned long sig, struct k_sigaction *ka,
+handle_rt_signal(unsigned long sig, struct k_sigaction *ka_copy,
 		 siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 		 unsigned long newsp)
 {
@@ -393,7 +393,7 @@ handle_rt_signal(unsigned long sig, stru
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 
@@ -405,7 +405,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -505,7 +505,7 @@ int sys_rt_sigreturn(int r3, int r4, int
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
+handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 	      unsigned long newsp)
 {
@@ -530,7 +530,7 @@ handle_signal(unsigned long sig, struct 
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
+	if (__put_user((unsigned long) ka_copy->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 	    || __put_user((struct pt_regs *)frame, &sc->regs)
@@ -545,7 +545,7 @@ handle_signal(unsigned long sig, struct 
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 
@@ -557,7 +557,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -604,7 +604,7 @@ badframe:
 int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	struct k_sigaction ka_copy;
 	unsigned long frame, newsp;
 	int signr, ret;
 
@@ -613,9 +613,7 @@ int do_signal(sigset_t *oldset, struct p
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -626,7 +624,7 @@ int do_signal(sigset_t *oldset, struct p
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka_copy.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -645,7 +643,7 @@ int do_signal(sigset_t *oldset, struct p
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka_copy.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
 	else
@@ -653,17 +651,14 @@ int do_signal(sigset_t *oldset, struct p
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal(signr, ka, &info, oldset, regs, newsp);
+	if (ka_copy.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 	else
-		handle_signal(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,&ka_copy.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
_
