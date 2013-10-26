From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCHv2 1/2] xtensa: fix fast_syscall_spill_registers_fixup
Date: Sat, 26 Oct 2013 05:03:04 +0400
Message-ID: <1382749385-29062-2-git-send-email-jcmvbkbc@gmail.com>
References: <1382749385-29062-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:40807 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab3JZBD0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Oct 2013 21:03:26 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so4516182wes.36
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2013 18:03:25 -0700 (PDT)
In-Reply-To: <1382749385-29062-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

fast_syscall_spill_registers_fixup was not correctly updated by the
'keep a3 and excsave1 on entry to exception handlers' patch: it doesn't
preserve a3 that it gets on entry, breaking _spill_registers in case of
page fault on stack during register spilling, leading to unhandled
exception in kernel mode.

Preserve a3 by saving it in the original _spill_registers stack frame's
a3 during exception handling and restoring it afterwards.

Also fix comments and function bounds annotations.

Reported-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/xtensa/kernel/entry.S | 64 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index de1dfa1..baf45de 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1064,6 +1064,9 @@ ENDPROC(fast_syscall_xtensa)
  *   excsave_1:	dispatch table
  *
  * Note: We assume the stack pointer is EXC_TABLE_KSTK in the fixup handler.
+ * FIXME: this may be wrong in case we enter _spill_registers with 4 live
+ * registers, followed by a 12-register live window: .Lc12 in the
+ * _spill_registers would use a2 then.
  */
 
 ENTRY(fast_syscall_spill_registers)
@@ -1117,12 +1120,19 @@ ENDPROC(fast_syscall_spill_registers)
  * We basically restore WINDOWBASE and WINDOWSTART to the condition when
  * we entered the spill routine and jump to the user exception handler.
  *
+ * Note that we only need to restore the bits in windowstart that have not
+ * been spilled yet by the _spill_register routine. Luckily, a3 contains a
+ * rotated windowstart with only those bits set for frames that haven't been
+ * spilled yet. Because a3 is rotated such that bit 0 represents the register
+ * frame for the current windowbase - 1, we need to rotate a3 left by the
+ * value of the current windowbase + 1 and move it to windowstart.
+ *
  * a0: value of depc, original value in depc
  * a2: trashed, original value in EXC_TABLE_DOUBLE_SAVE
  * a3: exctable, original value in excsave1
  */
 
-fast_syscall_spill_registers_fixup:
+ENTRY(fast_syscall_spill_registers_fixup)
 
 	rsr	a2, windowbase	# get current windowbase (a2 is saved)
 	xsr	a0, depc	# restore depc and a0
@@ -1131,25 +1141,34 @@ fast_syscall_spill_registers_fixup:
 	/* We need to make sure the current registers (a0-a3) are preserved.
 	 * To do this, we simply set the bit for the current window frame
 	 * in WS, so that the exception handlers save them to the task stack.
+	 *
+	 * Note: we use a3 to set the windowbase, so we take a special care
+	 * of it, saving it in the original _spill_registers frame across
+	 * the exception handler call.
 	 */
 
 	xsr	a3, excsave1	# get spill-mask
-	slli	a2, a3, 1	# shift left by one
+	slli	a3, a3, 1	# shift left by one
+	addi	a3, a3, 1	# set the bit for the current window frame
 
-	slli	a3, a2, 32-WSBITS
-	src	a2, a2, a3	# a1 = xxwww1yyxxxwww1yy......
+	slli	a2, a3, 32-WSBITS
+	src	a2, a3, a2	# a2 = xxwww1yyxxxwww1yy......
 	wsr	a2, windowstart	# set corrected windowstart
 
-	rsr	a3, excsave1
-	l32i	a2, a3, EXC_TABLE_DOUBLE_SAVE	# restore a2
-	l32i	a3, a3, EXC_TABLE_PARAM	# original WB (in user task)
+	srli	a3, a3, 1
+	rsr	a2, excsave1
+	l32i	a2, a2, EXC_TABLE_DOUBLE_SAVE	# restore a2
+	xsr	a2, excsave1
+	s32i	a3, a2, EXC_TABLE_DOUBLE_SAVE	# save a3
+	l32i	a3, a2, EXC_TABLE_PARAM	# original WB (in user task)
+	xsr	a2, excsave1
 
 	/* Return to the original (user task) WINDOWBASE.
 	 * We leave the following frame behind:
 	 * a0, a1, a2	same
-	 * a3:		trashed (saved in excsave_1)
+	 * a3:		trashed (saved in EXC_TABLE_DOUBLE_SAVE)
 	 * depc:	depc (we have to return to that address)
-	 * excsave_1:	a3
+	 * excsave_1:	exctable
 	 */
 
 	wsr	a3, windowbase
@@ -1159,9 +1178,9 @@ fast_syscall_spill_registers_fixup:
 	 *  a0: return address
 	 *  a1: used, stack pointer
 	 *  a2: kernel stack pointer
-	 *  a3: available, saved in EXCSAVE_1
+	 *  a3: available
 	 *  depc: exception address
-	 *  excsave: a3
+	 *  excsave: exctable
 	 * Note: This frame might be the same as above.
 	 */
 
@@ -1181,9 +1200,12 @@ fast_syscall_spill_registers_fixup:
 	rsr	a0, exccause
 	addx4	a0, a0, a3              	# find entry in table
 	l32i	a0, a0, EXC_TABLE_FAST_USER     # load handler
+	l32i	a3, a3, EXC_TABLE_DOUBLE_SAVE
 	jx	a0
 
-fast_syscall_spill_registers_fixup_return:
+ENDPROC(fast_syscall_spill_registers_fixup)
+
+ENTRY(fast_syscall_spill_registers_fixup_return)
 
 	/* When we return here, all registers have been restored (a2: DEPC) */
 
@@ -1191,13 +1213,13 @@ fast_syscall_spill_registers_fixup_return:
 
 	/* Restore fixup handler. */
 
-	xsr	a3, excsave1
-	movi	a2, fast_syscall_spill_registers_fixup
-	s32i	a2, a3, EXC_TABLE_FIXUP
-	s32i	a0, a3, EXC_TABLE_DOUBLE_SAVE
-	rsr	a2, windowbase
-	s32i	a2, a3, EXC_TABLE_PARAM
-	l32i	a2, a3, EXC_TABLE_KSTK
+	rsr	a2, excsave1
+	s32i	a3, a2, EXC_TABLE_DOUBLE_SAVE
+	movi	a3, fast_syscall_spill_registers_fixup
+	s32i	a3, a2, EXC_TABLE_FIXUP
+	rsr	a3, windowbase
+	s32i	a3, a2, EXC_TABLE_PARAM
+	l32i	a2, a2, EXC_TABLE_KSTK
 
 	/* Load WB at the time the exception occurred. */
 
@@ -1206,8 +1228,12 @@ fast_syscall_spill_registers_fixup_return:
 	wsr	a3, windowbase
 	rsync
 
+	rsr	a3, excsave1
+	l32i	a3, a3, EXC_TABLE_DOUBLE_SAVE
+
 	rfde
 
+ENDPROC(fast_syscall_spill_registers_fixup_return)
 
 /*
  * spill all registers.
-- 
1.8.1.4
