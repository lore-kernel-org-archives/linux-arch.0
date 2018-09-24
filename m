Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:56615 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeIXPRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:17:18 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 11:10:15 +0200
Message-ID: <20180924091015.4458-15-ebiederm@xmission.com>
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Subject: [REVIEW][PATCH 15/15] signal/arm64: Use send_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924091015.g0UBFMHm4msLK2UdqMeesQJ56OWKiliCpV5grGA0oYg@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/fpsimd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 58c53bc96928..5ebe73b69961 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -842,7 +842,6 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
  */
 asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 {
-	siginfo_t info;
 	unsigned int si_code = FPE_FLTUNK;
 
 	if (esr & ESR_ELx_FP_EXC_TFV) {
@@ -858,12 +857,9 @@ asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 			si_code = FPE_FLTRES;
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_code = si_code;
-	info.si_addr = (void __user *)instruction_pointer(regs);
-
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, si_code,
+		       (void __user *)instruction_pointer(regs),
+		       current);
 }
 
 void fpsimd_thread_switch(struct task_struct *next)
-- 
2.17.1
