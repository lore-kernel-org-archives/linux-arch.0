Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267325AbUHZAfl@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:46209 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267301AbUHZAdL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:11 -0400
Message-Id: <200408260033.i7Q0X5132198@mail.osdl.org>
Subject: [patch 4/8] signal-race-fixes: x86-64 support
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:45 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, ak@muc.de, mikpe@csd.uu.se
List-ID: <linux-arch.vger.kernel.org>


From: Andi Kleen <ak@muc.de>

  Add the signal race changes to x86-64 to make it compile again.

  Didn't merge the more pointless changes from i386.

  Also remove the special SA_ONESHOT handling, doesn't seem to be needed
  anymore.

From: Mikael Pettersson <mikpe@csd.uu.se>

  The signal-race-fixes patch in 2.6.8-rc2-mm1 appears to have broken
  x86-64's ia32 emulation.

  When forcing a SIGSEGV the old code updated "*ka", where ka was a pointer
  to current's k_sigaction for SIGSEGV.  Now "ka_copy" points to a copy of
  that structure, so assigning "*ka_copy" doesn't do what we want.  Instead do
  the assignment via current->...  just like the normal signal delivery code
  does.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/ia32/ia32_signal.c |   18 +++++++++---------
 25-akpm/arch/x86_64/kernel/signal.c    |   28 +++++++++++++---------------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff -puN arch/x86_64/ia32/ia32_signal.c~signal-race-fix-x86_64 arch/x86_64/ia32/ia32_signal.c
--- 25/arch/x86_64/ia32/ia32_signal.c~signal-race-fix-x86_64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/x86_64/ia32/ia32_signal.c	Wed Aug 25 17:35:08 2004
@@ -394,7 +394,7 @@ ia32_setup_sigcontext(struct sigcontext_
  * Determine which stack to use..
  */
 static void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long rsp;
 
@@ -411,14 +411,14 @@ get_sigframe(struct k_sigaction *ka, str
 	else if ((regs->ss & 0xffff) != __USER_DS &&
 		!(ka->sa.sa_flags & SA_RESTORER) &&
 		 ka->sa.sa_restorer) {
-		rsp = (unsigned long) ka->sa.sa_restorer;
+		rsp = (unsigned long)ka->sa.sa_restorer;
 	}
 
 	return (void __user *)((rsp - frame_size) & -8UL);
 }
 
 void ia32_setup_frame(int sig, struct k_sigaction *ka,
-			compat_sigset_t *set, struct pt_regs * regs)
+		compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
 	int err = 0;
@@ -455,7 +455,7 @@ void ia32_setup_frame(int sig, struct k_
 	{ 
 		void __user *restorer = VSYSCALL32_SIGRETURN; 
 		if (ka->sa.sa_flags & SA_RESTORER)
-			restorer = ka->sa.sa_restorer;       
+			restorer = ka->sa.sa_restorer;
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
 	}
 	/* These are actually not used anymore, but left because some 
@@ -500,12 +500,12 @@ void ia32_setup_frame(int sig, struct k_
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs,frame,"32bit signal deliver");
 }
 
-void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   compat_sigset_t *set, struct pt_regs * regs)
+void ia32_setup_rt_frame(int sig, struct k_sigaction *ka,
+		siginfo_t *info, compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
@@ -548,7 +548,7 @@ void ia32_setup_rt_frame(int sig, struct
 	{ 
 		void __user *restorer = VSYSCALL32_RTSIGRETURN; 
 		if (ka->sa.sa_flags & SA_RESTORER)
-			restorer = ka->sa.sa_restorer;       
+			restorer = ka->sa.sa_restorer;
 		err |= __put_user(ptr_to_u32(restorer), &frame->pretcode);
 	}
 
@@ -596,7 +596,7 @@ void ia32_setup_rt_frame(int sig, struct
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs, frame, "32bit rt signal setup"); 
 }
 
diff -puN arch/x86_64/kernel/signal.c~signal-race-fix-x86_64 arch/x86_64/kernel/signal.c
--- 25/arch/x86_64/kernel/signal.c~signal-race-fix-x86_64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/x86_64/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -233,7 +233,8 @@ get_stack(struct k_sigaction *ka, struct
 	return (void __user *)round_down(rsp - size, 16); 
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+static void setup_rt_frame(int sig, struct k_sigaction *ka,
+			   siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe __user *frame;
@@ -242,7 +243,7 @@ static void setup_rt_frame(int sig, stru
 	struct task_struct *me = current;
 
 	if (me->used_math) {
-		fp = get_stack(ka, regs, sizeof(struct _fpstate)); 
+		fp = get_stack(ka, regs, sizeof(struct _fpstate));
 		frame = (void __user *)round_down((unsigned long)fp - sizeof(struct rt_sigframe), 16) - 8;
 
 		if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate))) { 
@@ -259,7 +260,7 @@ static void setup_rt_frame(int sig, stru
 		goto give_sigsegv;
 	}
 
-	if (ka->sa.sa_flags & SA_SIGINFO) { 
+	if (ka->sa.sa_flags & SA_SIGINFO) {
 		err |= copy_siginfo_to_user(&frame->info, info);
 		if (err) { 
 			goto give_sigsegv;
@@ -288,7 +289,7 @@ static void setup_rt_frame(int sig, stru
 	if (ka->sa.sa_flags & SA_RESTORER) {
 		err |= __put_user(ka->sa.sa_restorer, &frame->pretcode);
 	} else {
-		printk("%s forgot to set SA_RESTORER for signal %d.\n", me->comm, sig); 
+		/* could use a vstub here */
 		goto give_sigsegv; 
 	}
 
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
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
+		sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 #ifdef DEBUG_SIG
 	printk("handle_signal pid:%d sig:%lu rip:%lx rsp:%lx regs=%p\n", current->pid, sig, 
 		regs->rip, regs->rsp, regs);
@@ -380,12 +379,10 @@ handle_signal(unsigned long sig, siginfo
 #endif
 	setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,
+			  &ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -399,6 +396,7 @@ handle_signal(unsigned long sig, siginfo
  */
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
+	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
 
@@ -420,7 +418,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -431,7 +429,7 @@ int do_signal(struct pt_regs *regs, sigs
 			asm volatile("movq %0,%%db7"	: : "r" (current->thread.debugreg7));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 
_
