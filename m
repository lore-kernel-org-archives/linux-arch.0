From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 08/12] ppc: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:30 +0000
Message-ID: <1454095114-4128-8-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/Kbuild      |  1 +
 arch/powerpc/kernel/Makefile         |  4 ---
 arch/powerpc/kernel/entry_32.S       |  2 ++
 arch/powerpc/kernel/entry_64.S       |  3 ++
 arch/powerpc/kernel/epapr_hcalls.S   |  2 ++
 arch/powerpc/kernel/fpu.S            |  3 ++
 arch/powerpc/kernel/head_32.S        |  5 +++
 arch/powerpc/kernel/head_40x.S       |  2 ++
 arch/powerpc/kernel/head_44x.S       |  2 ++
 arch/powerpc/kernel/head_64.S        |  2 ++
 arch/powerpc/kernel/head_8xx.S       |  2 ++
 arch/powerpc/kernel/head_fsl_booke.S |  2 ++
 arch/powerpc/kernel/misc.S           |  2 ++
 arch/powerpc/kernel/misc_32.S        | 12 +++++++
 arch/powerpc/kernel/misc_64.S        |  4 +++
 arch/powerpc/kernel/pci-common.c     |  1 +
 arch/powerpc/kernel/pci_32.c         |  2 ++
 arch/powerpc/kernel/ppc_ksyms.c      | 39 -----------------------
 arch/powerpc/kernel/ppc_ksyms_32.c   | 61 ------------------------------------
 arch/powerpc/kernel/setup_32.c       |  6 ++++
 arch/powerpc/kernel/time.c           |  1 +
 arch/powerpc/kernel/vector.S         |  4 +++
 arch/powerpc/lib/Makefile            |  2 +-
 arch/powerpc/lib/checksum_32.S       |  4 +++
 arch/powerpc/lib/checksum_64.S       |  4 +++
 arch/powerpc/lib/copy_32.S           |  5 +++
 arch/powerpc/lib/copypage_64.S       |  2 ++
 arch/powerpc/lib/copyuser_64.S       |  2 ++
 arch/powerpc/lib/hweight_64.S        |  5 +++
 arch/powerpc/lib/mem_64.S            |  3 ++
 arch/powerpc/lib/memcmp_64.S         |  2 ++
 arch/powerpc/lib/memcpy_64.S         |  2 ++
 arch/powerpc/lib/ppc_ksyms.c         | 35 ---------------------
 arch/powerpc/lib/string.S            | 10 ++++++
 arch/powerpc/lib/string_64.S         |  2 ++
 arch/powerpc/mm/hash_low_32.S        |  3 ++
 arch/powerpc/sysdev/dcr-low.S        |  3 ++
 37 files changed, 106 insertions(+), 140 deletions(-)
 delete mode 100644 arch/powerpc/kernel/ppc_ksyms.c
 delete mode 100644 arch/powerpc/kernel/ppc_ksyms_32.c
 delete mode 100644 arch/powerpc/lib/ppc_ksyms.c

diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index ab9f4e0..5c4fbc8 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += clkdev.h
 generic-y += div64.h
+generic-y += export.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += local64.h
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 794f22a..5550eac 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -92,10 +92,6 @@ obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc_32.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
-ifeq ($(CONFIG_PPC32),y)
-obj-$(CONFIG_MODULES)		+= ppc_ksyms_32.o
-endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 2405631..c9d487e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,6 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -1342,6 +1343,7 @@ _GLOBAL(_mcount)
 	MCOUNT_RESTORE_FRAME
 	bctr
 #endif
+EXPORT_SYMBOL(_mcount)
 
 _GLOBAL(ftrace_stub)
 	blr
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0d525ce..e980bf1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
+#include <asm/export.h>
 
 /*
  * System calls.
@@ -1143,6 +1144,7 @@ _GLOBAL(enter_prom)
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL(mcount)
 _GLOBAL(_mcount)
+EXPORT_SYMBOL(_mcount)
 	blr
 
 _GLOBAL_TOC(ftrace_caller)
@@ -1170,6 +1172,7 @@ _GLOBAL(ftrace_stub)
 	blr
 #else
 _GLOBAL_TOC(_mcount)
+EXPORT_SYMBOL(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 9f1ebf7..52ca247 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -16,6 +16,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
 #ifndef CONFIG_PPC64
 /* epapr_ev_idle() was derived from e500_idle() */
