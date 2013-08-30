From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 08/11] xtensa: new fast_alloca handler
Date: Fri, 30 Aug 2013 19:35:00 +0400
Message-ID: <1377876903-27860-9-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35784 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab3H3PfZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:25 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so1687722lab.3
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:24 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Instead of emulating movsp instruction in the kernel use window
underflow handler to load missing register window and retry failed
movsp.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S |  192 +++++++++----------------------------------
 1 files changed, 40 insertions(+), 152 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index ab025c1..de1dfa1 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -31,7 +31,6 @@
 /* Unimplemented features. */
 
 #undef KERNEL_STACK_OVERFLOW_CHECK
-#undef ALLOCA_EXCEPTION_IN_IRAM
 
 /* Not well tested.
  *
@@ -819,11 +818,27 @@ ENDPROC(unrecoverable_exception)
  *
  *  The ALLOCA handler is entered when user code executes the MOVSP
  *  instruction and the caller's frame is not in the register file.
- *  In this case, the caller frame's a0..a3 are on the stack just
- *  below sp (a1), and this handler moves them.
  *
- *  For "MOVSP <ar>,<as>" without destination register a1, this routine
- *  simply moves the value from <as> to <ar> without moving the save area.
+ * This algorithm was taken from the Ross Morley's RTOS Porting Layer:
+ *
+ *    /home/ross/rtos/porting/XtensaRTOS-PortingLayer-20090507/xtensa_vectors.S
+ *
+ * It leverages the existing window spill/fill routines and their support for
+ * double exceptions. The 'movsp' instruction will only cause an exception if
+ * the next window needs to be loaded. In fact this ALLOCA exception may be
+ * replaced at some point by changing the hardware to do a underflow exception
+ * of the proper size instead.
+ *
+ * This algorithm simply backs out the register changes started by the user
+ * excpetion handler, makes it appear that we have started a window underflow
+ * by rotating the window back and then setting the old window base (OWB) in
+ * the 'ps' register with the rolled back window base. The 'movsp' instruction
+ * will be re-executed and this time since the next window frames is in the
+ * active AR registers it won't cause an exception.
+ *
+ * If the WindowUnderflow code gets a TLB miss the page will get mapped
+ * the the partial windeowUnderflow will be handeled in the double exception
+ * handler.
  *
  * Entry condition:
  *
@@ -838,155 +853,28 @@ ENDPROC(unrecoverable_exception)
  *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
  */
 
-#if XCHAL_HAVE_BE
-#define _EXTUI_MOVSP_SRC(ar)	extui ar, ar, 4, 4
-#define _EXTUI_MOVSP_DST(ar)	extui ar, ar, 0, 4
-#else
-#define _EXTUI_MOVSP_SRC(ar)	extui ar, ar, 0, 4
-#define _EXTUI_MOVSP_DST(ar)	extui ar, ar, 4, 4
-#endif
-
 ENTRY(fast_alloca)
+	rsr	a0, windowbase
+	rotw	-1
+	rsr	a2, ps
+	extui	a3, a2, PS_OWB_SHIFT, PS_OWB_WIDTH
+	xor	a3, a3, a4
+	l32i	a4, a6, PT_AREG0
+	l32i	a1, a6, PT_DEPC
+	rsr	a6, depc
+	wsr	a1, depc
+	slli	a3, a3, PS_OWB_SHIFT
+	xor	a2, a2, a3
+	wsr	a2, ps
+	rsync
 
