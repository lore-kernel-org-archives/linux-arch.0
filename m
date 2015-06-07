From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 05/19] ARC: entry.S: common'ize scrtach reg freeup in intr + exceptions
Date: Sun, 7 Jun 2015 14:08:09 +0530
Message-ID: <1433666303-26112-6-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37829 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932097AbbFGIjZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:25 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry.h | 35 ++++++++++++++++-------------------
 arch/arc/kernel/entry.S      | 10 ++--------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 884081099f80..9e844ab5eede 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -360,26 +360,26 @@
 .endm
 
 /*--------------------------------------------------------------
- * For early Exception Prologue, a core reg is temporarily needed to
+ * For early Exception/ISR Prologue, a core reg is temporarily needed to
  * code the rest of prolog (stack switching). This is done by stashing
  * it to memory (non-SMP case) or SCRATCH0 Aux Reg (SMP).
  *
  * Before saving the full regfile - this reg is restored back, only
  * to be saved again on kernel mode stack, as part of pt_regs.
  *-------------------------------------------------------------*/
-.macro EXCPN_PROLOG_FREEUP_REG	reg
+.macro PROLOG_FREEUP_REG	reg, mem
 #ifdef CONFIG_SMP
 	sr  \reg, [ARC_REG_SCRATCH_DATA0]
 #else
-	st  \reg, [@ex_saved_reg1]
+	st  \reg, [\mem]
 #endif
 .endm
 
-.macro EXCPN_PROLOG_RESTORE_REG	reg
+.macro PROLOG_RESTORE_REG	reg, mem
 #ifdef CONFIG_SMP
 	lr  \reg, [ARC_REG_SCRATCH_DATA0]
 #else
-	ld  \reg, [@ex_saved_reg1]
+	ld  \reg, [\mem]
 #endif
 .endm
 
@@ -393,7 +393,7 @@
 .macro EXCEPTION_PROLOGUE
 
 	/* Need at least 1 reg to code the early exception prologue */
-	EXCPN_PROLOG_FREEUP_REG r9
+	PROLOG_FREEUP_REG r9, @ex_saved_reg1
 
 	/* U/K mode at time of exception (stack not switched if already K) */
 	lr  r9, [erstatus]
@@ -421,7 +421,7 @@
 	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
 
 	/* Restore r9 used to code the early prologue */
-	EXCPN_PROLOG_RESTORE_REG  r9
+	PROLOG_RESTORE_REG  r9, @ex_saved_reg1
 
 	SAVE_R0_TO_R12
 	PUSH	gp
@@ -471,12 +471,8 @@
  *-------------------------------------------------------------*/
 .macro SAVE_ALL_INT1
 
-	/* restore original r9 to be saved as part of reg-file */
-#ifdef CONFIG_SMP
-	lr  r9, [ARC_REG_SCRATCH_DATA0]
-#else
-	ld  r9, [@int1_saved_reg]
-#endif
+	/* restore original r9 */
+	PROLOG_RESTORE_REG  r9, @int1_saved_reg
 
 	/* now we are ready to save the remaining context :) */
 	st      event_IRQ1, [sp, 8]    /* Dummy ECR */
@@ -496,12 +492,13 @@
 
 .macro SAVE_ALL_INT2
 
-	/* TODO-vineetg: SMP we can't use global nor can we use
-	*   SCRATCH0 as we do for int1 because while int1 is using
-	*   it, int2 can come
-	*/
-	/* retsore original r9 , saved in sys_saved_r9 */
-	ld  r9, [@int2_saved_reg]
+	/*
+	 * In SMP we can't use mem nor can we use SCRARCH_DATA0
+	 * as we do for int1 because int2 can clobber it
+	 * Hence 2 levels of intr are NOT allowed in SMP (by Kconfig)
+	 */
+	/* restore original r9 */
+	PROLOG_RESTORE_REG r9, @int2_saved_reg
 
 	/* now we are ready to save the remaining context :) */
 	st      event_IRQ2, [sp, 8]    /* Dummy ECR */
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index d868289c5a26..13b14b8dcd8d 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -186,9 +186,8 @@ reserved:		; processor restart
 ; ---------------------------------------------
 ENTRY(handle_interrupt_level2)
 
-	; TODO-vineetg for SMP this wont work
 	; free up r9 as scratchpad
-	st  r9, [@int2_saved_reg]
+	PROLOG_FREEUP_REG r9, @int2_saved_reg
 
 	;Which mode (user/kernel) was the system in when intr occured
 	lr  r9, [status32_l2]
@@ -234,12 +233,7 @@ END(handle_interrupt_level2)
 ; ---------------------------------------------
 ENTRY(handle_interrupt_level1)
 
-	/* free up r9 as scratchpad */
-#ifdef CONFIG_SMP
-	sr  r9, [ARC_REG_SCRATCH_DATA0]
-#else
-	st   r9, [@int1_saved_reg]
-#endif
+	PROLOG_FREEUP_REG r9, @int1_saved_reg
 
 	;Which mode (user/kernel) was the system in when intr occured
 	lr  r9, [status32_l1]
-- 
1.9.1
