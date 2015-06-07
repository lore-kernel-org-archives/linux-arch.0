From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 13/19] ARC: entry.S: split into ARCompact ISA specific, common bits
Date: Sun, 7 Jun 2015 14:08:17 +0530
Message-ID: <1433666303-26112-14-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56901 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbbFGIkG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:40:06 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-compact.h | 306 +++++++++++++++++++++++++++
 arch/arc/include/asm/entry.h         | 300 +-------------------------
 arch/arc/kernel/Makefile             |   4 +-
 arch/arc/kernel/entry-compact.S      | 393 +++++++++++++++++++++++++++++++++++
 arch/arc/kernel/entry.S              | 389 +---------------------------------
 5 files changed, 711 insertions(+), 681 deletions(-)
 create mode 100644 arch/arc/include/asm/entry-compact.h
 create mode 100644 arch/arc/kernel/entry-compact.S

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
new file mode 100644
index 000000000000..6c0a81b598d2
--- /dev/null
+++ b/arch/arc/include/asm/entry-compact.h
@@ -0,0 +1,306 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Vineetg: March 2009 (Supporting 2 levels of Interrupts)
+ *  Stack switching code can no longer reliably rely on the fact that
+ *  if we are NOT in user mode, stack is switched to kernel mode.
+ *  e.g. L2 IRQ interrupted a L1 ISR which had not yet completed
+ *  it's prologue including stack switching from user mode
+ *
+ * Vineetg: Aug 28th 2008: Bug #94984
+ *  -Zero Overhead Loop Context shd be cleared when entering IRQ/EXcp/Trap
+ *   Normally CPU does this automatically, however when doing FAKE rtie,
+ *   we also need to explicitly do this. The problem in macros
+ *   FAKE_RET_FROM_EXCPN and FAKE_RET_FROM_EXCPN_LOCK_IRQ was that this bit
+ *   was being "CLEARED" rather then "SET". Actually "SET" clears ZOL context
+ *
+ * Vineetg: May 5th 2008
+ *  -Modified CALLEE_REG save/restore macros to handle the fact that
+ *      r25 contains the kernel current task ptr
+ *  - Defined Stack Switching Macro to be reused in all intr/excp hdlrs
+ *  - Shaved off 11 instructions from RESTORE_ALL_INT1 by using the
+ *      address Write back load ld.ab instead of seperate ld/add instn
+ *
+ * Amit Bhor, Sameer Dhavale: Codito Technologies 2004
+ */
+
+#ifndef __ASM_ARC_ENTRY_COMPACT_H
+#define __ASM_ARC_ENTRY_COMPACT_H
+
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>	/* For THREAD_SIZE */
+
+/*--------------------------------------------------------------
+ * Switch to Kernel Mode stack if SP points to User Mode stack
+ *
+ * Entry   : r9 contains pre-IRQ/exception/trap status32
+ * Exit    : SP is set to kernel mode stack pointer
+ *           If CURR_IN_REG, r25 set to "current" task pointer
+ * Clobbers: r9
+ *-------------------------------------------------------------*/
+
+.macro SWITCH_TO_KERNEL_STK
+
+	/* User Mode when this happened ? Yes: Proceed to switch stack */
+	bbit1   r9, STATUS_U_BIT, 88f
+
+	/* OK we were already in kernel mode when this event happened, thus can
+	 * assume SP is kernel mode SP. _NO_ need to do any stack switching
+	 */
+
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
+	/* However....
+	 * If Level 2 Interrupts enabled, we may end up with a corner case:
+	 * 1. User Task executing
+	 * 2. L1 IRQ taken, ISR starts (CPU auto-switched to KERNEL mode)
+	 * 3. But before it could switch SP from USER to KERNEL stack
+	 *      a L2 IRQ "Interrupts" L1
+	 * Thay way although L2 IRQ happened in Kernel mode, stack is still
+	 * not switched.
+	 * To handle this, we may need to switch stack even if in kernel mode
+	 * provided SP has values in range of USER mode stack ( < 0x7000_0000 )
+	 */
+	brlo sp, VMALLOC_START, 88f
+
+	/* TODO: vineetg:
+	 * We need to be a bit more cautious here. What if a kernel bug in
+	 * L1 ISR, caused SP to go whaco (some small value which looks like
+	 * USER stk) and then we take L2 ISR.
+	 * Above brlo alone would treat it as a valid L1-L2 sceanrio
+	 * instead of shouting alound
+	 * The only feasible way is to make sure this L2 happened in
+	 * L1 prelogue ONLY i.e. ilink2 is less than a pre-set marker in
+	 * L1 ISR before it switches stack
+	 */
+
+#endif
+
+	/* Save Pre Intr/Exception KERNEL MODE SP on kernel stack
+	 * safe-keeping not really needed, but it keeps the epilogue code
+	 * (SP restore) simpler/uniform.
+	 */
+	b.d	66f
+	mov	r9, sp
+
+88: /*------Intr/Ecxp happened in user mode, "switch" stack ------ */
+
+	GET_CURR_TASK_ON_CPU   r9
+
+	/* With current tsk in r9, get it's kernel mode stack base */
+	GET_TSK_STACK_BASE  r9, r9
+
+66:
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/*
+	 * Treat r25 as scratch reg, save it on stack first
+	 * Load it with current task pointer
+	 */
+	st	r25, [r9, -4]
+	GET_CURR_TASK_ON_CPU   r25
+#endif
+
+	/* Save Pre Intr/Exception User SP on kernel stack */
+	st.a    sp, [r9, -16]	; Make room for orig_r0, ECR, user_r25
+
+	/* CAUTION:
+	 * SP should be set at the very end when we are done with everything
+	 * In case of 2 levels of interrupt we depend on value of SP to assume
+	 * that everything else is done (loading r25 etc)
+	 */
+
+	/* set SP to point to kernel mode stack */
+	mov sp, r9
+
+	/* ----- Stack Switched to kernel Mode, Now save REG FILE ----- */
+
+.endm
+
+/*------------------------------------------------------------
+ * "FAKE" a rtie to return from CPU Exception context
+ * This is to re-enable Exceptions within exception
+ * Look at EV_ProtV to see how this is actually used
+ *-------------------------------------------------------------*/
+
+.macro FAKE_RET_FROM_EXCPN
+
+	ld  r9, [sp, PT_status32]
+	bic r9, r9, (STATUS_U_MASK|STATUS_DE_MASK)
+	bset  r9, r9, STATUS_L_BIT
+	sr  r9, [erstatus]
+	mov r9, 55f
+	sr  r9, [eret]
+
+	rtie
+55:
+.endm
+
+/*--------------------------------------------------------------
+ * For early Exception/ISR Prologue, a core reg is temporarily needed to
+ * code the rest of prolog (stack switching). This is done by stashing
+ * it to memory (non-SMP case) or SCRATCH0 Aux Reg (SMP).
+ *
+ * Before saving the full regfile - this reg is restored back, only
+ * to be saved again on kernel mode stack, as part of pt_regs.
+ *-------------------------------------------------------------*/
+.macro PROLOG_FREEUP_REG	reg, mem
+#ifdef CONFIG_SMP
+	sr  \reg, [ARC_REG_SCRATCH_DATA0]
+#else
+	st  \reg, [\mem]
+#endif
+.endm
+
+.macro PROLOG_RESTORE_REG	reg, mem
+#ifdef CONFIG_SMP
+	lr  \reg, [ARC_REG_SCRATCH_DATA0]
+#else
+	ld  \reg, [\mem]
+#endif
+.endm
+
+/*--------------------------------------------------------------
+ * Exception Entry prologue
+ * -Switches stack to K mode (if not already)
+ * -Saves the register file
+ *
+ * After this it is safe to call the "C" handlers
+ *-------------------------------------------------------------*/
+.macro EXCEPTION_PROLOGUE
+
+	/* Need at least 1 reg to code the early exception prologue */
+	PROLOG_FREEUP_REG r9, @ex_saved_reg1
+
+	/* U/K mode at time of exception (stack not switched if already K) */
+	lr  r9, [erstatus]
+
+	/* ARC700 doesn't provide auto-stack switching */
+	SWITCH_TO_KERNEL_STK
+
+	lr	r9, [ecr]
+	st      r9, [sp, 8]    /* ECR */
+	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
+
+	/* Restore r9 used to code the early prologue */
+	PROLOG_RESTORE_REG  r9, @ex_saved_reg1
+
+	SAVE_R0_TO_R12
+	PUSH	gp
+	PUSH	fp
+	PUSH	blink
+	PUSHAX	eret
+	PUSHAX	erstatus
+	PUSH	lp_count
+	PUSHAX	lp_end
+	PUSHAX	lp_start
+	PUSHAX	erbta
+.endm
+
+/*--------------------------------------------------------------
+ * Restore all registers used by system call or Exceptions
+ * SP should always be pointing to the next free stack element
+ * when entering this macro.
+ *
+ * NOTE:
+ *
+ * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
+ * for memory load operations. If used in that way interrupts are deffered
+ * by hardware and that is not good.
+ *-------------------------------------------------------------*/
+.macro EXCEPTION_EPILOGUE
+	POPAX	erbta
+	POPAX	lp_start
+	POPAX	lp_end
+
+	POP	r9
+	mov	lp_count, r9	;LD to lp_count is not allowed
+
+	POPAX	erstatus
+	POPAX	eret
+	POP	blink
+	POP	fp
+	POP	gp
+	RESTORE_R12_TO_R0
+
+	ld  sp, [sp] /* restore original sp */
+	/* orig_r0, ECR, user_r25 skipped automatically */
+.endm
+
+/* Dummy ECR values for Interrupts */
+#define event_IRQ1		0x0031abcd
+#define event_IRQ2		0x0032abcd
+
+.macro INTERRUPT_PROLOGUE  LVL
+
+	/* free up r9 as scratchpad */
+	PROLOG_FREEUP_REG r9, @int\LVL\()_saved_reg
+
+	/* Which mode (user/kernel) was the system in when intr occured */
+	lr  r9, [status32_l\LVL\()]
+
+	SWITCH_TO_KERNEL_STK
+
+	/* restore original r9 */
+	PROLOG_RESTORE_REG  r9, @int\LVL\()_saved_reg
+
+	/* now we are ready to save the remaining context */
+	st	0x003\LVL\()abcd, [sp, 8]    /* Dummy ECR */
+	st      0, [sp, 4]    /* orig_r0 , N/A for IRQ */
+
+	SAVE_R0_TO_R12
+	PUSH	gp
+	PUSH	fp
+	PUSH	blink
+	PUSH	ilink\LVL\()
+	PUSHAX	status32_l\LVL\()
+	PUSH	lp_count
+	PUSHAX	lp_end
+	PUSHAX	lp_start
+	PUSHAX	bta_l\LVL\()
+.endm
+
+/*--------------------------------------------------------------
+ * Restore all registers used by interrupt handlers.
+ *
+ * NOTE:
+ *
+ * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
+ * for memory load operations. If used in that way interrupts are deffered
+ * by hardware and that is not good.
+ *-------------------------------------------------------------*/
+.macro INTERRUPT_EPILOGUE  LVL
+	POPAX	bta_l\LVL\()
+	POPAX	lp_start
+	POPAX	lp_end
+
+	POP	r9
+	mov	lp_count, r9	;LD to lp_count is not allowed
+
+	POPAX	status32_l\LVL\()
+	POP	ilink\LVL\()
+	POP	blink
+	POP	fp
+	POP	gp
+	RESTORE_R12_TO_R0
+
+	ld  sp, [sp] /* restore original sp */
+	/* orig_r0, ECR, user_r25 skipped automatically */
+.endm
+
+/* Get thread_info of "current" tsk */
+.macro GET_CURR_THR_INFO_FROM_SP  reg
+	bic \reg, sp, (THREAD_SIZE - 1)
+.endm
+
+/* Get CPU-ID of this core */
+.macro  GET_CPU_ID  reg
+	lr  \reg, [identity]
+	lsr \reg, \reg, 8
+	bmsk \reg, \reg, 7
+.endm
+
+#endif  /* __ASM_ARC_ENTRY_COMPACT_H */
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index c976b54c9b07..f61032c53d51 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -1,45 +1,23 @@
 /*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * Vineetg: March 2009 (Supporting 2 levels of Interrupts)
- *  Stack switching code can no longer reliably rely on the fact that
- *  if we are NOT in user mode, stack is switched to kernel mode.
- *  e.g. L2 IRQ interrupted a L1 ISR which had not yet completed
- *  it's prologue including stack switching from user mode
- *
- * Vineetg: Aug 28th 2008: Bug #94984
- *  -Zero Overhead Loop Context shd be cleared when entering IRQ/EXcp/Trap
- *   Normally CPU does this automatically, however when doing FAKE rtie,
- *   we also need to explicitly do this. The problem in macros
- *   FAKE_RET_FROM_EXCPN and FAKE_RET_FROM_EXCPN_LOCK_IRQ was that this bit
- *   was being "CLEARED" rather then "SET". Actually "SET" clears ZOL context
- *
- * Vineetg: May 5th 2008
- *  -Modified CALLEE_REG save/restore macros to handle the fact that
- *      r25 contains the kernel current task ptr
- *  - Defined Stack Switching Macro to be reused in all intr/excp hdlrs
- *  - Shaved off 11 instructions from RESTORE_ALL_INT1 by using the
- *      address Write back load ld.ab instead of seperate ld/add instn
- *
- * Amit Bhor, Sameer Dhavale: Codito Technologies 2004
  */
 
 #ifndef __ASM_ARC_ENTRY_H
 #define __ASM_ARC_ENTRY_H
 
