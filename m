Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfDMPO2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Apr 2019 11:14:28 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Support vmlinux bootup with MMU off
Date: Sat, 13 Apr 2019 23:14:00 +0800
Message-ID: <1555168440-16497-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190413151400.BGmS2BNE2QTYU81BaMCvxg6AsNBfwIdnLvBOOJ5lrws@z>

From: Guo Ren <ren_guo@c-sky.com>

Modify SETUP_MMU macro to fit on both MMU-on or MMU-off enviornment
and vmlinux could bootup from MMU off enviornment for some cases.

Unify the style of _start and _start_smp_secondary in head.S to make
head.S looks more concise and easy to understand.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/entry.h | 29 ++++++++-------
 arch/csky/abiv2/inc/abi/entry.h | 79 ++++++++++++++++++++++++++++++++---------
 arch/csky/kernel/head.S         | 60 ++++---------------------------
 arch/csky/kernel/setup.c        |  7 ++--
 4 files changed, 90 insertions(+), 85 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index 18e2023..7ab78bd 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -143,7 +143,12 @@
 	cpwcr   \rx, cpcr8
 .endm
 
-.macro SETUP_MMU rx
+.macro SETUP_MMU
+	/* Init psr and enable ee */
+	lrw	r6, DEFAULT_PSR_VALUE
+	mtcr    r6, psr
+	psrset  ee
+
 	/* Select MMU as co-processor */
 	cpseti	cp15
 
@@ -152,17 +157,17 @@
 	 * 31 - 29 | 28 - 4 | 3 | 2 | 1 | 0
 	 *   BA     Reserved  C   D   V
 	 */
-	cprcr	\rx, cpcr30
-	lsri	\rx, 28
-	lsli	\rx, 28
-	addi	\rx, 0xe
-	cpwcr	\rx, cpcr30
-
-	lsri	\rx, 28
-	addi	\rx, 2
-	lsli	\rx, 28
-	addi	\rx, 0xe
-	cpwcr	\rx, cpcr31
+	cprcr	r6, cpcr30
+	lsri	r6, 28
+	lsli	r6, 28
+	addi	r6, 0xe
+	cpwcr	r6, cpcr30
+
+	lsri	r6, 28
+	addi	r6, 2
+	lsli	r6, 28
+	addi	r6, 0xe
+	cpwcr	r6, cpcr31
 .endm
 
 .macro ANDI_R3 rx, imm
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index c0a76c4..9897a16 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -162,31 +162,76 @@
 	mtcr	\rx, cr<8, 15>
 .endm
 
-.macro SETUP_MMU rx
-	/* Check MMU on | off */
-	mfcr	\rx, cr18
-	btsti	\rx, 0
+.macro SETUP_MMU
+	/* Init psr and enable ee */
+	lrw	r6, DEFAULT_PSR_VALUE
+	mtcr    r6, psr
+	psrset  ee
+
+	/* Invalid I/Dcache BTB BHT */
+	movi	r6, 7
+	lsli	r6, 16
+	addi	r6, (1<<4) | 3
+	mtcr	r6, cr17
+
+	/* Invalid all TLB */
+	bgeni   r6, 26
+	mtcr	r6, cr<8, 15> /* Set MCIR */
+
+	/* Check MMU on/off */
+	mfcr	r6, cr18
+	btsti	r6, 0
 	bt	1f
-	grs	\rx, 1f
+
+	/* MMU off: setup mapping tlb entry */
+	movi	r6, 0
+	mtcr	r6, cr<6, 15> /* Set MPR with 4K page size */
+
+	grs	r6, 1f /* Get current pa by PC */
+	bmaski  r7, (PAGE_SHIFT + 1) /* r7 = 0x1fff */
+	andn    r6, r7
+	mtcr	r6, cr<4, 15> /* Set MEH */
+
+	mov	r8, r6
+	movi    r7, 0x00000006
+	or      r8, r7
+	mtcr	r8, cr<2, 15> /* Set MEL0 */
+	movi    r7, 0x00001006
+	or      r8, r7
+	mtcr	r8, cr<3, 15> /* Set MEL1 */
+
+	bgeni   r8, 28
+	mtcr	r8, cr<8, 15> /* Set MCIR to write TLB */
+
 	br	2f
 1:
 	/*
-	 * cr<30, 15> format:
+	 * MMU on: use origin MSA value from bootloader
+	 *
+	 * cr<30/31, 15> MSA register format:
 	 * 31 - 29 | 28 - 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
 	 *   BA     Reserved  SH  WA  B   SO SEC  C   D   V
 	 */
