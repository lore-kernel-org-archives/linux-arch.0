Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:6378 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264815AbUG3DGt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 Jul 2004 23:06:49 -0400
Date: Thu, 29 Jul 2004 20:06:39 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 1/1] signal handling race fix
Message-Id: <20040729200639.21e50e27.davem@redhat.com>
In-Reply-To: <200407270500.i6R500123859@mail.osdl.org>
References: <200407270500.i6R500123859@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>


Ok, here are the sparc64 and sparc32 versions.

===== arch/i386/kernel/signal.c 1.41 vs edited =====
--- 1.41/arch/i386/kernel/signal.c	2004-07-13 05:53:49 -07:00
+++ edited/arch/i386/kernel/signal.c	2004-07-29 19:40:11 -07:00
@@ -311,7 +311,7 @@
  * Determine which stack to use..
  */
 static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka_copy, struct pt_regs * regs, size_t frame_size)
 {
 	unsigned long esp;
 
@@ -319,16 +319,16 @@
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
 
===== arch/sparc/kernel/signal.c 1.30 vs edited =====
--- 1.30/arch/sparc/kernel/signal.c	2004-07-13 06:06:37 -07:00
+++ edited/arch/sparc/kernel/signal.c	2004-07-29 19:52:43 -07:00
@@ -589,7 +589,7 @@
 }
 
 static inline void
-new_setup_frame(struct k_sigaction *ka, struct pt_regs *regs,
+new_setup_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 		int signo, sigset_t *oldset)
 {
 	struct new_signal_frame __user *sf;
@@ -603,7 +603,7 @@
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct new_signal_frame __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill_and_return;
@@ -637,12 +637,12 @@
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 
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
 
@@ -666,7 +666,7 @@
 }
 
 static inline void
-new_setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
+new_setup_rt_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 		   int signo, sigset_t *oldset, siginfo_t *info)
 {
 	struct rt_signal_frame __user *sf;
@@ -679,7 +679,7 @@
 	if (!current->used_math)
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 	sf = (struct rt_signal_frame __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
 	if (current_thread_info()->w_saved != 0)
@@ -720,11 +720,11 @@
 	regs->u_regs[UREG_I0] = signo;
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->pc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->npc = (regs->pc + 4);
 
-	if (ka->ka_restorer)
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer)
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	else {
 		regs->u_regs[UREG_I7] = (unsigned long)(&(sf->insns[0]) - 2);
 
@@ -1020,25 +1020,25 @@
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
@@ -1075,6 +1075,7 @@
 {
 	siginfo_t info;
 	struct sparc_deliver_cookie cookie;
+	struct k_sigaction ka_copy;
 	int signr;
 
 	/*
@@ -1094,15 +1095,12 @@
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
===== arch/sparc64/kernel/signal.c 1.32 vs edited =====
--- 1.32/arch/sparc64/kernel/signal.c	2004-05-31 16:25:29 -07:00
+++ edited/arch/sparc64/kernel/signal.c	2004-07-29 19:43:37 -07:00
@@ -471,14 +471,14 @@
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
@@ -487,7 +487,7 @@
 }
 
 static inline void
-setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
+setup_rt_frame(struct k_sigaction *ka_copy, struct pt_regs *regs,
 	       int signo, sigset_t *oldset, siginfo_t *info)
 {
 	struct rt_signal_frame __user *sf;
@@ -502,7 +502,7 @@
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct rt_signal_frame __user *)
-		get_sigframe(ka, regs, sigframe_size);
+		get_sigframe(ka_copy, regs, sigframe_size);
 	
 	if (invalid_frame_pointer (sf, sigframe_size))
 		goto sigill;
@@ -546,14 +546,14 @@
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 
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
@@ -562,17 +562,17 @@
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
@@ -580,7 +580,7 @@
 }
 
 static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
-				     struct sigaction *sa)
+				   struct sigaction *sa)
 {
 	switch (regs->u_regs[UREG_I0]) {
 	case ERESTART_RESTARTBLOCK:
@@ -609,6 +609,7 @@
 {
 	siginfo_t info;
 	struct signal_deliver_cookie cookie;
+	struct k_sigaction ka_copy;
 	int signr;
 	
 	cookie.restart_syscall = restart_syscall;
@@ -626,15 +627,11 @@
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
===== arch/sparc64/kernel/signal32.c 1.38 vs edited =====
--- 1.38/arch/sparc64/kernel/signal32.c	2004-07-13 05:56:55 -07:00
+++ edited/arch/sparc64/kernel/signal32.c	2004-07-29 19:50:05 -07:00
@@ -672,7 +672,8 @@
 	return err;
 }
 
-static void new_setup_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void new_setup_frame32(struct k_sigaction *ka_copy,
+			      struct pt_regs *regs,
 			      int signo, sigset_t *oldset)
 {
 	struct new_signal_frame32 __user *sf;
@@ -690,7 +691,7 @@
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct new_signal_frame32 __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
@@ -751,7 +752,7 @@
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 
 	/* 4. signal handler */
-	regs->tpc = (unsigned long) ka->sa.sa_handler;
+	regs->tpc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->tnpc = (regs->tpc + 4);
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -759,8 +760,8 @@
 	}
 
 	/* 5. return to kernel instructions */
-	if (ka->ka_restorer) {
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer) {
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	} else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
@@ -1073,7 +1074,8 @@
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void setup_rt_frame32(struct k_sigaction *ka_copy,
+			     struct pt_regs *regs,
 			     unsigned long signr, sigset_t *oldset,
 			     siginfo_t *info)
 {
@@ -1092,7 +1094,7 @@
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct rt_signal_frame32 __user *)
-		get_sigframe(&ka->sa, regs, sigframe_size);
+		get_sigframe(&ka_copy->sa, regs, sigframe_size);
 	
 	if (invalid_frame_pointer(sf, sigframe_size))
 		goto sigill;
@@ -1159,7 +1161,7 @@
 	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
 
 	/* 4. signal handler */
-	regs->tpc = (unsigned long) ka->sa.sa_handler;
+	regs->tpc = (unsigned long) ka_copy->sa.sa_handler;
 	regs->tnpc = (regs->tpc + 4);
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -1167,8 +1169,8 @@
 	}
 
 	/* 5. return to kernel instructions */
-	if (ka->ka_restorer)
-		regs->u_regs[UREG_I7] = (unsigned long)ka->ka_restorer;
+	if (ka_copy->ka_restorer)
+		regs->u_regs[UREG_I7] = (unsigned long)ka_copy->ka_restorer;
 	else {
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
@@ -1209,34 +1211,35 @@
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
@@ -1266,21 +1269,19 @@
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
===== include/linux/signal.h 1.17 vs edited =====
--- 1.17/include/linux/signal.h	2004-06-17 23:41:39 -07:00
+++ edited/include/linux/signal.h	2004-07-29 19:40:11 -07:00
@@ -217,7 +217,7 @@
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
-extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
+extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 #endif
 
 #endif /* __KERNEL__ */
===== kernel/signal.c 1.127 vs edited =====
--- 1.127/kernel/signal.c	2004-07-06 23:25:30 -07:00
+++ edited/kernel/signal.c	2004-07-29 19:40:11 -07:00
@@ -1724,7 +1724,8 @@
 	return 1;
 }
 
-int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
+int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka,
+			  struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
 	int signr = 0;
@@ -1793,8 +1794,15 @@
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