-#ifdef __ASSEMBLY__
 #include <asm/unistd.h>		/* For NR_syscalls defination */
-#include <asm/asm-offsets.h>
 #include <asm/arcregs.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>	/* For VMALLOC_START */
-#include <asm/thread_info.h>	/* For THREAD_SIZE */
 #include <asm/mmu.h>
 
+#include <asm/entry-compact.h>	/* ISA specific bits */
+
 /* Note on the LD/ST addr modes with addr reg wback
  *
  * LD.a same as LD.aw
@@ -240,117 +218,6 @@
 
 .endm
 
-/*--------------------------------------------------------------
- * Switch to Kernel Mode stack if SP points to User Mode stack
- *
- * Entry   : r9 contains pre-IRQ/exception/trap status32
- * Exit    : SP is set to kernel mode stack pointer
- *           If CURR_IN_REG, r25 set to "current" task pointer
- * Clobbers: r9
- *-------------------------------------------------------------*/
-
-.macro SWITCH_TO_KERNEL_STK
-
-	/* User Mode when this happened ? Yes: Proceed to switch stack */
-	bbit1   r9, STATUS_U_BIT, 88f
-
-	/* OK we were already in kernel mode when this event happened, thus can
-	 * assume SP is kernel mode SP. _NO_ need to do any stack switching
-	 */
-
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
-	/* However....
-	 * If Level 2 Interrupts enabled, we may end up with a corner case:
-	 * 1. User Task executing
-	 * 2. L1 IRQ taken, ISR starts (CPU auto-switched to KERNEL mode)
-	 * 3. But before it could switch SP from USER to KERNEL stack
-	 *      a L2 IRQ "Interrupts" L1
-	 * Thay way although L2 IRQ happened in Kernel mode, stack is still
-	 * not switched.
-	 * To handle this, we may need to switch stack even if in kernel mode
-	 * provided SP has values in range of USER mode stack ( < 0x7000_0000 )
-	 */
-	brlo sp, VMALLOC_START, 88f
-
-	/* TODO: vineetg:
-	 * We need to be a bit more cautious here. What if a kernel bug in
-	 * L1 ISR, caused SP to go whaco (some small value which looks like
-	 * USER stk) and then we take L2 ISR.
-	 * Above brlo alone would treat it as a valid L1-L2 sceanrio
-	 * instead of shouting alound
-	 * The only feasible way is to make sure this L2 happened in
-	 * L1 prelogue ONLY i.e. ilink2 is less than a pre-set marker in
-	 * L1 ISR before it switches stack
-	 */
-
-#endif
-
-	/* Save Pre Intr/Exception KERNEL MODE SP on kernel stack
-	 * safe-keeping not really needed, but it keeps the epilogue code
-	 * (SP restore) simpler/uniform.
-	 */
-	b.d	66f
-	mov	r9, sp
-
-88: /*------Intr/Ecxp happened in user mode, "switch" stack ------ */
-
-	GET_CURR_TASK_ON_CPU   r9
-
-	/* With current tsk in r9, get it's kernel mode stack base */
-	GET_TSK_STACK_BASE  r9, r9
-
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
-
-.endm
-
-/*------------------------------------------------------------
- * "FAKE" a rtie to return from CPU Exception context
- * This is to re-enable Exceptions within exception
- * Look at EV_ProtV to see how this is actually used
- *-------------------------------------------------------------*/
-
-.macro FAKE_RET_FROM_EXCPN
-
-	ld  r9, [sp, PT_status32]
-	bic  r9, r9, (STATUS_U_MASK|STATUS_DE_MASK)
-	bset r9, r9, STATUS_L_BIT
-	sr  r9, [erstatus]
-	mov r9, 55f
-	sr  r9, [eret]
-
-	rtie
-55:
-.endm
-
-/*
- * @reg [OUT] &thread_info of "current"
- */
-.macro GET_CURR_THR_INFO_FROM_SP  reg
-	bic \reg, sp, (THREAD_SIZE - 1)
-.endm
-
 /*
  * @reg [OUT] thread_info->flags of "current"
  */
