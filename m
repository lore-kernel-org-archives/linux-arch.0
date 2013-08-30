From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 07/11] xtensa: keep a3 and excsave1 on entry to exception handlers
Date: Fri, 30 Aug 2013 19:34:59 +0400
Message-ID: <1377876903-27860-8-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35320 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab3H3PfY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:24 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so1890262lbi.32
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:22 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Based on the SMP patch by Joe Taylor and subsequent fixes.
Preserve exception table pointer (normally stored in excsave1 SR) as it
cannot be easily restored in SMP environment.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/regs.h   |    1 +
 arch/xtensa/kernel/align.S       |    5 +-
 arch/xtensa/kernel/coprocessor.S |    9 +-
 arch/xtensa/kernel/entry.S       |  115 +++++++----------
 arch/xtensa/kernel/vectors.S     |  250 ++++++++++++++++++++++++++++----------
 5 files changed, 238 insertions(+), 142 deletions(-)

diff --git a/arch/xtensa/include/asm/regs.h b/arch/xtensa/include/asm/regs.h
index b24de67..4ba9f51 100644
--- a/arch/xtensa/include/asm/regs.h
+++ b/arch/xtensa/include/asm/regs.h
@@ -82,6 +82,7 @@
 #define PS_CALLINC_SHIFT	16
 #define PS_CALLINC_MASK		0x00030000
 #define PS_OWB_SHIFT		8
+#define PS_OWB_WIDTH		4
 #define PS_OWB_MASK		0x00000F00
 #define PS_RING_SHIFT		6
 #define PS_RING_MASK		0x000000C0
diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
index aa2e87b..d4cef60 100644
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -146,9 +146,9 @@
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -171,7 +171,6 @@ ENTRY(fast_unaligned)
 	s32i	a8, a2, PT_AREG8
 
 	rsr	a0, depc
-	xsr	a3, excsave1
 	s32i	a0, a2, PT_AREG2
 	s32i	a3, a2, PT_AREG3
 
diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index 6476574..a482df5 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -32,9 +32,9 @@
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -225,9 +225,9 @@ ENDPROC(coprocessor_restore)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -245,7 +245,6 @@ ENTRY(fast_coprocessor)
 
 	/* Save remaining registers a1-a3 and SAR */
 
-	xsr	a3, excsave1
 	s32i	a3, a2, PT_AREG3
 	rsr	a3, sar
 	s32i	a1, a2, PT_AREG1
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 3f3de28..ab025c1 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -91,9 +91,9 @@
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original value in depc
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave1:	a3
+ *   excsave1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -109,9 +109,8 @@
 
 ENTRY(user_exception)
 
-	/* Save a2, a3, and depc, restore excsave_1 and set SP. */
+	/* Save a1, a2, a3, and set SP. */
 
-	xsr	a3, excsave1
 	rsr	a0, depc
 	s32i	a1, a2, PT_AREG1
 	s32i	a0, a2, PT_AREG2
@@ -237,9 +236,9 @@ ENDPROC(user_exception)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -255,9 +254,8 @@ ENDPROC(user_exception)
 
 ENTRY(kernel_exception)
 
-	/* Save a0, a2, a3, DEPC and set SP. */
+	/* Save a1, a2, a3, and set SP. */
 
-	xsr	a3, excsave1		# restore a3, excsave_1
 	rsr	a0, depc		# get a2
 	s32i	a1, a2, PT_AREG1
 	s32i	a0, a2, PT_AREG2
@@ -408,7 +406,7 @@ common_exception:
 	 * exception handler and call the exception handler.
 	 */
 
-	movi	a4, exc_table
+	rsr	a4, excsave1
 	mov	a6, a1			# pass stack frame
 	mov	a7, a0			# pass EXCCAUSE
 	addx4	a4, a0, a4
@@ -832,9 +830,9 @@ ENDPROC(unrecoverable_exception)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -857,18 +855,16 @@ ENTRY(fast_alloca)
 
 	rsr	a0, depc		# get a2
 	s32i	a4, a2, PT_AREG4	# save a4 and
+	s32i	a3, a2, PT_AREG3
 	s32i	a0, a2, PT_AREG2	# a2 to stack
 
 	/* Exit critical section. */
 
 	movi	a0, 0
+	rsr	a3, excsave1
 	s32i	a0, a3, EXC_TABLE_FIXUP
 
