From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: add HIGHMEM support
Date: Wed,  2 Apr 2014 03:15:46 +0400
Message-ID: <1396394146-7594-3-git-send-email-jcmvbkbc@gmail.com>
References: <1396394146-7594-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:53589 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbaDAXQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Apr 2014 19:16:20 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so3246698lab.6
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2014 16:16:19 -0700 (PDT)
In-Reply-To: <1396394146-7594-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Introduce fixmap area just below the vmalloc region. Use it for atomic
mapping of high memory pages.
High memory on cores with cache aliasing is not supported and is still
to be implemented. Fail build for such configurations for now.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig               | 18 ++++++++++
 arch/xtensa/include/asm/fixmap.h  | 58 +++++++++++++++++++++++++++++++
 arch/xtensa/include/asm/highmem.h | 45 +++++++++++++++++++++++-
 arch/xtensa/include/asm/pgtable.h |  4 +++
 arch/xtensa/mm/Makefile           |  1 +
 arch/xtensa/mm/cache.c            |  7 +++-
 arch/xtensa/mm/highmem.c          | 72 +++++++++++++++++++++++++++++++++++++++
 arch/xtensa/mm/init.c             | 45 ++++++++++++++++--------
 arch/xtensa/mm/mmu.c              | 36 ++++++++++++++++++++
 9 files changed, 270 insertions(+), 16 deletions(-)
 create mode 100644 arch/xtensa/include/asm/fixmap.h
 create mode 100644 arch/xtensa/mm/highmem.c

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2437f73..d01044e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -218,6 +218,24 @@ config INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
 
 	  If in doubt, say Y.
 
+config HIGHMEM
+	bool "High Memory Support"
+	help
+	  Linux can use the full amount of RAM in the system by
+	  default. However, the default MMUv2 setup only maps the
+	  lowermost 128 MB of memory linearly to the areas starting
+	  at 0xd0000000 (cached) and 0xd8000000 (uncached).
+	  When there are more than 128 MB memory in the system not
+	  all of it can be "permanently mapped" by the kernel.
+	  The physical memory that's not permanently mapped is called
+	  "high memory".
+
+	  If you are compiling a kernel which will never run on a
+	  machine with more than 128 MB total physical RAM, answer
+	  N here.
+
+	  If unsure, say Y.
+
 endmenu
 
 config XTENSA_CALIBRATE_CCOUNT
diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
new file mode 100644
index 0000000..9f6c33d0
--- /dev/null
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -0,0 +1,58 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ */
+
+#ifndef _ASM_FIXMAP_H
+#define _ASM_FIXMAP_H
+
+#include <asm/pgtable.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process. We allocate these special  addresses
+ * from the end of the consistent memory region backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * higher than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ */
+enum fixed_addresses {
+#ifdef CONFIG_HIGHMEM
+	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+#endif
+	__end_of_fixed_addresses
+};
+
+#define FIXADDR_TOP     (VMALLOC_START - PAGE_SIZE)
+#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START	((FIXADDR_TOP - FIXADDR_SIZE) & PMD_MASK)
+
+#include <asm-generic/fixmap.h>
+
+#define kmap_get_fixmap_pte(vaddr) \
+	pte_offset_kernel( \
+		pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), \
+		(vaddr) \
+	)
+
+#endif
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 80be151..2653ef5 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -6,11 +6,54 @@
  * this archive for more details.
  *
  * Copyright (C) 2003 - 2005 Tensilica Inc.
+ * Copyright (C) 2014 Cadence Design Systems Inc.
  */
 
 #ifndef _XTENSA_HIGHMEM_H
 #define _XTENSA_HIGHMEM_H
 
-extern void flush_cache_kmaps(void);
+#include <asm/cacheflush.h>
+#include <asm/fixmap.h>
+#include <asm/kmap_types.h>
+#include <asm/pgtable.h>
+
+#define PKMAP_BASE		(FIXADDR_START - PMD_SIZE)
+#define LAST_PKMAP		PTRS_PER_PTE
+#define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
+#define PKMAP_NR(virt)		(((virt) - PKMAP_BASE) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define kmap_prot		PAGE_KERNEL
+
+extern pte_t *pkmap_page_table;
+
+void *kmap_high(struct page *page);
+void kunmap_high(struct page *page);
+
+static inline void *kmap(struct page *page)
+{
+	BUG_ON(in_interrupt());
+	if (!PageHighMem(page))
+		return page_address(page);
+	return kmap_high(page);
+}
+
+static inline void kunmap(struct page *page)
+{
+	BUG_ON(in_interrupt());
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+
+static inline void flush_cache_kmaps(void)
+{
+	flush_cache_all();
+}
+
+void *kmap_atomic(struct page *page);
+void __kunmap_atomic(void *kvaddr);
+
+void kmap_init(void);
 
 #endif
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 2164462..4b0ca35 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -310,6 +310,10 @@ set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pteval)
 	update_pte(ptep, pteval);
 }
 
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	update_pte(ptep, pteval);
+}
 
 static inline void
 set_pmd(pmd_t *pmdp, pmd_t pmdval)
