Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266808AbUHYVnh@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:9179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266733AbUHYVk1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:40:27 -0400
Message-Id: <200408252140.i7PLeN131520@mail.osdl.org>
Subject: [patch 3/8] signal-race fixes for s390
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 14:38:40 -0700
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

 25-akpm/arch/s390/kernel/compat_signal.c |   49 ++++++++++++---------------
 25-akpm/arch/s390/kernel/signal.c        |   56 ++++++++++++++-----------------
 2 files changed, 50 insertions(+), 55 deletions(-)

diff -puN arch/s390/kernel/compat_signal.c~signal-race-fix-s390 arch/s390/kernel/compat_signal.c
--- 25/arch/s390/kernel/compat_signal.c~signal-race-fix-s390	2004-08-25 14:26:48.294353648 -0700
+++ 25-akpm/arch/s390/kernel/compat_signal.c	2004-08-25 14:26:48.299352888 -0700
@@ -504,10 +504,10 @@ static inline int map_signal(int sig)
 		return sig;
 }
 
-static void setup_frame32(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static void setup_frame32(int sig, struct k_sigaction *ka_copy,
+			sigset_t *set, struct pt_regs *regs)
 {
-	sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(sigframe32));
+	sigframe32 __user *frame = get_sigframe(ka_copy, regs, sizeof(sigframe32));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(sigframe32)))
 		goto give_sigsegv;
 
@@ -521,8 +521,8 @@ static void setup_frame32(int sig, struc
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = (__u64) ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
+		regs->gprs[14] = (__u64) ka_copy->sa.sa_restorer;
 	} else {
 		regs->gprs[14] = (__u64) frame->retcode;
 		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
@@ -536,7 +536,7 @@ static void setup_frame32(int sig, struc
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__u64) frame;
-	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.addr = (__u64) ka_copy->sa.sa_handler;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__u64) &frame->sc;
@@ -553,15 +553,16 @@ static void setup_frame32(int sig, struc
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame32(int sig, struct k_sigaction *ka_copy,
+			     siginfo_t *info, sigset_t *set,
+			     struct pt_regs *regs)
 {
 	int err = 0;
-	rt_sigframe32 __user *frame = get_sigframe(ka, regs, sizeof(rt_sigframe32));
+	rt_sigframe32 __user *frame = get_sigframe(ka_copy, regs, sizeof(rt_sigframe32));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(rt_sigframe32)))
 		goto give_sigsegv;
 
@@ -582,8 +583,8 @@ static void setup_rt_frame32(int sig, st
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
-		regs->gprs[14] = (__u64) ka->sa.sa_restorer;
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
+		regs->gprs[14] = (__u64) ka_copy->sa.sa_restorer;
 	} else {
 		regs->gprs[14] = (__u64) frame->retcode;
 		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
@@ -596,7 +597,7 @@ static void setup_rt_frame32(int sig, st
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (__u64) frame;
-	regs->psw.addr = (__u64) ka->sa.sa_handler;
+	regs->psw.addr = (__u64) ka_copy->sa.sa_handler;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (__u64) &frame->info;
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
+handle_signal32(unsigned long sig, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame32(sig, ka, info, oldset, regs);
+	if (ka_copy->sa.sa_flags & SA_SIGINFO)
+		setup_rt_frame32(sig, ka_copy, info, oldset, regs);
 	else
-		setup_frame32(sig, ka, oldset, regs);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		setup_frame32(sig, ka_copy, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
diff -puN arch/s390/kernel/signal.c~signal-race-fix-s390 arch/s390/kernel/signal.c
--- 25/arch/s390/kernel/signal.c~signal-race-fix-s390	2004-08-25 14:26:48.295353496 -0700
+++ 25-akpm/arch/s390/kernel/signal.c	2004-08-25 14:26:48.301352584 -0700
@@ -306,12 +306,12 @@ static inline int map_signal(int sig)
 		return sig;
 }
 
-static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static void setup_frame(int sig, struct k_sigaction *ka_copy,
+			sigset_t *set, struct pt_regs *regs)
 {
 	sigframe __user *frame;
 
-	frame = get_sigframe(ka, regs, sizeof(sigframe));
+	frame = get_sigframe(ka_copy, regs, sizeof(sigframe));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(sigframe)))
 		goto give_sigsegv;
 
@@ -325,9 +325,9 @@ static void setup_frame(int sig, struct 
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
                 regs->gprs[14] = (unsigned long)
-			ka->sa.sa_restorer | PSW_ADDR_AMODE;
+			ka_copy->sa.sa_restorer | PSW_ADDR_AMODE;
 	} else {
                 regs->gprs[14] = (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
@@ -342,7 +342,7 @@ static void setup_frame(int sig, struct 
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
-	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) ka_copy->sa.sa_handler | PSW_ADDR_AMODE;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (unsigned long) &frame->sc;
@@ -359,17 +359,17 @@ static void setup_frame(int sig, struct 
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   sigset_t *set, struct pt_regs * regs)
+static void setup_rt_frame(int sig, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	int err = 0;
 	rt_sigframe __user *frame;
 
-	frame = get_sigframe(ka, regs, sizeof(rt_sigframe));
+	frame = get_sigframe(ka_copy, regs, sizeof(rt_sigframe));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(rt_sigframe)))
 		goto give_sigsegv;
 
@@ -390,9 +390,9 @@ static void setup_rt_frame(int sig, stru
 
 	/* Set up to return from userspace.  If provided, use a stub
 	   already in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER) {
+	if (ka_copy->sa.sa_flags & SA_RESTORER) {
                 regs->gprs[14] = (unsigned long)
-			ka->sa.sa_restorer | PSW_ADDR_AMODE;
+			ka_copy->sa.sa_restorer | PSW_ADDR_AMODE;
 	} else {
                 regs->gprs[14] = (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
@@ -406,7 +406,7 @@ static void setup_rt_frame(int sig, stru
 
 	/* Set up registers for signal handler */
 	regs->gprs[15] = (unsigned long) frame;
-	regs->psw.addr = (unsigned long) ka->sa.sa_handler | PSW_ADDR_AMODE;
+	regs->psw.addr = (unsigned long) ka_copy->sa.sa_handler | PSW_ADDR_AMODE;
 
 	regs->gprs[2] = map_signal(sig);
 	regs->gprs[3] = (unsigned long) &frame->info;
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
+handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
+	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
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
+		sigorsets(&current->blocked,&current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -461,6 +457,7 @@ int do_signal(struct pt_regs *regs, sigs
 	unsigned long retval = 0, continue_addr = 0, restart_addr = 0;
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka_copy;
 
 	/*
 	 * We want the common case to go fast, which
@@ -494,7 +491,7 @@ int do_signal(struct pt_regs *regs, sigs
 
 	/* Get signal to deliver.  When running under ptrace, at this point
 	   the debugger may change all our registers ... */
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	/* Depending on the signal settings we may need to revert the
 	   decision to restart the system call. */
@@ -513,14 +510,15 @@ int do_signal(struct pt_regs *regs, sigs
 #ifdef CONFIG_S390_SUPPORT
 		if (test_thread_flag(TIF_31BIT)) {
 			extern void handle_signal32(unsigned long sig,
+						    struct k_sigaction *ka_copy,
 						    siginfo_t *info,
 						    sigset_t *oldset,
 						    struct pt_regs *regs);
-			handle_signal32(signr, &info, oldset, regs);
+			handle_signal32(signr, &ka_copy, &info, oldset, regs);
 			return 1;
 	        }
 #endif
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &ka_copy, &info, oldset, regs);
 		return 1;
 	}
 
_