-	/* Restore a3, excsave_1 */
-
-	xsr	a3, excsave1		# make sure excsave_1 is valid for dbl.
 	rsr	a4, epc1		# get exception address
-	s32i	a3, a2, PT_AREG3	# save a3 to stack
 
 #ifdef ALLOCA_EXCEPTION_IN_IRAM
 #error	iram not supported
@@ -1007,9 +1003,9 @@ ENDPROC(fast_alloca)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  */
 
 ENTRY(fast_syscall_kernel)
@@ -1056,7 +1052,6 @@ ENTRY(fast_syscall_unrecoverable)
 
 	l32i    a0, a2, PT_AREG0        # restore a0
 	xsr     a2, depc                # restore a2, depc
-	rsr     a3, excsave1
 
 	wsr     a0, excsave1
 	movi    a0, unrecoverable_exception
@@ -1078,10 +1073,10 @@ ENDPROC(fast_syscall_unrecoverable)
  *   a0:	a2 (syscall-nr), original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in a0 and DEPC
- *   a3:	dispatch table, original in excsave_1
+ *   a3:	a3
  *   a4..a15:	unchanged
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -1114,8 +1109,6 @@ ENDPROC(fast_syscall_unrecoverable)
 
 ENTRY(fast_syscall_xtensa)
 
-	xsr	a3, excsave1		# restore a3, excsave1
-
 	s32i	a7, a2, PT_AREG7	# we need an additional register
 	movi	a7, 4			# sizeof(unsigned int)
 	access_ok a3, a7, a0, a2, .Leac	# a0: scratch reg, a2: sp
@@ -1178,9 +1171,9 @@ ENDPROC(fast_syscall_xtensa)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  * Note: We assume the stack pointer is EXC_TABLE_KSTK in the fixup handler.
  */
@@ -1189,15 +1182,16 @@ ENTRY(fast_syscall_spill_registers)
 
 	/* Register a FIXUP handler (pass current wb as a parameter) */
 
+	xsr	a3, excsave1
 	movi	a0, fast_syscall_spill_registers_fixup
 	s32i	a0, a3, EXC_TABLE_FIXUP
 	rsr	a0, windowbase
 	s32i	a0, a3, EXC_TABLE_PARAM
+	xsr	a3, excsave1		# restore a3 and excsave_1
 
-	/* Save a3 and SAR on stack. */
+	/* Save a3, a4 and SAR on stack. */
 
 	rsr	a0, sar
-	xsr	a3, excsave1		# restore a3 and excsave_1
 	s32i	a3, a2, PT_AREG3
 	s32i	a4, a2, PT_AREG4
 	s32i	a0, a2, PT_AREG5	# store SAR to PT_AREG5
@@ -1251,14 +1245,14 @@ fast_syscall_spill_registers_fixup:
 	 * in WS, so that the exception handlers save them to the task stack.
 	 */
 
-	rsr	a3, excsave1	# get spill-mask
+	xsr	a3, excsave1	# get spill-mask
 	slli	a2, a3, 1	# shift left by one
 
 	slli	a3, a2, 32-WSBITS
 	src	a2, a2, a3	# a1 = xxwww1yyxxxwww1yy......
 	wsr	a2, windowstart	# set corrected windowstart
 
-	movi	a3, exc_table
+	rsr	a3, excsave1
 	l32i	a2, a3, EXC_TABLE_DOUBLE_SAVE	# restore a2
 	l32i	a3, a3, EXC_TABLE_PARAM	# original WB (in user task)
 
@@ -1295,7 +1289,7 @@ fast_syscall_spill_registers_fixup:
 
 	/* Jump to the exception handler. */
 
-	movi	a3, exc_table
+	rsr	a3, excsave1
 	rsr	a0, exccause
 	addx4	a0, a0, a3              	# find entry in table
 	l32i	a0, a0, EXC_TABLE_FAST_USER     # load handler
@@ -1312,6 +1306,7 @@ fast_syscall_spill_registers_fixup_return:
 	xsr	a3, excsave1
 	movi	a2, fast_syscall_spill_registers_fixup
 	s32i	a2, a3, EXC_TABLE_FIXUP
+	s32i	a0, a3, EXC_TABLE_DOUBLE_SAVE
 	rsr	a2, windowbase
 	s32i	a2, a3, EXC_TABLE_PARAM
 	l32i	a2, a3, EXC_TABLE_KSTK
