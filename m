From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 22/22] signal/xtensa: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:38:11 -0500
Message-ID: <20180420143811.9994-22-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
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

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/xtensa/kernel/traps.c | 10 +---------
 arch/xtensa/mm/fault.c     | 19 +++++--------------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 90b509f65b6f..86507fa7c2d7 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -323,8 +323,6 @@ do_illegal_instruction(struct pt_regs *regs)
 void
 do_unaligned_user (struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	__die_if_kernel("Unhandled unaligned exception in kernel",
 			regs, SIGKILL);
 
@@ -334,13 +332,7 @@ do_unaligned_user (struct pt_regs *regs)
 			    "(pid = %d, pc = %#010lx)\n",
 			    regs->excvaddr, current->comm,
 			    task_pid_nr(current), regs->pc);
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void *) regs->excvaddr;
-	force_sig_info(SIGBUS, &info, current);
-
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void *) regs->excvaddr, current);
 }
 #endif
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index f9323a3e61ce..c111a833205a 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -39,14 +39,13 @@ void do_page_fault(struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	unsigned int exccause = regs->exccause;
 	unsigned int address = regs->excvaddr;
-	siginfo_t info;
+	int code;
 
 	int is_write, is_exec;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
-	info.si_code = SEGV_MAPERR;
+	code = SEGV_MAPERR;
 
 	/* We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -92,7 +91,7 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 
 good_area:
-	info.si_code = SEGV_ACCERR;
+	code = SEGV_ACCERR;
 
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -158,11 +157,7 @@ void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		current->thread.bad_vaddr = address;
 		current->thread.error_code = is_write;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *) address;
-		force_sig_info(SIGSEGV, &info, current);
+		force_sig_fault(SIGSEGV, code, (void *) address, current);
 		return;
 	}
 	bad_page_fault(regs, address, SIGSEGV);
@@ -187,11 +182,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * or user mode.
 	 */
 	current->thread.bad_vaddr = address;
-	info.si_code = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *) address;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address, current);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
-- 
2.14.1
