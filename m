From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 05/28] lkl: memory handling
Date: Tue,  3 Nov 2015 22:20:36 +0200
Message-ID: <1446582059-17355-6-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38789 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbbKCUXI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Nov 2015 15:23:08 -0500
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>

LKL is a non MMU architecture and hence there is not much work left to
do other than initializing the boot allocator and providing the page
and page table definitions.

The backstore memory is allocated via a host operation and the memory
size to be used is specified when the kernel is started, in the
lkl_start_kernel call.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/page.h    | 13 ++++++++
 arch/lkl/include/asm/pgtable.h | 60 +++++++++++++++++++++++++++++++++++++
 arch/lkl/kernel/mem.c          | 67 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 arch/lkl/include/asm/page.h
 create mode 100644 arch/lkl/include/asm/pgtable.h
 create mode 100644 arch/lkl/kernel/mem.c

diff --git a/arch/lkl/include/asm/page.h b/arch/lkl/include/asm/page.h
new file mode 100644
index 0000000..455bf62
--- /dev/null
+++ b/arch/lkl/include/asm/page.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_LKL_PAGE_H
+#define _ASM_LKL_PAGE_H
+
+#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
+
+#ifndef __ASSEMBLY__
+void free_mem(void);
+void bootmem_init(int mem_size);
+#endif
+
+#include <asm-generic/page.h>
+
+#endif /* _ASM_LKL_PAGE_H */
diff --git a/arch/lkl/include/asm/pgtable.h b/arch/lkl/include/asm/pgtable.h
new file mode 100644
index 0000000..726675a
--- /dev/null
+++ b/arch/lkl/include/asm/pgtable.h
@@ -0,0 +1,60 @@
+#ifndef _LKL_PGTABLE_H
+#define _LKL_PGTABLE_H
+
+#include <asm-generic/4level-fixup.h>
+
+/*
+ * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
+ */
+
+#include <linux/slab.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+
+#define pgd_present(pgd)	(1)
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_clear(pgdp)
+#define kern_addr_valid(addr)	(1)
+#define	pmd_offset(a, b)	((void *)0)
+
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_SHARED		__pgprot(0)
+#define PAGE_COPY		__pgprot(0)
+#define PAGE_READONLY		__pgprot(0)
+#define PAGE_KERNEL		__pgprot(0)
+
+void paging_init(void);
+#define swapper_pg_dir		((pgd_t *)0)
+
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+#define ZERO_PAGE(vaddr)	(virt_to_page(0))
+
+/*
+ * No page table caches to initialise.
+ */
+#define pgtable_cache_init()	do { } while (0)
+
+/*
+ * All 32bit addresses are effectively valid for vmalloc...
+ * Sort of meaningless for non-VM targets.
+ */
+#define	VMALLOC_START		0
+#define	VMALLOC_END		0xffffffff
+#define	KMAP_START		0
+#define	KMAP_END		0xffffffff
+
+#include <asm-generic/pgtable.h>
+
+#define check_pgt_cache()	do { } while (0)
+
+#endif
diff --git a/arch/lkl/kernel/mem.c b/arch/lkl/kernel/mem.c
new file mode 100644
index 0000000..225c2cc
--- /dev/null
+++ b/arch/lkl/kernel/mem.c
@@ -0,0 +1,67 @@
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+
+unsigned long memory_start, memory_end;
+static unsigned long _memory_start, mem_size;
+
+void __init bootmem_init(int mem_size)
+{
+	int bootmap_size;
+
+	_memory_start = (unsigned long)lkl_ops->mem_alloc(mem_size);
+	memory_start = _memory_start;
+	BUG_ON(!memory_start);
+	memory_end = memory_start + mem_size;
+
+	if (PAGE_ALIGN(memory_start) != memory_start) {
+		mem_size -= PAGE_ALIGN(memory_start) - memory_start;
+		memory_start = PAGE_ALIGN(memory_start);
+		mem_size = (mem_size / PAGE_SIZE) * PAGE_SIZE;
+	}
+
+	/*
+	 * Give all the memory to the bootmap allocator, tell it to put the
+	 * boot mem_map at the start of memory.
+	 */
+	max_low_pfn = virt_to_pfn(memory_end);
+	min_low_pfn = virt_to_pfn(memory_start);
+	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, min_low_pfn,
+					 max_low_pfn);
+
+	/*
+	 * Free the usable memory, we have to make sure we do not free
+	 * the bootmem bitmap so we then reserve it after freeing it :-)
+	 */
+	free_bootmem(memory_start, mem_size);
+	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
+
+	{
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+		zones_size[ZONE_NORMAL] = (mem_size) >> PAGE_SHIFT;
+		free_area_init(zones_size);
+	}
+}
+
+void __init mem_init(void)
+{
+	max_mapnr = (((unsigned long)high_memory) - PAGE_OFFSET) >> PAGE_SHIFT;
+	/* this will put all memory onto the freelists */
+	totalram_pages = free_all_bootmem();
+	pr_info("Memory available: %luk/%luk RAM\n",
+		(nr_free_pages() << PAGE_SHIFT) >> 10, mem_size >> 10);
+}
+
+/*
+ * In our case __init memory is not part of the page allocator so there is
+ * nothing to free.
+ */
+void free_initmem(void)
+{
+}
+
+void free_mem(void)
+{
+	lkl_ops->mem_free((void *)_memory_start);
+}
-- 
2.1.0