@@ -1323,11 +1318,6 @@ fast_syscall_spill_registers_fixup_return:
 	wsr	a3, windowbase
 	rsync
 
-	/* Restore a3 and return. */
-
-	movi	a3, exc_table
-	xsr	a3, excsave1
-
 	rfde
 
 
@@ -1514,9 +1504,8 @@ ENTRY(_spill_registers)
 
 	movi	a0, 0
 
-	movi	a3, exc_table
+	rsr	a3, excsave1
 	l32i	a1, a3, EXC_TABLE_KSTK
-	wsr	a3, excsave1
 
 	movi	a4, (1 << PS_WOE_BIT) | LOCKLEVEL
 	wsr	a4, ps
@@ -1560,9 +1549,9 @@ ENDPROC(fast_second_level_miss_double_kernel)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -1570,9 +1559,10 @@ ENDPROC(fast_second_level_miss_double_kernel)
 
 ENTRY(fast_second_level_miss)
 
-	/* Save a1. Note: we don't expect a double exception. */
+	/* Save a1 and a3. Note: we don't expect a double exception. */
 
 	s32i	a1, a2, PT_AREG1
+	s32i	a3, a2, PT_AREG3
 
 	/* We need to map the page of PTEs for the user task.  Find
 	 * the pointer to that page.  Also, it's possible for tsk->mm
@@ -1594,9 +1584,6 @@ ENTRY(fast_second_level_miss)
 	l32i	a0, a1, TASK_MM		# tsk->mm
 	beqz	a0, 9f
 
-
-	/* We deliberately destroy a3 that holds the exception table. */
-
 8:	rsr	a3, excvaddr		# fault address
 	_PGD_OFFSET(a0, a3, a1)
 	l32i	a0, a0, 0		# read pmdval
@@ -1647,7 +1634,7 @@ ENTRY(fast_second_level_miss)
 
 	/* Exit critical section. */
 
-4:	movi	a3, exc_table		# restore a3
+4:	rsr	a3, excsave1
 	movi	a0, 0
 	s32i	a0, a3, EXC_TABLE_FIXUP
 
@@ -1655,8 +1642,8 @@ ENTRY(fast_second_level_miss)
 
 	l32i	a0, a2, PT_AREG0
 	l32i	a1, a2, PT_AREG1
+	l32i	a3, a2, PT_AREG3
 	l32i	a2, a2, PT_DEPC
-	xsr	a3, excsave1
 
 	bgeui	a2, VALID_DOUBLE_EXCEPTION_ADDRESS, 1f
 
@@ -1743,11 +1730,8 @@ ENTRY(fast_second_level_miss)
 
 2:	/* Invalid PGD, default exception handling */
 
-	movi	a3, exc_table
 	rsr	a1, depc
-	xsr	a3, excsave1
 	s32i	a1, a2, PT_AREG2
-	s32i	a3, a2, PT_AREG3
 	mov	a1, a2
 
 	rsr	a2, ps
@@ -1767,9 +1751,9 @@ ENDPROC(fast_second_level_miss)
  *   a0:	trashed, original value saved on stack (PT_AREG0)
  *   a1:	a1
  *   a2:	new stack pointer, original in DEPC
- *   a3:	dispatch table
+ *   a3:	a3
  *   depc:	a2, original value saved on stack (PT_DEPC)
- *   excsave_1:	a3
+ *   excsave_1:	dispatch table
  *
  *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
@@ -1777,17 +1761,17 @@ ENDPROC(fast_second_level_miss)
 
 ENTRY(fast_store_prohibited)
 
-	/* Save a1 and a4. */
+	/* Save a1 and a3. */
 
 	s32i	a1, a2, PT_AREG1
-	s32i	a4, a2, PT_AREG4
+	s32i	a3, a2, PT_AREG3
 
 	GET_CURRENT(a1,a2)
 	l32i	a0, a1, TASK_MM		# tsk->mm
 	beqz	a0, 9f
 
 8:	rsr	a1, excvaddr		# fault address
-	_PGD_OFFSET(a0, a1, a4)
+	_PGD_OFFSET(a0, a1, a3)
 	l32i	a0, a0, 0
 	beqz	a0, 2f
 
@@ -1796,39 +1780,37 @@ ENTRY(fast_store_prohibited)
 	 * and is not PAGE_NONE. See pgtable.h for possible PTE layouts.
 	 */
 
