From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:57 -0500
Message-ID: <20180420143811.9994-8-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
 arch/mips/mm/fault.c     | 19 ++++----------
 2 files changed, 23 insertions(+), 61 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 967e9e4e795e..66ec4b0b484d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 asmlinkage void do_ov(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_code = FPE_INTOVF;
-	info.si_addr = (void __user *)regs->cp0_epc;
 
 	prev_state = exception_enter();
 	die_if_kernel("Integer overflow", regs);
 
-	force_sig_info(SIGFPE, &info, current);
+	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
 	exception_exit(prev_state);
 }
 
@@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	si.si_addr = fault_addr;
-	si.si_signo = SIGFPE;
+	int si_code;
 
 	if (fcr31 & FPU_CSR_INV_X)
-		si.si_code = FPE_FLTINV;
+		si_code = FPE_FLTINV;
 	else if (fcr31 & FPU_CSR_DIV_X)
-		si.si_code = FPE_FLTDIV;
+		si_code = FPE_FLTDIV;
 	else if (fcr31 & FPU_CSR_OVF_X)
-		si.si_code = FPE_FLTOVF;
+		si_code = FPE_FLTOVF;
 	else if (fcr31 & FPU_CSR_UDF_X)
-		si.si_code = FPE_FLTUND;
+		si_code = FPE_FLTUND;
 	else if (fcr31 & FPU_CSR_INE_X)
-		si.si_code = FPE_FLTRES;
+		si_code = FPE_FLTRES;
 
-	force_sig_info(SIGFPE, &si, tsk);
+	force_sig_fault(SIGFPE, si_code, fault_addr, tsk);
 }
 
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
-	struct siginfo si;
+	int si_code;
 	struct vm_area_struct *vma;
 
-	clear_siginfo(&si);
 	switch (sig) {
 	case 0:
 		return 0;
@@ -757,23 +746,18 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		return 1;
 
 	case SIGBUS:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
-		si.si_code = BUS_ADRERR;
-		force_sig_info(sig, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, fault_addr, current);
 		return 1;
 
 	case SIGSEGV:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
 		down_read(&current->mm->mmap_sem);
 		vma = find_vma(current->mm, (unsigned long)fault_addr);
 		if (vma && (vma->vm_start <= (unsigned long)fault_addr))
-			si.si_code = SEGV_ACCERR;
+			si_code = SEGV_ACCERR;
 		else
-			si.si_code = SEGV_MAPERR;
+			si_code = SEGV_MAPERR;
 		up_read(&current->mm->mmap_sem);
-		force_sig_info(sig, &si, current);
+		force_sig_fault(SIGSEGV, si_code, fault_addr, current);
 		return 1;
 
 	default:
@@ -896,10 +880,8 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	const char *str)
 {
-	siginfo_t info;
 	char b[40];
 
-	clear_siginfo(&info);
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_TRAP, str, regs, code, current->thread.trap_nr,
 			 SIGTRAP) == NOTIFY_STOP)
@@ -921,13 +903,9 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	case BRK_DIVZERO:
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
-		if (code == BRK_DIVZERO)
-			info.si_code = FPE_INTDIV;
-		else
-			info.si_code = FPE_INTOVF;
-		info.si_signo = SIGFPE;
-		info.si_addr = (void __user *) regs->cp0_epc;
-		force_sig_info(SIGFPE, &info, current);
+		force_sig_fault(SIGFPE,
+				code == BRK_DIVZERO ? FPE_INTDIV : FPE_INTOVF,
+				(void __user *) regs->cp0_epc, current);
 		break;
 	case BRK_BUG:
 		die_if_kernel("Kernel bug detected", regs);
@@ -952,9 +930,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
 		if (si_code) {
-			info.si_signo = SIGTRAP;
-			info.si_code = si_code;
-			force_sig_info(SIGTRAP, &info, current);
+			force_sig_fault(SIGTRAP, si_code, NULL,	current);
 		} else {
 			force_sig(SIGTRAP, current);
 		}
@@ -1506,13 +1482,8 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
  */
 asmlinkage void do_watch(struct pt_regs *regs)
 {
-	siginfo_t info;
 	enum ctx_state prev_state;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_HWBKPT;
-
 	prev_state = exception_enter();
 	/*
 	 * Clear WP (bit 22) bit of cause register so we don't loop
@@ -1528,7 +1499,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
-		force_sig_info(SIGTRAP, &info, current);
+		force_sig_fault(SIGTRAP, TRAP_HWBKPT, NULL, current);
 	} else {
 		mips_clear_watch_registers();
 		local_irq_enable();
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 75392becd933..5f71f2b903b7 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -42,7 +42,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	const int field = sizeof(unsigned long) * 2;
-	siginfo_t info;
+	int si_code;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
@@ -63,8 +63,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		return;
 #endif
 
-	clear_siginfo(&info);
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
@@ -113,7 +112,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
  * we can handle it..
  */
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -224,11 +223,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			pr_cont("\n");
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void __user *) address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 		return;
 	}
 
@@ -284,11 +279,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 #endif
 	current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 	tsk->thread.cp0_badvaddr = address;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 
 	return;
 #ifndef CONFIG_64BIT
-- 
2.14.1