-	/* We shouldn't be in a double exception. */
-
-	l32i	a0, a2, PT_DEPC
-	_bgeui	a0, VALID_DOUBLE_EXCEPTION_ADDRESS, .Lunhandled_double
-
-	rsr	a0, depc		# get a2
-	s32i	a4, a2, PT_AREG4	# save a4 and
-	s32i	a3, a2, PT_AREG3
-	s32i	a0, a2, PT_AREG2	# a2 to stack
-
-	/* Exit critical section. */
-
-	movi	a0, 0
-	rsr	a3, excsave1
-	s32i	a0, a3, EXC_TABLE_FIXUP
-
-	rsr	a4, epc1		# get exception address
-
-#ifdef ALLOCA_EXCEPTION_IN_IRAM
-#error	iram not supported
-#else
-	/* Note: l8ui not allowed in IRAM/IROM!! */
-	l8ui	a0, a4, 1		# read as(src) from MOVSP instruction
-#endif
-	movi	a3, .Lmovsp_src
-	_EXTUI_MOVSP_SRC(a0)		# extract source register number
-	addx8	a3, a0, a3
-	jx	a3
-
-.Lunhandled_double:
-	wsr	a0, excsave1
-	movi	a0, unrecoverable_exception
-	callx0	a0
-
-	.align 8
-.Lmovsp_src:
-	l32i	a3, a2, PT_AREG0;	_j 1f;	.align 8
-	mov	a3, a1;			_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG2;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG3;	_j 1f;	.align 8
-	l32i	a3, a2, PT_AREG4;	_j 1f;	.align 8
-	mov	a3, a5;			_j 1f;	.align 8
-	mov	a3, a6;			_j 1f;	.align 8
-	mov	a3, a7;			_j 1f;	.align 8
-	mov	a3, a8;			_j 1f;	.align 8
-	mov	a3, a9;			_j 1f;	.align 8
-	mov	a3, a10;		_j 1f;	.align 8
-	mov	a3, a11;		_j 1f;	.align 8
-	mov	a3, a12;		_j 1f;	.align 8
-	mov	a3, a13;		_j 1f;	.align 8
-	mov	a3, a14;		_j 1f;	.align 8
-	mov	a3, a15;		_j 1f;	.align 8
-
-1:
-
-#ifdef ALLOCA_EXCEPTION_IN_IRAM
-#error	iram not supported
-#else
-	l8ui	a0, a4, 0		# read ar(dst) from MOVSP instruction
-#endif
-	addi	a4, a4, 3		# step over movsp
-	_EXTUI_MOVSP_DST(a0)		# extract destination register
-	wsr	a4, epc1		# save new epc_1
-
-	_bnei	a0, 1, 1f		# no 'movsp a1, ax': jump
-
-	/* Move the save area. This implies the use of the L32E
-	 * and S32E instructions, because this move must be done with
-	 * the user's PS.RING privilege levels, not with ring 0
-	 * (kernel's) privileges currently active with PS.EXCM
-	 * set. Note that we have stil registered a fixup routine with the
-	 * double exception vector in case a double exception occurs.
-	 */
-
-	/* a0,a4:avail a1:old user stack a2:exc. stack a3:new user stack. */
-
-	l32e	a0, a1, -16
-	l32e	a4, a1, -12
-	s32e	a0, a3, -16
-	s32e	a4, a3, -12
-	l32e	a0, a1, -8
-	l32e	a4, a1, -4
-	s32e	a0, a3, -8
-	s32e	a4, a3, -4
-
-	/* Restore stack-pointer and all the other saved registers. */
-
-	mov	a1, a3
-
-	l32i	a4, a2, PT_AREG4
-	l32i	a3, a2, PT_AREG3
-	l32i	a0, a2, PT_AREG0
-	l32i	a2, a2, PT_AREG2
-	rfe
-
-	/*  MOVSP <at>,<as>  was invoked with <at> != a1.
-	 *  Because the stack pointer is not being modified,
-	 *  we should be able to just modify the pointer
-	 *  without moving any save area.
-	 *  The processor only traps these occurrences if the
-	 *  caller window isn't live, so unfortunately we can't
-	 *  use this as an alternate trap mechanism.
-	 *  So we just do the move.  This requires that we
-	 *  resolve the destination register, not just the source,
-	 *  so there's some extra work.
-	 *  (PERHAPS NOT REALLY NEEDED, BUT CLEANER...)
-	 */
-
-	/* a0 dst-reg, a1 user-stack, a2 stack, a3 value of src reg. */
-
-1:	movi	a4, .Lmovsp_dst
-	addx8	a4, a0, a4
-	jx	a4
-
-	.align 8
-.Lmovsp_dst:
-	s32i	a3, a2, PT_AREG0;	_j 1f;	.align 8
-	mov	a1, a3;			_j 1f;	.align 8
-	s32i	a3, a2, PT_AREG2;	_j 1f;	.align 8
-	s32i	a3, a2, PT_AREG3;	_j 1f;	.align 8
-	s32i	a3, a2, PT_AREG4;	_j 1f;	.align 8
-	mov	a5, a3;			_j 1f;	.align 8
-	mov	a6, a3;			_j 1f;	.align 8
-	mov	a7, a3;			_j 1f;	.align 8
-	mov	a8, a3;			_j 1f;	.align 8
-	mov	a9, a3;			_j 1f;	.align 8
-	mov	a10, a3;		_j 1f;	.align 8
-	mov	a11, a3;		_j 1f;	.align 8
-	mov	a12, a3;		_j 1f;	.align 8
-	mov	a13, a3;		_j 1f;	.align 8
-	mov	a14, a3;		_j 1f;	.align 8
-	mov	a15, a3;		_j 1f;	.align 8
-
-1:	l32i	a4, a2, PT_AREG4
-	l32i	a3, a2, PT_AREG3
-	l32i	a0, a2, PT_AREG0
-	l32i	a2, a2, PT_AREG2
-	rfe
-
+	_bbci.l	a4, 31, 4f
+	rotw	-1
+	_bbci.l	a8, 30, 8f
+	rotw	-1
+	j	_WindowUnderflow12
+8:	j	_WindowUnderflow8
+4:	j	_WindowUnderflow4
 ENDPROC(fast_alloca)
 
 /*
-- 
1.7.7.6
