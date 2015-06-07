From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 06/19] ARC: entry.S: Introduce INTERRUPT_{PROLOGUE,EPILOGUE}
Date: Sun, 7 Jun 2015 14:08:10 +0530
Message-ID: <1433666303-26112-7-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37830 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932463AbbFGIja (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:30 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

-common'ize macros for level 1 and level 2 interrupts

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/arcregs.h |  3 --
 arch/arc/include/asm/entry.h   | 77 +++++++++++-------------------------------
 arch/arc/kernel/entry.S        | 22 +++---------
 3 files changed, 23 insertions(+), 79 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index e42a5f8b05aa..336a9f694c2e 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -76,9 +76,6 @@
 #define ECR_C_BIT_DTLB_LD_MISS		8
 #define ECR_C_BIT_DTLB_ST_MISS		9
 
-/* Dummy ECR values for Interrupts */
-#define event_IRQ1		0x0031abcd
-#define event_IRQ2		0x0032abcd
 
 /* Auxiliary registers */
 #define AUX_IDENTITY		4
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 9e844ab5eede..35c4111d8c80 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -465,55 +465,37 @@
 	/* orig_r0, ECR, user_r25 skipped automatically */
 .endm
 
+/* Dummy ECR values for Interrupts */
+#define event_IRQ1		0x0031abcd
+#define event_IRQ2		0x0032abcd
 
-/*--------------------------------------------------------------
- * Save all registers used by interrupt handlers.
- *-------------------------------------------------------------*/
-.macro SAVE_ALL_INT1
+.macro INTERRUPT_PROLOGUE  LVL
 
-	/* restore original r9 */
-	PROLOG_RESTORE_REG  r9, @int1_saved_reg
+	/* free up r9 as scratchpad */
+	PROLOG_FREEUP_REG r9, @int\LVL\()_saved_reg
 
-	/* now we are ready to save the remaining context :) */
-	st      event_IRQ1, [sp, 8]    /* Dummy ECR */
-	st      0, [sp, 4]    /* orig_r0 , N/A for IRQ */
+	/* Which mode (user/kernel) was the system in when intr occured */
+	lr  r9, [status32_l\LVL\()]
 
-	SAVE_R0_TO_R12
-	PUSH	gp
-	PUSH	fp
-	PUSH	blink
-	PUSH	ilink1
-	PUSHAX	status32_l1
-	PUSH	lp_count
-	PUSHAX	lp_end
-	PUSHAX	lp_start
-	PUSHAX	bta_l1
-.endm
-
-.macro SAVE_ALL_INT2
+	SWITCH_TO_KERNEL_STK
 
-	/*
-	 * In SMP we can't use mem nor can we use SCRARCH_DATA0
-	 * as we do for int1 because int2 can clobber it
-	 * Hence 2 levels of intr are NOT allowed in SMP (by Kconfig)
-	 */
 	/* restore original r9 */
-	PROLOG_RESTORE_REG r9, @int2_saved_reg
+	PROLOG_RESTORE_REG  r9, @int\LVL\()_saved_reg
 
-	/* now we are ready to save the remaining context :) */
-	st      event_IRQ2, [sp, 8]    /* Dummy ECR */
+	/* now we are ready to save the remaining context */
+	st      0x003\LVL\()abcd, [sp, 8]    /* Dummy ECR */
 	st      0, [sp, 4]    /* orig_r0 , N/A for IRQ */
 
 	SAVE_R0_TO_R12
 	PUSH	gp
 	PUSH	fp
 	PUSH	blink
-	PUSH	ilink2
-	PUSHAX	status32_l2
+	PUSH	ilink\LVL\()
+	PUSHAX	status32_l\LVL\()
 	PUSH	lp_count
 	PUSHAX	lp_end
 	PUSHAX	lp_start
-	PUSHAX	bta_l2
+	PUSHAX	bta_l\LVL\()
 .endm
 
 /*--------------------------------------------------------------
@@ -525,17 +507,16 @@
  * for memory load operations. If used in that way interrupts are deffered
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
-
-.macro RESTORE_ALL_INT1
-	POPAX	bta_l1
+.macro INTERRUPT_EPILOGUE  LVL
+	POPAX	bta_l\LVL\()
 	POPAX	lp_start
 	POPAX	lp_end
 
 	POP	r9
 	mov	lp_count, r9	;LD to lp_count is not allowed
 
-	POPAX	status32_l1
-	POP	ilink1
+	POPAX	status32_l\LVL\()
+	POP	ilink\LVL\()
 	POP	blink
 	POP	fp
 	POP	gp
@@ -545,26 +526,6 @@
 	/* orig_r0, ECR, user_r25 skipped automatically */
 .endm
 
-.macro RESTORE_ALL_INT2
-	POPAX	bta_l2
-	POPAX	lp_start
-	POPAX	lp_end
-
-	POP	r9
-	mov	lp_count, r9	;LD to lp_count is not allowed
-
-	POPAX	status32_l2
-	POP	ilink2
-	POP	blink
-	POP	fp
-	POP	gp
-	RESTORE_R12_TO_R0
-
-	ld  sp, [sp] /* restore original sp */
-	/* orig_r0, ECR, user_r25 skipped automatically */
-.endm
-
-
 /* Get CPU-ID of this core */
 .macro  GET_CPU_ID  reg
 	lr  \reg, [identity]
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 13b14b8dcd8d..03a349520b55 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -186,14 +186,7 @@ reserved:		; processor restart
 ; ---------------------------------------------
 ENTRY(handle_interrupt_level2)
 
-	; free up r9 as scratchpad
-	PROLOG_FREEUP_REG r9, @int2_saved_reg
-
-	;Which mode (user/kernel) was the system in when intr occured
-	lr  r9, [status32_l2]
-
-	SWITCH_TO_KERNEL_STK
-	SAVE_ALL_INT2
+	INTERRUPT_PROLOGUE 2
 
 	;------------------------------------------------------
 	; if L2 IRQ interrupted a L1 ISR, disable preemption
@@ -233,13 +226,7 @@ END(handle_interrupt_level2)
 ; ---------------------------------------------
 ENTRY(handle_interrupt_level1)
 
-	PROLOG_FREEUP_REG r9, @int1_saved_reg
-
-	;Which mode (user/kernel) was the system in when intr occured
-	lr  r9, [status32_l1]
-
-	SWITCH_TO_KERNEL_STK
-	SAVE_ALL_INT1
+	INTERRUPT_PROLOGUE 1
 
 	lr  r0, [icause1]
 	and r0, r0, 0x1f
@@ -698,7 +685,7 @@ not_exception:
 
 149:
 	;return from level 2
-	RESTORE_ALL_INT2
+	INTERRUPT_EPILOGUE 2
 debug_marker_l2:
 	rtie
 
@@ -709,8 +696,7 @@ not_level2_interrupt:
 	bbit0  r10, STATUS_A1_BIT, not_level1_interrupt
 
 	;return from level 1
-
-	RESTORE_ALL_INT1
+	INTERRUPT_EPILOGUE 1
 debug_marker_l1:
 	rtie
 
-- 
1.9.1
