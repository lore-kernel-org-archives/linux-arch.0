From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: fix fast_syscall_spill_registers_fixup
Date: Tue, 15 Oct 2013 02:22:42 +0400
Message-ID: <1381789363-2411-2-git-send-email-jcmvbkbc@gmail.com>
References: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:43035 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab3JNWXM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2013 18:23:12 -0400
Received: by mail-la0-f50.google.com with SMTP id gx14so6071155lab.23
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2013 15:23:10 -0700 (PDT)
In-Reply-To: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

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
 arch/xtensa/kernel/entry.S |   49 ++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index de1dfa1..21dbe6b 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1122,7 +1122,7 @@ ENDPROC(fast_syscall_spill_registers)
  * a3: exctable, original value in excsave1
  */
 
-fast_syscall_spill_registers_fixup:
+ENTRY(fast_syscall_spill_registers_fixup)
 
 	rsr	a2, windowbase	# get current windowbase (a2 is saved)
 	xsr	a0, depc	# restore depc and a0
@@ -1134,22 +1134,26 @@ fast_syscall_spill_registers_fixup:
 	 */
 
 	xsr	a3, excsave1	# get spill-mask
-	slli	a2, a3, 1	# shift left by one
+	slli	a3, a3, 1	# shift left by one
 
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
@@ -1159,9 +1163,9 @@ fast_syscall_spill_registers_fixup:
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
 
@@ -1181,9 +1185,12 @@ fast_syscall_spill_registers_fixup:
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
 
@@ -1191,13 +1198,13 @@ fast_syscall_spill_registers_fixup_return:
 
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
 
@@ -1206,8 +1213,12 @@ fast_syscall_spill_registers_fixup_return:
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
1.7.7.6