-	_PTE_OFFSET(a0, a1, a4)
-	l32i	a4, a0, 0		# read pteval
+	_PTE_OFFSET(a0, a1, a3)
+	l32i	a3, a0, 0		# read pteval
 	movi	a1, _PAGE_CA_INVALID
-	ball	a4, a1, 2f
-	bbci.l	a4, _PAGE_WRITABLE_BIT, 2f
+	ball	a3, a1, 2f
+	bbci.l	a3, _PAGE_WRITABLE_BIT, 2f
 
 	movi	a1, _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_HW_WRITE
-	or	a4, a4, a1
+	or	a3, a3, a1
 	rsr	a1, excvaddr
-	s32i	a4, a0, 0
+	s32i	a3, a0, 0
 
 	/* We need to flush the cache if we have page coloring. */
 #if (DCACHE_WAY_SIZE > PAGE_SIZE) && XCHAL_DCACHE_IS_WRITEBACK
 	dhwb	a0, 0
 #endif
 	pdtlb	a0, a1
-	wdtlb	a4, a0
+	wdtlb	a3, a0
 
 	/* Exit critical section. */
 
 	movi	a0, 0
+	rsr	a3, excsave1
 	s32i	a0, a3, EXC_TABLE_FIXUP
 
 	/* Restore the working registers, and return. */
 
-	l32i	a4, a2, PT_AREG4
+	l32i	a3, a2, PT_AREG3
 	l32i	a1, a2, PT_AREG1
 	l32i	a0, a2, PT_AREG0
 	l32i	a2, a2, PT_DEPC
 
-	/* Restore excsave1 and a3. */
-
-	xsr	a3, excsave1
 	bgeui	a2, VALID_DOUBLE_EXCEPTION_ADDRESS, 1f
 
 	rsr	a2, depc
@@ -1845,11 +1827,8 @@ ENTRY(fast_store_prohibited)
 
 2:	/* If there was a problem, handle fault in C */
 
-	rsr	a4, depc	# still holds a2
-	xsr	a3, excsave1
-	s32i	a4, a2, PT_AREG2
-	s32i	a3, a2, PT_AREG3
-	l32i	a4, a2, PT_AREG4
+	rsr	a3, depc	# still holds a2
+	s32i	a3, a2, PT_AREG2
 	mov	a1, a2
 
 	rsr	a2, ps
diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
index f9e1753..cb8fd44 100644
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -78,6 +78,7 @@ ENTRY(_UserExceptionVector)
 	s32i	a0, a2, PT_DEPC		# mark it as a regular exception
 	addx4	a0, a0, a3		# find entry in table
 	l32i	a0, a0, EXC_TABLE_FAST_USER	# load handler
+	xsr	a3, excsave1		# restore a3 and dispatch table
 	jx	a0
 
 ENDPROC(_UserExceptionVector)
@@ -104,6 +105,7 @@ ENTRY(_KernelExceptionVector)
 	s32i	a0, a2, PT_DEPC		# mark it as a regular exception
 	addx4	a0, a0, a3		# find entry in table
 	l32i	a0, a0, EXC_TABLE_FAST_KERNEL	# load handler address
+	xsr	a3, excsave1		# restore a3 and dispatch table
 	jx	a0
 
 ENDPROC(_KernelExceptionVector)
@@ -168,7 +170,7 @@ ENDPROC(_KernelExceptionVector)
  *
  *	a0:	   DEPC
  *	a1: 	   a1
- *	a2:	   trashed, original value in EXC_TABLE_DOUBLE_A2
+ *	a2:	   trashed, original value in EXC_TABLE_DOUBLE_SAVE
  *	a3:	   exctable
  *	depc:	   a0
  *	excsave_1: a3
@@ -204,47 +206,46 @@ ENDPROC(_KernelExceptionVector)
 
 	.section .DoubleExceptionVector.text, "ax"
 	.begin literal_prefix .DoubleExceptionVector
+	.globl _DoubleExceptionVector_WindowUnderflow
+	.globl _DoubleExceptionVector_WindowOverflow
 
 ENTRY(_DoubleExceptionVector)
 
-	/* Deliberately destroy excsave (don't assume it's value was valid). */
-
-	wsr	a3, excsave1		# save a3
+	xsr	a3, excsave1
+	s32i	a2, a3, EXC_TABLE_DOUBLE_SAVE
 
 	/* Check for kernel double exception (usually fatal). */
 
