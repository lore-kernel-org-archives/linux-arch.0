From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 02/22] signal/alpha: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:37:51 -0500
Message-ID: <20180420143811.9994-2-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
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

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/traps.c |  9 +--------
 arch/alpha/mm/fault.c     | 15 ++-------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 106a1692fca0..bc9627698796 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -400,16 +400,9 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 asmlinkage void
 do_entDbg(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	die_if_kernel("Instruction fault", regs, 0, NULL);
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLOPC;
-	info.si_addr = (void __user *) regs->pc;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0, current);
 }
 
 
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 7f2202a9f50a..de2bd217adad 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -88,11 +88,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	struct mm_struct *mm = current->mm;
 	const struct exception_table_entry *fixup;
 	int fault, si_code = SEGV_MAPERR;
-	siginfo_t info;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
-
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
 	   (or is suppressed by the PALcode).  Support that for older CPUs
 	   by ignoring such an instruction.  */
@@ -223,21 +220,13 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	up_read(&mm->mmap_sem);
 	/* Send a sigbus, regardless of whether we were in kernel
 	   or user mode.  */
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address, 0, current);
 	if (!user_mode(regs))
 		goto no_context;
 	return;
 
  do_sigsegv:
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = si_code;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, si_code, (void __user *) address, 0, current);
 	return;
 
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
-- 
2.14.1
