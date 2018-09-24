From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 2/4] signal/arm: Use force_sig_fault where appropriate
Date: Mon, 24 Sep 2018 14:11:26 +0200
Message-ID: <20180924121128.5983-2-ebiederm@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/ptrace.c | 11 ++---------
 arch/arm/mm/alignment.c  | 10 +---------
 arch/arm/mm/fault.c      | 10 +---------
 3 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 36718a424358..6fa5b6387556 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -203,15 +203,8 @@ void ptrace_disable(struct task_struct *child)
  */
 void ptrace_break(struct task_struct *tsk, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code  = TRAP_BRKPT;
-	info.si_addr  = (void __user *)instruction_pointer(regs);
-
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT,
+			(void __user *)instruction_pointer(regs), tsk);
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index bd2c739d8083..b54f8f8def36 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -948,15 +948,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto fixup;
 
 	if (ai_usermode & UM_SIGNAL) {
-		siginfo_t si;
-
-		clear_siginfo(&si);
-		si.si_signo = SIGBUS;
-		si.si_errno = 0;
-		si.si_code = BUS_ADRALN;
-		si.si_addr = (void __user *)addr;
-
-		force_sig_info(si.si_signo, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, current);
 	} else {
 		/*
 		 * We're about to disable the alignment trap and return to
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 544d2c8c2775..f4ea4c62c613 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -161,13 +161,9 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	struct siginfo si;
-
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
-	clear_siginfo(&si);
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -181,11 +177,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-- 
2.17.1