@@ -53,3 +54,4 @@ epapr_hypercall_start:
 	nop
 	nop
 	blr
+EXPORT_SYMBOL(epapr_hypercall_start)
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 2117eac..1e70bb7 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -24,6 +24,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_VSX
 #define __REST_32FPVSRS(n,c,base)					\
@@ -85,6 +86,7 @@ _GLOBAL(load_fp_state)
 	MTFSF_L(fr0)
 	REST_32FPVSRS(0, R4, R3)
 	blr
+EXPORT_SYMBOL(load_fp_state)
 
 /*
  * Store FP state into memory, including FPSCR
@@ -95,6 +97,7 @@ _GLOBAL(store_fp_state)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
 	blr
+EXPORT_SYMBOL(store_fp_state)
 
 /*
  * This task wants to use the FPU now.
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dc0488b..590fe4a 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -34,6 +34,7 @@
 #include <asm/ptrace.h>
 #include <asm/bug.h>
 #include <asm/kvm_book3s_asm.h>
+#include <asm/export.h>
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
@@ -739,6 +740,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 
 	.globl mol_trampoline
 	.set mol_trampoline, i0x2f00
+	EXPORT_SYMBOL(mol_trampoline)
 
 	. = 0x3000
 
@@ -1048,6 +1050,7 @@ _ENTRY(switch_mmu_context)
 4:	trap
 	EMIT_BUG_ENTRY 4b,__FILE__,__LINE__,0
 	blr
+EXPORT_SYMBOL(switch_mmu_context)
 
 /*
  * An undocumented "feature" of 604e requires that the v bit
@@ -1275,6 +1278,7 @@ sdata:
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	4096
+EXPORT_SYMBOL(empty_zero_page)
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
@@ -1288,6 +1292,7 @@ intercept_table:
 	.long 0, 0, 0, 0, 0, 0, 0, 0
 	.long 0, 0, 0, 0, 0, 0, 0, 0
 	.long 0, 0, 0, 0, 0, 0, 0, 0
+EXPORT_SYMBOL(intercept_table)
 
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7d7d863..41374a4 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -41,6 +41,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
@@ -971,6 +972,7 @@ sdata:
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	4096
+EXPORT_SYMBOL(empty_zero_page)
 	.globl	swapper_pg_dir
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b5061ab..58b8616 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -39,6 +39,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/synch.h>
+#include <asm/export.h>
 #include "head_booke.h"
 
 
@@ -1254,6 +1255,7 @@ sdata:
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	PAGE_SIZE
+EXPORT_SYMBOL(empty_zero_page)
 
 /*
  * To support >32-bit physical addresses, we use an 8KB pgdir.
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1b77956..4a37166 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -40,6 +40,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/ptrace.h>
 #include <asm/hw_irq.h>
+#include <asm/export.h>
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -881,6 +882,7 @@ start_here_common:
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	PAGE_SIZE
+EXPORT_SYMBOL(empty_zero_page)
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 78c1eba..27a6cb0 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -30,6 +30,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
@@ -930,6 +931,7 @@ sdata:
 	.align	PAGE_SHIFT
 empty_zero_page:
 	.space	PAGE_SIZE
+EXPORT_SYMBOL(empty_zero_page)
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index f705171..4b3d564 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -42,6 +42,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 #include "head_booke.h"
 
 /* As with the other PowerPC ports, it is expected that when code
@@ -1297,6 +1298,7 @@ sdata:
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	4096
+EXPORT_SYMBOL(empty_zero_page)
 	.globl	swapper_pg_dir
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 0d43219..384357c 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -18,6 +18,7 @@
 #include <asm/unistd.h>
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
 	.text
 
@@ -118,3 +119,4 @@ _GLOBAL(longjmp)
 _GLOBAL(current_stack_pointer)
 	PPC_LL	r3,0(r1)
 	blr
+EXPORT_SYMBOL(current_stack_pointer)
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index be8edd6..b1519c5 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -33,6 +33,7 @@
 #include <asm/kexec.h>
 #include <asm/bug.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 	.text
 
@@ -337,6 +338,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
 #endif /* CONFIG_8xx/4xx */
 	isync
 	blr
+EXPORT_SYMBOL(flush_instruction_cache)
 
 /*
  * Write any modified data cache blocks out to memory
@@ -376,6 +378,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	sync				/* additional sync needed on g4 */
 	isync
 	blr
