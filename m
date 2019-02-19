Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfBSKeJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2019 05:34:09 -0500
Message-ID: <20190219103233.564804918@infradead.org>
Date: Tue, 19 Feb 2019 11:32:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 12/18] arch/tlb: Clean up simple architectures
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, "David S. Miller" <davem@davemloft.net>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, Greentime Hu <green.hu@gmail.com>, Richard Henderson <rth@twiddle.net>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Vineet Gupta <vgupta@synopsys.com>, Paul Burton <paul.burton@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190219103200.QSRlFu7m9XJOhu9l6V5q89OpO01nnnMUZzxfL29Vo5Q@z>

For the architectures that do not implement their own tlb_flush() but
do already use the generic mmu_gather, there are two options:

 1) the platform has an efficient flush_tlb_range() and
    asm-generic/tlb.h doesn't need any overrides at all.

 2) the platform lacks an efficient flush_tlb_range() and
    we select MMU_GATHER_NO_RANGE to minimize full invalidates.

Convert all 'simple' architectures to one of these two forms.

alpha:	    has no range invalidate -> 2
arc:	    already used flush_tlb_range() -> 1
c6x:	    has no range invalidate -> 2
hexagon:    has an efficient flush_tlb_range() -> 1
            (flush_tlb_mm() is in fact a full range invalidate,
	     so no need to shoot down everything)
m68k:	    has inefficient flush_tlb_range() -> 2
microblaze: has no flush_tlb_range() -> 2
mips:	    has efficient flush_tlb_range() -> 1
	    (even though it currently seems to use flush_tlb_mm())
nds32:	    already uses flush_tlb_range() -> 1
nios2:	    has inefficient flush_tlb_range() -> 2
	    (no limit on range iteration)
openrisc:   has inefficient flush_tlb_range() -> 2
	    (no limit on range iteration)
parisc:	    already uses flush_tlb_range() -> 1
sparc32:    already uses flush_tlb_range() -> 1
unicore32:  has inefficient flush_tlb_range() -> 2
	    (no limit on range iteration)
xtensa:	    has efficient flush_tlb_range() -> 1

Note this also fixes a bug in the existing code for a number
platforms. Those platforms that did:

  tlb_end_vma() -> if (!full_mm) flush_tlb_*()
  tlb_flush -> if (full_mm) flush_tlb_mm()

missed the case of shift_arg_pages(), which doesn't have @fullmm set,
nor calls into tlb_*vma(), but still frees page-tables and thus needs
an invalidate. The new code handles this by detecting a non-empty
range, and either issuing the matching range invalidate or a full
invalidate, depending on the capabilities.


Cc: Nick Piggin <npiggin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Mark Salter <msalter@redhat.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/Kconfig                |    1 +
 arch/alpha/include/asm/tlb.h      |    6 ------
 arch/arc/include/asm/tlb.h        |   23 -----------------------
 arch/c6x/Kconfig                  |    1 +
 arch/c6x/include/asm/tlb.h        |    2 --
 arch/h8300/include/asm/tlb.h      |    2 --
 arch/hexagon/include/asm/tlb.h    |   12 ------------
 arch/m68k/Kconfig                 |    1 +
 arch/m68k/include/asm/tlb.h       |   14 --------------
 arch/microblaze/Kconfig           |    1 +
 arch/microblaze/include/asm/tlb.h |    9 ---------
 arch/mips/include/asm/tlb.h       |    8 --------
 arch/nds32/include/asm/tlb.h      |   10 ----------
 arch/nios2/Kconfig                |    1 +
 arch/nios2/include/asm/tlb.h      |    8 ++++----
 arch/openrisc/Kconfig             |    1 +
 arch/openrisc/include/asm/tlb.h   |    8 ++------
 arch/parisc/include/asm/tlb.h     |   13 -------------
 arch/sparc/include/asm/tlb_32.h   |   13 -------------
 arch/unicore32/Kconfig            |    1 +
 arch/unicore32/include/asm/tlb.h  |    7 +++----
 arch/xtensa/include/asm/tlb.h     |   17 -----------------
 22 files changed, 16 insertions(+), 143 deletions(-)

--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -36,6 +36,7 @@ config ALPHA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
+	select MMU_GATHER_NO_RANGE
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
--- a/arch/alpha/include/asm/tlb.h
+++ b/arch/alpha/include/asm/tlb.h
@@ -2,12 +2,6 @@
 #ifndef _ALPHA_TLB_H
 #define _ALPHA_TLB_H
 
