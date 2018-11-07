From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: MM: fix UB and kernel resourse leak in do_page_fault
Date: Wed,  7 Nov 2018 15:12:49 +0300
Message-ID: <20181107121249.6657-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org, Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <alexey.brodkin@synopsys.com>, "Eric W . Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Commit 15773ae938d8 ("signal/arc: Use force_sig_fault where
appropriate") adds undefined behaviour and kernel resource leak
to userspace in ARC do_page_fault() implementation.

This happens because we don't initialize si_code variable after we
switch to force_sig_fault using. si_code (as a part of siginfo_t
structure) was previously initialized by clear_siginfo(&info) call
which was removed.

Undefined behaviour path:
-------------------->8---------------------------
}}} a/arch/arc/mm/fault.c
!! -67,6 +67,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
        struct task_struct *tsk = current;
        struct mm_struct *mm = tsk->mm;
+       /// >>> si_code - uninitialized
        int si_code;
        int ret;
        vm_fault_t fault;
        int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
!! -81,8 +82,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
         * only copy the information from the master page table,
         * nothing more.
         */
+       /// >>> take true branch
        if (address >= VMALLOC_START) {
                ret = handle_kernel_vaddr_fault(address);
+               /// >>> take true branch
                if (unlikely(ret))
+                       /// >>> jump to label "bad_area_nosemaphore"
                        goto bad_area_nosemaphore;
                else
!! -193,10 +196,13 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 bad_area:
        up_read(&mm->mmap_sem);

+       /// >>> reach label "bad_area_nosemaphore"
 bad_area_nosemaphore:
        /* User mode accesses just cause a SIGSEGV */
+       /// >>> take true branch
        if (user_mode(regs)) {
                tsk->thread.fault_address = address;
+               /// >>> Ooops:
+               /// >>> use uninitialized value "si_code"
+               /// >>> when calling "force_sig_fault"
                force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
                return;
        }
-------------------->8---------------------------

Fixes: 15773ae938d8 ("signal/arc: Use force_sig_fault where appropriate")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index c9da6102eb4f..e2d9fc3fea01 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code;
+	int si_code = 0;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
-- 
2.14.5
