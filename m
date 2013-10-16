From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 16/17] xtensa: add Three Core HiFi-2 MX Variant.
Date: Thu, 17 Oct 2013 02:42:27 +0400
Message-ID: <1381963348-29448-17-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:37810 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761127Ab3JPWnK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:10 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1139485lab.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:08 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Piet Delaney <piet.delaney@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

From: Piet Delaney <piet.delaney@gmail.com>

This variant is equipped with MX and is capable of running SMP linux.

Signed-off-by: Piet Delaney <piet.delaney@gmail.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                                |   7 +
 arch/xtensa/Makefile                               |   1 +
 .../test_mmuhifi_c3/include/variant/core.h         | 384 +++++++++++++++++++++
 .../test_mmuhifi_c3/include/variant/tie-asm.h      | 183 ++++++++++
 .../variants/test_mmuhifi_c3/include/variant/tie.h | 141 ++++++++
 5 files changed, 716 insertions(+)
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 4b09c60..9cfb514 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -89,6 +89,13 @@ config XTENSA_VARIANT_DC233C
 	help
 	  This variant refers to Tensilica's Diamond 233L Standard core Rev.C (LE).
 
+config XTENSA_VARIANT_TEST_MMUHIFI_C3
+	bool "test_mmuhifi_c3 - Experimental 3 Core SMP HiFi-2 with a V2 MMU; Extension of a Diamond DC_D_330HiFi"
+	select MMU
+	select MAY_HAVE_SMP
+	help
+	  This variant refers to Tensilica's Diamond 330HiFi 3 core SMP cluster.
+
 config XTENSA_VARIANT_S6000
 	bool "s6000 - Stretch software configurable processor"
 	select VARIANT_IRQ_SWITCH
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 81250ec..8edd7c0 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -16,6 +16,7 @@
 variant-$(CONFIG_XTENSA_VARIANT_FSF)		:= fsf
 variant-$(CONFIG_XTENSA_VARIANT_DC232B)		:= dc232b
 variant-$(CONFIG_XTENSA_VARIANT_DC233C)		:= dc233c
+variant-$(CONFIG_XTENSA_VARIANT_TEST_MMUHIFI_C3) := test_mmuhifi_c3
 variant-$(CONFIG_XTENSA_VARIANT_S6000)		:= s6000
 variant-$(CONFIG_XTENSA_VARIANT_LINUX_CUSTOM)	:= custom
 
