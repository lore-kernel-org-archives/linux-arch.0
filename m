Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfDHPqd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Apr 2019 11:46:33 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Support dynamic start physical address
Date: Mon,  8 Apr 2019 23:46:19 +0800
Message-ID: <1554738379-5318-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190408154619.2VternLEuoZcL-IdIx2LotA5SRAPFlvuj87rpgUQLuk@z>

From: Guo Ren <ren_guo@c-sky.com>

Before this patch csky-linux need CONFIG_RAM_BASE to determine start
physical address. Now we use phys_offset variable to replace the macro
of PHYS_OFFSET and we setup phys_offset with real physical address which
is determined during startup in head.S.

With this patch we needn't re-compile kernel for different start
physical address. ie: 0x0 / 0xc0000000 start physical address could use
the same vmlinux, be care different start address must be 512MB aligned.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/ckmmu.h     | 20 +++++++++++++++++++
 arch/csky/abiv1/inc/abi/entry.h     | 19 ++++++++++++++++--
 arch/csky/abiv2/inc/abi/ckmmu.h     | 20 +++++++++++++++++++
 arch/csky/abiv2/inc/abi/entry.h     | 24 +++++++++++++++++++++--
 arch/csky/include/asm/mmu_context.h |  4 ++--
 arch/csky/include/asm/page.h        | 39 +++++++++++++++----------------------
 arch/csky/kernel/setup.c            |  5 +++++
 7 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
index 3a00201..85339bd 100644
--- a/arch/csky/abiv1/inc/abi/ckmmu.h
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -40,6 +40,26 @@ static inline void write_mmu_entryhi(int value)
 	cpwcr("cpcr4", value);
 }
 
+static inline unsigned long read_mmu_msa0(void)
+{
+	return cprcr("cpcr30");
+}
+
+static inline void write_mmu_msa0(unsigned long value)
+{
+	cpwcr("cpcr30", value);
+}
+
+static inline unsigned long read_mmu_msa1(void)
+{
+	return cprcr("cpcr31");
+}
+
+static inline void write_mmu_msa1(unsigned long value)
+{
+	cpwcr("cpcr31", value);
+}
+
 /*
  * TLB operations.
  */
diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index fa26461..1d66bcd 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -128,9 +128,24 @@
 .endm
 
 .macro SETUP_MMU rx
-	lrw	\rx, PHYS_OFFSET | 0xe
+	/* Select MMU as co-processor */
+	cpseti	cp15
+
+	/*
+	 * cpcr30 format:
+	 * 31 - 29 | 28 - 4 | 3 | 2 | 1 | 0
+	 *   BA     Reserved  C   D   V
+	 */
+	cprcr	\rx, cpcr30
+	lsri	\rx, 28
+	lsli	\rx, 28
+	addi	\rx, 0xe
 	cpwcr	\rx, cpcr30
-	lrw	\rx, (PHYS_OFFSET + 0x20000000) | 0xe
+
+	lsri	\rx, 28
+	addi	\rx, 2
+	lsli	\rx, 28
+	addi	\rx, 0xe
 	cpwcr	\rx, cpcr31
 .endm
 
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
index 97230ad..31d75e1 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -42,6 +42,26 @@ static inline void write_mmu_entryhi(int value)
 	mtcr("cr<4, 15>", value);
 }
 
+static inline unsigned long read_mmu_msa0(void)
+{
+	return mfcr("cr<30, 15>");
+}
+
+static inline void write_mmu_msa0(unsigned long value)
+{
+	mtcr("cr<30, 15>", value);
+}
+
+static inline unsigned long read_mmu_msa1(void)
+{
+	return mfcr("cr<31, 15>");
+}
+
+static inline void write_mmu_msa1(unsigned long value)
+{
+	mtcr("cr<31, 15>", value);
+}
+
 /*
  * TLB operations.
  */
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 31d0aa9..15ada63 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -143,9 +143,29 @@
 .endm
 
 .macro SETUP_MMU rx
-	lrw	\rx, PHYS_OFFSET | 0xe
+	/* Check MMU on | off */
+	mfcr	\rx, cr18
+	btsti	\rx, 0
+	bt	1f
+	grs	\rx, 1f
+	br	2f
+1:
+	/*
+	 * cr<30, 15> format:
+	 * 31 - 29 | 28 - 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+	 *   BA     Reserved  SH  WA  B   SO SEC  C   D   V
+	 */
+	mfcr	\rx, cr<30, 15>
+2:
+	lsri	\rx, 28
+	lsli	\rx, 28
+	addi	\rx, 0x1ce
 	mtcr	\rx, cr<30, 15>