+EXPORT_SYMBOL(flush_icache_range)
 /*
  * Write any modified data cache blocks out to memory.
  * Does not invalidate the corresponding cache lines (especially for
@@ -418,6 +421,7 @@ _GLOBAL(flush_dcache_range)
 	bdnz	1b
 	sync				/* wait for dcbst's to get to ram */
 	blr
+EXPORT_SYMBOL(flush_dcache_range)
 
 /*
  * Like above, but invalidate the D-cache.  This is used by the 8xx
@@ -549,6 +553,7 @@ _GLOBAL(clear_pages)
 	stw	r7,8(r3);	\
 	stw	r8,12(r3);	\
 	stwu	r9,16(r3)
+EXPORT_SYMBOL(clear_pages)
 
 _GLOBAL(copy_page)
 	addi	r3,r3,-4
@@ -594,6 +599,7 @@ _GLOBAL(copy_page)
 	li	r0,MAX_COPY_PREFETCH
 	li	r11,4
 	b	2b
+EXPORT_SYMBOL(copy_page)
 
 /*
  * Extended precision shifts.
@@ -621,6 +627,7 @@ _GLOBAL(__ashrdi3)
 	sraw	r3,r3,r5	# MSW = MSW >> count
 	or	r4,r4,r7	# LSW |= t2
 	blr
+EXPORT_SYMBOL(__ashrdi3)
 
 _GLOBAL(__ashldi3)
 	subfic	r6,r5,32
@@ -632,6 +639,7 @@ _GLOBAL(__ashldi3)
 	slw	r4,r4,r5	# LSW = LSW << count
 	or	r3,r3,r7	# MSW |= t2
 	blr
+EXPORT_SYMBOL(__ashldi3)
 
 _GLOBAL(__lshrdi3)
 	subfic	r6,r5,32
@@ -643,6 +651,7 @@ _GLOBAL(__lshrdi3)
 	srw	r3,r3,r5	# MSW = MSW >> count
 	or	r4,r4,r7	# LSW |= t2
 	blr
+EXPORT_SYMBOL(__lshrdi3)
 
 /*
  * 64-bit comparison: __cmpdi2(s64 a, s64 b)
@@ -658,6 +667,7 @@ _GLOBAL(__cmpdi2)
 	bltlr
 	li	r3,2
 	blr
+EXPORT_SYMBOL(__cmpdi2)
 /*
  * 64-bit comparison: __ucmpdi2(u64 a, u64 b)
  * Returns 0 if a < b, 1 if a == b, 2 if a > b.
@@ -672,6 +682,7 @@ _GLOBAL(__ucmpdi2)
 	bltlr
 	li	r3,2
 	blr
+EXPORT_SYMBOL(__ucmpdi2)
 
 _GLOBAL(__bswapdi2)
 	rotlwi  r9,r4,8
@@ -683,6 +694,7 @@ _GLOBAL(__bswapdi2)
 	mr      r3,r9
 	mr      r4,r10
 	blr
+EXPORT_SYMBOL(__bswapdi2)
 
 _GLOBAL(abs)
 	srawi	r4,r3,31
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index db475d4..f485c94 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -27,6 +27,7 @@
 #include <asm/kexec.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/export.h>
 
 	.text
 
@@ -110,6 +111,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	isync
 	blr
 	.previous .text
+EXPORT_SYMBOL(flush_icache_range)
 /*
  * Like above, but only do the D-cache.
  *
@@ -139,6 +141,7 @@ _GLOBAL(flush_dcache_range)
 	bdnz	0b
 	sync
 	blr
+EXPORT_SYMBOL(flush_dcache_range)
 
 /*
  * Like above, but works on non-mapped physical addresses.
@@ -242,6 +245,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	blr
 
 _GLOBAL(__bswapdi2)
+EXPORT_SYMBOL(__bswapdi2)
 	srdi	r8,r3,32
 	rlwinm	r7,r3,8,0xffffffff
 	rlwimi	r7,r3,24,0,7
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..fe276cb 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -49,6 +49,7 @@ static int global_phb_number;		/* Global phb counter */
 
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
+EXPORT_SYMBOL(isa_mem_base);
 
 
 static struct dma_map_ops *pci_dma_ops = &dma_direct_ops;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 1f793003..678f87a 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -32,6 +32,8 @@
 unsigned long isa_io_base     = 0;
 unsigned long pci_dram_offset = 0;
 int pcibios_assign_bus_offset = 1;
