Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:11161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266254AbUG0FAF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jul 2004 01:00:05 -0400
Message-Id: <200407270500.i6R501123916@mail.osdl.org>
Subject: [patch 1/1] signal-race-fix: ia64
From: akpm@osdl.org
Date: Mon, 26 Jul 2004 21:58:38 -0700
To: linux-arch@vger.kernel.org
Cc: minyard@acm.org, akpm@osdl.org, davidm@napali.hpl.hp.com
List-ID: <linux-arch.vger.kernel.org>


From: David Mosberger <davidm@napali.hpl.hp.com>

It looks fine to me, except that I decided to play chicken as far as the
give_sigsegv update of sa_handler is concerned.

Arun, I hope I got the ia32 emulation parts right, but you may want to
double-check.

The patch seems to work fine as far as I have tested.  I'm seeing some
oddity in context-switch overhead and pipe latency as reported by LMbench,
but I suspect that's due to another change that happened somewhere between
2.6.5-rc1 and Linus' bk tree as of this morning.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ia64/ia32/ia32_signal.c |   83 +++++++++++++++++++----------------
 25-akpm/arch/ia64/kernel/signal.c    |   80 +++++++++++++++++++--------------
 2 files changed, 93 insertions(+), 70 deletions(-)

diff -puN arch/ia64/ia32/ia32_signal.c~signal-race-fix-ia64 arch/ia64/ia32/ia32_signal.c
--- 25/arch/ia64/ia32/ia32_signal.c~signal-race-fix-ia64	2004-07-26 21:48:34.240846296 -0700
+++ 25-akpm/arch/ia64/ia32/ia32_signal.c	2004-07-26 21:48:34.247845232 -0700
@@ -1,7 +1,7 @@
 /*
  * IA32 Architecture-specific signal handling support.
  *
- * Copyright (C) 1999, 2001-2002 Hewlett-Packard Co
+ * Copyright (C) 1999, 2001-2002, 2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  * Copyright (C) 1999 Arun Sharma <arun.sharma@intel.com>
  * Copyright (C) 2000 VA Linux Co
@@ -809,7 +809,7 @@ restore_sigcontext_ia32 (struct pt_regs 
  * Determine which stack to use..
  */
 static inline void *
