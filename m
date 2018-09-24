Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:44000 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 17:29:04 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 17:25:35 +0200
Message-ID: <20180924152537.19515-1-ebiederm@xmission.com>
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
Subject: [REVIEW][PATCH 1/3] signal/unicore32: Use send_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924152535.Ybw1oqJb7hyrKZGfLcInPUUgeDZfcwhlR1HUn42QOcU@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/kernel/fpu-ucf64.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/unicore32/kernel/fpu-ucf64.c b/arch/unicore32/kernel/fpu-ucf64.c
index 8594b168f25e..fc5dad32a982 100644
--- a/arch/unicore32/kernel/fpu-ucf64.c
+++ b/arch/unicore32/kernel/fpu-ucf64.c
@@ -54,14 +54,6 @@
  */
 void ucf64_raise_sigfpe(struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-
-	info.si_signo = SIGFPE;
-	info.si_code = FPE_FLTUNK;
-	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
-
 	/*
 	 * This is the same as NWFPE, because it's not clear what
 	 * this is used for
@@ -69,7 +61,9 @@ void ucf64_raise_sigfpe(struct pt_regs *regs)
 	current->thread.error_code = 0;
 	current->thread.trap_no = 6;
 
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, FPE_FLTUNK,
+		       (void __user *)(instruction_pointer(regs) - 4),
+		       current);
 }
 
 /*
-- 
2.17.1
