Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:56268 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbeIXUw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 16:52:27 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 16:49:10 +0200
Message-ID: <20180924144910.14902-2-ebiederm@xmission.com>
In-Reply-To: <874lef2bqn.fsf@xmission.com>
References: <874lef2bqn.fsf@xmission.com>
Subject: [REVIEW][PATCH 2/2] signal/arc: Use force_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924144910.lvjm_ijc9jU2ZnZh_aKJEFn03wHIr2lRU3N4XPRzLho@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/mm/fault.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index db6913094be3..c9da6102eb4f 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,14 +66,12 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	siginfo_t info;
+	int si_code;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
-
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -91,7 +89,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 			return;
 	}
 
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -119,7 +117,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * we can handle it..
 	 */
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	/* Handle protection violation, execute on heap or stack */
 
@@ -199,11 +197,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.fault_address = address;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 		return;
 	}
 
@@ -238,9 +232,5 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto no_context;
 
 	tsk->thread.fault_address = address;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *)address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 }
-- 
2.17.1