-	lrw	\rx, (PHYS_OFFSET + 0x20000000) | 0xe
+
+	lsri	\rx, 28
+	addi	\rx, 2
+	lsli	\rx, 28
+	addi	\rx, 0x1ce
 	mtcr	\rx, cr<31, 15>
 .endm
 
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index b2905c0..c41f86b 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -17,7 +17,7 @@
 static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 {
 	pgd -= PAGE_OFFSET;
-	pgd += PHYS_OFFSET;
+	pgd += phys_offset;
 	pgd |= 1;
 	setup_pgd(pgd, kernel);
 }
@@ -29,7 +29,7 @@ static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 
 static inline unsigned long tlb_get_pgd(void)
 {
-	return ((get_pgd() - PHYS_OFFSET) & ~1) + PAGE_OFFSET;
+	return ((get_pgd() - phys_offset) & ~1) + PAGE_OFFSET;
 }
 
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 73cf2bd..4ce3d5c 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -8,7 +8,7 @@
 #include <linux/const.h>
 
 /*
- * PAGE_SHIFT determines the page size
+ * PAGE_SHIFT determines the page size: 4KB
  */
 #define PAGE_SHIFT	12
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
@@ -17,12 +17,18 @@
 #define THREAD_MASK	(~(THREAD_SIZE - 1))
 #define THREAD_SHIFT	(PAGE_SHIFT + 1)
 
+
 /*
- * NOTE: virtual isn't really correct, actually it should be the offset into the
- * memory node, but we have no highmem, so that works for now.
- * TODO: implement (fast) pfn<->pgdat_idx conversion functions, this makes lots
- * of the shifts unnecessary.
+ * For C-SKY "User-space:Kernel-space" is "2GB:2GB" fixed by hardware and there
+ * are two segment registers (MSA0 + MSA1) to mapping 512MB + 512MB physical
+ * address region. We use them mapping kernel 1GB direct-map address area and
+ * for more than 1GB of memory we use highmem.
  */
+#define PAGE_OFFSET	0x80000000
+#define SSEG_SIZE	0x20000000
+#define LOWMEM_LIMIT	(SSEG_SIZE * 2)
+
+#define PHYS_OFFSET_OFFSET (CONFIG_RAM_BASE & (SSEG_SIZE - 1))
 
 #ifndef __ASSEMBLY__
 
@@ -50,9 +56,6 @@ struct page;
 
 struct vm_area_struct;
 
-/*
- * These are used to make use of C type-checking..
- */
 typedef struct { unsigned long pte_low; } pte_t;
 #define pte_val(x)	((x).pte_low)
 
@@ -69,18 +72,13 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#endif /* !__ASSEMBLY__ */
-
-#define PHYS_OFFSET		(CONFIG_RAM_BASE & ~(LOWMEM_LIMIT - 1))
-#define PHYS_OFFSET_OFFSET	(CONFIG_RAM_BASE & (LOWMEM_LIMIT - 1))
-#define ARCH_PFN_OFFSET		PFN_DOWN(CONFIG_RAM_BASE)
+extern unsigned long phys_offset;
 
-#define	PAGE_OFFSET	0x80000000
-#define LOWMEM_LIMIT	0x40000000
+#define ARCH_PFN_OFFSET	PFN_DOWN(phys_offset + PHYS_OFFSET_OFFSET)
 
-#define __pa(x)		((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __pa(x)		((unsigned long)(x) - PAGE_OFFSET + phys_offset)
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - \
-				  PHYS_OFFSET))
+				  phys_offset))
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
 
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
@@ -90,15 +88,10 @@ typedef struct page *pgtable_t;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-/*
- * main RAM and kernel working space are coincident at 0x80000000, but to make
- * life more interesting, there's also an uncached virtual shadow at 0xb0000000
- * - these mappings are fixed in the MMU
- */
-
 #define pfn_to_kaddr(x)	__va(PFN_PHYS(x))
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
+#endif /* !__ASSEMBLY__ */
 #endif /* __ASM_CSKY_PAGE_H */
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index dff8b89..c377194 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -142,11 +142,16 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
+unsigned long phys_offset;
+EXPORT_SYMBOL(phys_offset);
+
 asmlinkage __visible void __init csky_start(unsigned int unused, void *param)
 {
 	/* Clean up bss section */
 	memset(__bss_start, 0, __bss_stop - __bss_start);
 
+	phys_offset = read_mmu_msa0() & ~(SSEG_SIZE - 1);
+
 	pre_trap_init();
 	pre_mmu_init();
 
-- 
2.7.4
