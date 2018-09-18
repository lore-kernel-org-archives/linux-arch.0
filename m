From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 03/20] signal/x86: Move MCE error reporting out of force_sig_info_fault
Date: Tue, 18 Sep 2018 02:05:29 +0200
Message-ID: <20180918000546.12552-3-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Only the call from do_sigbus will send SIGBUS due to a memory machine
check error.  Consolidate all of the machine check signal generation
code in do_sigbus and remove the now unnecessary fault parameter from
force_sig_info_fault.

Explicitly use the now constant si_code BUS_ADRERR in the call
to force_sig_info_fault from do_sigbus.

This makes the code in arch/x86/mm/fault.c easier to follower and
simpler to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..4112b05d0dec 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -205,9 +205,8 @@ static void fill_sig_info_pkey(int si_signo, int si_code, siginfo_t *info,
 
 static void
 force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk, u32 *pkey, int fault)
+		     struct task_struct *tsk, u32 *pkey)
 {
-	unsigned lsb = 0;
 	siginfo_t info;
 
 	clear_siginfo(&info);
@@ -215,11 +214,6 @@ force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 	info.si_errno	= 0;
 	info.si_code	= si_code;
 	info.si_addr	= (void __user *)address;
-	if (fault & VM_FAULT_HWPOISON_LARGE)
-		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault)); 
-	if (fault & VM_FAULT_HWPOISON)
-		lsb = PAGE_SHIFT;
-	info.si_addr_lsb = lsb;
 
 	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
 
@@ -731,7 +725,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_info_fault(signal, si_code, address,
-					     tsk, NULL, 0);
+					     tsk, NULL);
 		}
 
 		/*
@@ -890,7 +884,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		tsk->thread.error_code	= error_code;
 		tsk->thread.trap_nr	= X86_TRAP_PF;
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey, 0);
+		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
 
 		return;
 	}
@@ -971,7 +965,6 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  u32 *pkey, unsigned int fault)
 {
 	struct task_struct *tsk = current;
-	int code = BUS_ADRERR;
 
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
@@ -989,13 +982,19 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		unsigned lsb = 0;
 		printk(KERN_ERR
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			tsk->comm, tsk->pid, address);
-		code = BUS_MCEERR_AR;
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+		if (fault & VM_FAULT_HWPOISON)
+			lsb = PAGE_SHIFT;
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
+		return;
 	}
 #endif
-	force_sig_info_fault(SIGBUS, code, address, tsk, pkey, fault);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, pkey);
 }
 
 static noinline void
-- 
2.17.1