+EXPORT_SYMBOL(isa_io_base);
+EXPORT_SYMBOL(pci_dram_offset);
 
 void pcibios_make_OF_bus_map(void);
 
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
deleted file mode 100644
index 41e1607..0000000
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include <linux/ftrace.h>
-#include <linux/mm.h>
-
-#include <asm/processor.h>
-#include <asm/switch_to.h>
-#include <asm/cacheflush.h>
-#include <asm/epapr_hcalls.h>
-
-EXPORT_SYMBOL(flush_dcache_range);
-EXPORT_SYMBOL(flush_icache_range);
-
-EXPORT_SYMBOL(empty_zero_page);
-
-long long __bswapdi2(long long);
-EXPORT_SYMBOL(__bswapdi2);
-
-#ifdef CONFIG_FUNCTION_TRACER
-EXPORT_SYMBOL(_mcount);
-#endif
-
-#ifdef CONFIG_PPC_FPU
-EXPORT_SYMBOL(load_fp_state);
-EXPORT_SYMBOL(store_fp_state);
-#endif
-
-#ifdef CONFIG_ALTIVEC
-EXPORT_SYMBOL(load_vr_state);
-EXPORT_SYMBOL(store_vr_state);
-#endif
-
-#ifdef CONFIG_VSX
-EXPORT_SYMBOL_GPL(__giveup_vsx);
-#endif
-
-#ifdef CONFIG_EPAPR_PARAVIRT
-EXPORT_SYMBOL(epapr_hypercall_start);
-#endif
-
-EXPORT_SYMBOL(current_stack_pointer);
diff --git a/arch/powerpc/kernel/ppc_ksyms_32.c b/arch/powerpc/kernel/ppc_ksyms_32.c
deleted file mode 100644
index 30ddd8a..0000000
--- a/arch/powerpc/kernel/ppc_ksyms_32.c
+++ /dev/null
@@ -1,61 +0,0 @@
-#include <linux/export.h>
-#include <linux/smp.h>
-
-#include <asm/page.h>
-#include <asm/dma.h>
-#include <asm/io.h>
-#include <asm/hw_irq.h>
-#include <asm/time.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
-#include <asm/dcr.h>
-
-EXPORT_SYMBOL(clear_pages);
-EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
-EXPORT_SYMBOL(DMA_MODE_READ);
-EXPORT_SYMBOL(DMA_MODE_WRITE);
-
-#if defined(CONFIG_PCI)
-EXPORT_SYMBOL(isa_io_base);
-EXPORT_SYMBOL(isa_mem_base);
-EXPORT_SYMBOL(pci_dram_offset);
-#endif
-
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(smp_hw_index);
-#endif
-
-long long __ashrdi3(long long, int);
-long long __ashldi3(long long, int);
-long long __lshrdi3(long long, int);
-int __ucmpdi2(unsigned long long, unsigned long long);
-int __cmpdi2(long long, long long);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__ucmpdi2);
-EXPORT_SYMBOL(__cmpdi2);
-
-EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(tb_ticks_per_jiffy);
-
-EXPORT_SYMBOL(switch_mmu_context);
-
-#ifdef CONFIG_PPC_STD_MMU_32
-extern long mol_trampoline;
-EXPORT_SYMBOL(mol_trampoline); /* For MOL */
-EXPORT_SYMBOL(flush_hash_pages); /* For MOL */
-#ifdef CONFIG_SMP
-extern int mmu_hash_lock;
-EXPORT_SYMBOL(mmu_hash_lock); /* For MOL */
-#endif /* CONFIG_SMP */
-extern long *intercept_table;
-EXPORT_SYMBOL(intercept_table);
-#endif /* CONFIG_PPC_STD_MMU_32 */
-
-#ifdef CONFIG_PPC_DCR_NATIVE
-EXPORT_SYMBOL(__mtdcr);
-EXPORT_SYMBOL(__mfdcr);
-#endif
-
-EXPORT_SYMBOL(flush_instruction_cache);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ad8c9db..a9d63f5 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/memblock.h>
+#include <linux/export.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -48,11 +49,16 @@ int boot_cpuid_phys;
 EXPORT_SYMBOL_GPL(boot_cpuid_phys);
 
 int smp_hw_index[NR_CPUS];