diff --git a/arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h
new file mode 100644
index 0000000..309caa1
--- /dev/null
+++ b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h
@@ -0,0 +1,384 @@
+/*
+ * Xtensa processor core configuration information.
+ *
+ * This file is subject to the terms and conditions of version 2.1 of the GNU
+ * Lesser General Public License as published by the Free Software Foundation.
+ *
+ * Copyright (c) 1999-2009 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_CORE_CONFIGURATION_H
+#define _XTENSA_CORE_CONFIGURATION_H
+
+
+/****************************************************************************
+	    Parameters Useful for Any Code, USER or PRIVILEGED
+ ****************************************************************************/
+
+/*
+ *  Note:  Macros of the form XCHAL_HAVE_*** have a value of 1 if the option is
+ *  configured, and a value of 0 otherwise.  These macros are always defined.
+ */
+
+
+/*----------------------------------------------------------------------
+				ISA
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_BE			0	/* big-endian byte ordering */
+#define XCHAL_HAVE_WINDOWED		1	/* windowed registers option */
+#define XCHAL_NUM_AREGS			32	/* num of physical addr regs */
+#define XCHAL_NUM_AREGS_LOG2		5	/* log2(XCHAL_NUM_AREGS) */
+#define XCHAL_MAX_INSTRUCTION_SIZE	8	/* max instr bytes (3..8) */
+#define XCHAL_HAVE_DEBUG		1	/* debug option */
+#define XCHAL_HAVE_DENSITY		1	/* 16-bit instructions */
+#define XCHAL_HAVE_LOOPS		1	/* zero-overhead loops */
+#define XCHAL_HAVE_NSA			1	/* NSA/NSAU instructions */
+#define XCHAL_HAVE_MINMAX		1	/* MIN/MAX instructions */
+#define XCHAL_HAVE_SEXT			1	/* SEXT instruction */
+#define XCHAL_HAVE_CLAMPS		1	/* CLAMPS instruction */
+#define XCHAL_HAVE_MUL16		1	/* MUL16S/MUL16U instructions */
+#define XCHAL_HAVE_MUL32		1	/* MULL instruction */
+#define XCHAL_HAVE_MUL32_HIGH		0	/* MULUH/MULSH instructions */
+#define XCHAL_HAVE_DIV32		0	/* QUOS/QUOU/REMS/REMU instructions */
+#define XCHAL_HAVE_L32R			1	/* L32R instruction */
+#define XCHAL_HAVE_ABSOLUTE_LITERALS	1	/* non-PC-rel (extended) L32R */
+#define XCHAL_HAVE_CONST16		0	/* CONST16 instruction */
+#define XCHAL_HAVE_ADDX			1	/* ADDX#/SUBX# instructions */
+#define XCHAL_HAVE_WIDE_BRANCHES	0	/* B*.W18 or B*.W15 instr's */
+#define XCHAL_HAVE_PREDICTED_BRANCHES	0	/* B[EQ/EQZ/NE/NEZ]T instr's */
+#define XCHAL_HAVE_CALL4AND12		1	/* (obsolete option) */
+#define XCHAL_HAVE_ABS			1	/* ABS instruction */
+/*#define XCHAL_HAVE_POPC		0*/	/* POPC instruction */
+/*#define XCHAL_HAVE_CRC		0*/	/* CRC instruction */
+#define XCHAL_HAVE_RELEASE_SYNC		1	/* L32AI/S32RI instructions */
+#define XCHAL_HAVE_S32C1I		1	/* S32C1I instruction */
+#define XCHAL_HAVE_SPECULATION		0	/* speculation */
+#define XCHAL_HAVE_FULL_RESET		1	/* all regs/state reset */
+#define XCHAL_NUM_CONTEXTS		1	/* */
+#define XCHAL_NUM_MISC_REGS		2	/* num of scratch regs (0..4) */
+#define XCHAL_HAVE_TAP_MASTER		0	/* JTAG TAP control instr's */
+#define XCHAL_HAVE_PRID			1	/* processor ID register */
+#define XCHAL_HAVE_EXTERN_REGS		1	/* WER/RER instructions */
+#define XCHAL_HAVE_MP_INTERRUPTS	1	/* interrupt distributor port */
+#define XCHAL_HAVE_MP_RUNSTALL		1	/* core RunStall control port */
+#define XCHAL_HAVE_THREADPTR		1	/* THREADPTR register */
+#define XCHAL_HAVE_BOOLEANS		1	/* boolean registers */
+#define XCHAL_HAVE_CP			1	/* CPENABLE reg (coprocessor) */
+#define XCHAL_CP_MAXCFG			2	/* max allowed cp id plus one */
+#define XCHAL_HAVE_MAC16		0	/* MAC16 package */
+#define XCHAL_HAVE_VECTORFPU2005	0	/* vector floating-point pkg */
+#define XCHAL_HAVE_FP			0	/* floating point pkg */
+#define XCHAL_HAVE_DFP			0	/* double precision FP pkg */
+#define XCHAL_HAVE_DFP_accel		0	/* double precision FP acceleration pkg */
+#define XCHAL_HAVE_VECTRA1		0	/* Vectra I  pkg */
+#define XCHAL_HAVE_VECTRALX		0	/* Vectra LX pkg */
+#define XCHAL_HAVE_HIFIPRO		0	/* HiFiPro Audio Engine pkg */
+#define XCHAL_HAVE_HIFI2		1	/* HiFi2 Audio Engine pkg */
+#define XCHAL_HAVE_CONNXD2		0	/* ConnX D2 pkg */
+
+
+/*----------------------------------------------------------------------
+				MISC
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_NUM_WRITEBUFFER_ENTRIES	8	/* size of write buffer */
+#define XCHAL_INST_FETCH_WIDTH		8	/* instr-fetch width in bytes */
+#define XCHAL_DATA_WIDTH		8	/* data width in bytes */
+/*  In T1050, applies to selected core load and store instructions (see ISA): */
+#define XCHAL_UNALIGNED_LOAD_EXCEPTION	1	/* unaligned loads cause exc. */
+#define XCHAL_UNALIGNED_STORE_EXCEPTION	1	/* unaligned stores cause exc.*/
+#define XCHAL_UNALIGNED_LOAD_HW		0	/* unaligned loads work in hw */
+#define XCHAL_UNALIGNED_STORE_HW	0	/* unaligned stores work in hw*/
+
+#define XCHAL_SW_VERSION		800000	/* sw version of this header */
+
+#define XCHAL_CORE_ID			"test_mmuhifi_c3"	/* alphanum core name
+						   (CoreID) set in the Xtensa
+						   Processor Generator */
+
+#define XCHAL_CORE_DESCRIPTION		"test_mmuhifi_c3"
+#define XCHAL_BUILD_UNIQUE_ID		0x00005A6A	/* 22-bit sw build ID */
+
+/*
+ *  These definitions describe the hardware targeted by this software.
+ */
+#define XCHAL_HW_CONFIGID0		0xC1B3CBFE	/* ConfigID hi 32 bits*/
+#define XCHAL_HW_CONFIGID1		0x10405A6A	/* ConfigID lo 32 bits*/
+#define XCHAL_HW_VERSION_NAME		"LX3.0.0"	/* full version name */
+#define XCHAL_HW_VERSION_MAJOR		2300	/* major ver# of targeted hw */
+#define XCHAL_HW_VERSION_MINOR		0	/* minor ver# of targeted hw */
+#define XCHAL_HW_VERSION		230000	/* major*100+minor */
+#define XCHAL_HW_REL_LX3		1
+#define XCHAL_HW_REL_LX3_0		1
+#define XCHAL_HW_REL_LX3_0_0		1
+#define XCHAL_HW_CONFIGID_RELIABLE	1
+/*  If software targets a *range* of hardware versions, these are the bounds: */
+#define XCHAL_HW_MIN_VERSION_MAJOR	2300	/* major v of earliest tgt hw */
+#define XCHAL_HW_MIN_VERSION_MINOR	0	/* minor v of earliest tgt hw */
+#define XCHAL_HW_MIN_VERSION		230000	/* earliest targeted hw */
+#define XCHAL_HW_MAX_VERSION_MAJOR	2300	/* major v of latest tgt hw */
+#define XCHAL_HW_MAX_VERSION_MINOR	0	/* minor v of latest tgt hw */
+#define XCHAL_HW_MAX_VERSION		230000	/* latest targeted hw */
+
+
+/*----------------------------------------------------------------------
+				CACHE
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_ICACHE_LINESIZE		32	/* I-cache line size in bytes */
+#define XCHAL_DCACHE_LINESIZE		32	/* D-cache line size in bytes */
+#define XCHAL_ICACHE_LINEWIDTH		5	/* log2(I line size in bytes) */
+#define XCHAL_DCACHE_LINEWIDTH		5	/* log2(D line size in bytes) */
+
+#define XCHAL_ICACHE_SIZE		16384	/* I-cache size in bytes or 0 */
+#define XCHAL_DCACHE_SIZE		16384	/* D-cache size in bytes or 0 */
+
+#define XCHAL_DCACHE_IS_WRITEBACK	1	/* writeback feature */
+#define XCHAL_DCACHE_IS_COHERENT	1	/* MP coherence feature */
+
+
+
+
+/****************************************************************************
+    Parameters Useful for PRIVILEGED (Supervisory or Non-Virtualized) Code
+ ****************************************************************************/
+
+
+#ifndef XTENSA_HAL_NON_PRIVILEGED_ONLY
+
+/*----------------------------------------------------------------------
+				CACHE
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_PIF			1	/* any outbound PIF present */
+
+/*  If present, cache size in bytes == (ways * 2^(linewidth + setwidth)).  */
+
+/*  Number of cache sets in log2(lines per way):  */
+#define XCHAL_ICACHE_SETWIDTH		8
+#define XCHAL_DCACHE_SETWIDTH		8
+
+/*  Cache set associativity (number of ways):  */
+#define XCHAL_ICACHE_WAYS		2
+#define XCHAL_DCACHE_WAYS		2
+
+/*  Cache features:  */
+#define XCHAL_ICACHE_LINE_LOCKABLE	0
+#define XCHAL_DCACHE_LINE_LOCKABLE	0
+#define XCHAL_ICACHE_ECC_PARITY		0
+#define XCHAL_DCACHE_ECC_PARITY		0
+
+/*  Cache access size in bytes (affects operation of SICW instruction):  */
+#define XCHAL_ICACHE_ACCESS_SIZE	8
+#define XCHAL_DCACHE_ACCESS_SIZE	8
+
+/*  Number of encoded cache attr bits (see <xtensa/hal.h> for decoded bits):  */
+#define XCHAL_CA_BITS			4
+
+
+/*----------------------------------------------------------------------
+			INTERNAL I/D RAM/ROMs and XLMI
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_NUM_INSTROM		0	/* number of core instr. ROMs */
+#define XCHAL_NUM_INSTRAM		0	/* number of core instr. RAMs */
+#define XCHAL_NUM_DATAROM		0	/* number of core data ROMs */
+#define XCHAL_NUM_DATARAM		0	/* number of core data RAMs */
+#define XCHAL_NUM_URAM			0	/* number of core unified RAMs*/
+#define XCHAL_NUM_XLMI			0	/* number of core XLMI ports */
+
+
+/*----------------------------------------------------------------------
+			INTERRUPTS and TIMERS
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_INTERRUPTS		1	/* interrupt option */
+#define XCHAL_HAVE_HIGHPRI_INTERRUPTS	1	/* med/high-pri. interrupts */
+#define XCHAL_HAVE_NMI			0	/* non-maskable interrupt */
+#define XCHAL_HAVE_CCOUNT		1	/* CCOUNT reg. (timer option) */
+#define XCHAL_NUM_TIMERS		2	/* number of CCOMPAREn regs */
+#define XCHAL_NUM_INTERRUPTS		12	/* number of interrupts */
+#define XCHAL_NUM_INTERRUPTS_LOG2	4	/* ceil(log2(NUM_INTERRUPTS)) */
+#define XCHAL_NUM_EXTINTERRUPTS		9	/* num of external interrupts */
+#define XCHAL_NUM_INTLEVELS		2	/* number of interrupt levels
+						   (not including level zero) */
+#define XCHAL_EXCM_LEVEL		1	/* level masked by PS.EXCM */
+	/* (always 1 in XEA1; levels 2 .. EXCM_LEVEL are "medium priority") */
+
+/*  Masks of interrupts at each interrupt level:  */
+#define XCHAL_INTLEVEL1_MASK		0x00000FFF
+#define XCHAL_INTLEVEL2_MASK		0x00000000
+#define XCHAL_INTLEVEL3_MASK		0x00000000
+#define XCHAL_INTLEVEL4_MASK		0x00000000
+#define XCHAL_INTLEVEL5_MASK		0x00000000
+#define XCHAL_INTLEVEL6_MASK		0x00000000
+#define XCHAL_INTLEVEL7_MASK		0x00000000
+
+/*  Masks of interrupts at each range 1..n of interrupt levels:  */
+#define XCHAL_INTLEVEL1_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL2_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL3_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL4_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL5_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL6_ANDBELOW_MASK	0x00000FFF
+#define XCHAL_INTLEVEL7_ANDBELOW_MASK	0x00000FFF
+
+/*  Level of each interrupt:  */
+#define XCHAL_INT0_LEVEL		1
+#define XCHAL_INT1_LEVEL		1
+#define XCHAL_INT2_LEVEL		1
+#define XCHAL_INT3_LEVEL		1
+#define XCHAL_INT4_LEVEL		1
+#define XCHAL_INT5_LEVEL		1
+#define XCHAL_INT6_LEVEL		1
+#define XCHAL_INT7_LEVEL		1
+#define XCHAL_INT8_LEVEL		1
+#define XCHAL_INT9_LEVEL		1
+#define XCHAL_INT10_LEVEL		1
+#define XCHAL_INT11_LEVEL		1
+#define XCHAL_DEBUGLEVEL		2	/* debug interrupt level */
+#define XCHAL_HAVE_DEBUG_EXTERN_INT	1	/* OCD external db interrupt */
+
+/*  Type of each interrupt:  */
+#define XCHAL_INT0_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT1_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT2_TYPE 	XTHAL_INTTYPE_EXTERN_EDGE
+#define XCHAL_INT3_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT4_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT5_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT6_TYPE 	XTHAL_INTTYPE_TIMER
+#define XCHAL_INT7_TYPE 	XTHAL_INTTYPE_SOFTWARE
+#define XCHAL_INT8_TYPE 	XTHAL_INTTYPE_TIMER
+#define XCHAL_INT9_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT10_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT11_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+
+/*  Masks of interrupts for each type of interrupt:  */
+#define XCHAL_INTTYPE_MASK_UNCONFIGURED	0xFFFFF000
+#define XCHAL_INTTYPE_MASK_SOFTWARE	0x00000080
+#define XCHAL_INTTYPE_MASK_EXTERN_EDGE	0x00000004
+#define XCHAL_INTTYPE_MASK_EXTERN_LEVEL	0x00000E3B
+#define XCHAL_INTTYPE_MASK_TIMER	0x00000140
+#define XCHAL_INTTYPE_MASK_NMI		0x00000000
+#define XCHAL_INTTYPE_MASK_WRITE_ERROR	0x00000000
+
+/*  Interrupt numbers assigned to specific interrupt sources:  */
+#define XCHAL_TIMER0_INTERRUPT		6	/* CCOMPARE0 */
+#define XCHAL_TIMER1_INTERRUPT		8	/* CCOMPARE1 */
+#define XCHAL_TIMER2_INTERRUPT		XTHAL_TIMER_UNCONFIGURED
+#define XCHAL_TIMER3_INTERRUPT		XTHAL_TIMER_UNCONFIGURED
+
+/*  Interrupt numbers for levels at which only one interrupt is configured:  */
+/*  (There are many interrupts each at level(s) 1.)  */
+
+
+/*
+ *  External interrupt vectors/levels.
+ *  These macros describe how Xtensa processor interrupt numbers
+ *  (as numbered internally, eg. in INTERRUPT and INTENABLE registers)
+ *  map to external BInterrupt<n> pins, for those interrupts
+ *  configured as external (level-triggered, edge-triggered, or NMI).
+ *  See the Xtensa processor databook for more details.
+ */
+
+/*  Core interrupt numbers mapped to each EXTERNAL interrupt number:  */
+#define XCHAL_EXTINT0_NUM		0	/* (intlevel 1) */
+#define XCHAL_EXTINT1_NUM		1	/* (intlevel 1) */
+#define XCHAL_EXTINT2_NUM		2	/* (intlevel 1) */
+#define XCHAL_EXTINT3_NUM		3	/* (intlevel 1) */
+#define XCHAL_EXTINT4_NUM		4	/* (intlevel 1) */
+#define XCHAL_EXTINT5_NUM		5	/* (intlevel 1) */
+#define XCHAL_EXTINT6_NUM		9	/* (intlevel 1) */
+#define XCHAL_EXTINT7_NUM		10	/* (intlevel 1) */
+#define XCHAL_EXTINT8_NUM		11	/* (intlevel 1) */
+
+
+/*----------------------------------------------------------------------
+			EXCEPTIONS and VECTORS
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_XEA_VERSION		2	/* Xtensa Exception Architecture
+						   number: 1 == XEA1 (old)
+							   2 == XEA2 (new)
+							   0 == XEAX (extern) */
+#define XCHAL_HAVE_XEA1			0	/* Exception Architecture 1 */
+#define XCHAL_HAVE_XEA2			1	/* Exception Architecture 2 */
+#define XCHAL_HAVE_XEAX			0	/* External Exception Arch. */
+#define XCHAL_HAVE_EXCEPTIONS		1	/* exception option */
+#define XCHAL_HAVE_MEM_ECC_PARITY	0	/* local memory ECC/parity */
+#define XCHAL_HAVE_VECTOR_SELECT	1	/* relocatable vectors */
+#define XCHAL_HAVE_VECBASE		1	/* relocatable vectors */
+#define XCHAL_VECBASE_RESET_VADDR	0xD0000000  /* VECBASE reset value */
+#define XCHAL_VECBASE_RESET_PADDR	0x00000000
+#define XCHAL_RESET_VECBASE_OVERLAP	0
+
+#define XCHAL_RESET_VECTOR0_VADDR	0xFE000000
+#define XCHAL_RESET_VECTOR0_PADDR	0xFE000000
+#define XCHAL_RESET_VECTOR1_VADDR	0xD8000500
+#define XCHAL_RESET_VECTOR1_PADDR	0x00000500
+#define XCHAL_RESET_VECTOR_VADDR	0xFE000000
+#define XCHAL_RESET_VECTOR_PADDR	0xFE000000
+#define XCHAL_USER_VECOFS		0x00000340
+#define XCHAL_USER_VECTOR_VADDR		0xD0000340
+#define XCHAL_USER_VECTOR_PADDR		0x00000340
+#define XCHAL_KERNEL_VECOFS		0x00000300
+#define XCHAL_KERNEL_VECTOR_VADDR	0xD0000300
+#define XCHAL_KERNEL_VECTOR_PADDR	0x00000300
+#define XCHAL_DOUBLEEXC_VECOFS		0x000003C0
+#define XCHAL_DOUBLEEXC_VECTOR_VADDR	0xD00003C0
+#define XCHAL_DOUBLEEXC_VECTOR_PADDR	0x000003C0
+#define XCHAL_WINDOW_OF4_VECOFS		0x00000000
+#define XCHAL_WINDOW_UF4_VECOFS		0x00000040
+#define XCHAL_WINDOW_OF8_VECOFS		0x00000080
+#define XCHAL_WINDOW_UF8_VECOFS		0x000000C0
+#define XCHAL_WINDOW_OF12_VECOFS	0x00000100
+#define XCHAL_WINDOW_UF12_VECOFS	0x00000140
+#define XCHAL_WINDOW_VECTORS_VADDR	0xD0000000
+#define XCHAL_WINDOW_VECTORS_PADDR	0x00000000
+#define XCHAL_INTLEVEL2_VECOFS		0x00000280
+#define XCHAL_INTLEVEL2_VECTOR_VADDR	0xD0000280
+#define XCHAL_INTLEVEL2_VECTOR_PADDR	0x00000280
+#define XCHAL_DEBUG_VECOFS		XCHAL_INTLEVEL2_VECOFS
+#define XCHAL_DEBUG_VECTOR_VADDR	XCHAL_INTLEVEL2_VECTOR_VADDR
+#define XCHAL_DEBUG_VECTOR_PADDR	XCHAL_INTLEVEL2_VECTOR_PADDR
+
+
+/*----------------------------------------------------------------------
+				DEBUG
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_OCD			1	/* OnChipDebug option */
+#define XCHAL_NUM_IBREAK		0	/* number of IBREAKn regs */
+#define XCHAL_NUM_DBREAK		0	/* number of DBREAKn regs */
+#define XCHAL_HAVE_OCD_DIR_ARRAY	0	/* faster OCD option */
+
+
+/*----------------------------------------------------------------------
+				MMU
+  ----------------------------------------------------------------------*/
+
+/*  See core-matmap.h header file for more details.  */
+
+#define XCHAL_HAVE_TLBS			1	/* inverse of HAVE_CACHEATTR */
+#define XCHAL_HAVE_SPANNING_WAY		0	/* one way maps I+D 4GB vaddr */
+#define XCHAL_HAVE_IDENTITY_MAP		0	/* vaddr == paddr always */
+#define XCHAL_HAVE_CACHEATTR		0	/* CACHEATTR register present */
+#define XCHAL_HAVE_MIMIC_CACHEATTR	0	/* region protection */
+#define XCHAL_HAVE_XLT_CACHEATTR	0	/* region prot. w/translation */
+#define XCHAL_HAVE_PTP_MMU		1	/* full MMU (with page table
+						   [autorefill] and protection)
+						   usable for an MMU-based OS */
+/*  If none of the above last 4 are set, it's a custom TLB configuration.  */
+#define XCHAL_ITLB_ARF_ENTRIES_LOG2	2	/* log2(autorefill way size) */
+#define XCHAL_DTLB_ARF_ENTRIES_LOG2	2	/* log2(autorefill way size) */
+
+#define XCHAL_MMU_ASID_BITS		8	/* number of bits in ASIDs */
+#define XCHAL_MMU_RINGS			4	/* number of rings (1..4) */
+#define XCHAL_MMU_RING_BITS		2	/* num of bits in RING field */
+
+#endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
+
+
+#endif /* _XTENSA_CORE_CONFIGURATION_H */
+
diff --git a/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h
new file mode 100644
index 0000000..ffade04
--- /dev/null
+++ b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h
@@ -0,0 +1,183 @@
+/*
+ * This header file contains assembly-language definitions (assembly
+ * macros, etc.) for this specific Xtensa processor's TIE extensions
+ * and options.  It is customized to this Xtensa processor configuration.
+ *
+ * This file is subject to the terms and conditions of version 2.1 of the GNU
+ * Lesser General Public License as published by the Free Software Foundation.
+ *
+ * Copyright (C) 1999-2009 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_CORE_TIE_ASM_H
+#define _XTENSA_CORE_TIE_ASM_H
+
+/*  Selection parameter values for save-area save/restore macros:  */
+/*  Option vs. TIE:  */
+#define XTHAL_SAS_TIE	0x0001	/* custom extension or coprocessor */
+#define XTHAL_SAS_OPT	0x0002	/* optional (and not a coprocessor) */
+/*  Whether used automatically by compiler:  */
+#define XTHAL_SAS_NOCC	0x0004	/* not used by compiler w/o special opts/code */
+#define XTHAL_SAS_CC	0x0008	/* used by compiler without special opts/code */
+/*  ABI handling across function calls:  */
+#define XTHAL_SAS_CALR	0x0010	/* caller-saved */
+#define XTHAL_SAS_CALE	0x0020	/* callee-saved */
+#define XTHAL_SAS_GLOB	0x0040	/* global across function calls (in thread) */
+/*  Misc  */
+#define XTHAL_SAS_ALL	0xFFFF	/* include all default NCP contents */
+
+
+
+/* Macro to save all non-coprocessor (extra) custom TIE and optional state
+ * (not including zero-overhead loop registers).
+ * Save area ptr (clobbered):  ptr  (8 byte aligned)
+ * Scratch regs  (clobbered):  at1..at4  (only first XCHAL_NCP_NUM_ATMPS needed)
+ */
+	.macro xchal_ncp_store  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL
+	xchal_sa_start	\continue, \ofs
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	rsr	\at1, BR		// boolean option
+	s32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	rsr	\at1, SCOMPARE1		// conditional store option
+	s32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	rur	\at1, THREADPTR		// threadptr option
+	s32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.endm	// xchal_ncp_store
+
+/* Macro to save all non-coprocessor (extra) custom TIE and optional state
+ * (not including zero-overhead loop registers).
+ * Save area ptr (clobbered):  ptr  (8 byte aligned)
+ * Scratch regs  (clobbered):  at1..at4  (only first XCHAL_NCP_NUM_ATMPS needed)
+ */
+	.macro xchal_ncp_load  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL
+	xchal_sa_start	\continue, \ofs
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	wsr	\at1, BR		// boolean option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	wsr	\at1, SCOMPARE1		// conditional store option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~\select
+	xchal_sa_align	\ptr, 0, 1024-4, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_ + 0
+	wur	\at1, THREADPTR		// threadptr option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	.endm	// xchal_ncp_load
+
+
+
+#define XCHAL_NCP_NUM_ATMPS	1
+
+
+
+/* Macro to save the state of TIE coprocessor AudioEngineLX.
+ * Save area ptr (clobbered):  ptr  (8 byte aligned)
+ * Scratch regs  (clobbered):  at1..at4  (only first XCHAL_CP1_NUM_ATMPS needed)
+ */
+#define xchal_cp_AudioEngineLX_store	xchal_cp1_store
+/* #define xchal_cp_AudioEngineLX_store_a2	xchal_cp1_store a2 a3 a4 a5 a6 */
+	.macro	xchal_cp1_store  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL
+	xchal_sa_start \continue, \ofs
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 0, 1, 8
+	rur240	\at1		// AE_OVF_SAR
+	s32i	\at1, \ptr, 0
+	rur241	\at1		// AE_BITHEAD
+	s32i	\at1, \ptr, 4
+	rur242	\at1		// AE_TS_FTS_BU_BP
+	s32i	\at1, \ptr, 8
+	rur243	\at1		// AE_SD_NO
+	s32i	\at1, \ptr, 12
+	AE_SP24X2S.I aep0, \ptr,  16
+	AE_SP24X2S.I aep1, \ptr,  24
+	AE_SP24X2S.I aep2, \ptr,  32
+	AE_SP24X2S.I aep3, \ptr,  40
+	AE_SP24X2S.I aep4, \ptr,  48
+	AE_SP24X2S.I aep5, \ptr,  56
+	addi	\ptr, \ptr, 64
+	AE_SP24X2S.I aep6, \ptr,  0
+	AE_SP24X2S.I aep7, \ptr,  8
+	AE_SQ56S.I aeq0, \ptr,  16
+	AE_SQ56S.I aeq1, \ptr,  24
+	AE_SQ56S.I aeq2, \ptr,  32
+	AE_SQ56S.I aeq3, \ptr,  40
+	.set	.Lxchal_pofs_, .Lxchal_pofs_ + 64
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 112
+	.endif
+	.endm	// xchal_cp1_store
+
+/* Macro to restore the state of TIE coprocessor AudioEngineLX.
+ * Save area ptr (clobbered):  ptr  (8 byte aligned)
+ * Scratch regs  (clobbered):  at1..at4  (only first XCHAL_CP1_NUM_ATMPS needed)
+ */
+#define xchal_cp_AudioEngineLX_load	xchal_cp1_load
+/* #define xchal_cp_AudioEngineLX_load_a2	xchal_cp1_load a2 a3 a4 a5 a6 */
+	.macro	xchal_cp1_load  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL
+	xchal_sa_start \continue, \ofs
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~\select
+	xchal_sa_align	\ptr, 0, 0, 1, 8
+	l32i	\at1, \ptr, 0
+	wur240	\at1		// AE_OVF_SAR
+	l32i	\at1, \ptr, 4
+	wur241	\at1		// AE_BITHEAD
+	l32i	\at1, \ptr, 8
+	wur242	\at1		// AE_TS_FTS_BU_BP
+	l32i	\at1, \ptr, 12
+	wur243	\at1		// AE_SD_NO
+	addi	\ptr, \ptr, 80
+	AE_LQ56.I aeq0, \ptr,  0
+	AE_LQ56.I aeq1, \ptr,  8
+	AE_LQ56.I aeq2, \ptr,  16
+	AE_LQ56.I aeq3, \ptr,  24
+	AE_LP24X2.I aep0, \ptr,  -64
+	AE_LP24X2.I aep1, \ptr,  -56
+	AE_LP24X2.I aep2, \ptr,  -48
+	AE_LP24X2.I aep3, \ptr,  -40
+	AE_LP24X2.I aep4, \ptr,  -32
+	AE_LP24X2.I aep5, \ptr,  -24
+	AE_LP24X2.I aep6, \ptr,  -16
+	AE_LP24X2.I aep7, \ptr,  -8
+	.set	.Lxchal_pofs_, .Lxchal_pofs_ + 80
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 112
+	.endif
+	.endm	// xchal_cp1_load
+
+#define XCHAL_CP1_NUM_ATMPS	1
+#define XCHAL_SA_NUM_ATMPS	1
+
+	/*  Empty macros for unconfigured coprocessors:  */
+	.macro xchal_cp0_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp0_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp2_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp2_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp3_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp3_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp4_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp4_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp5_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp5_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp6_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp6_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp7_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp7_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+
+#endif /*_XTENSA_CORE_TIE_ASM_H*/
+
diff --git a/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h
new file mode 100644
index 0000000..6ec45c0
--- /dev/null
+++ b/arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h
@@ -0,0 +1,141 @@
+/*
+ * This header file describes this specific Xtensa processor's TIE extensions
+ * that extend basic Xtensa core functionality.  It is customized to this
+ * Xtensa processor configuration.
+ *
+ * This file is subject to the terms and conditions of version 2.1 of the GNU
+ * Lesser General Public License as published by the Free Software Foundation.
+ *
+ * Copyright (C) 1999-2009 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_CORE_TIE_H
+#define _XTENSA_CORE_TIE_H
+
+#define XCHAL_CP_NUM			1	/* number of coprocessors */
+#define XCHAL_CP_MAX			2	/* max CP ID + 1 (0 if none) */
+#define XCHAL_CP_MASK			0x02	/* bitmask of all CPs by ID */
+#define XCHAL_CP_PORT_MASK		0x00	/* bitmask of only port CPs */
+
+/*  Basic parameters of each coprocessor:  */
+#define XCHAL_CP1_NAME			"AudioEngineLX"
+#define XCHAL_CP1_IDENT			AudioEngineLX
+#define XCHAL_CP1_SA_SIZE		112	/* size of state save area */
+#define XCHAL_CP1_SA_ALIGN		8	/* min alignment of save area */
+#define XCHAL_CP_ID_AUDIOENGINELX	1	/* coprocessor ID (0..7) */
+
+/*  Filler info for unassigned coprocessors, to simplify arrays etc:  */
+#define XCHAL_CP0_SA_SIZE		0
+#define XCHAL_CP0_SA_ALIGN		1
+#define XCHAL_CP2_SA_SIZE		0
+#define XCHAL_CP2_SA_ALIGN		1
+#define XCHAL_CP3_SA_SIZE		0
+#define XCHAL_CP3_SA_ALIGN		1
+#define XCHAL_CP4_SA_SIZE		0
+#define XCHAL_CP4_SA_ALIGN		1
+#define XCHAL_CP5_SA_SIZE		0
+#define XCHAL_CP5_SA_ALIGN		1
+#define XCHAL_CP6_SA_SIZE		0
+#define XCHAL_CP6_SA_ALIGN		1
+#define XCHAL_CP7_SA_SIZE		0
+#define XCHAL_CP7_SA_ALIGN		1
+
+/*  Save area for non-coprocessor optional and custom (TIE) state:  */
+#define XCHAL_NCP_SA_SIZE		12
+#define XCHAL_NCP_SA_ALIGN		4
+
+/*  Total save area for optional and custom state (NCP + CPn):  */
+#define XCHAL_TOTAL_SA_SIZE		128	/* with 16-byte align padding */
+#define XCHAL_TOTAL_SA_ALIGN		8	/* actual minimum alignment */
+
+/*
+ * Detailed contents of save areas.
+ * NOTE:  caller must define the XCHAL_SA_REG macro (not defined here)
+ * before expanding the XCHAL_xxx_SA_LIST() macros.
+ *
+ * XCHAL_SA_REG(s,ccused,abikind,kind,opt,name,galign,align,asize,
+ *		dbnum,base,regnum,bitsz,gapsz,reset,x...)
+ *
+ *	s = passed from XCHAL_*_LIST(s), eg. to select how to expand
+ *	ccused = set if used by compiler without special options or code
+ *	abikind = 0 (caller-saved), 1 (callee-saved), or 2 (thread-global)
+ *	kind = 0 (special reg), 1 (TIE user reg), or 2 (TIE regfile reg)
+ *	opt = 0 (custom TIE extension or coprocessor), or 1 (optional reg)
+ *	name = lowercase reg name (no quotes)
+ *	galign = group byte alignment (power of 2) (galign >= align)
+ *	align = register byte alignment (power of 2)
+ *	asize = allocated size in bytes (asize*8 == bitsz + gapsz + padsz)
+ *	  (not including any pad bytes required to galign this or next reg)
+ *	dbnum = unique target number f/debug (see <xtensa-libdb-macros.h>)
+ *	base = reg shortname w/o index (or sr=special, ur=TIE user reg)
+ *	regnum = reg index in regfile, or special/TIE-user reg number
+ *	bitsz = number of significant bits (regfile width, or ur/sr mask bits)
+ *	gapsz = intervening bits, if bitsz bits not stored contiguously
+ *	(padsz = pad bits at end [TIE regfile] or at msbits [ur,sr] of asize)
+ *	reset = register reset value (or 0 if undefined at reset)
+ *	x = reserved for future use (0 until then)
+ *
+ *  To filter out certain registers, e.g. to expand only the non-global
+ *  registers used by the compiler, you can do something like this:
+ *
+ *  #define XCHAL_SA_REG(s,ccused,p...)	SELCC##ccused(p)
+ *  #define SELCC0(p...)
+ *  #define SELCC1(abikind,p...)	SELAK##abikind(p)
+ *  #define SELAK0(p...)		REG(p)
+ *  #define SELAK1(p...)		REG(p)
+ *  #define SELAK2(p...)
+ *  #define REG(kind,tie,name,galn,aln,asz,csz,dbnum,base,rnum,bsz,rst,x...) \
+ *		...what you want to expand...
+ */
+
+#define XCHAL_NCP_SA_NUM	3
+#define XCHAL_NCP_SA_LIST(s)	\
+ XCHAL_SA_REG(s,0,0,0,1,             br, 4, 4, 4,0x0204,  sr,4  , 16,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,      scompare1, 4, 4, 4,0x020C,  sr,12 , 32,0,0,0) \
+ XCHAL_SA_REG(s,1,2,1,1,      threadptr, 4, 4, 4,0x03E7,  ur,231, 32,0,0,0)
+
+#define XCHAL_CP0_SA_NUM	0
+#define XCHAL_CP0_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP1_SA_NUM	16
+#define XCHAL_CP1_SA_LIST(s)	\
+ XCHAL_SA_REG(s,0,0,1,0,     ae_ovf_sar, 8, 4, 4,0x03F0,  ur,240,  7,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,     ae_bithead, 4, 4, 4,0x03F1,  ur,241, 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,ae_ts_fts_bu_bp, 4, 4, 4,0x03F2,  ur,242, 16,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,       ae_sd_no, 4, 4, 4,0x03F3,  ur,243, 28,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep0, 8, 8, 8,0x0060, aep,0  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep1, 8, 8, 8,0x0061, aep,1  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep2, 8, 8, 8,0x0062, aep,2  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep3, 8, 8, 8,0x0063, aep,3  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep4, 8, 8, 8,0x0064, aep,4  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep5, 8, 8, 8,0x0065, aep,5  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep6, 8, 8, 8,0x0066, aep,6  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aep7, 8, 8, 8,0x0067, aep,7  , 48,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aeq0, 8, 8, 8,0x0068, aeq,0  , 56,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aeq1, 8, 8, 8,0x0069, aeq,1  , 56,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aeq2, 8, 8, 8,0x006A, aeq,2  , 56,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,           aeq3, 8, 8, 8,0x006B, aeq,3  , 56,0,0,0)
+
+#define XCHAL_CP2_SA_NUM	0
+#define XCHAL_CP2_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP3_SA_NUM	0
+#define XCHAL_CP3_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP4_SA_NUM	0
+#define XCHAL_CP4_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP5_SA_NUM	0
+#define XCHAL_CP5_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP6_SA_NUM	0
+#define XCHAL_CP6_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP7_SA_NUM	0
+#define XCHAL_CP7_SA_LIST(s)	/* empty */
+
+/* Byte length of instruction from its first nibble (op0 field), per FLIX.  */
+#define XCHAL_OP0_FORMAT_LENGTHS	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,8
+
+#endif /*_XTENSA_CORE_TIE_H*/
+
-- 
1.8.1.4
