Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267318AbUHZAfm@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:44673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267291AbUHZAdJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:09 -0400
Message-Id: <200408260033.i7Q0X4132179@mail.osdl.org>
Subject: [patch 3/8] signal-race fixes for s390
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:44 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, schwidefsky@de.ibm.com, mikpe@csd.uu.se
List-ID: <linux-arch.vger.kernel.org>


From: Martin Schwidefsky <schwidefsky@de.ibm.com>

  Update s30 for the signal race fix

From: Mikael Pettersson <mikpe@csd.uu.se>

  The signal-race-fixes patch in 2.6.8-rc2-mm1 appears to be a bit broken on
  s390.

  When forcing a SIGSEGV the old code updated "*ka", where ka was a pointer
  to current's k_sigaction for SIGSEGV.  Now "ka_copy" points to a copy of
  that structure, so assigning "*ka_copy" doesn't do what we want.  Instead do
  the assignment via current->...  just like i386 and x86_64 do.

  Furthermore, the SA_ONESHOT handling wasn't deleted.  That is now handled
  by generic code in the kernel.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/s390/kernel/compat_signal.c |   23 ++++++++++-------------
 25-akpm/arch/s390/kernel/signal.c        |   30 ++++++++++++++----------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff -puN arch/s390/kernel/compat_signal.c~signal-race-fix-s390 arch/s390/kernel/compat_signal.c
--- 25/arch/s390/kernel/compat_signal.c~signal-race-fix-s390	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/s390/kernel/compat_signal.c	Wed Aug 25 17:13:41 2004
@@ -505,7 +505,7 @@ static inline int map_signal(int sig)
 }
 
 static void setup_frame32(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+			sigset_t *set, struct pt_regs *regs)
 {
 	sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(sigframe32));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(sigframe32)))
@@ -553,12 +553,13 @@ static void setup_frame32(int sig, struc
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame32(int sig, struct k_sigaction *ka,
+			     siginfo_t *info, sigset_t *set,
+			     struct pt_regs *regs)
 {
 	int err = 0;
 	rt_sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(rt_sigframe32));
@@ -605,7 +606,7 @@ static void setup_rt_frame32(int sig, st
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -614,23 +615,19 @@ give_sigsegv:
  */	
 
 void
-handle_signal32(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal32(unsigned long sig, struct k_sigaction *ka,
+		siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame32(sig, ka, info, oldset, regs);
 	else
 		setup_frame32(sig, ka, oldset, regs);
 
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
diff -puN arch/s390/kernel/signal.c~signal-race-fix-s390 arch/s390/kernel/signal.c
--- 25/arch/s390/kernel/signal.c~signal-race-fix-s390	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/s390/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -307,7 +307,7 @@ static inline int map_signal(int sig)
 }
 
 static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+			sigset_t *set, struct pt_regs *regs)
 {
 	sigframe __user *frame;
 
@@ -359,12 +359,12 @@ static void setup_frame(int sig, struct 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame(int sig, struct k_sigaction *ka,
+		siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	int err = 0;
 	rt_sigframe __user *frame;
@@ -415,7 +415,7 @@ static void setup_rt_frame(int sig, stru
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -424,23 +424,19 @@ give_sigsegv:
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal(unsigned long sig, struct k_sigaction *ka,
+	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(sig, ka, info, oldset, regs);
 	else
 		setup_frame(sig, ka, oldset, regs);
 
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
@@ -461,6 +457,7 @@ int do_signal(struct pt_regs *regs, sigs
 	unsigned long retval = 0, continue_addr = 0, restart_addr = 0;
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -494,7 +491,7 @@ int do_signal(struct pt_regs *regs, sigs
 
 	/* Get signal to deliver.  When running under ptrace, at this point
 	   the debugger may change all our registers ... */
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
 	/* Depending on the signal settings we may need to revert the
 	   decision to restart the system call. */
@@ -513,14 +510,15 @@ int do_signal(struct pt_regs *regs, sigs
 #ifdef CONFIG_S390_SUPPORT
 		if (test_thread_flag(TIF_31BIT)) {
 			extern void handle_signal32(unsigned long sig,
+						    struct k_sigaction *ka,
 						    siginfo_t *info,
 						    sigset_t *oldset,
 						    struct pt_regs *regs);
-			handle_signal32(signr, &info, oldset, regs);
+			handle_signal32(signr, &ka, &info, oldset, regs);
 			return 1;
 	        }
 #endif
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 
_