@@ -359,165 +226,6 @@
 	ld  \reg, [\reg, THREAD_INFO_FLAGS]
 .endm
 
-/*--------------------------------------------------------------
- * For early Exception/ISR Prologue, a core reg is temporarily needed to
- * code the rest of prolog (stack switching). This is done by stashing
- * it to memory (non-SMP case) or SCRATCH0 Aux Reg (SMP).
- *
- * Before saving the full regfile - this reg is restored back, only
- * to be saved again on kernel mode stack, as part of pt_regs.
- *-------------------------------------------------------------*/
-.macro PROLOG_FREEUP_REG	reg, mem
-#ifdef CONFIG_SMP
-	sr  \reg, [ARC_REG_SCRATCH_DATA0]
-#else
-	st  \reg, [\mem]
-#endif
-.endm
-
-.macro PROLOG_RESTORE_REG	reg, mem
-#ifdef CONFIG_SMP
-	lr  \reg, [ARC_REG_SCRATCH_DATA0]
-#else
-	ld  \reg, [\mem]
-#endif
-.endm
-
-/*--------------------------------------------------------------
- * Exception Entry prologue
- * -Switches stack to K mode (if not already)
- * -Saves the register file
- *
- * After this it is safe to call the "C" handlers
- *-------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
-
-	/* Need at least 1 reg to code the early exception prologue */
-	PROLOG_FREEUP_REG r9, @ex_saved_reg1
-
-	/* U/K mode at time of exception (stack not switched if already K) */
-	lr  r9, [erstatus]
-
-	/* ARC700 doesn't provide auto-stack switching */
-	SWITCH_TO_KERNEL_STK
-
-	lr	r9, [ecr]
-	st      r9, [sp, 8]    /* ECR */
-	st      r0, [sp, 4]    /* orig_r0, needed only for sys calls */
-
-	/* Restore r9 used to code the early prologue */
-	PROLOG_RESTORE_REG  r9, @ex_saved_reg1
-
-	SAVE_R0_TO_R12
-	PUSH	gp
-	PUSH	fp
-	PUSH	blink
-	PUSHAX	eret
-	PUSHAX	erstatus
-	PUSH	lp_count
-	PUSHAX	lp_end
-	PUSHAX	lp_start
-	PUSHAX	erbta
-.endm
-
-/*--------------------------------------------------------------
- * Restore all registers used by system call or Exceptions
- * SP should always be pointing to the next free stack element
- * when entering this macro.
- *
- * NOTE:
- *
- * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
- * for memory load operations. If used in that way interrupts are deffered
- * by hardware and that is not good.
- *-------------------------------------------------------------*/
-.macro EXCEPTION_EPILOGUE
-	POPAX	erbta
-	POPAX	lp_start
-	POPAX	lp_end
-
-	POP	r9
-	mov	lp_count, r9	;LD to lp_count is not allowed
-
-	POPAX	erstatus
-	POPAX	eret
-	POP	blink
-	POP	fp
-	POP	gp
-	RESTORE_R12_TO_R0
-
-	ld  sp, [sp] /* restore original sp */
-	/* orig_r0, ECR, user_r25 skipped automatically */
-.endm
-
-/* Dummy ECR values for Interrupts */
-#define event_IRQ1		0x0031abcd
-#define event_IRQ2		0x0032abcd
-
-.macro INTERRUPT_PROLOGUE  LVL
-
-	/* free up r9 as scratchpad */
-	PROLOG_FREEUP_REG r9, @int\LVL\()_saved_reg
-
-	/* Which mode (user/kernel) was the system in when intr occured */
-	lr  r9, [status32_l\LVL\()]
-
-	SWITCH_TO_KERNEL_STK
-
-	/* restore original r9 */
-	PROLOG_RESTORE_REG  r9, @int\LVL\()_saved_reg
-
-	/* now we are ready to save the remaining context */
-	st      0x003\LVL\()abcd, [sp, 8]    /* Dummy ECR */
-	st      0, [sp, 4]    /* orig_r0 , N/A for IRQ */
-
-	SAVE_R0_TO_R12
-	PUSH	gp
-	PUSH	fp
-	PUSH	blink
-	PUSH	ilink\LVL\()
-	PUSHAX	status32_l\LVL\()
-	PUSH	lp_count
-	PUSHAX	lp_end
-	PUSHAX	lp_start
-	PUSHAX	bta_l\LVL\()
-.endm
-
-/*--------------------------------------------------------------
- * Restore all registers used by interrupt handlers.
- *
- * NOTE:
- *
- * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
- * for memory load operations. If used in that way interrupts are deffered
- * by hardware and that is not good.
- *-------------------------------------------------------------*/
-.macro INTERRUPT_EPILOGUE  LVL
-	POPAX	bta_l\LVL\()
-	POPAX	lp_start
-	POPAX	lp_end
-
-	POP	r9
-	mov	lp_count, r9	;LD to lp_count is not allowed
-
-	POPAX	status32_l\LVL\()
-	POP	ilink\LVL\()
-	POP	blink
-	POP	fp
-	POP	gp
-	RESTORE_R12_TO_R0
-
-	ld  sp, [sp] /* restore original sp */
-	/* orig_r0, ECR, user_r25 skipped automatically */
-.endm
-
-/* Get CPU-ID of this core */
-.macro  GET_CPU_ID  reg
-	lr  \reg, [identity]
-	lsr \reg, \reg, 8
-	bmsk \reg, \reg, 7
-.endm
-
 #ifdef CONFIG_SMP
 
 /*-------------------------------------------------
@@ -586,6 +294,4 @@
 
 #endif	/* CONFIG_ARC_CURR_IN_REG */
 