-	rsr	a3, ps
-	_bbci.l	a3, PS_UM_BIT, .Lksp
+	rsr	a2, ps
+	_bbci.l	a2, PS_UM_BIT, .Lksp
 
 	/* Check if we are currently handling a window exception. */
 	/* Note: We don't need to indicate that we enter a critical section. */
 
 	xsr	a0, depc		# get DEPC, save a0
 
-	movi	a3, WINDOW_VECTORS_VADDR
-	_bltu	a0, a3, .Lfixup
-	addi	a3, a3, WINDOW_VECTORS_SIZE
-	_bgeu	a0, a3, .Lfixup
+	movi	a2, WINDOW_VECTORS_VADDR
+	_bltu	a0, a2, .Lfixup
+	addi	a2, a2, WINDOW_VECTORS_SIZE
+	_bgeu	a0, a2, .Lfixup
 
 	/* Window overflow/underflow exception. Get stack pointer. */
 
-	mov	a3, a2
-	/* This explicit literal and the following references to it are made
-	 * in order to fit DoubleExceptionVector.literals into the available
-	 * 16-byte gap before DoubleExceptionVector.text in the absence of
-	 * link time relaxation. See kernel/vmlinux.lds.S
-	 */
-	.literal .Lexc_table, exc_table
-	l32r	a2, .Lexc_table
-	l32i	a2, a2, EXC_TABLE_KSTK
+	l32i	a2, a3, EXC_TABLE_KSTK
 
 	/* Check for overflow/underflow exception, jump if overflow. */
 
-	_bbci.l	a0, 6, .Lovfl
-
-	/* a0: depc, a1: a1, a2: kstk, a3: a2, depc: a0, excsave: a3  */
+	_bbci.l	a0, 6, _DoubleExceptionVector_WindowOverflow
 
-	/* Restart window underflow exception.
+	/*
+	 * Restart window underflow exception.
+	 * Currently:
+	 *	depc = orig a0,
+	 *	a0 = orig DEPC,
+	 *	a2 = new sp based on KSTK from exc_table
+	 *	a3 = excsave_1
+	 *	excsave_1 = orig a3
+	 *
 	 * We return to the instruction in user space that caused the window
 	 * underflow exception. Therefore, we change window base to the value
 	 * before we entered the window underflow exception and prepare the
@@ -252,10 +253,11 @@ ENTRY(_DoubleExceptionVector)
 	 * by changing depc (in a0).
 	 * Note: We can trash the current window frame (a0...a3) and depc!
 	 */
-
+_DoubleExceptionVector_WindowUnderflow:
+	xsr	a3, excsave1
 	wsr	a2, depc		# save stack pointer temporarily
 	rsr	a0, ps
-	extui	a0, a0, PS_OWB_SHIFT, 4
+	extui	a0, a0, PS_OWB_SHIFT, PS_OWB_WIDTH
 	wsr	a0, windowbase
 	rsync
 
@@ -263,28 +265,57 @@ ENTRY(_DoubleExceptionVector)
 
 	xsr	a2, depc		# save a2 and get stack pointer
 	s32i	a0, a2, PT_AREG0
-
-	wsr	a3, excsave1		# save a3
-	l32r	a3, .Lexc_table
-
+	xsr	a3, excsave1
 	rsr	a0, exccause
 	s32i	a0, a2, PT_DEPC		# mark it as a regular exception
 	addx4	a0, a0, a3
+	xsr	a3, excsave1
 	l32i	a0, a0, EXC_TABLE_FAST_USER
 	jx	a0
 
-.Lfixup:/* Check for a fixup handler or if we were in a critical section. */
+	/*
+	 * We only allow the ITLB miss exception if we are in kernel space.
+	 * All other exceptions are unexpected and thus unrecoverable!
+	 */
+
+#ifdef CONFIG_MMU
+	.extern fast_second_level_miss_double_kernel
+
+.Lksp:	/* a0: a0, a1: a1, a2: a2, a3: trashed, depc: depc, excsave: a3 */
+
+	rsr	a3, exccause
+	beqi	a3, EXCCAUSE_ITLB_MISS, 1f
+	addi	a3, a3, -EXCCAUSE_DTLB_MISS
+	bnez	a3, .Lunrecoverable
+1:	movi	a3, fast_second_level_miss_double_kernel
+	jx	a3
+#else
+.equ	.Lksp,	.Lunrecoverable
+#endif
+
+	/* Critical! We can't handle this situation. PANIC! */
 
