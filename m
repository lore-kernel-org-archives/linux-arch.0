Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267301AbUHZAfm@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:46465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267318AbUHZAdL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:11 -0400
Message-Id: <200408260033.i7Q0X6132214@mail.osdl.org>
Subject: [patch 5/8] ppc signal handling fixes
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:46 -0700
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

 25-akpm/arch/ppc/kernel/signal.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff -puN arch/ppc/kernel/signal.c~ppc-signal-handling-fixes arch/ppc/kernel/signal.c
--- 25/arch/ppc/kernel/signal.c~ppc-signal-handling-fixes	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/ppc/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -405,7 +405,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
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
+	struct k_sigaction ka;
 	unsigned long frame, newsp;
 	int signr, ret;
 
@@ -613,9 +613,7 @@ int do_signal(sigset_t *oldset, struct p
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -626,7 +624,7 @@ int do_signal(sigset_t *oldset, struct p
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -645,7 +643,7 @@ int do_signal(sigset_t *oldset, struct p
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
 	else
@@ -653,17 +651,14 @@ int do_signal(sigset_t *oldset, struct p
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal(signr, ka, &info, oldset, regs, newsp);
+	if (ka.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal(signr, &ka, &info, oldset, regs, newsp);
 	else
-		handle_signal(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal(signr, &ka, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,&ka.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
_