-#endif  /* __ASSEMBLY__ */
-
 #endif  /* __ASM_ARC_ENTRY_H */
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 113f2033da9f..024a63e90b72 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -8,9 +8,9 @@
 # Pass UTS_MACHINE for user_regset definition
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o entry.o process.o
+obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o clk.o
-obj-y	+= devtree.o
+obj-y	+= entry-compact.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
diff --git a/arch/arc/kernel/entry-compact.S b/arch/arc/kernel/entry-compact.S
new file mode 100644
index 000000000000..bf611ec9a017
--- /dev/null
+++ b/arch/arc/kernel/entry-compact.S
@@ -0,0 +1,393 @@
+/*
+ * Low Level Interrupts/Traps/Exceptions(non-TLB) Handling for ARCompact ISA
+ *
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * vineetg: May 2011
+ *  -Userspace unaligned access emulation
+ *
+ * vineetg: Feb 2011 (ptrace low level code fixes)
+ *  -traced syscall return code (r0) was not saved into pt_regs for restoring
+ *   into user reg-file when traded task rets to user space.
+ *  -syscalls needing arch-wrappers (mainly for passing sp as pt_regs)
+ *   were not invoking post-syscall trace hook (jumping directly into
+ *   ret_from_system_call)
+ *
+ * vineetg: Nov 2010:
+ *  -Vector table jumps (@8 bytes) converted into branches (@4 bytes)
+ *  -To maintain the slot size of 8 bytes/vector, added nop, which is
+ *   not executed at runtime.
+ *
+ * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
+ *  -do_signal()invoked upon TIF_RESTORE_SIGMASK as well
+ *  -Wrappers for sys_{,rt_}sigsuspend() nolonger needed as they don't
+ *   need ptregs anymore
+ *
+ * Vineetg: Oct 2009
+ *  -In a rare scenario, Process gets a Priv-V exception and gets scheduled
+ *   out. Since we don't do FAKE RTIE for Priv-V, CPU excpetion state remains
+ *   active (AE bit enabled).  This causes a double fault for a subseq valid
+ *   exception. Thus FAKE RTIE needed in low level Priv-Violation handler.
+ *   Instr Error could also cause similar scenario, so same there as well.
+ *
+ * Vineetg: March 2009 (Supporting 2 levels of Interrupts)
+ *
+ * Vineetg: Aug 28th 2008: Bug #94984
+ *  -Zero Overhead Loop Context shd be cleared when entering IRQ/EXcp/Trap
+ *   Normally CPU does this automatically, however when doing FAKE rtie,
+ *   we need to explicitly do this. The problem in macros
+ *   FAKE_RET_FROM_EXCPN and FAKE_RET_FROM_EXCPN_LOCK_IRQ was that this bit
+ *   was being "CLEARED" rather then "SET". Since it is Loop INHIBIT Bit,
+ *   setting it and not clearing it clears ZOL context
+ *
+ * Vineetg: May 16th, 2008
+ *  - r25 now contains the Current Task when in kernel
+ *
+ * Vineetg: Dec 22, 2007
+ *    Minor Surgery of Low Level ISR to make it SMP safe
+ *    - MMU_SCRATCH0 Reg used for freeing up r9 in Level 1 ISR
+ *    - _current_task is made an array of NR_CPUS
+ *    - Access of _current_task wrapped inside a macro so that if hardware
+ *       team agrees for a dedicated reg, no other code is touched
+ *
+ * Amit Bhor, Rahul Trivedi, Kanika Nema, Sameer Dhavale : Codito Tech 2004
+ */
+
+#include <linux/errno.h>
+#include <linux/linkage.h>	/* {EXTRY,EXIT} */
+#include <asm/entry.h>
+#include <asm/irqflags.h>
+
+	.cpu A7
+
+;############################ Vector Table #################################
+
+.macro VECTOR  lbl
+#if 1   /* Just in case, build breaks */
+	j   \lbl
+#else
+	b   \lbl
+	nop
+#endif
+.endm
+
+	.section .vector, "ax",@progbits
+	.align 4
+
+/* Each entry in the vector table must occupy 2 words. Since it is a jump
+ * across sections (.vector to .text) we are gauranteed that 'j somewhere'
+ * will use the 'j limm' form of the intrsuction as long as somewhere is in
+ * a section other than .vector.
+ */
+
+; ********* Critical System Events **********************
+VECTOR   res_service             ; 0x0, Restart Vector  (0x0)
+VECTOR   mem_service             ; 0x8, Mem exception   (0x1)
+VECTOR   instr_service           ; 0x10, Instrn Error   (0x2)
+
+; ******************** Device ISRs **********************
+#ifdef CONFIG_ARC_IRQ3_LV2
+VECTOR   handle_interrupt_level2
+#else
+VECTOR   handle_interrupt_level1
+#endif
+
+VECTOR   handle_interrupt_level1
+
+#ifdef CONFIG_ARC_IRQ5_LV2
+VECTOR   handle_interrupt_level2
+#else
+VECTOR   handle_interrupt_level1
+#endif
+
+#ifdef CONFIG_ARC_IRQ6_LV2
+VECTOR   handle_interrupt_level2
+#else
+VECTOR   handle_interrupt_level1
+#endif
+
+.rept   25
+VECTOR   handle_interrupt_level1 ; Other devices
+.endr
+
+/* FOR ARC600: timer = 0x3, uart = 0x8, emac = 0x10 */
+
+; ******************** Exceptions **********************
+VECTOR   EV_MachineCheck         ; 0x100, Fatal Machine check   (0x20)
+VECTOR   EV_TLBMissI             ; 0x108, Intruction TLB miss   (0x21)
+VECTOR   EV_TLBMissD             ; 0x110, Data TLB miss         (0x22)
+VECTOR   EV_TLBProtV             ; 0x118, Protection Violation  (0x23)
+				 ;         or Misaligned Access
+VECTOR   EV_PrivilegeV           ; 0x120, Privilege Violation   (0x24)
+VECTOR   EV_Trap                 ; 0x128, Trap exception        (0x25)
+VECTOR   EV_Extension            ; 0x130, Extn Intruction Excp  (0x26)
+
+.rept   24
+VECTOR   reserved                ; Reserved Exceptions
+.endr
+
+
+;##################### Scratch Mem for IRQ stack switching #############
+
+ARCFP_DATA int1_saved_reg
+	.align 32
+	.type   int1_saved_reg, @object
+	.size   int1_saved_reg, 4
+int1_saved_reg:
+	.zero 4
+
+/* Each Interrupt level needs its own scratch */
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
+
+ARCFP_DATA int2_saved_reg
+	.type   int2_saved_reg, @object
+	.size   int2_saved_reg, 4
+int2_saved_reg:
+	.zero 4
+
+#endif
+
+; ---------------------------------------------
+	.section .text, "ax",@progbits
+
+res_service:		; processor restart
+	flag    0x1     ; not implemented
+	nop
+	nop
+
+reserved:		; processor restart
+	rtie            ; jump to processor initializations
+
+;##################### Interrupt Handling ##############################
+
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
+; ---------------------------------------------
+;  Level 2 ISR: Can interrupt a Level 1 ISR
+; ---------------------------------------------
+ENTRY(handle_interrupt_level2)
+
+	INTERRUPT_PROLOGUE 2
+
+	;------------------------------------------------------
+	; if L2 IRQ interrupted a L1 ISR, disable preemption
+	;------------------------------------------------------
+
+	ld r9, [sp, PT_status32]        ; get statu32_l2 (saved in pt_regs)
+	bbit0 r9, STATUS_A1_BIT, 1f     ; L1 not active when L2 IRQ, so normal
+
+	; A1 is set in status32_l2
+	; bump thread_info->preempt_count (Disable preemption)
+	GET_CURR_THR_INFO_FROM_SP   r10
+	ld      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
+	add     r9, r9, 1
+	st      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
+
+1:
+	;------------------------------------------------------
+	; setup params for Linux common ISR and invoke it
+	;------------------------------------------------------
+	lr  r0, [icause2]
+	and r0, r0, 0x1f
+
+	bl.d  @arch_do_IRQ
+	mov r1, sp
+
+	mov r8,0x2
+	sr r8, [AUX_IRQ_LV12]       ; clear bit in Sticky Status Reg
+
+	b   ret_from_exception
+
+END(handle_interrupt_level2)
+
+#endif
+
+; ---------------------------------------------
+;  Level 1 ISR
+; ---------------------------------------------
+ENTRY(handle_interrupt_level1)
+
+	INTERRUPT_PROLOGUE 1
+
+	lr  r0, [icause1]
+	and r0, r0, 0x1f
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	; icause1 needs to be read early, before calling tracing, which
+	; can clobber scratch regs, hence use of stack to stash it
+	push r0
+	TRACE_ASM_IRQ_DISABLE
+	pop  r0
+#endif
+
+	bl.d  @arch_do_IRQ
+	mov r1, sp
+
+	mov r8,0x1
+	sr r8, [AUX_IRQ_LV12]       ; clear bit in Sticky Status Reg
+
+	b   ret_from_exception
+END(handle_interrupt_level1)
+
+;################### Non TLB Exception Handling #############################
+
+; ---------------------------------------------
+; Protection Violation Exception Handler
+; ---------------------------------------------
+
+ENTRY(EV_TLBProtV)
+
+	EXCEPTION_PROLOGUE
+
+	lr  r2, [ecr]
+	lr  r0, [efa]	; Faulting Data address (not part of pt_regs saved above)
+
+	; Exception auto-disables further Intr/exceptions.
+	; Re-enable them by pretending to return from exception
+	; (so rest of handler executes in pure K mode)
+
+	FAKE_RET_FROM_EXCPN
+
+	mov   r1, sp	; Handle to pt_regs
+
+	;------ (5) Type of Protection Violation? ----------
+	;
+	; ProtV Hardware Exception is triggered for Access Faults of 2 types
+	;   -Access Violaton	: 00_23_(00|01|02|03)_00
+	;			         x  r  w  r+w
+	;   -Unaligned Access	: 00_23_04_00
+	;
+	bbit1 r2, ECR_C_BIT_PROTV_MISALIG_DATA, 4f
+
+	;========= (6a) Access Violation Processing ========
+	bl  do_page_fault
+	b   ret_from_exception
+
+	;========== (6b) Non aligned access ============
+4:
+
+	SAVE_CALLEE_SAVED_USER
+	mov r2, sp              ; callee_regs
+
+	bl  do_misaligned_access
+
+	; TBD: optimize - do this only if a callee reg was involved
+	; either a dst of emulated LD/ST or src with address-writeback
+	RESTORE_CALLEE_SAVED_USER
+
+	b   ret_from_exception
+
+END(EV_TLBProtV)
+
+; Wrapper for Linux page fault handler called from EV_TLBMiss*
+; Very similar to ProtV handler case (6a) above, but avoids the extra checks
+; for Misaligned access
+;
+ENTRY(call_do_page_fault)
+
+	EXCEPTION_PROLOGUE
+	lr  r0, [efa]	; Faulting Data address
+	mov   r1, sp
+	FAKE_RET_FROM_EXCPN
+
+	mov blink, ret_from_exception
+	b  do_page_fault
+
+END(call_do_page_fault)
+
+;############# Common Handlers for ARCompact and ARCv2 ##############
+
+#include "entry.S"
+
+;############# Return from Intr/Excp/Trap (ARC Specifics) ##############
+;
+; Restore the saved sys context (common exit-path for EXCPN/IRQ/Trap)
+; IRQ shd definitely not happen between now and rtie
+; All 2 entry points to here already disable interrupts
+
+.Lrestore_regs:
+
+	TRACE_ASM_IRQ_ENABLE
+
+	lr	r10, [status32]
+
+	; Restore REG File. In case multiple Events outstanding,
+	; use the same priorty as rtie: EXCPN, L2 IRQ, L1 IRQ, None
+	; Note that we use realtime STATUS32 (not pt_regs->status32) to
+	; decide that.
+
+	; if Returning from Exception
+	bbit0  r10, STATUS_AE_BIT, not_exception
+	EXCEPTION_EPILOGUE
+	rtie
+
+	; Not Exception so maybe Interrupts (Level 1 or 2)
+
+not_exception:
+
+#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
+
+	; Level 2 interrupt return Path - from hardware standpoint
+	bbit0  r10, STATUS_A2_BIT, not_level2_interrupt
+
+	;------------------------------------------------------------------
+	; However the context returning might not have taken L2 intr itself
+	; e.g. Task'A' user-code -> L2 intr -> schedule -> 'B' user-code ret
+	; Special considerations needed for the context which took L2 intr
+
+	ld   r9, [sp, PT_event]        ; Ensure this is L2 intr context
+	brne r9, event_IRQ2, 149f
+
+	;------------------------------------------------------------------
+	; if L2 IRQ interrupted an L1 ISR,  we'd disabled preemption earlier
+	; so that sched doesn't move to new task, causing L1 to be delayed
+	; undeterministically. Now that we've achieved that, let's reset
+	; things to what they were, before returning from L2 context
+	;----------------------------------------------------------------
+
+	ld r9, [sp, PT_status32]       ; get statu32_l2 (saved in pt_regs)
+	bbit0 r9, STATUS_A1_BIT, 149f  ; L1 not active when L2 IRQ, so normal
+
+	; decrement thread_info->preempt_count (re-enable preemption)
+	GET_CURR_THR_INFO_FROM_SP   r10
+	ld      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
+
+	; paranoid check, given A1 was active when A2 happened, preempt count
+	; must not be 0 because we would have incremented it.
+	; If this does happen we simply HALT as it means a BUG !!!
+	cmp     r9, 0
+	bnz     2f
+	flag 1
+
+2:
+	sub     r9, r9, 1
+	st      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
+
+149:
+	;return from level 2
+	INTERRUPT_EPILOGUE 2
+debug_marker_l2:
+	rtie
+
+not_level2_interrupt:
+
+#endif
+
+	bbit0  r10, STATUS_A1_BIT, not_level1_interrupt
+
+	;return from level 1
+	INTERRUPT_EPILOGUE 1
+debug_marker_l1:
+	rtie
+
+not_level1_interrupt:
+
+	;this case is for syscalls or Exceptions (with fake rtie)
+
+	EXCEPTION_EPILOGUE
+debug_marker_syscall:
+	rtie
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 5995b11181fc..75cdc56351d9 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -1,60 +1,13 @@
 /*
- * Low Level Interrupts/Traps/Exceptions(non-TLB) Handling for ARC
+ * Common Low Level Interrupts/Traps/Exceptions(non-TLB) Handling for ARC
+ * (included from entry-<isa>.S
  *
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * vineetg: May 2011
- *  -Userspace unaligned access emulation
- *
- * vineetg: Feb 2011 (ptrace low level code fixes)
- *  -traced syscall return code (r0) was not saved into pt_regs for restoring
- *   into user reg-file when traded task rets to user space.
- *  -syscalls needing arch-wrappers (mainly for passing sp as pt_regs)
- *   were not invoking post-syscall trace hook (jumping directly into
- *   ret_from_system_call)
- *
- * vineetg: Nov 2010:
- *  -Vector table jumps (@8 bytes) converted into branches (@4 bytes)
- *  -To maintain the slot size of 8 bytes/vector, added nop, which is
- *   not executed at runtime.
- *
- * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
- *  -do_signal()invoked upon TIF_RESTORE_SIGMASK as well
- *  -Wrappers for sys_{,rt_}sigsuspend() nolonger needed as they don't
- *   need ptregs anymore
- *
- * Vineetg: Oct 2009
- *  -In a rare scenario, Process gets a Priv-V exception and gets scheduled
- *   out. Since we don't do FAKE RTIE for Priv-V, CPU excpetion state remains
- *   active (AE bit enabled).  This causes a double fault for a subseq valid
- *   exception. Thus FAKE RTIE needed in low level Priv-Violation handler.
- *   Instr Error could also cause similar scenario, so same there as well.
- *
- * Vineetg: March 2009 (Supporting 2 levels of Interrupts)
- *
- * Vineetg: Aug 28th 2008: Bug #94984
- *  -Zero Overhead Loop Context shd be cleared when entering IRQ/EXcp/Trap
- *   Normally CPU does this automatically, however when doing FAKE rtie,
- *   we need to explicitly do this. The problem in macros
- *   FAKE_RET_FROM_EXCPN and FAKE_RET_FROM_EXCPN_LOCK_IRQ was that this bit
- *   was being "CLEARED" rather then "SET". Since it is Loop INHIBIT Bit,
- *   setting it and not clearing it clears ZOL context
- *
- * Vineetg: May 16th, 2008
- *  - r25 now contains the Current Task when in kernel
- *
- * Vineetg: Dec 22, 2007
- *    Minor Surgery of Low Level ISR to make it SMP safe
- *    - MMU_SCRATCH0 Reg used for freeing up r9 in Level 1 ISR
- *    - _current_task is made an array of NR_CPUS
- *    - Access of _current_task wrapped inside a macro so that if hardware
- *       team agrees for a dedicated reg, no other code is touched
- *
- * Amit Bhor, Rahul Trivedi, Kanika Nema, Sameer Dhavale : Codito Tech 2004
  */
 
 /*------------------------------------------------------------------
@@ -67,187 +20,10 @@
  *  Global Pointer (gp)                 r26
  *  Frame Pointer (fp)                  r27
  *  Stack Pointer (sp)                  r28
- *  Interrupt link register (ilink1)    r29
- *  Interrupt link register (ilink2)    r30
  *  Branch link register (blink)        r31
  *------------------------------------------------------------------
  */
 
