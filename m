Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S265087AbUHYVyX@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:1747 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269151AbUHYVcG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:32:06 -0400
Message-Id: <200408252131.i7PLVt129265@mail.osdl.org>
Subject: [patch 4/8] signal-race-fixes: x86-64 support
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:30:11 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, ak@muc.de, mikpe@csd.uu.se
List-ID: <linux-arch.vger.kernel.org>


From: Andi Kleen <ak@muc.de>

Add the signal race changes to x86-64 to make it compile again.

Didn't merge the more pointless changes from i386.

Also remove the special SA_ONESHOT handling, doesn't seem to be needed
anymore.
DESC
x86_64 signal handling fix
EDESC
From: Mikael Pettersson <mikpe@csd.uu.se>

The signal-race-fixes patch in 2.6.8-rc2-mm1 appears to have broken
x86-64's ia32 emulation.

When forcing a SIGSEGV the old code updated "*ka", where ka was a pointer
to current's k_sigaction for SIGSEGV.  Now "ka_copy" points to a copy of
that structure, so assigning "*ka_copy" doesn't do what we want.  Instead
do the assignment via current->...  just like the normal signal delivery
code does.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/ia32/ia32_signal.c |   38 +++++++++++++-------------
 25-akpm/arch/x86_64/kernel/signal.c    |   48 +++++++++++++++------------------
 2 files changed, 42 insertions(+), 44 deletions(-)

