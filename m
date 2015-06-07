From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 17/19] ARC: entry.S: [arcompact] simplify SWITCH_TO_KERNEL_STK
Date: Sun, 7 Jun 2015 14:08:21 +0530
Message-ID: <1433666303-26112-18-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37848 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932897AbbFGIlS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:41:18 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Previously this macro was overloaded with stack switching, saving SP at right
slot in pt_regs, saving/setup of r25 and setting SP baseline to where
pt_regs->sp is saved (vs. bottom of pt_regs)

Now it only does SP switch, and leaves SP pointing to bottom of pt_regs.

r25 saving is no longer done here to allow for future reordering of
regfile in pt_regs w/o touching this macro

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-compact.h | 71 ++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 8b65eb36655a..8d0dd4d1001c 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -39,8 +39,8 @@
  * Switch to Kernel Mode stack if SP points to User Mode stack
  *
  * Entry   : r9 contains pre-IRQ/exception/trap status32
- * Exit    : SP is set to kernel mode stack pointer
- *           If CURR_IN_REG, r25 set to "current" task pointer
+ * Exit    : SP set to K mode stack
+ *           SP at the time of entry (K/U) saved @ pt_regs->sp
  * Clobbers: r9
  *-------------------------------------------------------------*/
 
@@ -80,12 +80,11 @@
 
 #endif
 
-	/* Save Pre Intr/Exception KERNEL MODE SP on kernel stack
-	 * safe-keeping not really needed, but it keeps the epilogue code
-	 * (SP restore) simpler/uniform.
-	 */
+    /*------Intr/Ecxp happened in kernel mode, SP already setup ------ */
+	/* save it nevertheless @ pt_regs->sp for uniformity */
+
 	b.d	66f
-	mov	r9, sp
+	st	sp, [sp, PT_sp - SZ_PT_REGS]
 
 88: /*------Intr/Ecxp happened in user mode, "switch" stack ------ */
 
@@ -94,30 +93,12 @@
 	/* With current tsk in r9, get it's kernel mode stack base */
 	GET_TSK_STACK_BASE  r9, r9
 
-66:
-#ifdef CONFIG_ARC_CURR_IN_REG
-	/*
-	 * Treat r25 as scratch reg, save it on stack first
-	 * Load it with current task pointer
-	 */
-	st	r25, [r9, -4]
-	GET_CURR_TASK_ON_CPU   r25
-#endif
-
-	/* Save Pre Intr/Exception User SP on kernel stack */
-	st.a    sp, [r9, -16]	; Make room for orig_r0, ECR, user_r25
-
-	/* CAUTION:
-	 * SP should be set at the very end when we are done with everything
-	 * In case of 2 levels of interrupt we depend on value of SP to assume
-	 * that everything else is done (loading r25 etc)
-	 */
-
-	/* set SP to point to kernel mode stack */
-	mov sp, r9
-
-	/* ----- Stack Switched to kernel Mode, Now save REG FILE ----- */
+	/* save U mode SP @ pt_regs->sp */
+	st	sp, [r9, PT_sp - SZ_PT_REGS]
 
+	/* final SP switch */
+	mov	sp, r9
+66:
 .endm
 
 /*------------------------------------------------------------
@@ -181,11 +162,21 @@
 	/* ARC700 doesn't provide auto-stack switching */
 	SWITCH_TO_KERNEL_STK
 
-	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/* Treat r25 as scratch reg (save it on stack) and load with "current" */
+	PUSH    r25
+	GET_CURR_TASK_ON_CPU   r25
+#else
+	sub     sp, sp, 4
+#endif
+
+	st.a	r0, [sp, -8]    /* orig_r0 needed for syscall (skip ECR slot) */
+	sub	sp, sp, 4	/* skip pt_regs->sp, already saved above */
 
 	/* Restore r9 used to code the early prologue */
 	PROLOG_RESTORE_REG  r9, @ex_saved_reg1
 
+	/* now we are ready to save the regfile */
 	SAVE_R0_TO_R12
 	PUSH	gp
 	PUSH	fp
@@ -245,12 +236,20 @@
 
 	SWITCH_TO_KERNEL_STK
 
-	/* restore original r9 */
-	PROLOG_RESTORE_REG  r9, @int\LVL\()_saved_reg
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/* Treat r25 as scratch reg (save it on stack) and load with "current" */
+	PUSH    r25
+	GET_CURR_TASK_ON_CPU   r25
+#else
+	sub     sp, sp, 4
+#endif
 
-	/* now we are ready to save the remaining context */
-	st	0x003\LVL\()abcd, [sp, 8]    /* Dummy ECR */
-	st      0, [sp, 4]    /* orig_r0 , N/A for IRQ */
+	PUSH	0x003\LVL\()abcd	/* Dummy ECR */
+	sub	sp, sp, 8		/* skip orig_r0 (not needed)
+					   skip pt_regs->sp, already saved above */
+
+	/* Restore r9 used to code the early prologue */
+	PROLOG_RESTORE_REG  r9, @int\LVL\()_saved_reg
 
 	SAVE_R0_TO_R12
 	PUSH	gp
-- 
1.9.1
