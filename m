Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:51064 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:03:42 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:04 -0500
Message-ID: <20190523003916.20726-15-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 14/26] signal/riscv: Remove tsk parameter from do_trap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003904.UwLo1100FjFxXa572Z3lBswIKxQ3kVGlwTwH0aow1ec@z>

The do_trap function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that do_trap calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/include/asm/bug.h | 2 +-
 arch/riscv/kernel/traps.c    | 7 ++++---
 arch/riscv/mm/fault.c        | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 52a1fbdeab3b..f1390914ba7a 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -94,7 +94,7 @@ struct task_struct;
 
 extern void die(struct pt_regs *regs, const char *str);
 extern void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk);
+	unsigned long addr);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3d1a651dc54c..71445a928c1b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -63,9 +63,10 @@ void die(struct pt_regs *regs, const char *str)
 		do_exit(SIGSEGV);
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk)
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
+	struct task_struct *tsk = current;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -82,7 +83,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, const char *str)
 {
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr, current);
+		do_trap(regs, signo, code, addr);
 	} else {
 		if (!fixup_exception(regs))
 			die(regs, str);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index cec8be9e2d6a..0a0081d9b766 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -181,7 +181,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	up_read(&mm->mmap_sem);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		do_trap(regs, SIGSEGV, code, addr, tsk);
+		do_trap(regs, SIGSEGV, code, addr);
 		return;
 	}
 
@@ -217,7 +217,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
-	do_trap(regs, SIGBUS, BUS_ADRERR, addr, tsk);
+	do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 	return;
 
 vmalloc_fault:
@@ -231,7 +231,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 		/* User mode accesses just cause a SIGSEGV */
 		if (user_mode(regs))
-			return do_trap(regs, SIGSEGV, code, addr, tsk);
+			return do_trap(regs, SIGSEGV, code, addr);
 
 		/*
 		 * Synchronize this task's top level page-table
-- 
2.21.0