diff -puN arch/x86_64/ia32/ia32_signal.c~signal-race-fix-x86_64 arch/x86_64/ia32/ia32_signal.c
--- 25/arch/x86_64/ia32/ia32_signal.c~signal-race-fix-x86_64	2004-08-25 14:26:48.950253936 -0700
+++ 25-akpm/arch/x86_64/ia32/ia32_signal.c	2004-08-25 14:26:48.956253024 -0700
@@ -394,7 +394,7 @@ ia32_setup_sigcontext(struct sigcontext_
  * Determine which stack to use..
  */
 static void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka_copy, struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long rsp;
 
@@ -402,28 +402,28 @@ get_sigframe(struct k_sigaction *ka, str
 	rsp = regs->rsp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ka_copy->sa.sa_flags & SA_ONSTACK) {
 		if (sas_ss_flags(rsp) == 0)
 			rsp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
 	/* This is the legacy signal stack switching. */
 	else if ((regs->ss & 0xffff) != __USER_DS &&
-		!(ka->sa.sa_flags & SA_RESTORER) &&
-		 ka->sa.sa_restorer) {
-		rsp = (unsigned long) ka->sa.sa_restorer;
+		!(ka_copy->sa.sa_flags & SA_RESTORER) &&
+		 ka_copy->sa.sa_restorer) {
+		rsp = (unsigned long)ka_copy->sa.sa_restorer;
 	}
 
 	return (void __user *)((rsp - frame_size) & -8UL);
 }
 
-void ia32_setup_frame(int sig, struct k_sigaction *ka,
-			compat_sigset_t *set, struct pt_regs * regs)
+void ia32_setup_frame(int sig, struct k_sigaction *ka_copy,
+		compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -454,8 +454,8 @@ void ia32_setup_frame(int sig, struct k_
 	/* Return stub is in 32bit vsyscall page */
 	{ 
 		void __user *restorer = VSYSCALL32_SIGRETURN; 
-		if (ka->sa.sa_flags & SA_RESTORER)
-			restorer = ka->sa.sa_restorer;       
+		if (ka_copy->sa.sa_flags & SA_RESTORER)
+			restorer = ka_copy->sa.sa_restorer;
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
 	}
 	/* These are actually not used anymore, but left because some 
@@ -480,7 +480,7 @@ void ia32_setup_frame(int sig, struct k_
 
 	/* Set up registers for signal handler */
 	regs->rsp = (unsigned long) frame;
-	regs->rip = (unsigned long) ka->sa.sa_handler;
+	regs->rip = (unsigned long) ka_copy->sa.sa_handler;
 
 	asm volatile("movl %0,%%ds" :: "r" (__USER32_DS)); 
 	asm volatile("movl %0,%%es" :: "r" (__USER32_DS)); 
@@ -500,17 +500,17 @@ void ia32_setup_frame(int sig, struct k_
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs,frame,"32bit signal deliver");
 }
 
-void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   compat_sigset_t *set, struct pt_regs * regs)
+void ia32_setup_rt_frame(int sig, struct k_sigaction *ka_copy,
+		siginfo_t *info, compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -547,8 +547,8 @@ void ia32_setup_rt_frame(int sig, struct
 	
 	{ 
 		void __user *restorer = VSYSCALL32_RTSIGRETURN; 
-		if (ka->sa.sa_flags & SA_RESTORER)
-			restorer = ka->sa.sa_restorer;       
+		if (ka_copy->sa.sa_flags & SA_RESTORER)
+			restorer = ka_copy->sa.sa_restorer;
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
 	}
 
@@ -576,7 +576,7 @@ void ia32_setup_rt_frame(int sig, struct
 
 	/* Set up registers for signal handler */
 	regs->rsp = (unsigned long) frame;
-	regs->rip = (unsigned long) ka->sa.sa_handler;
+	regs->rip = (unsigned long) ka_copy->sa.sa_handler;
 
 	asm volatile("movl %0,%%ds" :: "r" (__USER32_DS)); 
 	asm volatile("movl %0,%%es" :: "r" (__USER32_DS)); 
@@ -596,7 +596,7 @@ void ia32_setup_rt_frame(int sig, struct
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs, frame, "32bit rt signal setup"); 
 }
 
diff -puN arch/x86_64/kernel/signal.c~signal-race-fix-x86_64 arch/x86_64/kernel/signal.c
--- 25/arch/x86_64/kernel/signal.c~signal-race-fix-x86_64	2004-08-25 14:26:48.951253784 -0700
+++ 25-akpm/arch/x86_64/kernel/signal.c	2004-08-25 14:26:48.957252872 -0700
@@ -233,7 +233,8 @@ get_stack(struct k_sigaction *ka, struct
 	return (void __user *)round_down(rsp - size, 16); 
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+static void setup_rt_frame(int sig, struct k_sigaction *ka_copy,
+			   siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe __user *frame;
@@ -242,7 +243,7 @@ static void setup_rt_frame(int sig, stru
 	struct task_struct *me = current;
 
 	if (me->used_math) {
-		fp = get_stack(ka, regs, sizeof(struct _fpstate)); 
+		fp = get_stack(ka_copy, regs, sizeof(struct _fpstate));
 		frame = (void __user *)round_down((unsigned long)fp - sizeof(struct rt_sigframe), 16) - 8;
 
 		if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate))) { 
@@ -252,14 +253,14 @@ static void setup_rt_frame(int sig, stru
 		if (save_i387(fp) < 0) 
 			err |= -1; 
 	} else {
-		frame = get_stack(ka, regs, sizeof(struct rt_sigframe)) - 8;
+		frame = get_stack(ka_copy, regs, sizeof(struct rt_sigframe)) - 8;
 	}
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame))) {
 		goto give_sigsegv;
 	}
 
-	if (ka->sa.sa_flags & SA_SIGINFO) { 
+	if (ka_copy->sa.sa_flags & SA_SIGINFO) {
 		err |= copy_siginfo_to_user(&frame->info, info);
 		if (err) { 
 			goto give_sigsegv;
@@ -285,10 +286,10 @@ static void setup_rt_frame(int sig, stru
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
 	/* x86-64 should always use SA_RESTORER. */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		err |= __put_user(ka->sa.sa_restorer, &frame->pretcode);
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
+		err |= __put_user(ka_copy->sa.sa_restorer, &frame->pretcode);
 	} else {
-		printk("%s forgot to set SA_RESTORER for signal %d.\n", me->comm, sig); 
+		/* could use a vstub here */
 		goto give_sigsegv; 
 	}
 
@@ -314,7 +315,7 @@ static void setup_rt_frame(int sig, stru
 	   next argument after the signal number on the stack. */
 	regs->rsi = (unsigned long)&frame->info; 
 	regs->rdx = (unsigned long)&frame->uc; 
-	regs->rip = (unsigned long) ka->sa.sa_handler;
+	regs->rip = (unsigned long) ka_copy->sa.sa_handler;
 
 	regs->rsp = (unsigned long)frame;
 
@@ -330,7 +331,7 @@ static void setup_rt_frame(int sig, stru
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs,frame,"signal deliver");
 }
 
@@ -339,11 +340,9 @@ give_sigsegv:
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka_copy,
+		sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 #ifdef DEBUG_SIG
 	printk("handle_signal pid:%d sig:%lu rip:%lx rsp:%lx regs=%p\n", current->pid, sig, 
 		regs->rip, regs->rsp, regs);
@@ -359,7 +358,7 @@ handle_signal(unsigned long sig, siginfo
 				break;
 
 			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
+				if (!(ka_copy->sa.sa_flags & SA_RESTART)) {
 					regs->rax = -EINTR;
 					break;
 				}
@@ -372,20 +371,18 @@ handle_signal(unsigned long sig, siginfo
 
 #ifdef CONFIG_IA32_EMULATION
 	if (test_thread_flag(TIF_IA32)) {
-		if (ka->sa.sa_flags & SA_SIGINFO)
-			ia32_setup_rt_frame(sig, ka, info, oldset, regs);
+		if (ka_copy->sa.sa_flags & SA_SIGINFO)
+			ia32_setup_rt_frame(sig, ka_copy, info, oldset, regs);
 		else
-			ia32_setup_frame(sig, ka, oldset, regs);
+			ia32_setup_frame(sig, ka_copy, oldset, regs);
 	} else 
 #endif
-	setup_rt_frame(sig, ka, info, oldset, regs);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+	setup_rt_frame(sig, ka_copy, info, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -399,6 +396,7 @@ handle_signal(unsigned long sig, siginfo
  */
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
+	struct k_sigaction ka_copy;
 	siginfo_t info;
 	int signr;
 
@@ -420,7 +418,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -431,7 +429,7 @@ int do_signal(struct pt_regs *regs, sigs
 			asm volatile("movq %0,%%db7"	: : "r" (current->thread.debugreg7));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka_copy, oldset, regs);
 		return 1;
 	}
 
_