diff --git a/arch/xtensa/mm/Makefile b/arch/xtensa/mm/Makefile
index f0b646d..f54f78e 100644
--- a/arch/xtensa/mm/Makefile
+++ b/arch/xtensa/mm/Makefile
@@ -4,3 +4,4 @@
 
 obj-y			:= init.o cache.o misc.o
 obj-$(CONFIG_MMU)	+= fault.o mmu.o tlb.o
+obj-$(CONFIG_HIGHMEM)	+= highmem.o
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index ba4c47f..63cbb86 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -59,6 +59,10 @@
  *
  */
 
+#if (DCACHE_WAY_SIZE > PAGE_SIZE) && defined(CONFIG_HIGHMEM)
+#error "HIGHMEM is not supported on cores with aliasing cache."
+#endif
+
 #if (DCACHE_WAY_SIZE > PAGE_SIZE) && XCHAL_DCACHE_IS_WRITEBACK
 
 /*
@@ -179,10 +183,11 @@ update_mmu_cache(struct vm_area_struct * vma, unsigned long addr, pte_t *ptep)
 #else
 	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)
 	    && (vma->vm_flags & VM_EXEC) != 0) {
-	    	unsigned long paddr = (unsigned long) page_address(page);
+		unsigned long paddr = (unsigned long)kmap_atomic(page);
 		__flush_dcache_page(paddr);
 		__invalidate_icache_page(paddr);
 		set_bit(PG_arch_1, &page->flags);
+		kunmap_atomic((void *)paddr);
 	}
 #endif
 }
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
new file mode 100644
index 0000000..17a8c0d
--- /dev/null
+++ b/arch/xtensa/mm/highmem.c
@@ -0,0 +1,72 @@
+/*
+ * High memory support for Xtensa architecture
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file "COPYING" in the main directory of
+ * this archive for more details.
+ *
+ * Copyright (C) 2014 Cadence Design Systems Inc.
+ */
+
+#include <linux/export.h>
+#include <linux/highmem.h>
+#include <asm/tlbflush.h>
+
+static pte_t *kmap_pte;
+
+void *kmap_atomic(struct page *page)
+{
+	enum fixed_addresses idx;
+	unsigned long vaddr;
+	int type;
+
+	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	type = kmap_atomic_idx_push();
+	idx = type + KM_TYPE_NR * smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+#ifdef CONFIG_DEBUG_HIGHMEM
+	BUG_ON(!pte_none(*(kmap_pte - idx)));
+#endif
+	set_pte(kmap_pte - idx, mk_pte(page, PAGE_KERNEL_EXEC));
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL(kmap_atomic);
+
+void __kunmap_atomic(void *kvaddr)
+{
+	int idx, type;
+
+	if (kvaddr >= (void *)FIXADDR_START &&
+	    kvaddr < (void *)FIXADDR_TOP) {
+		type = kmap_atomic_idx();
+		idx = type + KM_TYPE_NR * smp_processor_id();
+
+		/*
+		 * Force other mappings to Oops if they'll try to access this
+		 * pte without first remap it.  Keeping stale mappings around
+		 * is a bad idea also, in case the page changes cacheability
+		 * attributes or becomes a protected page in a hypervisor.
+		 */
+		pte_clear(&init_mm, kvaddr, kmap_pte - idx);
+		local_flush_tlb_kernel_range((unsigned long)kvaddr,
+					     (unsigned long)kvaddr + PAGE_SIZE);
+
+		kmap_atomic_idx_pop();
+	}
+
+	pagefault_enable();
+}
+EXPORT_SYMBOL(__kunmap_atomic);
+
+void __init kmap_init(void)
+{
+	unsigned long kmap_vstart;
+
+	/* cache the first kmap pte */
+	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
+}
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 03bd025..4224256 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/bootmem.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -296,19 +297,13 @@ void __init bootmem_init(void)
 
 void __init zones_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-	int i;
-
 	/* All pages are DMA-able, so we put them all in the DMA zone. */
-
-	zones_size[ZONE_DMA] = max_low_pfn - ARCH_PFN_OFFSET;
-	for (i = 1; i < MAX_NR_ZONES; i++)
-		zones_size[i] = 0;
-
+	unsigned long zones_size[MAX_NR_ZONES] = {
+		[ZONE_DMA] = max_low_pfn - ARCH_PFN_OFFSET,
 #ifdef CONFIG_HIGHMEM
-	zones_size[ZONE_HIGHMEM] = max_pfn - max_low_pfn;
+		[ZONE_HIGHMEM] = max_pfn - max_low_pfn,
 #endif
-
+	};
 	free_area_init_node(0, zones_size, ARCH_PFN_OFFSET, NULL);
 }
 
