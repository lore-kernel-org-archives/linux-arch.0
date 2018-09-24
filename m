Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:33460 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 17:29:12 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 17:25:37 +0200
Message-ID: <20180924152537.19515-3-ebiederm@xmission.com>
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
Subject: [REVIEW][PATCH 3/3] signal/unicore32: Use force_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924152537.i7dez9E4b4hpG_pKLrlesJXo4P8MmdPfphvPL3VOE0A@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/mm/fault.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index a942776110a0..b9a3a50644c1 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -120,17 +120,10 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	struct siginfo si;
-
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	clear_siginfo(&si);
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-- 
2.17.1
