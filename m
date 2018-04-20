From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 04/22] signal/hexagon: Use force_sig_fault as appropriate
Date: Fri, 20 Apr 2018 09:37:53 -0500
Message-ID: <20180420143811.9994-4-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
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

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/hexagon/kernel/traps.c | 10 ++--------
 arch/hexagon/mm/vm_fault.c  | 21 +++++++--------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 1ff6a6a7b97c..91ee04842c22 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -412,11 +412,6 @@ void do_trap0(struct pt_regs *regs)
 	case TRAP_DEBUG:
 		/* Trap0 0xdb is debug breakpoint */
 		if (user_mode(regs)) {
-			struct siginfo info;
-
-			clear_siginfo(&info);
-			info.si_signo = SIGTRAP;
-			info.si_errno = 0;
 			/*
 			 * Some architecures add some per-thread state
 			 * to distinguish between breakpoint traps and
@@ -424,9 +419,8 @@ void do_trap0(struct pt_regs *regs)
 			 * set the si_code value appropriately, or we
 			 * may want to use a different trap0 flavor.
 			 */
-			info.si_code = TRAP_BRKPT;
-			info.si_addr = (void __user *) pt_elr(regs);
-			force_sig_info(SIGTRAP, &info, current);
+			force_sig_fault(SIGTRAP, TRAP_BRKPT,
+					(void __user *) pt_elr(regs), current);
 		} else {
 #ifdef CONFIG_KGDB
 			kgdb_handle_exception(pt_cause(regs), SIGTRAP,
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 2ad92edc877c..933bbcef5363 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -50,13 +50,12 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	siginfo_t info;
+	int si_signo;
 	int si_code = SEGV_MAPERR;
 	int fault;
 	const struct exception_table_entry *fixup;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
 	/*
 	 * If we're in an interrupt or have no user context,
 	 * then must not take the fault.
@@ -141,28 +140,22 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	 * unable to fix up the page fault.
 	 */
 	if (fault & VM_FAULT_SIGBUS) {
-		info.si_signo = SIGBUS;
-		info.si_code = BUS_ADRERR;
+		si_signo = SIGBUS;
+		si_code = BUS_ADRERR;
 	}
 	/* Address is not in the memory map */
 	else {
-		info.si_signo = SIGSEGV;
-		info.si_code = SEGV_ACCERR;
+		si_signo = SIGSEGV;
+		si_code  = SEGV_ACCERR;
 	}
-	info.si_errno = 0;
-	info.si_addr = (void __user *)address;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_fault(si_signo, si_code, (void __user *)address, current);
 	return;
 
 bad_area:
 	up_read(&mm->mmap_sem);
 
 	if (user_mode(regs)) {
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = si_code;
-		info.si_addr = (void *)address;
-		force_sig_info(info.si_signo, &info, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
 	/* Kernel-mode fault falls through */
-- 
2.14.1