-get_sigframe (struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe (struct k_sigaction *ka_copy, struct pt_regs * regs, size_t frame_size)
 {
 	unsigned long esp;
 
@@ -817,7 +817,7 @@ get_sigframe (struct k_sigaction *ka, st
 	esp = (unsigned int) regs->r12;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ka_copy->sa.sa_flags & SA_ONSTACK) {
 		if (!on_sig_stack(esp))
 			esp = current->sas_ss_sp + current->sas_ss_size;
 	}
@@ -826,17 +826,40 @@ get_sigframe (struct k_sigaction *ka, st
 	return (void *)((esp - frame_size) & -8ul);
 }
 
+static long
+force_sigsegv (int sig)
+{
+	unsigned long flags;
+
+	if (sig == SIGSEGV) {
+		/*
+		 * Acquiring siglock around the sa_handler-update is almost
+		 * certainly overkill, but this isn't a
+		 * performance-critical path and I'd rather play it safe
+		 * here than having to debug a nasty race if and when
+		 * something changes in kernel/signal.c that would make it
+		 * no longer safe to modify sa_handler without holding the
+		 * lock.
+		 */
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		current->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	}
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
 static int
-setup_frame_ia32 (int sig, struct k_sigaction *ka, sigset_t *set, struct pt_regs * regs)
+setup_frame_ia32 (int sig, struct k_sigaction *ka_copy, sigset_t *set, struct pt_regs * regs)
 {
 	struct exec_domain *ed = current_thread_info()->exec_domain;
 	struct sigframe_ia32 *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	err |= __put_user((ed && ed->signal_invmap && sig < 32
 			   ? (int)(ed->signal_invmap[sig]) : sig), &frame->sig);
@@ -849,8 +872,8 @@ setup_frame_ia32 (int sig, struct k_siga
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		unsigned int restorer = IA32_SA_RESTORER(ka);
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
+		unsigned int restorer = IA32_SA_RESTORER(ka_copy);
 		err |= __put_user(restorer, &frame->pretcode);
 	} else {
 		err |= __put_user((long)frame->retcode, &frame->pretcode);
@@ -862,11 +885,11 @@ setup_frame_ia32 (int sig, struct k_siga
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up registers for signal handler */
 	regs->r12 = (unsigned long) frame;
-	regs->cr_iip = IA32_SA_HANDLER(ka);
+	regs->cr_iip = IA32_SA_HANDLER(ka_copy);
 
 	set_fs(USER_DS);
 
@@ -874,32 +897,26 @@ setup_frame_ia32 (int sig, struct k_siga
 	regs->eflags &= ~TF_MASK;
 #endif
 
-#if 0
+#if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sig=%d sp=%p pc=%lx ra=%x\n",
                current->comm, current->pid, sig, (void *) frame, regs->cr_iip, frame->pretcode);
 #endif
 
 	return 1;
-
-  give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
-	return 0;
 }
 
 static int
-setup_rt_frame_ia32 (int sig, struct k_sigaction *ka, siginfo_t *info,
+setup_rt_frame_ia32 (int sig, struct k_sigaction *ka_copy, siginfo_t *info,
 		     sigset_t *set, struct pt_regs * regs)
 {
 	struct exec_domain *ed = current_thread_info()->exec_domain;
 	struct rt_sigframe_ia32 *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	err |= __put_user((ed && ed->signal_invmap
 			   && sig < 32 ? ed->signal_invmap[sig] : sig), &frame->sig);
@@ -916,12 +933,12 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	err |= setup_sigcontext_ia32(&frame->uc.uc_mcontext, &frame->fpstate, regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		unsigned int restorer = IA32_SA_RESTORER(ka);
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
+		unsigned int restorer = IA32_SA_RESTORER(ka_copy);
 		err |= __put_user(restorer, &frame->pretcode);
 	} else {
 		err |= __put_user((long)frame->retcode, &frame->pretcode);
@@ -932,11 +949,11 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up registers for signal handler */
 	regs->r12 = (unsigned long) frame;
-	regs->cr_iip = IA32_SA_HANDLER(ka);
+	regs->cr_iip = IA32_SA_HANDLER(ka_copy);
 
 	set_fs(USER_DS);
 
@@ -944,29 +961,23 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	regs->eflags &= ~TF_MASK;
 #endif
 
-#if 0
+#if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%lx ra=%x\n",
                current->comm, current->pid, (void *) frame, regs->cr_iip, frame->pretcode);
 #endif
 
 	return 1;
-
-give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	force_sig(SIGSEGV, current);
-	return 0;
 }
 
 int
-ia32_setup_frame1 (int sig, struct k_sigaction *ka, siginfo_t *info,
+ia32_setup_frame1 (int sig, struct k_sigaction *ka_copy, siginfo_t *info,
 		   sigset_t *set, struct pt_regs *regs)
 {
        /* Set up the stack frame */
-       if (ka->sa.sa_flags & SA_SIGINFO)
-               return setup_rt_frame_ia32(sig, ka, info, set, regs);
+       if (ka_copy->sa.sa_flags & SA_SIGINFO)
+               return setup_rt_frame_ia32(sig, ka_copy, info, set, regs);
        else
-               return setup_frame_ia32(sig, ka, set, regs);
+               return setup_frame_ia32(sig, ka_copy, set, regs);
 }
 
 asmlinkage long
diff -puN arch/ia64/kernel/signal.c~signal-race-fix-ia64 arch/ia64/kernel/signal.c
--- 25/arch/ia64/kernel/signal.c~signal-race-fix-ia64	2004-07-26 21:48:34.241846144 -0700
+++ 25-akpm/arch/ia64/kernel/signal.c	2004-07-26 21:48:34.248845080 -0700
@@ -1,7 +1,7 @@
 /*
  * Architecture-specific signal handling support.
  *
- * Copyright (C) 1999-2003 Hewlett-Packard Co
+ * Copyright (C) 1999-2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *
  * Derived from i386 and Alpha versions.
@@ -352,18 +352,47 @@ rbs_on_sig_stack (unsigned long bsp)
 }
 
 static long
-setup_frame (int sig, struct k_sigaction *ka, siginfo_t *info, sigset_t *set,
+force_sigsegv (int sig, void *addr)
+{
+	unsigned long flags;
+	struct siginfo si;
+
+	if (sig == SIGSEGV) {
+		/*
+		 * Acquiring siglock around the sa_handler-update is almost
+		 * certainly overkill, but this isn't a
+		 * performance-critical path and I'd rather play it safe
+		 * here than having to debug a nasty race if and when
+		 * something changes in kernel/signal.c that would make it
+		 * no longer safe to modify sa_handler without holding the
+		 * lock.
+		 */
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		current->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	}
+	si.si_signo = SIGSEGV;
+	si.si_errno = 0;
+	si.si_code = SI_KERNEL;
+	si.si_pid = current->pid;
+	si.si_uid = current->uid;
+	si.si_addr = addr;
+	force_sig_info(SIGSEGV, &si, current);
+	return 0;
+}
+
+static long
+setup_frame (int sig, struct k_sigaction *ka_copy, siginfo_t *info, sigset_t *set,
 	     struct sigscratch *scr)
 {
 	extern char __kernel_sigtramp[];
 	unsigned long tramp_addr, new_rbs = 0;
 	struct sigframe *frame;
-	struct siginfo si;
 	long err;
 
 	frame = (void *) scr->pt.r12;
 	tramp_addr = (unsigned long) __kernel_sigtramp;
-	if ((ka->sa.sa_flags & SA_ONSTACK) && sas_ss_flags((unsigned long) frame) == 0) {
+	if ((ka_copy->sa.sa_flags & SA_ONSTACK) && sas_ss_flags((unsigned long) frame) == 0) {
 		frame = (void *) ((current->sas_ss_sp + current->sas_ss_size)
 				  & ~(STACK_ALIGN - 1));
 		/*
@@ -377,14 +406,14 @@ setup_frame (int sig, struct k_sigaction
 	frame = (void *) frame - ((sizeof(*frame) + STACK_ALIGN - 1) & ~(STACK_ALIGN - 1));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig, frame);
 
 	err  = __put_user(sig, &frame->arg0);
 	err |= __put_user(&frame->info, &frame->arg1);
 	err |= __put_user(&frame->sc, &frame->arg2);
 	err |= __put_user(new_rbs, &frame->sc.sc_rbs_base);
 	err |= __put_user(0, &frame->sc.sc_loadrs);	/* initialize to zero */
-	err |= __put_user(ka->sa.sa_handler, &frame->handler);
+	err |= __put_user(ka_copy->sa.sa_handler, &frame->handler);
 
 	err |= copy_siginfo_to_user(&frame->info, info);
 
@@ -393,8 +422,8 @@ setup_frame (int sig, struct k_sigaction
 	err |= __put_user(sas_ss_flags(scr->pt.r12), &frame->sc.sc_stack.ss_flags);
 	err |= setup_sigcontext(&frame->sc, set, scr);
 
-	if (err)
-		goto give_sigsegv;
+	if (unlikely(err))
+		return force_sigsegv(sig, frame);
 
 	scr->pt.r12 = (unsigned long) frame - 16;	/* new stack pointer */
 	scr->pt.ar_fpsr = FPSR_DEFAULT;			/* reset fpsr for signal handler */
@@ -422,40 +451,25 @@ setup_frame (int sig, struct k_sigaction
 	       current->comm, current->pid, sig, scr->pt.r12, frame->sc.sc_ip, frame->handler);
 #endif
 	return 1;
-
-  give_sigsegv:
-	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
-	si.si_signo = SIGSEGV;
-	si.si_errno = 0;
-	si.si_code = SI_KERNEL;
-	si.si_pid = current->pid;
-	si.si_uid = current->uid;
-	si.si_addr = frame;
-	force_sig_info(SIGSEGV, &si, current);
-	return 0;
 }
 
 static long
-handle_signal (unsigned long sig, struct k_sigaction *ka, siginfo_t *info, sigset_t *oldset,
+handle_signal (unsigned long sig, struct k_sigaction *ka_copy, siginfo_t *info, sigset_t *oldset,
 	       struct sigscratch *scr)
 {
 	if (IS_IA32_PROCESS(&scr->pt)) {
 		/* send signal to IA-32 process */
-		if (!ia32_setup_frame1(sig, ka, info, oldset, &scr->pt))
+		if (!ia32_setup_frame1(sig, ka_copy, info, oldset, &scr->pt))
 			return 0;
 	} else
 		/* send signal to IA-64 process */
-		if (!setup_frame(sig, ka, info, oldset, scr))
+		if (!setup_frame(sig, ka_copy, info, oldset, scr))
 			return 0;
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		{
-			sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+			sigorsets(&current->blocked, &current->blocked, &ka_copy->sa.sa_mask);
 			sigaddset(&current->blocked, sig);
 			recalc_sigpending();
 		}
@@ -471,7 +485,7 @@ handle_signal (unsigned long sig, struct
 long
 ia64_do_signal (sigset_t *oldset, struct sigscratch *scr, long in_syscall)
 {
-	struct k_sigaction *ka;
+	struct k_sigaction ka_copy;
 	siginfo_t info;
 	long restart = in_syscall;
 	long errno = scr->pt.r8;
@@ -493,7 +507,7 @@ ia64_do_signal (sigset_t *oldset, struct
 	 * need to push through a forced SIGSEGV.
 	 */
 	while (1) {
-		int signr = get_signal_to_deliver(&info, &scr->pt, NULL);
+		int signr = get_signal_to_deliver(&info, &ka_copy, &scr->pt, NULL);
 
 		/*
 		 * get_signal_to_deliver() may have run a debugger (via notify_parent())
@@ -520,8 +534,6 @@ ia64_do_signal (sigset_t *oldset, struct
 		if (signr <= 0)
 			break;
 
-		ka = &current->sighand->action[signr - 1];
-
 		if (unlikely(restart)) {
 			switch (errno) {
 			      case ERESTART_RESTARTBLOCK:
@@ -531,7 +543,7 @@ ia64_do_signal (sigset_t *oldset, struct
 				break;
 
 			      case ERESTARTSYS:
-				if ((ka->sa.sa_flags & SA_RESTART) == 0) {
+				if ((ka_copy.sa.sa_flags & SA_RESTART) == 0) {
 					scr->pt.r8 = ERR_CODE(EINTR);
 					/* note: scr->pt.r10 is already -1 */
 					break;
@@ -550,7 +562,7 @@ ia64_do_signal (sigset_t *oldset, struct
 		 * Whee!  Actually deliver the signal.  If the delivery failed, we need to
 		 * continue to iterate in this loop so we can deliver the SIGSEGV...
 		 */
-		if (handle_signal(signr, ka, &info, oldset, scr))
+		if (handle_signal(signr, &ka_copy, &info, oldset, scr))
 			return 1;
 	}
 
_
