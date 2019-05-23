Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60238 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfEWAnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:14 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:06 -0500
Message-ID: <20190523003916.20726-17-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 16/26] signal/arm: Remove tsk parameter from ptrace_break
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003906.i7dXqDKoguKm0BNcMScyvwAyUq2fiNrT0XwAd-16W5s@z>

The ptrace_break function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that ptrace_break calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/include/asm/traps.h | 2 +-
 arch/arm/kernel/ptrace.c     | 6 +++---
 arch/arm/kernel/traps.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index a00288d75ee6..172b08ff3760 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -30,7 +30,7 @@ static inline int __in_irqentry_text(unsigned long ptr)
 
 extern void __init early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
-extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
+extern void ptrace_break(struct pt_regs *regs);
 
 extern void *vectors_page;
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 6fa5b6387556..f9cbd08a9075 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -201,15 +201,15 @@ void ptrace_disable(struct task_struct *child)
 /*
  * Handle hitting a breakpoint.
  */
-void ptrace_break(struct task_struct *tsk, struct pt_regs *regs)
+void ptrace_break(struct pt_regs *regs)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
-			(void __user *)instruction_pointer(regs), tsk);
+			(void __user *)instruction_pointer(regs), current);
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
 {
-	ptrace_break(current, regs);
+	ptrace_break(regs);
 	return 0;
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 33af097c454b..288989c7355d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -606,7 +606,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 
 	case NR(breakpoint): /* SWI BREAK_POINT */
 		regs->ARM_pc -= thumb_mode(regs) ? 2 : 4;
-		ptrace_break(current, regs);
+		ptrace_break(regs);
 		return regs->ARM_r0;
 
 	/*
-- 
2.21.0
