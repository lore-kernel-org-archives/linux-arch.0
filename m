From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 4/8] m68k/asm-offsets: rename signal defines
Date: Sat, 29 Aug 2009 12:21:19 +0200
Message-ID: <20090829102156.341631462@de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.de.ibm.com ([195.212.17.167]:33575 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZH2KWA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 06:22:00 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7TALwhf003928
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 10:21:58 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TALw2e1655038
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:58 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TALunV005808
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 12:21:58 +0200
Content-Disposition: inline; filename=m68k_signal.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In order to be able to use asm-offsets.h in C files the existing namespace
conflicts must be solved first. In asm-offsets.h there are defines for signal
constants, so they can be used in assembler files.

Unfortunately the existing defines use a 1:1 mapping for the macro names
which results in name space conflicts if the header file would also be used
in C files. So rename the created defines and add an "L" prefix to each one
since that has already been done for the SIGTRAP define in entry_mm.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/m68k/include/asm/entry_mm.h |    1 -
 arch/m68k/kernel/asm-offsets.c   |    8 ++++----
 arch/m68k/math-emu/fp_entry.S    |    8 ++++----
 3 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6/arch/m68k/include/asm/entry_mm.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/entry_mm.h
+++ linux-2.6/arch/m68k/include/asm/entry_mm.h
@@ -46,7 +46,6 @@
 #define curptr a2
 
 LFLUSH_I_AND_D = 0x00000808
-LSIGTRAP = 5
 
 /* process bits for task_struct.ptrace */
 PT_TRACESYS_OFF = 3
Index: linux-2.6/arch/m68k/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/asm-offsets.c
+++ linux-2.6/arch/m68k/kernel/asm-offsets.c
@@ -84,10 +84,10 @@ int main(void)
 	DEFINE(FONT_DESC_PREF, offsetof(struct font_desc, pref));
 
 	/* signal defines */
-	DEFINE(SIGSEGV, SIGSEGV);
-	DEFINE(SEGV_MAPERR, SEGV_MAPERR);
-	DEFINE(SIGTRAP, SIGTRAP);
-	DEFINE(TRAP_TRACE, TRAP_TRACE);
+	DEFINE(LSIGSEGV, SIGSEGV);
+	DEFINE(LSEGV_MAPERR, SEGV_MAPERR);
+	DEFINE(LSIGTRAP, SIGTRAP);
+	DEFINE(LTRAP_TRACE, TRAP_TRACE);
 
 	/* offsets into the custom struct */
 	DEFINE(CUSTOMBASE, &amiga_custom);
Index: linux-2.6/arch/m68k/math-emu/fp_entry.S
===================================================================
--- linux-2.6.orig/arch/m68k/math-emu/fp_entry.S
+++ linux-2.6/arch/m68k/math-emu/fp_entry.S
@@ -85,8 +85,8 @@ fp_err_ua2:
 fp_err_ua1:
 	addq.l	#4,%sp
 	move.l	%a0,-(%sp)
-	pea	SEGV_MAPERR
-	pea	SIGSEGV
+	pea	LSEGV_MAPERR
+	pea	LSIGSEGV
 	jsr	fpemu_signal
 	add.w	#12,%sp
 	jra	ret_from_exception
@@ -96,8 +96,8 @@ fp_err_ua1:
 	| it does not really belong here, but...
 fp_sendtrace060:
 	move.l	(FPS_PC,%sp),-(%sp)
-	pea	TRAP_TRACE
-	pea	SIGTRAP
+	pea	LTRAP_TRACE
+	pea	LSIGTRAP
 	jsr	fpemu_signal
 	add.w	#12,%sp
 	jra	ret_from_exception

-- 