-	.cpu A7
-
-;############################ Vector Table #################################
-
-.macro VECTOR  lbl
-#if 1   /* Just in case, build breaks */
-	j   \lbl
-#else
-	b   \lbl
-	nop
-#endif
-.endm
-
-	.section .vector, "ax",@progbits
-	.align 4
-
-/* Each entry in the vector table must occupy 2 words. Since it is a jump
- * across sections (.vector to .text) we are gauranteed that 'j somewhere'
- * will use the 'j limm' form of the intrsuction as long as somewhere is in
- * a section other than .vector.
- */
-
-; ********* Critical System Events **********************
-VECTOR   res_service             ; 0x0, Restart Vector  (0x0)
-VECTOR   mem_service             ; 0x8, Mem exception   (0x1)
-VECTOR   instr_service           ; 0x10, Instrn Error   (0x2)
-
-; ******************** Device ISRs **********************
-#ifdef CONFIG_ARC_IRQ3_LV2
-VECTOR   handle_interrupt_level2
-#else
-VECTOR   handle_interrupt_level1
-#endif
-
-VECTOR   handle_interrupt_level1
-
-#ifdef CONFIG_ARC_IRQ5_LV2
-VECTOR   handle_interrupt_level2
-#else
-VECTOR   handle_interrupt_level1
-#endif
-
-#ifdef CONFIG_ARC_IRQ6_LV2
-VECTOR   handle_interrupt_level2
-#else
-VECTOR   handle_interrupt_level1
-#endif
-
-.rept   25
-VECTOR   handle_interrupt_level1 ; Other devices
-.endr
-
-/* FOR ARC600: timer = 0x3, uart = 0x8, emac = 0x10 */
-
-; ******************** Exceptions **********************
-VECTOR   EV_MachineCheck         ; 0x100, Fatal Machine check   (0x20)
-VECTOR   EV_TLBMissI             ; 0x108, Intruction TLB miss   (0x21)
-VECTOR   EV_TLBMissD             ; 0x110, Data TLB miss         (0x22)
-VECTOR   EV_TLBProtV             ; 0x118, Protection Violation  (0x23)
-				 ;         or Misaligned Access
-VECTOR   EV_PrivilegeV           ; 0x120, Privilege Violation   (0x24)
-VECTOR   EV_Trap                 ; 0x128, Trap exception        (0x25)
-VECTOR   EV_Extension            ; 0x130, Extn Intruction Excp  (0x26)
-
-.rept   24
-VECTOR   reserved                ; Reserved Exceptions
-.endr
-
-#include <linux/linkage.h>   /* {EXTRY,EXIT} */
-#include <asm/entry.h>       /* SAVE_ALL_{INT1,INT2,SYS...} */
-#include <asm/errno.h>
-#include <asm/arcregs.h>
-#include <asm/irqflags.h>
-
-;##################### Scratch Mem for IRQ stack switching #############
-
-ARCFP_DATA int1_saved_reg
-	.align 32
-	.type   int1_saved_reg, @object
-	.size   int1_saved_reg, 4
-int1_saved_reg:
-	.zero 4
-
-/* Each Interrupt level needs its own scratch */
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
-
-ARCFP_DATA int2_saved_reg
-	.type   int2_saved_reg, @object
-	.size   int2_saved_reg, 4
-int2_saved_reg:
-	.zero 4
-
-#endif
-
-; ---------------------------------------------
-	.section .text, "ax",@progbits
-
-res_service:		; processor restart
-	flag    0x1     ; not implemented
-	nop
-	nop
-
-reserved:		; processor restart
-	rtie            ; jump to processor initializations
-
-;##################### Interrupt Handling ##############################
-
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
-; ---------------------------------------------
-;  Level 2 ISR: Can interrupt a Level 1 ISR
-; ---------------------------------------------
-ENTRY(handle_interrupt_level2)
-
-	INTERRUPT_PROLOGUE 2
-
-	;------------------------------------------------------
-	; if L2 IRQ interrupted a L1 ISR, disable preemption
-	;------------------------------------------------------
-
-	ld r9, [sp, PT_status32]        ; get statu32_l2 (saved in pt_regs)
-	bbit0 r9, STATUS_A1_BIT, 1f     ; L1 not active when L2 IRQ, so normal
-
-	; A1 is set in status32_l2
-	; bump thread_info->preempt_count (Disable preemption)
-	GET_CURR_THR_INFO_FROM_SP   r10
-	ld      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
-	add     r9, r9, 1
-	st      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
-
-1:
-	;------------------------------------------------------
-	; setup params for Linux common ISR and invoke it
-	;------------------------------------------------------
-	lr  r0, [icause2]
-	and r0, r0, 0x1f
-
-	bl.d  @arch_do_IRQ
-	mov r1, sp
-
-	mov r8,0x2
-	sr r8, [AUX_IRQ_LV12]       ; clear bit in Sticky Status Reg
-
-	b   ret_from_exception
-
-END(handle_interrupt_level2)
-
-#endif
-
-; ---------------------------------------------
-;  Level 1 ISR
-; ---------------------------------------------
-ENTRY(handle_interrupt_level1)
-
-	INTERRUPT_PROLOGUE 1
-
-	lr  r0, [icause1]
-	and r0, r0, 0x1f
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	; icause1 needs to be read early, before calling tracing, which
-	; can clobber scratch regs, hence use of stack to stash it
-	push r0
-	TRACE_ASM_IRQ_DISABLE
-	pop  r0
-#endif
-
-	bl.d  @arch_do_IRQ
-	mov r1, sp
-
-	mov r8,0x1
-	sr r8, [AUX_IRQ_LV12]       ; clear bit in Sticky Status Reg
-
-	b   ret_from_exception
-END(handle_interrupt_level1)
-
 ;################### Non TLB Exception Handling #############################
 
 ; ---------------------------------------------