-	mfcr	\rx, cr<30, 15>
+	mfcr	r6, cr<30, 15> /* Get MSA0 */
 2:
-	lsri	\rx, 28
-	lsli	\rx, 28
-	addi	\rx, 0x1ce
-	mtcr	\rx, cr<30, 15>
-
-	lsri	\rx, 28
-	addi	\rx, 2
-	lsli	\rx, 28
-	addi	\rx, 0x1ce
-	mtcr	\rx, cr<31, 15>
+	lsri	r6, 28
+	lsli	r6, 28
+	addi	r6, 0x1ce
+	mtcr	r6, cr<30, 15> /* Set MSA0 */
+
+	lsri	r6, 28
+	addi	r6, 2
+	lsli	r6, 28
+	addi	r6, 0x1ce
+	mtcr	r6, cr<31, 15> /* Set MSA1 */
+
+	/* enable MMU */
+	mfcr    r6, cr18
+	bseti	r6, 0
+	mtcr    r6, cr18
+
+	jmpi	3f /* jump to va */
+3:
 .endm
 
 .macro ANDI_R3 rx, imm
diff --git a/arch/csky/kernel/head.S b/arch/csky/kernel/head.S
index 9c4ec47..61989f9 100644
--- a/arch/csky/kernel/head.S
+++ b/arch/csky/kernel/head.S
@@ -7,16 +7,11 @@
 
 __HEAD
 ENTRY(_start)
-	/* set super user mode */
-	lrw	a3, DEFAULT_PSR_VALUE
-	mtcr    a3, psr
-	psrset  ee
-
-	SETUP_MMU a3
+	SETUP_MMU
 
 	/* set stack point */
-	lrw     a3, init_thread_union + THREAD_SIZE
-	mov	sp, a3
+	lrw     r6, init_thread_union + THREAD_SIZE
+	mov	sp, r6
 
 	jmpi	csky_start
 END(_start)
@@ -24,53 +19,12 @@ END(_start)
 #ifdef CONFIG_SMP
 .align 10
 ENTRY(_start_smp_secondary)
-	/* Invalid I/Dcache BTB BHT */
-	movi	a3, 7
-	lsli	a3, 16
-	addi	a3, (1<<4) | 3
-	mtcr	a3, cr17
-
-	tlbi.alls
-
-	/* setup PAGEMASK */
-	movi	a3, 0
-	mtcr	a3, cr<6, 15>
-
-	/* setup MEL0/MEL1 */
-	grs	a0, _start_smp_pc
-_start_smp_pc:
-	bmaski  a1, 13
-	andn    a0, a1
-	movi    a1, 0x00000006
-	movi    a2, 0x00001006
-	or      a1, a0
-	or      a2, a0
-	mtcr	a1, cr<2, 15>
-	mtcr	a2, cr<3, 15>
-
-	/* setup MEH */
-	mtcr	a0, cr<4, 15>
-
-	/* write TLB */
-	bgeni   a3, 28
-	mtcr	a3, cr<8, 15>
-
-	SETUP_MMU a3
-
-	/* enable MMU */
-	movi	a3, 1
-	mtcr    a3, cr18
-
-	jmpi	_goto_mmu_on
-_goto_mmu_on:
-	lrw	a3, DEFAULT_PSR_VALUE
-	mtcr    a3, psr
-	psrset  ee
+	SETUP_MMU
 
 	/* set stack point */
-	lrw     a3, secondary_stack
-	ld.w	a3, (a3, 0)
-	mov	sp, a3
+	lrw     r6, secondary_stack
+	ld.w	r6, (r6, 0)
+	mov	sp, r6
 
 	jmpi	csky_start_secondary
 END(_start_smp_secondary)
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index c377194..36fc04b 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -145,7 +145,8 @@ void __init setup_arch(char **cmdline_p)
 unsigned long phys_offset;
 EXPORT_SYMBOL(phys_offset);
 
-asmlinkage __visible void __init csky_start(unsigned int unused, void *param)
+asmlinkage __visible void __init csky_start(unsigned int unused,
+					    void *dtb_start)
 {
 	/* Clean up bss section */
 	memset(__bss_start, 0, __bss_stop - __bss_start);
@@ -155,10 +156,10 @@ asmlinkage __visible void __init csky_start(unsigned int unused, void *param)
 	pre_trap_init();
 	pre_mmu_init();
 
-	if (param == NULL)
+	if (dtb_start == NULL)
 		early_init_dt_scan(__dtb_start);
 	else
-		early_init_dt_scan(param);
+		early_init_dt_scan(dtb_start);
 
 	start_kernel();
 
-- 
2.7.4
