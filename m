From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 11/22] signal/openrisc: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:38:00 -0500
Message-ID: <20180420143811.9994-11-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/openrisc/kernel/traps.c | 33 ++++-----------------------------
 arch/openrisc/mm/fault.c     | 19 +++++--------------
 2 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 1610b1d65a11..fac246e6f37a 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -250,28 +250,16 @@ void __init trap_init(void)
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_TRACE;
-	info.si_addr = (void *)address;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);
 
 	regs->pc += 4;
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRALN;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
@@ -282,16 +270,9 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 
 asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
 		show_registers(regs);
@@ -466,7 +447,6 @@ static inline void simulate_swa(struct pt_regs *regs, unsigned long address,
 asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 				       unsigned long address)
 {
-	siginfo_t info;
 	unsigned int op;
 	unsigned int insn = *((unsigned int *)address);
 
@@ -487,12 +467,7 @@ asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 
 	if (user_mode(regs)) {
 		/* Send a SIGILL */
-		clear_siginfo(&info);
-		info.si_signo = SIGILL;
-		info.si_errno = 0;
-		info.si_code = ILL_ILLOPC;
-		info.si_addr = (void *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)address, current);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
 		       address);
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 68be33e4ae17..9f011d16cc46 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -52,11 +52,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
-	siginfo_t info;
+	int si_code;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
 	tsk = current;
 
 	/*
@@ -98,7 +97,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	mm = tsk->mm;
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -140,7 +139,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	/* first do some preliminary protection checks */
 
@@ -214,11 +213,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses just cause a SIGSEGV */
 
 	if (user_mode(regs)) {
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 		return;
 	}
 
@@ -283,11 +278,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *)address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
-- 
2.14.1