@@ -315,70 +91,6 @@ ENTRY(EV_MachineCheck)
 END(EV_MachineCheck)
 
 ; ---------------------------------------------
-; Protection Violation Exception Handler
-; ---------------------------------------------
-
-ENTRY(EV_TLBProtV)
-
-	EXCEPTION_PROLOGUE
-
-	lr  r2, [ecr]
-	lr  r0, [efa]	; Faulting Data address (not part of pt_regs saved above)
-
-	; Exception auto-disables further Intr/exceptions.
-	; Re-enable them by pretending to return from exception
-	; (so rest of handler executes in pure K mode)
-
-	FAKE_RET_FROM_EXCPN
-
-	mov   r1, sp	; Handle to pt_regs
-
-	;------ (5) Type of Protection Violation? ----------
-	;
-	; ProtV Hardware Exception is triggered for Access Faults of 2 types
-	;   -Access Violaton	: 00_23_(00|01|02|03)_00
-	;			         x  r  w  r+w
-	;   -Unaligned Access	: 00_23_04_00
-	;
-	bbit1 r2, ECR_C_BIT_PROTV_MISALIG_DATA, 4f
-
-	;========= (6a) Access Violation Processing ========
-	bl  do_page_fault
-	b   ret_from_exception
-
-	;========== (6b) Non aligned access ============
-4:
-
-	SAVE_CALLEE_SAVED_USER
-	mov r2, sp              ; callee_regs
-
-	bl  do_misaligned_access
-
-	; TBD: optimize - do this only if a callee reg was involved
-	; either a dst of emulated LD/ST or src with address-writeback
-	RESTORE_CALLEE_SAVED_USER
-
-	b   ret_from_exception
-
-END(EV_TLBProtV)
-
-; Wrapper for Linux page fault handler called from EV_TLBMiss*
-; Very similar to ProtV handler case (6a) above, but avoids the extra checks
-; for Misaligned access
-;
-ENTRY(call_do_page_fault)
-
-	EXCEPTION_PROLOGUE
-	lr  r0, [efa]	; Faulting Data address
-	mov   r1, sp
-	FAKE_RET_FROM_EXCPN
-
-	mov blink, ret_from_exception
-	b  do_page_fault
-
-END(call_do_page_fault)
-
-; ---------------------------------------------
 ; Privilege Violation Exception Handler
 ; ---------------------------------------------
 ENTRY(EV_PrivilegeV)
