Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266782AbUHYVnc@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:13019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266775AbUHYVka (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:40:30 -0400
Message-Id: <200408252140.i7PLeQ131559@mail.osdl.org>
Subject: [patch 6/8] signal handling race fixes: sparc and sparc64
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:38:43 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, davem@redhat.com
List-ID: <linux-arch.vger.kernel.org>


From: "David S. Miller" <davem@redhat.com>

Ok, here are the sparc64 and sparc32 versions.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/sparc/kernel/signal.c     |   52 ++++++++++++++----------------
 25-akpm/arch/sparc64/kernel/signal.c   |   39 ++++++++++------------
 25-akpm/arch/sparc64/kernel/signal32.c |   57 ++++++++++++++++-----------------
 arch/i386/kernel/signal.c              |    0 
 include/linux/signal.h                 |    0 
 kernel/signal.c                        |    0 
 6 files changed, 72 insertions(+), 76 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/i386/kernel/signal.c
diff -puN arch/sparc64/kernel/signal32.c~signal-race-fixes-sparc-sparc64 arch/sparc64/kernel/signal32.c
--- 25/arch/sparc64/kernel/signal32.c~signal-race-fixes-sparc-sparc64	2004-08-25 14:26:50.041088104 -0700
+++ 25-akpm/arch/sparc64/kernel/signal32.c	2004-08-25 14:26:50.052086432 -0700
@@ -672,7 +672,8 @@ static int save_fpu_state32(struct pt_re
 	return err;
 }
 
-static void new_setup_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void new_setup_frame32(struct k_sigaction *ka_copy,
+			      struct pt_regs *regs,
 			      int signo, sigset_t *oldset)
 {
 	struct new_signal_frame32 __user *sf;
@@ -690,7 +691,7 @@ static void new_setup_frame32(struct k_s
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct new_signal_frame32 __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
@@ -752,7 +753,7 @@ static void new_setup_frame32(struct k_s
 	regs->u_regs[UREG_I2] = (unsigned long) &sf->info;
 
 	/* 4. signal handler */
-	regs->tpc = (unsigned long) ka->sa.sa_handler;
+	regs->tpc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->tnpc = (regs->tpc + 4);
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -760,8 +761,8 @@ static void new_setup_frame32(struct k_s
 	}
 
 	/* 5. return to kernel instructions */
-	if (ka->ka_restorer) {
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer) {
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	} else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
@@ -1074,7 +1075,8 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void setup_rt_frame32(struct k_sigaction *ka_copy,
+			     struct pt_regs *regs,
 			     unsigned long signr, sigset_t *oldset,
 			     siginfo_t *info)
 {
@@ -1093,7 +1095,7 @@ static void setup_rt_frame32(struct k_si
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct rt_signal_frame32 __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
@@ -1161,7 +1163,7 @@ static void setup_rt_frame32(struct k_si
 	regs->u_regs[UREG_I2] = (unsigned long) &sf->regs;
 
 	/* 4. signal handler */
-	regs->tpc = (unsigned long) ka->sa.sa_handler;
+	regs->tpc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->tnpc = (regs->tpc + 4);
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -1169,8 +1171,8 @@ static void setup_rt_frame32(struct k_si
 	}
 
 	/* 5. return to kernel instructions */
-	if (ka->ka_restorer)
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer)
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
@@ -1211,34 +1213,35 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static inline void handle_signal32(unsigned long signr, struct k_sigaction *ka,
+static inline void handle_signal32(unsigned long signr,
+				   struct k_sigaction *ka_copy,
 				   siginfo_t *info,
 				   sigset_t *oldset, struct pt_regs *regs,
 				   int svr4_signal)
 {
 	if (svr4_signal)
-		setup_svr4_frame32(&ka->sa, regs->tpc, regs->tnpc,
+		setup_svr4_frame32(&ka_copy->sa, regs->tpc, regs->tnpc,
 				   regs, signr, oldset);
 	else {
-		if (ka->sa.sa_flags & SA_SIGINFO)
-			setup_rt_frame32(ka, regs, signr, oldset, info);
+		if (ka_copy->sa.sa_flags & SA_SIGINFO)
+			setup_rt_frame32(ka_copy, regs, signr, oldset, info);
 		else if (test_thread_flag(TIF_NEWSIGNALS))
-			new_setup_frame32(ka, regs, signr, oldset);
+			new_setup_frame32(ka_copy, regs, signr, oldset);
 		else
-			setup_frame32(&ka->sa, regs, signr, oldset, info);
+			setup_frame32(&ka_copy->sa, regs, signr, oldset, info);
 	}
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
+	if (!(ka_copy->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
-static inline void syscall_restart32(unsigned long orig_i0, struct pt_regs *regs,
+static inline void syscall_restart32(unsigned long orig_i0,
+				     struct pt_regs *regs,
 				     struct sigaction *sa)
 {
 	switch (regs->u_regs[UREG_I0]) {
@@ -1268,21 +1271,19 @@ int do_signal32(sigset_t *oldset, struct
 {
 	siginfo_t info;
 	struct signal_deliver_cookie cookie;
+	struct k_sigaction ka_copy;
 	int signr;
 	int svr4_signal = current->personality == PER_SVR4;
 	
 	cookie.restart_syscall = restart_syscall;
 	cookie.orig_i0 = orig_i0;
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart32(orig_i0, regs, &ka->sa);
-		handle_signal32(signr, ka, &info, oldset, regs, svr4_signal);
+			syscall_restart32(orig_i0, regs, &ka_copy.sa);
+		handle_signal32(signr, &ka_copy, &info, oldset,
+				regs, svr4_signal);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN arch/sparc64/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/sparc64/kernel/signal.c
--- 25/arch/sparc64/kernel/signal.c~signal-race-fixes-sparc-sparc64	2004-08-25 14:26:50.043087800 -0700
+++ 25-akpm/arch/sparc64/kernel/signal.c	2004-08-25 14:26:50.053086280 -0700
@@ -471,14 +471,14 @@ save_fpu_state(struct pt_regs *regs, __s
 	return err;
 }
 
-static inline void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, unsigned long framesize)
+static inline void __user *get_sigframe(struct k_sigaction *ka_copy, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp;
 
 	sp = regs->u_regs[UREG_FP] + STACK_BIAS;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ka_copy->sa.sa_flags & SA_ONSTACK) {
 		if (!on_sig_stack(sp) &&
 		    !((current->sas_ss_sp + current->sas_ss_size) & 7))
 			sp = current->sas_ss_sp + current->sas_ss_size;
@@ -487,7 +487,7 @@ static inline void __user *get_sigframe(
 }
 
 static inline void
-setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
+setup_rt_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 	       int signo, sigset_t *oldset, siginfo_t *info)
 {
 	struct rt_signal_frame __user *sf;
@@ -502,7 +502,7 @@ setup_rt_frame(struct k_sigaction *ka, s
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct rt_signal_frame __user *)
-		get_sigframe(ka, regs, sigframe_size);
+		get_sigframe(ka_copy, regs, sigframe_size);
 	
 	if (invalid_frame_pointer (sf, sigframe_size))
 		goto sigill;
@@ -552,14 +552,14 @@ setup_rt_frame(struct k_sigaction *ka, s
 	regs->u_regs[UREG_I2] = (unsigned long) &sf->info;
 
 	/* 5. signal handler */
-	regs->tpc = (unsigned long) ka->sa.sa_handler;
+	regs->tpc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->tnpc = (regs->tpc + 4);
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
 	/* 4. return to kernel instructions */
-	regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	return;
 
 sigill:
@@ -568,17 +568,17 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static inline void handle_signal(unsigned long signr, struct k_sigaction *ka,
+static inline void handle_signal(unsigned long signr,
+				 struct k_sigaction *ka_copy,
 				 siginfo_t *info,
 				 sigset_t *oldset, struct pt_regs *regs)
 {
-	setup_rt_frame(ka, regs, signr, oldset,
-		       (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
+	setup_rt_frame(ka_copy, regs, signr, oldset,
+		       (ka_copy->sa.sa_flags & SA_SIGINFO) ? info : NULL);
+	if (!(ka_copy->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -586,7 +586,7 @@ static inline void handle_signal(unsigne
 }
 
 static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
-				     struct sigaction *sa)
+				   struct sigaction *sa)
 {
 	switch (regs->u_regs[UREG_I0]) {
 	case ERESTART_RESTARTBLOCK:
@@ -615,6 +615,7 @@ static int do_signal(sigset_t *oldset, s
 {
 	siginfo_t info;
 	struct signal_deliver_cookie cookie;
+	struct k_sigaction ka_copy;
 	int signr;
 	
 	cookie.restart_syscall = restart_syscall;
@@ -632,15 +633,11 @@ static int do_signal(sigset_t *oldset, s
 	}
 #endif	
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart(orig_i0, regs, &ka->sa);
-		handle_signal(signr, ka, &info, oldset, regs);
+			syscall_restart(orig_i0, regs, &ka_copy.sa);
+		handle_signal(signr, &ka_copy, &info, oldset, regs);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN arch/sparc/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/sparc/kernel/signal.c
--- 25/arch/sparc/kernel/signal.c~signal-race-fixes-sparc-sparc64	2004-08-25 14:26:50.044087648 -0700
+++ 25-akpm/arch/sparc/kernel/signal.c	2004-08-25 14:26:50.055085976 -0700
@@ -589,7 +589,7 @@ save_fpu_state(struct pt_regs *regs, __s
 }
 
 static inline void
-new_setup_frame(struct k_sigaction *ka, struct pt_regs *regs,
+new_setup_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 		int signo, sigset_t *oldset)
 {
 	struct new_signal_frame __user *sf;
@@ -603,7 +603,7 @@ new_setup_frame(struct k_sigaction *ka, 
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct new_signal_frame __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill_and_return;
@@ -638,12 +638,12 @@ new_setup_frame(struct k_sigaction *ka, 
 	regs->u_regs[UREG_I2] = (unsigned long) &sf->info;
 
 	/* 4. signal handler */
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->npc = (regs->pc + 4);
 
 	/* 5. return to kernel instructions */
-	if (ka->ka_restorer)
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer)
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	else {
 		regs->u_regs[UREG_I7] = (unsigned long)(&(sf->insns[0]) - 2);
 
@@ -667,7 +667,7 @@ sigsegv:
 }
 
 static inline void
-new_setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
+new_setup_rt_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 		   int signo, sigset_t *oldset, siginfo_t *info)
 {
 	struct rt_signal_frame __user *sf;
@@ -680,7 +680,7 @@ new_setup_rt_frame(struct k_sigaction *k
 	if (!current->used_math)
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 	sf = (struct rt_signal_frame __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
 	if (current_thread_info()->w_saved != 0)
@@ -722,11 +722,11 @@ new_setup_rt_frame(struct k_sigaction *k
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 	regs->u_regs[UREG_I2] = (unsigned long) &sf->regs;
 
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->npc = (regs->pc + 4);
 
-	if (ka->ka_restorer)
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer)
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	else {
 		regs->u_regs[UREG_I7] = (unsigned long)(&(sf->insns[0]) - 2);
 
@@ -1022,25 +1022,25 @@ sigsegv_and_return:
 }
 
 static inline void
-handle_signal(unsigned long signr, struct k_sigaction *ka,
+handle_signal(unsigned long signr, struct k_sigaction *ka_copy,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs *regs,
 	      int svr4_signal)
 {
 	if (svr4_signal)
-		setup_svr4_frame(&ka->sa, regs->pc, regs->npc, regs, signr, oldset);
+		setup_svr4_frame(&ka_copy->sa, regs->pc, regs->npc,
+				 regs, signr, oldset);
 	else {
-		if (ka->sa.sa_flags & SA_SIGINFO)
-			new_setup_rt_frame(ka, regs, signr, oldset, info);
+		if (ka_copy->sa.sa_flags & SA_SIGINFO)
+			new_setup_rt_frame(ka_copy, regs, signr, oldset, info);
 		else if (current->thread.new_signal)
-			new_setup_frame(ka, regs, signr, oldset);
+			new_setup_frame(ka_copy, regs, signr, oldset);
 		else
-			setup_frame(&ka->sa, regs, signr, oldset, info);
+			setup_frame(&ka_copy->sa, regs, signr, oldset, info);
 	}
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-	if (!(ka->sa.sa_flags & SA_NOMASK)) {
+	if (!(ka_copy->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -1077,6 +1077,7 @@ asmlinkage int do_signal(sigset_t *oldse
 {
 	siginfo_t info;
 	struct sparc_deliver_cookie cookie;
+	struct k_sigaction ka_copy;
 	int signr;
 
 	/*
@@ -1096,15 +1097,12 @@ asmlinkage int do_signal(sigset_t *oldse
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-		
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart(cookie.orig_i0, regs, &ka->sa);
-		handle_signal(signr, ka, &info, oldset, regs, svr4_signal);
+			syscall_restart(cookie.orig_i0, regs, &ka_copy.sa);
+		handle_signal(signr, &ka_copy, &info, oldset,
+			      regs, svr4_signal);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN include/linux/signal.h~signal-race-fixes-sparc-sparc64 include/linux/signal.h
diff -puN kernel/signal.c~signal-race-fixes-sparc-sparc64 kernel/signal.c
_
