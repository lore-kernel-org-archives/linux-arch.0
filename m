From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 17/26] signal/arm: Remove tsk parameter from __do_user_fault
Date: Wed, 22 May 2019 19:39:07 -0500
Message-ID: <20190523003916.20726-18-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The __do_user_fault function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This makes it clear that __do_user_fault calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/mm/fault.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 58f69fa07df9..324def0279b2 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -157,10 +157,11 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
  * User mode accesses just cause a SIGSEGV
  */
 static void
-__do_user_fault(struct task_struct *tsk, unsigned long addr,
-		unsigned int fsr, unsigned int sig, int code,
-		struct pt_regs *regs)
+__do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
+		int code, struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
@@ -196,7 +197,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * have no context to handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -392,7 +393,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, fsr, sig, code, regs);
+	__do_user_fault(addr, fsr, sig, code, regs);
 	return 0;
 
 no_context:
-- 
2.21.0