@@ -318,16 +313,38 @@ void __init zones_init(void)
 
 void __init mem_init(void)
 {
-	max_mapnr = max_low_pfn - ARCH_PFN_OFFSET;
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 #ifdef CONFIG_HIGHMEM
-#error HIGHGMEM not implemented in init.c
+	unsigned long tmp;
+
+	reset_all_zones_managed_pages();
+	for (tmp = max_low_pfn; tmp < max_pfn; tmp++)
+		free_highmem_page(pfn_to_page(tmp));
 #endif
 
+	max_mapnr = max_pfn - ARCH_PFN_OFFSET;
+	high_memory = (void *)__va(max_low_pfn << PAGE_SHIFT);
+
 	free_all_bootmem();
 
 	mem_init_print_info(NULL);
+	pr_info("virtual kernel memory layout:\n"
+#ifdef CONFIG_HIGHMEM
+		"    pkmap   : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+		"    fixmap  : 0x%08lx - 0x%08lx  (%5lu kB)\n"
+#endif
+		"    vmalloc : 0x%08x - 0x%08x  (%5u MB)\n"
+		"    lowmem  : 0x%08x - 0x%08lx  (%5lu MB)\n",
+#ifdef CONFIG_HIGHMEM
+		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
+		(LAST_PKMAP*PAGE_SIZE) >> 10,
+		FIXADDR_START, FIXADDR_TOP,
+		(FIXADDR_TOP - FIXADDR_START) >> 10,
+#endif
+		VMALLOC_START, VMALLOC_END,
+		(VMALLOC_END - VMALLOC_START) >> 20,
+		PAGE_OFFSET, PAGE_OFFSET +
+		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
+		((max_low_pfn - min_low_pfn) * PAGE_SIZE) >> 20);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 861203e..3429b48 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -3,6 +3,7 @@
  *
  * Extracted from init.c
  */
+#include <linux/bootmem.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -16,9 +17,44 @@
 #include <asm/initialize_mmu.h>
 #include <asm/io.h>
 
+#if defined(CONFIG_HIGHMEM)
+static void * __init init_pmd(unsigned long vaddr)
+{
+	pgd_t *pgd = pgd_offset_k(vaddr);
+	pmd_t *pmd = pmd_offset(pgd, vaddr);
+
+	if (pmd_none(*pmd)) {
+		unsigned i;
+		pte_t *pte = alloc_bootmem_low_pages(PAGE_SIZE);
+
+		for (i = 0; i < 1024; i++)
+			pte_clear(NULL, 0, pte + i);
+
+		set_pmd(pmd, __pmd(((unsigned long)pte) & PAGE_MASK));
+		BUG_ON(pte != pte_offset_kernel(pmd, 0));
+		pr_debug("%s: vaddr: 0x%08lx, pmd: 0x%p, pte: 0x%p\n",
+			 __func__, vaddr, pmd, pte);
+		return pte;
+	} else {
+		return pte_offset_kernel(pmd, 0);
+	}
+}
+
+static void __init fixedrange_init(void)
+{
+	BUILD_BUG_ON(FIXADDR_SIZE > PMD_SIZE);
+	init_pmd(__fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK);
+}
+#endif
+
 void __init paging_init(void)
 {
 	memset(swapper_pg_dir, 0, PAGE_SIZE);
+#ifdef CONFIG_HIGHMEM
+	fixedrange_init();
+	pkmap_page_table = init_pmd(PKMAP_BASE);
+	kmap_init();
+#endif
 }
 
 /*
-- 
1.8.1.4