@@ -625,97 +337,7 @@ resume_kernel_mode:
 	; preempt_schedule_irq() always returns with IRQ disabled
 #endif
 
-	; fall through
-
-;############# Return from Intr/Excp/Trap (ARC Specifics) ##############
-;
-; Restore the saved sys context (common exit-path for EXCPN/IRQ/Trap)
-; IRQ shd definitely not happen between now and rtie
-; All 2 entry points to here already disable interrupts
-
-.Lrestore_regs:
-
-	TRACE_ASM_IRQ_ENABLE
-
-	lr	r10, [status32]
-
-	; Restore REG File. In case multiple Events outstanding,
-	; use the same priorty as rtie: EXCPN, L2 IRQ, L1 IRQ, None
-	; Note that we use realtime STATUS32 (not pt_regs->status32) to
-	; decide that.
-
-	; if Returning from Exception
-	bbit0  r10, STATUS_AE_BIT, not_exception
-	EXCEPTION_EPILOGUE
-	rtie
-
-	; Not Exception so maybe Interrupts (Level 1 or 2)
-
-not_exception:
-
-#ifdef CONFIG_ARC_COMPACT_IRQ_LEVELS
-
-	; Level 2 interrupt return Path - from hardware standpoint
-	bbit0  r10, STATUS_A2_BIT, not_level2_interrupt
-
-	;------------------------------------------------------------------
-	; However the context returning might not have taken L2 intr itself
-	; e.g. Task'A' user-code -> L2 intr -> schedule -> 'B' user-code ret
-	; Special considerations needed for the context which took L2 intr
-
-	ld   r9, [sp, PT_event]        ; Ensure this is L2 intr context
-	brne r9, event_IRQ2, 149f
-
-	;------------------------------------------------------------------
-	; if L2 IRQ interrupted an L1 ISR,  we'd disabled preemption earlier
-	; so that sched doesn't move to new task, causing L1 to be delayed
-	; undeterministically. Now that we've achieved that, let's reset
-	; things to what they were, before returning from L2 context
-	;----------------------------------------------------------------
-
-	ld r9, [sp, PT_status32]       ; get statu32_l2 (saved in pt_regs)
-	bbit0 r9, STATUS_A1_BIT, 149f  ; L1 not active when L2 IRQ, so normal
-
-	; decrement thread_info->preempt_count (re-enable preemption)
-	GET_CURR_THR_INFO_FROM_SP   r10
-	ld      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
-
-	; paranoid check, given A1 was active when A2 happened, preempt count
-	; must not be 0 because we would have incremented it.
-	; If this does happen we simply HALT as it means a BUG !!!
-	cmp     r9, 0
-	bnz     2f
-	flag 1
-
-2:
-	sub     r9, r9, 1
-	st      r9, [r10, THREAD_INFO_PREEMPT_COUNT]
-
-149:
-	;return from level 2
-	INTERRUPT_EPILOGUE 2
-debug_marker_l2:
-	rtie
-
-not_level2_interrupt:
-
-#endif
-
-	bbit0  r10, STATUS_A1_BIT, not_level1_interrupt
-
-	;return from level 1
-	INTERRUPT_EPILOGUE 1
-debug_marker_l1:
-	rtie
-
-not_level1_interrupt:
-
-	;this case is for syscalls or Exceptions (with fake rtie)
-
-	EXCEPTION_EPILOGUE
-debug_marker_syscall:
-	rtie
-
+	b	.Lrestore_regs
 END(ret_from_exception)
 
 ENTRY(ret_from_fork)
@@ -762,4 +384,7 @@ END(sys_clone_wrapper)
 ; This also fixes STAR 9000487933 where the prev-workaround (objcopy --setflag)
 ; would not work after a clean build due to kernel build system dependencies.
 .section .debug_frame, "wa",@progbits
+
+; Reset to .text as this file is included in entry-<isa>.S
+.section .text, "ax",@progbits
 #endif
-- 
1.9.1