-	/* a0: depc, a1: a1, a2: a2, a3: trashed, depc: a0, excsave1: a3 */
+	.extern unrecoverable_exception
 
-	l32r	a3, .Lexc_table
-	s32i	a2, a3, EXC_TABLE_DOUBLE_SAVE	# temporary variable
+.Lunrecoverable_fixup:
+	l32i	a2, a3, EXC_TABLE_DOUBLE_SAVE
+	xsr	a0, depc
+
+.Lunrecoverable:
+	rsr	a3, excsave1
+	wsr	a0, excsave1
+	movi	a0, unrecoverable_exception
+	callx0	a0
+
+.Lfixup:/* Check for a fixup handler or if we were in a critical section. */
+
+	/* a0: depc, a1: a1, a2: trash, a3: exctable, depc: a0, excsave1: a3 */
 
 	/* Enter critical section. */
 
 	l32i	a2, a3, EXC_TABLE_FIXUP
 	s32i	a3, a3, EXC_TABLE_FIXUP
-	beq	a2, a3, .Lunrecoverable_fixup	# critical!
+	beq	a2, a3, .Lunrecoverable_fixup	# critical section
 	beqz	a2, .Ldflt			# no handler was registered
 
 	/* a0: depc, a1: a1, a2: trash, a3: exctable, depc: a0, excsave: a3 */
@@ -293,58 +324,145 @@ ENTRY(_DoubleExceptionVector)
 
 .Ldflt:	/* Get stack pointer. */
 
-	l32i	a3, a3, EXC_TABLE_DOUBLE_SAVE
-	addi	a2, a3, -PT_USER_SIZE
-
-.Lovfl:	/* Jump to default handlers. */
+	l32i	a2, a3, EXC_TABLE_DOUBLE_SAVE
+	addi	a2, a2, -PT_USER_SIZE
 
-	/* a0: depc, a1: a1, a2: kstk, a3: a2, depc: a0, excsave: a3 */
+	/* a0: depc, a1: a1, a2: kstk, a3: exctable, depc: a0, excsave: a3 */
 
-	xsr	a3, depc
 	s32i	a0, a2, PT_DEPC
-	s32i	a3, a2, PT_AREG0
+	l32i	a0, a3, EXC_TABLE_DOUBLE_SAVE
+	xsr	a0, depc
+	s32i	a0, a2, PT_AREG0
 
-	/* a0: avail, a1: a1, a2: kstk, a3: avail, depc: a2, excsave: a3 */
+	/* a0: avail, a1: a1, a2: kstk, a3: exctable, depc: a2, excsave: a3 */
 
-	l32r	a3, .Lexc_table
 	rsr	a0, exccause
 	addx4	a0, a0, a3
+	xsr	a3, excsave1
 	l32i	a0, a0, EXC_TABLE_FAST_USER
 	jx	a0
 
 	/*
-	 * We only allow the ITLB miss exception if we are in kernel space.
-	 * All other exceptions are unexpected and thus unrecoverable!
+	 * Restart window OVERFLOW exception.
+	 * Currently:
+	 *	depc = orig a0,
+	 *	a0 = orig DEPC,
+	 *	a2 = new sp based on KSTK from exc_table
+	 *	a3 = EXCSAVE_1
+	 *	excsave_1 = orig a3
+	 *
+	 * We return to the instruction in user space that caused the window
+	 * overflow exception. Therefore, we change window base to the value
+	 * before we entered the window overflow exception and prepare the
+	 * registers to return as if we were coming from a regular exception
+	 * by changing DEPC (in a0).
+	 *
+	 * NOTE: We CANNOT trash the current window frame (a0...a3), but we
+	 * can clobber depc.
+	 *
+	 * The tricky part here is that overflow8 and overflow12 handlers
+	 * save a0, then clobber a0.  To restart the handler, we have to restore
+	 * a0 if the double exception was past the point where a0 was clobbered.
+	 *
+	 * To keep things simple, we take advantage of the fact all overflow
+	 * handlers save a0 in their very first instruction.  If DEPC was past
+	 * that instruction, we can safely restore a0 from where it was saved
+	 * on the stack.
+	 *
+	 * a0: depc, a1: a1, a2: kstk, a3: exc_table, depc: a0, excsave1: a3
 	 */