-#define tlb_start_vma(tlb, vma)			do { } while (0)
-#define tlb_end_vma(tlb, vma)			do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
-
-#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #define __pte_free_tlb(tlb, pte, address)		pte_free((tlb)->mm, pte)
--- a/arch/arc/include/asm/tlb.h
+++ b/arch/arc/include/asm/tlb.h
@@ -9,29 +9,6 @@
 #ifndef _ASM_ARC_TLB_H
 #define _ASM_ARC_TLB_H
 
-#define tlb_flush(tlb)				\
-do {						\
-	if (tlb->fullmm)			\
-		flush_tlb_mm((tlb)->mm);	\
-} while (0)
-
-/*
- * This pair is called at time of munmap/exit to flush cache and TLB entries
- * for mappings being torn down.
- * 1) cache-flush part -implemented via tlb_start_vma( ) for VIPT aliasing D$
- * 2) tlb-flush part - implemted via tlb_end_vma( ) flushes the TLB range
- *
- * Note, read http://lkml.org/lkml/2004/1/15/6
- */
-
-#define tlb_end_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		flush_tlb_range(vma, vma->vm_start, vma->vm_end);	\
-} while (0)
-
-#define __tlb_remove_tlb_entry(tlb, ptep, address)
-
 #include <linux/pagemap.h>
 #include <asm-generic/tlb.h>
 
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -19,6 +19,7 @@ config C6X
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select MMU_GATHER_NO_RANGE if MMU
 
 config MMU
 	def_bool n
--- a/arch/c6x/include/asm/tlb.h
+++ b/arch/c6x/include/asm/tlb.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_C6X_TLB_H
 #define _ASM_C6X_TLB_H
 
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #endif /* _ASM_C6X_TLB_H */
--- a/arch/h8300/include/asm/tlb.h
+++ b/arch/h8300/include/asm/tlb.h
@@ -2,8 +2,6 @@
 #ifndef __H8300_TLB_H__
 #define __H8300_TLB_H__
 
-#define tlb_flush(tlb)	do { } while (0)
-
 #include <asm-generic/tlb.h>
 
 #endif
--- a/arch/hexagon/include/asm/tlb.h
+++ b/arch/hexagon/include/asm/tlb.h
@@ -22,18 +22,6 @@
 #include <linux/pagemap.h>
 #include <asm/tlbflush.h>
 
-/*
- * We don't need any special per-pte or per-vma handling...
- */
-#define tlb_start_vma(tlb, vma)				do { } while (0)
-#define tlb_end_vma(tlb, vma)				do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-
-/*
- * .. because we flush the whole mm when it fills up
- */
-#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #endif
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -27,6 +27,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select ARCH_DISCARD_MEMBLOCK
+	select MMU_GATHER_NO_RANGE if MMU
 
 config CPU_BIG_ENDIAN
 	def_bool y
--- a/arch/m68k/include/asm/tlb.h
+++ b/arch/m68k/include/asm/tlb.h
@@ -2,20 +2,6 @@
 #ifndef _M68K_TLB_H
 #define _M68K_TLB_H
 
-/*
- * m68k doesn't need any special per-pte or
- * per-vma handling..
- */
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-
-/*
- * .. because we flush the whole mm when it
- * fills up.
- */
-#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #endif /* _M68K_TLB_H */
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -40,6 +40,7 @@ config MICROBLAZE
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
+	select MMU_GATHER_NO_RANGE if MMU
 
 # Endianness selection
 choice
--- a/arch/microblaze/include/asm/tlb.h
+++ b/arch/microblaze/include/asm/tlb.h
@@ -11,16 +11,7 @@
 #ifndef _ASM_MICROBLAZE_TLB_H
 #define _ASM_MICROBLAZE_TLB_H
 
-#define tlb_flush(tlb)	flush_tlb_mm((tlb)->mm)
-
 #include <linux/pagemap.h>
-
-#ifdef CONFIG_MMU
-#define tlb_start_vma(tlb, vma)		do { } while (0)
-#define tlb_end_vma(tlb, vma)		do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
-#endif
-
 #include <asm-generic/tlb.h>
 
 #endif /* _ASM_MICROBLAZE_TLB_H */
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -5,14 +5,6 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
 
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
-
-/*
- * .. because we flush the whole mm when it fills up.
- */
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
 #define _UNIQUE_ENTRYHI(base, idx)					\
 		(((base) + ((idx) << (PAGE_SHIFT + 1))) |		\
 		 (cpu_has_tlbinv ? MIPS_ENTRYHI_EHINV : 0))
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -4,16 +4,6 @@
 #ifndef __ASMNDS32_TLB_H
 #define __ASMNDS32_TLB_H
 
