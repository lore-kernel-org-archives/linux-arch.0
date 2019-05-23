Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60219 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWAnI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:01 -0500
Message-ID: <20190523003916.20726-12-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 11/26] signal/x86: Remove task parameter from send_sigtrap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003901.FQ3uDQ961xYg5QiKwmyQCGDAENcxAdstldgYq89mheU@z>

The send_sigtrap function is always called with task == current.  Make
that explicit by removing the task parameter.

This also makes it clear that the x86 send_sigtrap passes current
into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/ptrace.h | 3 +--
 arch/x86/kernel/ptrace.c      | 7 ++++---
 arch/x86/kernel/traps.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 8a7fc0cca2d1..28779bf7951f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -102,8 +102,7 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 
 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
-extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-			 int error_code, int si_code);
+extern void send_sigtrap(struct pt_regs *regs, int error_code, int si_code);
 
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05dd6ad..00148141f138 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1360,9 +1360,10 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif
 }
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-					 int error_code, int si_code)
+void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.trap_nr = X86_TRAP_DB;
 	tsk->thread.error_code = error_code;
 
@@ -1373,5 +1374,5 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 
 void user_single_step_report(struct pt_regs *regs)
 {
-	send_sigtrap(current, regs, 0, TRAP_BRKPT);
+	send_sigtrap(regs, 0, TRAP_BRKPT);
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e54f0cad4b2e..30a9b843ef04 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -805,7 +805,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	}
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(tsk, regs, error_code, si_code);
+		send_sigtrap(regs, error_code, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
-- 
2.21.0