+EXPORT_SYMBOL(smp_hw_index);
 
 unsigned long ISA_DMA_THRESHOLD;
 unsigned int DMA_MODE_READ;
 unsigned int DMA_MODE_WRITE;
 
+EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
+EXPORT_SYMBOL(DMA_MODE_READ);
+EXPORT_SYMBOL(DMA_MODE_WRITE);
+
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
  * for each elf executable being started.
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 81b0900..78743ce 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -565,6 +565,7 @@ void timer_interrupt(struct pt_regs * regs)
 	irq_exit();
 	set_irq_regs(old_regs);
 }
+EXPORT_SYMBOL(timer_interrupt);
 
 /*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 162d0f7..3bcfda8 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -6,6 +6,7 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 /* void do_load_up_transact_altivec(struct thread_struct *thread)
@@ -42,6 +43,7 @@ _GLOBAL(load_vr_state)
 	mtvscr	v0
 	REST_32VRS(0,r4,r3)
 	blr
+EXPORT_SYMBOL(load_vr_state)
 
 /*
  * Store VMX state into memory, including VSCR.
@@ -53,6 +55,7 @@ _GLOBAL(store_vr_state)
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
 	blr
+EXPORT_SYMBOL(store_vr_state)
 
 /*
  * Disable VMX for the task which had it previously,
@@ -179,6 +182,7 @@ _GLOBAL(__giveup_vsx)
 	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
 	blr
+EXPORT_SYMBOL_GPL(__giveup_vsx)
 
 #endif /* CONFIG_VSX */
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e142..23a5cb0 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = -pg
 CFLAGS_REMOVE_feature-fixups.o = -pg
 
-obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
+obj-y += string.o alloc.o crtsavres.o code-patching.o \
 	 feature-fixups.o
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 6d67e05..cb90cd4 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -16,6 +16,7 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 	.text
 
@@ -39,6 +40,7 @@ _GLOBAL(ip_fast_csum)
 	not	r3,r3
 	srwi	r3,r3,16
 	blr
+EXPORT_SYMBOL(ip_fast_csum)
 
 /*
  * computes the checksum of a memory block at buff, length len,
@@ -77,6 +79,7 @@ _GLOBAL(csum_partial)
 	adde	r0,r0,r5
 5:	addze	r3,r0		/* add in final carry */
 	blr
+EXPORT_SYMBOL(csum_partial)
 
 /*
  * Computes the checksum of a memory block at src, length len,
@@ -207,3 +210,4 @@ dst_error:
 	.long	95b,dst_error
 	.long	96b,dst_error
 	.long	97b,dst_error
+EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index f3ef354..fa06a9d 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -16,6 +16,7 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 /*
  * ip_fast_csum(r3=buf, r4=len) -- Optimized for IP header
@@ -43,6 +44,7 @@ _GLOBAL(ip_fast_csum)
 	not	r3,r3
 	srwi	r3,r3,16
 	blr
+EXPORT_SYMBOL(ip_fast_csum)
 
 /*
  * Computes the checksum of a memory block at buff, length len,
@@ -203,6 +205,7 @@ _GLOBAL(csum_partial)
 	add	r3,r4,r0
 	srdi	r3,r3,32
 	blr
+EXPORT_SYMBOL(csum_partial)
 
 
 	.macro srcnr
@@ -457,3 +460,4 @@ dstnr;	stb	r6,0(r4)
 	li	r6,-EFAULT
 	stw	r6,0(r8)
 	blr
+EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index c44df2d..e43cc62 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -92,6 +93,7 @@ _GLOBAL(memset)
 	subf	r6,r0,r6
 	cmplwi	0,r4,0
 	bne	2f	/* Use normal procedure if r4 is not zero */
+EXPORT_SYMBOL(memset)
 _GLOBAL(memset_nocache_branch)
 	b	2f	/* Skip optimised bloc until cache is enabled */
 
@@ -216,6 +218,8 @@ _GLOBAL(memcpy)
 	stbu	r0,1(r6)
 	bdnz	40b
 65:	blr
+EXPORT_SYMBOL(memcpy)
+EXPORT_SYMBOL(memmove)
 
 _GLOBAL(generic_memcpy)
 	srwi.	r7,r5,3
@@ -507,3 +511,4 @@ _GLOBAL(__copy_tofrom_user)
 	.long	112b,120b
 	.long	114b,120b
 	.text
+EXPORT_SYMBOL(__copy_tofrom_user)
diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
index a3c4dc4..21367b3 100644
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
         .section        ".toc","aw"
 PPC64_CACHES:
