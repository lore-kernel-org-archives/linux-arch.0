From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 15/20] signal/x86: Don't compute pkey in __do_page_fault
Date: Tue, 18 Sep 2018 02:05:41 +0200
Message-ID: <20180918000546.12552-15-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

There are no more users of the computed pkey value in __do_page_fault
so stop computing the value.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7ba00519fa5d..f82106578364 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1215,7 +1215,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	struct mm_struct *mm;
 	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
-	u32 pkey;
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1387,10 +1386,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * (potentially after handling any pending signal during the return to
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
-	 * Thus we have to be careful about not touching vma after handling the
-	 * fault, so we read the pkey beforehand.
 	 */
-	pkey = vma_pkey(vma);
 	fault = handle_mm_fault(vma, address, flags);
 	major |= fault & VM_FAULT_MAJOR;
 
-- 
2.17.1
