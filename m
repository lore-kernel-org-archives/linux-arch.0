Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267364AbUHZAfa@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:50561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267360AbUHZAdP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:15 -0400
Message-Id: <200408260033.i7Q0X8132253@mail.osdl.org>
Subject: [patch 8/8] alpha signal race fixes
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:48 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, wli@holomorphy.com
List-ID: <linux-arch.vger.kernel.org>


From: William Lee Irwin III <wli@holomorphy.com>



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/alpha/kernel/signal.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN arch/alpha/kernel/signal.c~signal-race-fix-alpha arch/alpha/kernel/signal.c
--- 25/arch/alpha/kernel/signal.c~signal-race-fix-alpha	Wed Aug 25 17:13:42 2004
+++ 25-akpm/arch/alpha/kernel/signal.c	Wed Aug 25 17:13:42 2004
@@ -470,7 +470,7 @@ setup_frame(int sig, struct k_sigaction 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -534,7 +534,7 @@ setup_rt_frame(int sig, struct k_sigacti
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -608,21 +608,20 @@ do_signal(sigset_t *oldset, struct pt_re
 	siginfo_t info;
 	int signr;
 	unsigned long single_stepping = ptrace_cancel_bpt(current);
+	struct k_sigaction ka;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	/* This lets the debugger run, ... */
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	/* ... so re-check the single stepping. */
 	single_stepping |= ptrace_cancel_bpt(current);
 
 	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		struct k_sigaction *ka = &current->sighand->action[signr-1];
-
-		if (r0) syscall_restart(r0, r19, regs, ka);
-		handle_signal(signr, ka, &info, oldset, regs, sw);
+		if (r0) syscall_restart(r0, r19, regs, &ka);
+		handle_signal(signr, &ka, &info, oldset, regs, sw);
 		if (single_stepping) 
 			ptrace_set_bpt(current); /* re-set bpt */
 		return 1;
_
