Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:33462 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:36:22 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:28 +0200
Message-ID: <20180918000546.12552-2-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000528._2v3kCkxsmiN7weYauDYvXoL1y1QQMFkPChBGEcQEHw@z>

The function fill_sigtrap_info now only has one caller so remove
it and put it's contents in it's caller.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/ptrace.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 94bd6e89129a..511ea0f16078 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1369,27 +1369,19 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif
 }
 
-static void fill_sigtrap_info(struct task_struct *tsk,
-				struct pt_regs *regs,
-				int error_code, int si_code,
-				struct siginfo *info)
-{
-	tsk->thread.trap_nr = X86_TRAP_DB;
-	tsk->thread.error_code = error_code;
-
-	info->si_signo = SIGTRAP;
-	info->si_code = si_code;
-	info->si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
-}
-
-
 void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 					 int error_code, int si_code)
 {
 	struct siginfo info;
 
 	clear_siginfo(&info);
-	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
+	tsk->thread.trap_nr = X86_TRAP_DB;
+	tsk->thread.error_code = error_code;
+
+	info.si_signo = SIGTRAP;
+	info.si_code = si_code;
+	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
+
 	/* Send us the fake SIGTRAP */
 	force_sig_info(SIGTRAP, &info, tsk);
 }
-- 
2.17.1