@@ -110,3 +111,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
 	std	r11,120(r3)
 	std	r12,128(r3)
 	blr
+EXPORT_SYMBOL(copy_page)
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index f09899e..f19a15b 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -8,6 +8,7 @@
  */
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 #ifdef __BIG_ENDIAN__
 #define sLd sld		/* Shift towards low-numbered address. */
@@ -671,3 +672,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	.llong	89b,100b
 	.llong	90b,100b
 	.llong	91b,100b
+EXPORT_SYMBOL(__copy_tofrom_user)
diff --git a/arch/powerpc/lib/hweight_64.S b/arch/powerpc/lib/hweight_64.S
index 19e6600..3de7ac1 100644
--- a/arch/powerpc/lib/hweight_64.S
+++ b/arch/powerpc/lib/hweight_64.S
@@ -19,6 +19,7 @@
  */
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 /* Note: This code relies on -mminimal-toc */
 
@@ -32,6 +33,7 @@ FTR_SECTION_ELSE
 	clrldi	r3,r3,64-8
 	blr
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+EXPORT_SYMBOL(__arch_hweight8)
 
 _GLOBAL(__arch_hweight16)
 BEGIN_FTR_SECTION
@@ -54,6 +56,7 @@ FTR_SECTION_ELSE
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+EXPORT_SYMBOL(__arch_hweight16)
 
 _GLOBAL(__arch_hweight32)
 BEGIN_FTR_SECTION
@@ -79,6 +82,7 @@ FTR_SECTION_ELSE
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+EXPORT_SYMBOL(__arch_hweight32)
 
 _GLOBAL(__arch_hweight64)
 BEGIN_FTR_SECTION
@@ -108,3 +112,4 @@ FTR_SECTION_ELSE
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
+EXPORT_SYMBOL(__arch_hweight64)
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 43435c6..2d128df 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -11,6 +11,7 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 _GLOBAL(memset)
 	neg	r0,r3
@@ -76,6 +77,7 @@ _GLOBAL(memset)
 10:	bflr	31
 	stb	r4,0(r6)
 	blr
+EXPORT_SYMBOL(memset)
 
 _GLOBAL_TOC(memmove)
 	cmplw	0,r3,r4
@@ -117,3 +119,4 @@ _GLOBAL(backwards_memcpy)
 	beq	2b
 	mtctr	r7
 	b	1b
+EXPORT_SYMBOL(memmove)
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 8953d23..d75d18b 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -8,6 +8,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 #define off8	r6
 #define off16	r7
@@ -231,3 +232,4 @@ _GLOBAL(memcmp)
 	ld	r28,-32(r1)
 	ld	r27,-40(r1)
 	blr
+EXPORT_SYMBOL(memcmp)
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 32a06ec..f4d6088 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -8,6 +8,7 @@
  */
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 	.align	7
 _GLOBAL_TOC(memcpy)
@@ -219,3 +220,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 4:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
 	blr
 #endif
+EXPORT_SYMBOL(memcpy)
diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
deleted file mode 100644
index c7f8e95..0000000
--- a/arch/powerpc/lib/ppc_ksyms.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include <linux/string.h>
-#include <linux/uaccess.h>
-#include <linux/bitops.h>
-#include <net/checksum.h>
-
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memchr);
-
-EXPORT_SYMBOL(strcpy);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
-
-#ifndef CONFIG_GENERIC_CSUM
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_generic);
-EXPORT_SYMBOL(ip_fast_csum);
-EXPORT_SYMBOL(csum_tcpudp_magic);
-#endif
-
-EXPORT_SYMBOL(__copy_tofrom_user);
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(copy_page);
-
-#ifdef CONFIG_PPC64
-EXPORT_SYMBOL(__arch_hweight8);
-EXPORT_SYMBOL(__arch_hweight16);
-EXPORT_SYMBOL(__arch_hweight32);
-EXPORT_SYMBOL(__arch_hweight64);
-#endif
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index c80fb49..2d6cb94 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -11,6 +11,7 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/export.h>
 
 	.section __ex_table,"a"
 	PPC_LONG_ALIGN
@@ -24,6 +25,7 @@ _GLOBAL(strcpy)
 	stbu	r0,1(r5)
 	bne	1b
 	blr
