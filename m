Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267291AbUHZAfm@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:44417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267251AbUHZAdJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:09 -0400
Message-Id: <200408260033.i7Q0X3132167@mail.osdl.org>
Subject: [patch 2/8] signal-race-fix: ia64
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:43 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, davidm@napali.hpl.hp.com
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

 25-akpm/arch/ia64/ia32/ia32_signal.c |   51 ++++++++++++++++-----------
 25-akpm/arch/ia64/kernel/signal.c    |   64 ++++++++++++++++++++---------------
 2 files changed, 69 insertions(+), 46 deletions(-)

diff -puN arch/ia64/ia32/ia32_signal.c~signal-race-fix-ia64 arch/ia64/ia32/ia32_signal.c
--- 25/arch/ia64/ia32/ia32_signal.c~signal-race-fix-ia64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/ia64/ia32/ia32_signal.c	Wed Aug 25 17:13:41 2004
@@ -1,7 +1,7 @@
 /*
  * IA32 Architecture-specific signal handling support.
  *
- * Copyright (C) 1999, 2001-2002 Hewlett-Packard Co
+ * Copyright (C) 1999, 2001-2002, 2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  * Copyright (C) 1999 Arun Sharma <arun.sharma@intel.com>
  * Copyright (C) 2000 VA Linux Co
@@ -826,6 +826,29 @@ get_sigframe (struct k_sigaction *ka, st
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
 setup_frame_ia32 (int sig, struct k_sigaction *ka, sigset_t *set, struct pt_regs * regs)
 {
@@ -836,7 +859,7 @@ setup_frame_ia32 (int sig, struct k_siga
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	err |= __put_user((ed && ed->signal_invmap && sig < 32
 			   ? (int)(ed->signal_invmap[sig]) : sig), &frame->sig);
@@ -862,7 +885,7 @@ setup_frame_ia32 (int sig, struct k_siga
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up registers for signal handler */
 	regs->r12 = (unsigned long) frame;
@@ -874,18 +897,12 @@ setup_frame_ia32 (int sig, struct k_siga
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
@@ -899,7 +916,7 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	err |= __put_user((ed && ed->signal_invmap
 			   && sig < 32 ? ed->signal_invmap[sig] : sig), &frame->sig);
@@ -916,7 +933,7 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	err |= setup_sigcontext_ia32(&frame->uc.uc_mcontext, &frame->fpstate, regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
@@ -932,7 +949,7 @@ setup_rt_frame_ia32 (int sig, struct k_s
 	}
 
 	if (err)
-		goto give_sigsegv;
+		return force_sigsegv(sig);
 
 	/* Set up registers for signal handler */
 	regs->r12 = (unsigned long) frame;
@@ -944,18 +961,12 @@ setup_rt_frame_ia32 (int sig, struct k_s
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
diff -puN arch/ia64/kernel/signal.c~signal-race-fix-ia64 arch/ia64/kernel/signal.c
--- 25/arch/ia64/kernel/signal.c~signal-race-fix-ia64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/ia64/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -1,7 +1,7 @@
 /*
  * Architecture-specific signal handling support.
  *
- * Copyright (C) 1999-2003 Hewlett-Packard Co
+ * Copyright (C) 1999-2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *
  * Derived from i386 and Alpha versions.
@@ -352,13 +352,42 @@ rbs_on_sig_stack (unsigned long bsp)
 }
 
 static long
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
 setup_frame (int sig, struct k_sigaction *ka, siginfo_t *info, sigset_t *set,
 	     struct sigscratch *scr)
 {
 	extern char __kernel_sigtramp[];
 	unsigned long tramp_addr, new_rbs = 0;
 	struct sigframe *frame;
-	struct siginfo si;
 	long err;
 
 	frame = (void *) scr->pt.r12;
@@ -377,7 +406,7 @@ setup_frame (int sig, struct k_sigaction
 	frame = (void *) frame - ((sizeof(*frame) + STACK_ALIGN - 1) & ~(STACK_ALIGN - 1));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
+		return force_sigsegv(sig, frame);
 
 	err  = __put_user(sig, &frame->arg0);
 	err |= __put_user(&frame->info, &frame->arg1);
@@ -393,8 +422,8 @@ setup_frame (int sig, struct k_sigaction
 	err |= __put_user(sas_ss_flags(scr->pt.r12), &frame->sc.sc_stack.ss_flags);
 	err |= setup_sigcontext(&frame->sc, set, scr);
 
-	if (err)
-		goto give_sigsegv;
+	if (unlikely(err))
+		return force_sigsegv(sig, frame);
 
 	scr->pt.r12 = (unsigned long) frame - 16;	/* new stack pointer */
 	scr->pt.ar_fpsr = FPSR_DEFAULT;			/* reset fpsr for signal handler */
@@ -422,18 +451,6 @@ setup_frame (int sig, struct k_sigaction
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
@@ -449,9 +466,6 @@ handle_signal (unsigned long sig, struct
 		if (!setup_frame(sig, ka, info, oldset, scr))
 			return 0;
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		{
@@ -471,7 +485,7 @@ handle_signal (unsigned long sig, struct
 long
 ia64_do_signal (sigset_t *oldset, struct sigscratch *scr, long in_syscall)
 {
-	struct k_sigaction *ka;
+	struct k_sigaction ka;
 	siginfo_t info;
 	long restart = in_syscall;
 	long errno = scr->pt.r8;
@@ -493,7 +507,7 @@ ia64_do_signal (sigset_t *oldset, struct
 	 * need to push through a forced SIGSEGV.
 	 */
 	while (1) {
-		int signr = get_signal_to_deliver(&info, &scr->pt, NULL);
+		int signr = get_signal_to_deliver(&info, &ka, &scr->pt, NULL);
 
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
+				if ((ka.sa.sa_flags & SA_RESTART) == 0) {
 					scr->pt.r8 = ERR_CODE(EINTR);
 					/* note: scr->pt.r10 is already -1 */
 					break;
@@ -550,7 +562,7 @@ ia64_do_signal (sigset_t *oldset, struct
 		 * Whee!  Actually deliver the signal.  If the delivery failed, we need to
 		 * continue to iterate in this loop so we can deliver the SIGSEGV...
 		 */
-		if (handle_signal(signr, ka, &info, oldset, scr))
+		if (handle_signal(signr, &ka, &info, oldset, scr))
 			return 1;
 	}
 
_
