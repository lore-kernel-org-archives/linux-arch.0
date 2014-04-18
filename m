Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0103.outbound.protection.outlook.com ([207.46.100.103]:56236
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752808AbaDRMm7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 08:42:59 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 11/28] nios2: Cache handling
Date: Fri, 18 Apr 2014 20:26:55 +0800
Message-ID: <1397824031-4892-9-git-send-email-lftan@altera.com>
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140418122655.ADN-qv-ykR_4EvobCCWpsTWxipmnlMp9EeJIU8cJDn4@z>

This patch adds functionality required for cache maintenance.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/include/asm/cache.h      |  36 +++++
 arch/nios2/include/asm/cacheflush.h |  48 +++++++
 arch/nios2/mm/cacheflush.c          | 255 ++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 arch/nios2/include/asm/cache.h
 create mode 100644 arch/nios2/include/asm/cacheflush.h
 create mode 100644 arch/nios2/mm/cacheflush.c

diff --git a/arch/nios2/include/asm/cache.h b/arch/nios2/include/asm/cache.h
new file mode 100644
index 0000000..2293cf57e307a6b84e3972c2d27221dda54af500
--- /dev/null
+++ b/arch/nios2/include/asm/cache.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2004 Microtronix Datacom Ltd.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#ifndef _ASM_NIOS2_CACHE_H
+#define _ASM_NIOS2_CACHE_H
+
+#define NIOS2_DCACHE_SIZE	CONFIG_NIOS2_DCACHE_SIZE
+#define NIOS2_ICACHE_SIZE	CONFIG_NIOS2_ICACHE_SIZE
+#define NIOS2_DCACHE_LINE_SIZE	CONFIG_NIOS2_DCACHE_LINE_SIZE
+#define NIOS2_ICACHE_LINE_SHIFT	5
+#define NIOS2_ICACHE_LINE_SIZE	(1 << NIOS2_ICACHE_LINE_SHIFT)
+
+/* bytes per L1 cache line */
+#define L1_CACHE_SHIFT		NIOS2_ICACHE_LINE_SHIFT
+#define L1_CACHE_BYTES		NIOS2_ICACHE_LINE_SIZE
+
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+
+#define __cacheline_aligned
+#define ____cacheline_aligned
+
+#endif
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
new file mode 100644
index 0000000..ce2605a8c44de7e33686f9021b2b6736e94455a2
--- /dev/null
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2003 Microtronix Datacom Ltd.
+ * Copyright (C) 2000-2002 Greg Ungerer <gerg@snapgear.com>
+ *
+ * Ported from m68knommu.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_NIOS2_CACHEFLUSH_H
+#define _ASM_NIOS2_CACHEFLUSH_H
+
+#include <linux/mm_types.h>
+
+struct mm_struct;
+
+extern void flush_cache_all(void);
+extern void flush_cache_mm(struct mm_struct *mm);
+extern void flush_cache_dup_mm(struct mm_struct *mm);
+extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+	unsigned long end);
+extern void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
+	unsigned long pfn);
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+extern void flush_dcache_page(struct page *page);
+
+extern void flush_icache_range(unsigned long start, unsigned long end);
+extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+
+#define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
+#define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
+
+extern void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+				unsigned long user_vaddr,
+				void *dst, void *src, int len);
+extern void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
+				unsigned long user_vaddr,
+				void *dst, void *src, int len);
+
+extern void flush_dcache_range(unsigned long start, unsigned long end);
+extern void invalidate_dcache_range(unsigned long start, unsigned long end);
+
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
+#endif /* _ASM_NIOS2_CACHEFLUSH_H */
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
new file mode 100644
index 0000000..0c4d0d416f8f603f92b66017d100d3388f3d04c1
--- /dev/null
+++ b/arch/nios2/mm/cacheflush.c
@@ -0,0 +1,255 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009, Wind River Systems Inc
+ * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
+ */
+
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cpuinfo.h>
+
+static void __flush_dcache(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	start &= ~(cpuinfo.dcache_line_size - 1);
+	end += (cpuinfo.dcache_line_size - 1);
+	end &= ~(cpuinfo.dcache_line_size - 1);
+
+	if (end > start + cpuinfo.dcache_size)
+		end = start + cpuinfo.dcache_size;
+
+	for (addr = start; addr < end; addr += cpuinfo.dcache_line_size) {
+		__asm__ __volatile__ ("   flushda 0(%0)\n"
+					: /* Outputs */
+					: /* Inputs  */ "r"(addr)
+					/* : No clobber */);
+	}
+}
+
+static void __flush_dcache_all(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	start &= ~(cpuinfo.dcache_line_size - 1);
+	end += (cpuinfo.dcache_line_size - 1);
+	end &= ~(cpuinfo.dcache_line_size - 1);
+
+	if (end > start + cpuinfo.dcache_size)
+		end = start + cpuinfo.dcache_size;
+
+	for (addr = start; addr < end; addr += cpuinfo.dcache_line_size) {
+		__asm__ __volatile__ ("   flushd 0(%0)\n"
+					: /* Outputs */
+					: /* Inputs  */ "r"(addr)
+					/* : No clobber */);
+	}
+}
+
+static void __invalidate_dcache(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	start &= ~(cpuinfo.dcache_line_size - 1);
+	end += (cpuinfo.dcache_line_size - 1);
+	end &= ~(cpuinfo.dcache_line_size - 1);
+
+	if (end > start + cpuinfo.dcache_size)
+		end = start + cpuinfo.dcache_size;
+
+	for (addr = start; addr < end; addr += cpuinfo.dcache_line_size) {
+		__asm__ __volatile__ ("   initda 0(%0)\n"
+					: /* Outputs */
+					: /* Inputs  */ "r"(addr)
+					/* : No clobber */);
+	}
+}
+
+static void __flush_icache(unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	start &= ~(cpuinfo.icache_line_size - 1);
+	end += (cpuinfo.icache_line_size - 1);
+	end &= ~(cpuinfo.icache_line_size - 1);
+
+	if (end > start + cpuinfo.icache_size)
+		end = start + cpuinfo.icache_size;
+
+	for (addr = start; addr < end; addr += cpuinfo.icache_line_size) {
+		__asm__ __volatile__ ("   flushi %0\n"
+					: /* Outputs */
+					: /* Inputs  */ "r"(addr)
+					/* : No clobber */);
+	}
+	__asm__ __volatile(" flushp\n");
+}
+
+static void flush_aliases(struct address_space *mapping, struct page *page)
+{
+	struct mm_struct *mm = current->active_mm;
+	struct vm_area_struct *mpnt;
+	pgoff_t pgoff;
+
+	pgoff = page->index;
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
+		unsigned long offset;
+
+		if (mpnt->vm_mm != mm)
+			continue;
+		if (!(mpnt->vm_flags & VM_MAYSHARE))
+			continue;
+
+		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+		flush_cache_page(mpnt, mpnt->vm_start + offset,
+			page_to_pfn(page));
+	}
+	flush_dcache_mmap_unlock(mapping);
+}
+
+void flush_cache_all(void)
+{
+	__flush_dcache_all(0, cpuinfo.dcache_size);
+	__flush_icache(0, cpuinfo.icache_size);
+}
+
+void flush_cache_mm(struct mm_struct *mm)
+{
+	flush_cache_all();
+}
+
+void flush_cache_dup_mm(struct mm_struct *mm)
+{
+	flush_cache_all();
+}
+
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	__flush_icache(start, end);
+}
+
+void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	__flush_dcache(start, end);
+}
+EXPORT_SYMBOL(flush_dcache_range);
+
+void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	__invalidate_dcache(start, end);
+}
+EXPORT_SYMBOL(invalidate_dcache_range);
+
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end)
+{
+	__flush_dcache(start, end);
+	if (vma == NULL || (vma->vm_flags & VM_EXEC))
+		__flush_icache(start, end);
+}
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long start = (unsigned long) page_address(page);
+	unsigned long end = start + PAGE_SIZE;
+
+	__flush_icache(start, end);
+}
+
+void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
+			unsigned long pfn)
+{
+	unsigned long start = vmaddr;
+	unsigned long end = start + PAGE_SIZE;
+
+	__flush_dcache(start, end);
+	if (vma->vm_flags & VM_EXEC)
+		__flush_icache(start, end);
+}
+
+void flush_dcache_page(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	/* Flush this page if there are aliases. */
+	if (mapping) {
+		if (!mapping_mapped(mapping)) {
+			clear_bit(PG_arch_1, &page->flags);
+		} else if (mapping) {
+			unsigned long start = (unsigned long)page_address(page);
+			__flush_dcache(start, start + PAGE_SIZE);
+			flush_aliases(mapping,  page);
+		}
+	}
+}
+EXPORT_SYMBOL(flush_dcache_page);
+
+void update_mmu_cache(struct vm_area_struct *vma,
+		      unsigned long address, pte_t *pte)
+{
+	unsigned long pfn = pte_pfn(*pte);
+	struct page *page;
+
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+
+	if (!PageReserved(page) && !test_bit(PG_arch_1, &page->flags)) {
+		unsigned long start = page_to_virt(page);
+		struct address_space *mapping;
+
+		__flush_dcache(start, start + PAGE_SIZE);
+
+		mapping = page_mapping(page);
+		if (mapping)
+			flush_aliases(mapping, page);
+		set_bit(PG_arch_1, &page->flags);
+	}
+}
+
+void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+		    struct page *to)
+{
+	__flush_dcache(vaddr, vaddr + PAGE_SIZE);
+	copy_page(vto, vfrom);
+	__flush_dcache((unsigned long)vto, (unsigned long)vto + PAGE_SIZE);
+}
+
+void clear_user_page(void *addr, unsigned long vaddr, struct page *page)
+{
+	__flush_dcache(vaddr, vaddr + PAGE_SIZE);
+	clear_page(addr);
+	__flush_dcache((unsigned long)addr, (unsigned long)addr + PAGE_SIZE);
+}
+
+void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
+			unsigned long user_vaddr,
+			void *dst, void *src, int len)
+{
+	flush_cache_page(vma, user_vaddr, page_to_pfn(page));
+	memcpy(dst, src, len);
+	__flush_dcache((unsigned long)src, (unsigned long)src + len);
+	if (vma->vm_flags & VM_EXEC)
+		__flush_icache((unsigned long)src, (unsigned long)src + len);
+}
+
+void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+			unsigned long user_vaddr,
+			void *dst, void *src, int len)
+{
+	flush_cache_page(vma, user_vaddr, page_to_pfn(page));
+	memcpy(dst, src, len);
+	__flush_dcache((unsigned long)dst, (unsigned long)dst + len);
+	if (vma->vm_flags & VM_EXEC)
+		__flush_icache((unsigned long)dst, (unsigned long)dst + len);
+}
-- 
1.8.3.2