+_DoubleExceptionVector_WindowOverflow:
+	extui	a2, a0, 0, 6	# get offset into 64-byte vector handler
+	beqz	a2, 1f		# if at start of vector, don't restore
 
-#ifdef CONFIG_MMU
-	.extern fast_second_level_miss_double_kernel
+	addi	a0, a0, -128
+	bbsi	a0, 8, 1f	# don't restore except for overflow 8 and 12
+	bbsi	a0, 7, 2f
 
-.Lksp:	/* a0: a0, a1: a1, a2: a2, a3: trashed, depc: depc, excsave: a3 */
+	/*
+	 * Restore a0 as saved by _WindowOverflow8().
+	 *
+	 * FIXME:  we really need a fixup handler for this L32E,
+	 * for the extremely unlikely case where the overflow handler's
+	 * reference thru a0 gets a hardware TLB refill that bumps out
+	 * the (distinct, aliasing) TLB entry that mapped its prior
+	 * references thru a9, and where our reference now thru a9
+	 * gets a 2nd-level miss exception (not hardware TLB refill).
+	 */
 
-	rsr	a3, exccause
-	beqi	a3, EXCCAUSE_ITLB_MISS, 1f
-	addi	a3, a3, -EXCCAUSE_DTLB_MISS
-	bnez	a3, .Lunrecoverable
-1:	movi	a3, fast_second_level_miss_double_kernel
-	jx	a3
-#else
-.equ	.Lksp,	.Lunrecoverable
-#endif
+	l32e	a2, a9, -16
+	wsr	a2, depc	# replace the saved a0
+	j	1f
 
-	/* Critical! We can't handle this situation. PANIC! */
+2:
+	/*
+	 * Restore a0 as saved by _WindowOverflow12().
+	 *
+	 * FIXME:  we really need a fixup handler for this L32E,
+	 * for the extremely unlikely case where the overflow handler's
+	 * reference thru a0 gets a hardware TLB refill that bumps out
+	 * the (distinct, aliasing) TLB entry that mapped its prior
+	 * references thru a13, and where our reference now thru a13
+	 * gets a 2nd-level miss exception (not hardware TLB refill).
+	 */
 
-	.extern unrecoverable_exception
+	l32e	a2, a13, -16
+	wsr	a2, depc	# replace the saved a0
+1:
+	/*
+	 * Restore WindowBase while leaving all address registers restored.
+	 * We have to use ROTW for this, because WSR.WINDOWBASE requires
+	 * an address register (which would prevent restore).
+	 *
+	 * Window Base goes from 0 ... 7 (Module 8)
+	 * Window Start is 8 bits; Ex: (0b1010 1010):0x55 from series of call4s
+	 */
+
+	rsr	a0, ps
+	extui	a0, a0, PS_OWB_SHIFT, PS_OWB_WIDTH
+	rsr	a2, windowbase
+	sub	a0, a2, a0
+	extui	a0, a0, 0, 3
 
-.Lunrecoverable_fixup:
 	l32i	a2, a3, EXC_TABLE_DOUBLE_SAVE
-	xsr	a0, depc
+	xsr	a3, excsave1
+	beqi	a0, 1, .L1pane
+	beqi	a0, 3, .L3pane
 
-.Lunrecoverable:
-	rsr	a3, excsave1
-	wsr	a0, excsave1
-	movi	a0, unrecoverable_exception
-	callx0	a0
+	rsr	a0, depc
+	rotw	-2
+
+	/*
+	 * We are now in the user code's original window frame.
+	 * Process the exception as a user exception as if it was
+	 * taken by the user code.
+	 *
+	 * This is similar to the user exception vector,
+	 * except that PT_DEPC isn't set to EXCCAUSE.
+	 */
+1:
+	xsr	a3, excsave1
+	wsr	a2, depc
+	l32i	a2, a3, EXC_TABLE_KSTK
+	s32i	a0, a2, PT_AREG0
+	rsr	a0, exccause
+
+	s32i	a0, a2, PT_DEPC
+
+	addx4	a0, a0, a3
+	l32i	a0, a0, EXC_TABLE_FAST_USER
+	xsr	a3, excsave1
+	jx	a0
+
+.L1pane:
+	rsr	a0, depc
+	rotw	-1
+	j	1b
+
+.L3pane:
+	rsr	a0, depc
+	rotw	-3
+	j	1b
 
 	.end literal_prefix
 
-- 
1.7.7.6