+EXPORT_SYMBOL(strcpy)
 
 /* This clears out any unused part of the destination buffer,
    just as the libc version does.  -- paulus */
@@ -44,6 +46,7 @@ _GLOBAL(strncpy)
 2:	stbu	r0,1(r6)	/* clear it out if so */
 	bdnz	2b
 	blr
+EXPORT_SYMBOL(strncpy)
 
 _GLOBAL(strcat)
 	addi	r5,r3,-1
@@ -57,6 +60,7 @@ _GLOBAL(strcat)
 	stbu	r0,1(r5)
 	bne	1b
 	blr
+EXPORT_SYMBOL(strcat)
 
 _GLOBAL(strcmp)
 	addi	r5,r3,-1
@@ -68,6 +72,7 @@ _GLOBAL(strcmp)
 	beqlr	1
 	beq	1b
 	blr
+EXPORT_SYMBOL(strcmp)
 
 _GLOBAL(strncmp)
 	PPC_LCMPI 0,r5,0
@@ -84,6 +89,7 @@ _GLOBAL(strncmp)
 	blr
 2:	li	r3,0
 	blr
+EXPORT_SYMBOL(strncmp)
 
 _GLOBAL(strlen)
 	addi	r4,r3,-1
@@ -92,6 +98,7 @@ _GLOBAL(strlen)
 	bne	1b
 	subf	r3,r3,r4
 	blr
+EXPORT_SYMBOL(strlen)
 
 #ifdef CONFIG_PPC32
 _GLOBAL(memcmp)
@@ -107,6 +114,7 @@ _GLOBAL(memcmp)
 	blr
 2:	li	r3,0
 	blr
+EXPORT_SYMBOL(memcmp)
 #endif
 
 _GLOBAL(memchr)
@@ -120,6 +128,7 @@ _GLOBAL(memchr)
 	beqlr
 2:	li	r3,0
 	blr
+EXPORT_SYMBOL(memchr)
 
 #ifdef CONFIG_PPC32
 _GLOBAL(__clear_user)
@@ -163,4 +172,5 @@ _GLOBAL(__clear_user)
 	PPC_LONG	1b,91b
 	PPC_LONG	8b,92b
 	.text
+EXPORT_SYMBOL(__clear_user)
 #endif
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index 7bd9549..57ace35 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -20,6 +20,7 @@
 
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
 	.section	".toc","aw"
 PPC64_CACHES:
@@ -200,3 +201,4 @@ err1;	dcbz	r0,r3
 	cmpdi	r4,32
 	blt	.Lshort_clear
 	b	.Lmedium_clear
+EXPORT_SYMBOL(__clear_user)
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 115347f..09cc50c 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -26,6 +26,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/export.h>
 
 #ifdef CONFIG_SMP
 	.section .bss
@@ -33,6 +34,7 @@
 	.globl mmu_hash_lock
 mmu_hash_lock:
 	.space	4
+EXPORT_SYMBOL(mmu_hash_lock)
 #endif /* CONFIG_SMP */
 
 /*
@@ -575,6 +577,7 @@ _GLOBAL(flush_hash_pages)
 	rlwinm	r8,r8,0,31,29		/* clear HASHPTE bit */
 	stwcx.	r8,0,r5			/* update the pte */
 	bne-	33b
+EXPORT_SYMBOL(flush_hash_pages)
 
 	/* Get the address of the primary PTE group in the hash table (r3) */
 _GLOBAL(flush_hash_patch_A)
diff --git a/arch/powerpc/sysdev/dcr-low.S b/arch/powerpc/sysdev/dcr-low.S
index d3098ef..e687bb2 100644
--- a/arch/powerpc/sysdev/dcr-low.S
+++ b/arch/powerpc/sysdev/dcr-low.S
@@ -12,6 +12,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/processor.h>
 #include <asm/bug.h>
+#include <asm/export.h>
 
 #define DCR_ACCESS_PROLOG(table) \
 	cmpli	cr0,r3,1024;	 \
@@ -28,9 +29,11 @@
 
 _GLOBAL(__mfdcr)
 	DCR_ACCESS_PROLOG(__mfdcr_table)
+EXPORT_SYMBOL(__mfdcr)
 
 _GLOBAL(__mtdcr)
 	DCR_ACCESS_PROLOG(__mtdcr_table)
+EXPORT_SYMBOL(__mtdcr)
 
 __mfdcr_table:
 	mfdcr  r3,0; blr
-- 
2.1.4
