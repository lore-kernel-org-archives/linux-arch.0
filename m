Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267319AbUHZAfi@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:48001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267325AbUHZAdL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:11 -0400
Message-Id: <200408260033.i7Q0X6132229@mail.osdl.org>
Subject: [patch 6/8] signal handling race fixes: sparc and sparc64
From: akpm@osdl.org
Date: Wed, 25 Aug 2004 17:36:47 -0700
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org, akpm@osdl.org, davem@redhat.com
List-ID: <linux-arch.vger.kernel.org>


From: "David S. Miller" <davem@redhat.com>

Ok, here are the sparc64 and sparc32 versions.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/sparc/kernel/signal.c     |   20 +++++++++-----------
 25-akpm/arch/sparc64/kernel/signal.c   |   21 +++++++++------------
 25-akpm/arch/sparc64/kernel/signal32.c |   29 +++++++++++++++--------------
 arch/i386/kernel/signal.c              |    0 
 include/linux/signal.h                 |    0 
 kernel/signal.c                        |    0 
 6 files changed, 33 insertions(+), 37 deletions(-)

diff -puN arch/i386/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/i386/kernel/signal.c
diff -puN arch/sparc64/kernel/signal32.c~signal-race-fixes-sparc-sparc64 arch/sparc64/kernel/signal32.c
--- 25/arch/sparc64/kernel/signal32.c~signal-race-fixes-sparc-sparc64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/sparc64/kernel/signal32.c	Wed Aug 25 17:13:41 2004
@@ -672,7 +672,8 @@ static int save_fpu_state32(struct pt_re
 	return err;
 }
 
-static void new_setup_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void new_setup_frame32(struct k_sigaction *ka,
+			      struct pt_regs *regs,
 			      int signo, sigset_t *oldset)
 {
 	struct new_signal_frame32 __user *sf;
@@ -1074,7 +1075,8 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame32(struct k_sigaction *ka, struct pt_regs *regs,
+static void setup_rt_frame32(struct k_sigaction *ka,
+			     struct pt_regs *regs,
 			     unsigned long signr, sigset_t *oldset,
 			     siginfo_t *info)
 {
@@ -1211,7 +1213,8 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static inline void handle_signal32(unsigned long signr, struct k_sigaction *ka,
+static inline void handle_signal32(unsigned long signr,
+				   struct k_sigaction *ka,
 				   siginfo_t *info,
 				   sigset_t *oldset, struct pt_regs *regs,
 				   int svr4_signal)
@@ -1227,18 +1230,18 @@ static inline void handle_signal32(unsig
 		else
 			setup_frame32(&ka->sa, regs, signr, oldset, info);
 	}
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
 	if (!(ka->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka->sa.sa_mask);
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
+	struct k_sigaction ka;
 	int signr;
 	int svr4_signal = current->personality == PER_SVR4;
 	
 	cookie.restart_syscall = restart_syscall;
 	cookie.orig_i0 = orig_i0;
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart32(orig_i0, regs, &ka->sa);
-		handle_signal32(signr, ka, &info, oldset, regs, svr4_signal);
+			syscall_restart32(orig_i0, regs, &ka.sa);
+		handle_signal32(signr, &ka, &info, oldset,
+				regs, svr4_signal);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN arch/sparc64/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/sparc64/kernel/signal.c
--- 25/arch/sparc64/kernel/signal.c~signal-race-fixes-sparc-sparc64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/sparc64/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -568,17 +568,17 @@ sigsegv:
 	do_exit(SIGSEGV);
 }
 
-static inline void handle_signal(unsigned long signr, struct k_sigaction *ka,
+static inline void handle_signal(unsigned long signr,
+				 struct k_sigaction *ka,
 				 siginfo_t *info,
 				 sigset_t *oldset, struct pt_regs *regs)
 {
 	setup_rt_frame(ka, regs, signr, oldset,
 		       (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
 	if (!(ka->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka->sa.sa_mask);
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
+	struct k_sigaction ka;
 	int signr;
 	
 	cookie.restart_syscall = restart_syscall;
@@ -632,15 +633,11 @@ static int do_signal(sigset_t *oldset, s
 	}
 #endif	
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart(orig_i0, regs, &ka->sa);
-		handle_signal(signr, ka, &info, oldset, regs);
+			syscall_restart(orig_i0, regs, &ka.sa);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN arch/sparc/kernel/signal.c~signal-race-fixes-sparc-sparc64 arch/sparc/kernel/signal.c
--- 25/arch/sparc/kernel/signal.c~signal-race-fixes-sparc-sparc64	Wed Aug 25 17:13:41 2004
+++ 25-akpm/arch/sparc/kernel/signal.c	Wed Aug 25 17:13:41 2004
@@ -1027,7 +1027,8 @@ handle_signal(unsigned long signr, struc
 	      int svr4_signal)
 {
 	if (svr4_signal)
-		setup_svr4_frame(&ka->sa, regs->pc, regs->npc, regs, signr, oldset);
+		setup_svr4_frame(&ka->sa, regs->pc, regs->npc,
+				 regs, signr, oldset);
 	else {
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			new_setup_rt_frame(ka, regs, signr, oldset, info);
@@ -1036,11 +1037,10 @@ handle_signal(unsigned long signr, struc
 		else
 			setup_frame(&ka->sa, regs, signr, oldset, info);
 	}
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
 	if (!(ka->sa.sa_flags & SA_NOMASK)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka->sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
@@ -1077,6 +1077,7 @@ asmlinkage int do_signal(sigset_t *oldse
 {
 	siginfo_t info;
 	struct sparc_deliver_cookie cookie;
+	struct k_sigaction ka;
 	int signr;
 
 	/*
@@ -1096,15 +1097,12 @@ asmlinkage int do_signal(sigset_t *oldse
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, &cookie);
+	signr = get_signal_to_deliver(&info, &ka, regs, &cookie);
 	if (signr > 0) {
-		struct k_sigaction *ka;
-		
-		ka = &current->sighand->action[signr-1];
-
 		if (cookie.restart_syscall)
-			syscall_restart(cookie.orig_i0, regs, &ka->sa);
-		handle_signal(signr, ka, &info, oldset, regs, svr4_signal);
+			syscall_restart(cookie.orig_i0, regs, &ka.sa);
+		handle_signal(signr, &ka, &info, oldset,
+			      regs, svr4_signal);
 		return 1;
 	}
 	if (cookie.restart_syscall &&
diff -puN include/linux/signal.h~signal-race-fixes-sparc-sparc64 include/linux/signal.h
diff -puN kernel/signal.c~signal-race-fixes-sparc-sparc64 kernel/signal.c
_
