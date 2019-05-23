Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:59429 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:15:35 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:08 -0500
Message-ID: <20190523003916.20726-19-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 18/26] signal/unicore32: Remove tsk parameter from __do_user_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003908.rb7deVYIH0w7I7YEABepuI_KzMBidkqVSM0QXtsUKBA@z>

The __do_user_fault function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This makes it clear that __do_user_fault calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/mm/fault.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index b9a3a50644c1..cadee0b3b4e0 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -116,10 +116,11 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
  * Something tried to access memory that isn't in our memory map..
  * User mode accesses just cause a SIGSEGV
  */
-static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
-		unsigned int fsr, unsigned int sig, int code,
-		struct pt_regs *regs)
+static void __do_user_fault(unsigned long addr, unsigned int fsr,
+			    unsigned int sig, int code,	struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
@@ -136,7 +137,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * have no context to handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -310,7 +311,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		code = fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, fsr, sig, code, regs);
+	__do_user_fault(addr, fsr, sig, code, regs);
 	return 0;
 
 no_context:
-- 
2.21.0