-#define tlb_end_vma(tlb,vma)				\
-	do { 						\
-		if(!tlb->fullmm)			\
-			flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
-	} while (0)
-
-#define __tlb_remove_tlb_entry(tlb, pte, addr) do { } while (0)
-
-#define tlb_flush(tlb)	flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -23,6 +23,7 @@ config NIOS2
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
 	select ARCH_DISCARD_MEMBLOCK
+	select MMU_GATHER_NO_RANGE if MMU
 
 config GENERIC_CSUM
 	def_bool y
--- a/arch/nios2/include/asm/tlb.h
+++ b/arch/nios2/include/asm/tlb.h
@@ -11,12 +11,12 @@
 #ifndef _ASM_NIOS2_TLB_H
 #define _ASM_NIOS2_TLB_H
 
-#define tlb_flush(tlb)	flush_tlb_mm((tlb)->mm)
-
 extern void set_mmu_pid(unsigned long pid);
 
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
+/*
+ * NIOS32 does have flush_tlb_range(), but it lacks a limit and fallback to
+ * full mm invalidation. So use flush_tlb_mm() for everything.
+ */
 
 #include <linux/pagemap.h>
 #include <asm-generic/tlb.h>
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
+	select MMU_GATHER_NO_RANGE if MMU
 
 config CPU_BIG_ENDIAN
 	def_bool y
--- a/arch/openrisc/include/asm/tlb.h
+++ b/arch/openrisc/include/asm/tlb.h
@@ -20,14 +20,10 @@
 #define __ASM_OPENRISC_TLB_H__
 
 /*
- * or32 doesn't need any special per-pte or
- * per-vma handling..
+ * OpenRISC doesn't have an efficient flush_tlb_range() so use flush_tlb_mm()
+ * for everything.
  */
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 #include <linux/pagemap.h>
 #include <asm-generic/tlb.h>
 
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -2,19 +2,6 @@
 #ifndef _PARISC_TLB_H
 #define _PARISC_TLB_H
 
-#define tlb_flush(tlb)			\
-do {	if ((tlb)->fullmm)		\
-		flush_tlb_mm((tlb)->mm);\
-} while (0)
-
-#define tlb_end_vma(tlb, vma)	\
-do {	if (!(tlb)->fullmm)	\
-		flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
-} while (0)
-
-#define __tlb_remove_tlb_entry(tlb, pte, address) \
-	do { } while (0)
-
 #include <asm-generic/tlb.h>
 
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
--- a/arch/sparc/include/asm/tlb_32.h
+++ b/arch/sparc/include/asm/tlb_32.h
@@ -2,19 +2,6 @@
 #ifndef _SPARC_TLB_H
 #define _SPARC_TLB_H
 
-#define tlb_end_vma(tlb, vma) \
-do {								\
-	flush_tlb_range(vma, vma->vm_start, vma->vm_end);	\
-} while (0)
-
-#define __tlb_remove_tlb_entry(tlb, pte, address) \
-	do { } while (0)
-
-#define tlb_flush(tlb) \
-do {								\
-	flush_tlb_mm((tlb)->mm);				\
-} while (0)
-
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC_TLB_H */
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -20,6 +20,7 @@ config UNICORE32
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
+	select MMU_GATHER_NO_RANGE if MMU
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
--- a/arch/unicore32/include/asm/tlb.h
+++ b/arch/unicore32/include/asm/tlb.h
@@ -12,10 +12,9 @@
 #ifndef __UNICORE_TLB_H__
 #define __UNICORE_TLB_H__
 
-#define tlb_start_vma(tlb, vma)				do { } while (0)
-#define tlb_end_vma(tlb, vma)				do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
+/*
+ * unicore32 lacks an efficient flush_tlb_range(), use flush_tlb_mm().
+ */
 
 #define __pte_free_tlb(tlb, pte, addr)				\
 	do {							\
--- a/arch/xtensa/include/asm/tlb.h
+++ b/arch/xtensa/include/asm/tlb.h
@@ -14,23 +14,6 @@
 #include <asm/cache.h>
 #include <asm/page.h>
 
-#if (DCACHE_WAY_SIZE <= PAGE_SIZE)
-
-# define tlb_end_vma(tlb,vma)			do { } while (0)
-
-#else
-
-# define tlb_end_vma(tlb, vma)						      \
-	do {								      \
-		if (!tlb->fullmm)					      \
-			flush_tlb_range(vma, vma->vm_start, vma->vm_end);     \
-	} while(0)
-
-#endif
-
-#define __tlb_remove_tlb_entry(tlb,pte,addr)	do { } while (0)
-#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
-
 #include <asm-generic/tlb.h>
 
 #define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
