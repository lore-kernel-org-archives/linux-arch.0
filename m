From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 06/30] csky: Cache and TLB routines
Date: Mon, 24 Sep 2018 22:36:22 +0800
Message-ID: <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
References: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1537789737.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds cache and tlb sync codes for abiv1 & abiv2.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/cacheflush.c          |  51 ++++++++
 arch/csky/abiv1/inc/abi/cacheflush.h  |  43 +++++++
 arch/csky/abiv1/inc/abi/tlb.h         |  12 ++
 arch/csky/abiv2/cacheflush.c          |  59 ++++++++++
 arch/csky/abiv2/inc/abi/cacheflush.h  |  40 +++++++
 arch/csky/abiv2/inc/abi/tlb.h         |  13 ++
 arch/csky/include/asm/barrier.h       |  45 +++++++
 arch/csky/include/asm/cache.h         |  28 +++++
 arch/csky/include/asm/cacheflush.h    |   9 ++
 arch/csky/include/asm/io.h            |  24 ++++
 arch/csky/include/asm/tlb.h           |  20 ++++
 arch/csky/include/asm/tlbflush.h      |  23 ++++
 arch/csky/include/uapi/asm/cachectl.h |  14 +++
 arch/csky/mm/cachev1.c                | 127 ++++++++++++++++++++
 arch/csky/mm/cachev2.c                |  80 +++++++++++++
 arch/csky/mm/syscache.c               |  29 +++++
 arch/csky/mm/tlb.c                    | 215 ++++++++++++++++++++++++++++++++++
 17 files changed, 832 insertions(+)
 create mode 100644 arch/csky/abiv1/cacheflush.c
 create mode 100644 arch/csky/abiv1/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv1/inc/abi/tlb.h
 create mode 100644 arch/csky/abiv2/cacheflush.c
 create mode 100644 arch/csky/abiv2/inc/abi/cacheflush.h
 create mode 100644 arch/csky/abiv2/inc/abi/tlb.h
 create mode 100644 arch/csky/include/asm/barrier.h
 create mode 100644 arch/csky/include/asm/cache.h
 create mode 100644 arch/csky/include/asm/cacheflush.h
 create mode 100644 arch/csky/include/asm/io.h
 create mode 100644 arch/csky/include/asm/tlb.h
 create mode 100644 arch/csky/include/asm/tlbflush.h
 create mode 100644 arch/csky/include/uapi/asm/cachectl.h
 create mode 100644 arch/csky/mm/cachev1.c
 create mode 100644 arch/csky/mm/cachev2.c
 create mode 100644 arch/csky/mm/syscache.c
 create mode 100644 arch/csky/mm/tlb.c

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
new file mode 100644
index 0000000..e6650c3
--- /dev/null
+++ b/arch/csky/abiv1/cacheflush.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/syscalls.h>
+#include <linux/spinlock.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+#include <asm/cacheflush.h>
+#include <asm/cachectl.h>
+
+void flush_dcache_page(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+	unsigned long addr;
+
+	if (mapping && !mapping_mapped(mapping)) {
+		set_bit(PG_arch_1, &(page)->flags);
+		return;
+	}
+
+	/*
+	 * We could delay the flush for the !page_mapping case too.  But that
+	 * case is for exec env/arg pages and those are %99 certainly going to
+	 * get faulted into the tlb (and thus flushed) anyways.
+	 */
+	addr = (unsigned long) page_address(page);
+	dcache_wb_range(addr, addr + PAGE_SIZE);
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *pte)
+{
+	unsigned long addr;
+	struct page *page;
+	unsigned long pfn;
+
+	pfn = pte_pfn(*pte);
+	if (unlikely(!pfn_valid(pfn)))
+		return;
+
+	page = pfn_to_page(pfn);
+	addr = (unsigned long) page_address(page);
+
+	if (vma->vm_flags & VM_EXEC ||
+	    pages_do_alias(addr, address & PAGE_MASK))
+		cache_wbinv_all();
+
+	clear_bit(PG_arch_1, &(page)->flags);
+}
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
new file mode 100644
index 0000000..f0de49c
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_CACHEFLUSH_H
+#define __ABI_CSKY_CACHEFLUSH_H
+
+#include <linux/compiler.h>
+#include <asm/string.h>
+#include <asm/cache.h>
+
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+extern void flush_dcache_page(struct page *);
+
+#define flush_cache_mm(mm)		cache_wbinv_all()
+#define flush_cache_page(vma,page,pfn)	cache_wbinv_all()
+#define flush_cache_dup_mm(mm)		cache_wbinv_all()
+
+#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
+#define flush_cache_vmap(start, end)	cache_wbinv_range(start, end)
+#define flush_cache_vunmap(start, end)  cache_wbinv_range(start, end)
+
+#define flush_icache_page(vma, page)	cache_wbinv_all()
+#define flush_icache_range(start, end)	cache_wbinv_range(start, end)
+#define flush_icache_user_range(vma,pg,adr,len)	cache_wbinv_range(adr, adr + len)
+
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+do { \
+	cache_wbinv_all(); \
+	memcpy(dst, src, len); \
+	cache_wbinv_all(); \
+} while(0)
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+do { \
+	cache_wbinv_all(); \
+	memcpy(dst, src, len); \
+	cache_wbinv_all(); \
+} while(0)
+
+#define flush_dcache_mmap_lock(mapping)		do{}while(0)
+#define flush_dcache_mmap_unlock(mapping)	do{}while(0)
+
+#endif /* __ABI_CSKY_CACHEFLUSH_H */
diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
new file mode 100644
index 0000000..6d461f3
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/tlb.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_TLB_H
+#define __ABI_CSKY_TLB_H
+
+#define tlb_start_vma(tlb, vma) \
+	do { \
+		if (!tlb->fullmm) \
+			cache_wbinv_all(); \
+	}  while (0)
+#endif /* __ABI_CSKY_TLB_H */
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
new file mode 100644
index 0000000..8cd3e17
--- /dev/null
+++ b/arch/csky/abiv2/cacheflush.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/cache.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <asm/cache.h>
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long start;
+
+	start = (unsigned long) kmap_atomic(page);
+
+	cache_wbinv_range(start, start + PAGE_SIZE);
+
+	kunmap_atomic((void *)start);
+}
+
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long vaddr, int len)
+{
+	unsigned long kaddr;
+
+	kaddr = (unsigned long) kmap_atomic(page) + (vaddr & ~PAGE_MASK);
+
+	cache_wbinv_range(kaddr, kaddr + len);
+
+	kunmap_atomic((void *)kaddr);
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *pte)
+{
+	unsigned long addr, pfn;
+	struct page *page;
+	void *va;
+
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+
+	pfn = pte_pfn(*pte);
+	if (unlikely(!pfn_valid(pfn)))
+		return;
+
+	page = pfn_to_page(pfn);
+	if (page == ZERO_PAGE(0))
+		return;
+
+	va = page_address(page);
+	addr = (unsigned long) va;
+
+	if (va == NULL && PageHighMem(page))
+		addr = (unsigned long) kmap_atomic(page);
+
+	cache_wbinv_range(addr, addr + PAGE_SIZE);
+
+	if (va == NULL && PageHighMem(page))
+		kunmap_atomic((void *) addr);
+}
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
new file mode 100644
index 0000000..756beb7
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ABI_CSKY_CACHEFLUSH_H
+#define __ABI_CSKY_CACHEFLUSH_H
+
+/* Keep includes the same across arches.  */
+#include <linux/mm.h>
+
+/*
+ * The cache doesn't need to be flushed when TLB entries change when
+ * the cache is mapped to physical memory, not virtual memory
+ */
+#define flush_cache_all()			do { } while (0)
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+#define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
+#define flush_icache_range(start, end)		cache_wbinv_range(start, end)
+
+void flush_icache_page(struct vm_area_struct *vma, struct page *page);
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long vaddr, int len);
+
+#define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		do { } while (0)
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+	do { \
+		memcpy(dst, src, len); \
+		cache_wbinv_range((unsigned long)dst, (unsigned long)dst + len); \
+	} while (0)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy(dst, src, len)
+
+#endif /* __ABI_CSKY_CACHEFLUSH_H */
diff --git a/arch/csky/abiv2/inc/abi/tlb.h b/arch/csky/abiv2/inc/abi/tlb.h
new file mode 100644
index 0000000..1fb7c8d
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/tlb.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_TLB_H
+#define __ABI_CSKY_TLB_H
+
+#define tlb_start_vma(tlb, vma) \
+	do { \
+		if (!tlb->fullmm && (vma->vm_flags & VM_EXEC)) \
+			icache_inv_all(); \
+	}  while (0)
+
+#endif /* __ABI_CSKY_TLB_H */
diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
new file mode 100644
index 0000000..ecf4a02
--- /dev/null
+++ b/arch/csky/include/asm/barrier.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_BARRIER_H
+#define __ASM_CSKY_BARRIER_H
+
+#ifndef __ASSEMBLY__
+
+#define nop()	asm volatile ("nop")
+
+/*
+ * sync:        completion barrier
+ * sync.s:      completion barrier and shareable to other cores
+ * sync.i:      completion barrier with flush cpu pipeline
+ * sync.is:     completion barrier with flush cpu pipeline and shareable to other cores
+ *
+ * bar.brwarw:  ordering barrier for all load/store instructions before it
+ * bar.brwarws: ordering barrier for all load/store instructions before it and shareable to other cores
+ * bar.brar:    ordering barrier for all load       instructions before it
+ * bar.brars:   ordering barrier for all load       instructions before it and shareable to other cores
+ * bar.bwaw:    ordering barrier for all store      instructions before it
+ * bar.bwaws:   ordering barrier for all store      instructions before it and shareable to other cores
+ */
+
+#ifdef CONFIG_CPU_HAS_CACHEV2
+#define mb()		asm volatile ("bar.brwarw":::"memory")
+#define rmb()		asm volatile ("bar.brar":::"memory")
+#define wmb()		asm volatile ("bar.bwaw":::"memory")
+
+#ifdef CONFIG_SMP
+#define __smp_mb()	asm volatile ("bar.brwarws":::"memory")
+#define __smp_rmb()	asm volatile ("bar.brars":::"memory")
+#define __smp_wmb()	asm volatile ("bar.bwaws":::"memory")
+#endif /* CONFIG_SMP */
+
+#define sync_is()	asm volatile ("sync.is":::"memory")
+
+#else /* !CONFIG_CPU_HAS_CACHEV2 */
+#define mb()		asm volatile ("sync":::"memory")
+#endif
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_CSKY_BARRIER_H */
diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
new file mode 100644
index 0000000..9bb3cca
--- /dev/null
+++ b/arch/csky/include/asm/cache.h
@@ -0,0 +1,28 @@
+#ifndef __ASM_CSKY_CACHE_H
+#define __ASM_CSKY_CACHE_H
+
+/* bytes per L1 cache line */
+#define L1_CACHE_SHIFT	CONFIG_L1_CACHE_SHIFT
+
+#define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
+
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+
+#ifndef __ASSEMBLY__
+
+void dcache_wb_line(unsigned long start);
+
+void icache_inv_range(unsigned long start, unsigned long end);
+void icache_inv_all(void);
+
+void dcache_wb_range(unsigned long start, unsigned long end);
+void dcache_wbinv_all(void);
+
+void cache_wbinv_range(unsigned long start, unsigned long end);
+void cache_wbinv_all(void);
+
+void dma_wbinv_range(unsigned long start, unsigned long end);
+void dma_wb_range(unsigned long start, unsigned long end);
+
+#endif
+#endif  /* __ASM_CSKY_CACHE_H */
diff --git a/arch/csky/include/asm/cacheflush.h b/arch/csky/include/asm/cacheflush.h
new file mode 100644
index 0000000..994432e
--- /dev/null
+++ b/arch/csky/include/asm/cacheflush.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_CACHEFLUSH_H
+#define __ASM_CSKY_CACHEFLUSH_H
+
+#include <abi/cacheflush.h>
+
+#endif /* __ASM_CSKY_CACHEFLUSH_H */
diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
new file mode 100644
index 0000000..545cfad
--- /dev/null
+++ b/arch/csky/include/asm/io.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_IO_H
+#define __ASM_CSKY_IO_H
+
+#include <abi/pgtable-bits.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+extern void __iomem *ioremap(phys_addr_t offset, size_t size);
+
+extern void iounmap(void *addr);
+
+extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
+		size_t size, unsigned long flags);
+
+#define ioremap_nocache(phy, sz)	ioremap(phy, sz)
+#define ioremap_wc ioremap_nocache
+#define ioremap_wt ioremap_nocache
+
+#include <asm-generic/io.h>
+
+#endif /* __ASM_CSKY_IO_H */
diff --git a/arch/csky/include/asm/tlb.h b/arch/csky/include/asm/tlb.h
new file mode 100644
index 0000000..127a493
--- /dev/null
+++ b/arch/csky/include/asm/tlb.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_TLB_H
+#define __ASM_CSKY_TLB_H
+
+#include <asm/cacheflush.h>
+#include <abi/tlb.h>
+
+#define tlb_end_vma(tlb, vma) \
+	do { \
+		if (!tlb->fullmm) \
+			flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
+	}  while (0)
+
+#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
+
+#include <asm-generic/tlb.h>
+
+#endif /* __ASM_CSKY_TLB_H */
diff --git a/arch/csky/include/asm/tlbflush.h b/arch/csky/include/asm/tlbflush.h
new file mode 100644
index 0000000..cc6bd57
--- /dev/null
+++ b/arch/csky/include/asm/tlbflush.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_TLBFLUSH_H
+#define __ASM_TLBFLUSH_H
+/*
+ * TLB flushing:
+ *
+ *  - flush_tlb_all() flushes all processes TLB entries
+ *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
+ *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
+ */
+extern void flush_tlb_all(void);
+extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+
+extern void flush_tlb_one(unsigned long vaddr);
+
+#endif
diff --git a/arch/csky/include/uapi/asm/cachectl.h b/arch/csky/include/uapi/asm/cachectl.h
new file mode 100644
index 0000000..242e5bd
--- /dev/null
+++ b/arch/csky/include/uapi/asm/cachectl.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_CACHECTL_H
+#define __ASM_CSKY_CACHECTL_H
+
+/*
+ * See "man cacheflush"
+ */
+#define ICACHE  (1<<0)
+#define DCACHE  (1<<1)
+#define BCACHE  (ICACHE|DCACHE)
+
+#endif /* __ASM_CSKY_CACHECTL_H */
diff --git a/arch/csky/mm/cachev1.c b/arch/csky/mm/cachev1.c
new file mode 100644
index 0000000..39d0267
--- /dev/null
+++ b/arch/csky/mm/cachev1.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/spinlock.h>
+#include <asm/cache.h>
+#include <abi/reg_ops.h>
+
+/* for L1-cache */
+#define INS_CACHE		(1 << 0)
+#define DATA_CACHE		(1 << 1)
+#define CACHE_INV		(1 << 4)
+#define CACHE_CLR		(1 << 5)
+#define CACHE_OMS		(1 << 6)
+#define CACHE_ITS		(1 << 7)
+#define CACHE_LICF		(1 << 31)
+
+/* for L2-cache */
+#define CR22_LEVEL_SHIFT	(1)
+#define CR22_SET_SHIFT		(7)
+#define CR22_WAY_SHIFT		(30)
+#define CR22_WAY_SHIFT_L2	(29)
+
+#define SYNC asm volatile("sync\n")
+
+static DEFINE_SPINLOCK(cache_lock);
+
+static inline void cache_op_line(unsigned long i, unsigned int val)
+{
+	mtcr("cr22", i);
+	mtcr("cr17", val);
+}
+
+#define CCR2_L2E (1 << 3)
+static void cache_op_all(unsigned int value, unsigned int l2)
+{
+	mtcr("cr17", value | CACHE_CLR);
+	SYNC;
+
+	if (l2 && (mfcr_ccr2() & CCR2_L2E)) {
+		mtcr("cr24", value | CACHE_CLR);
+		SYNC;
+	}
+}
+
+static void cache_op_range(
+	unsigned int start,
+	unsigned int end,
+	unsigned int value,
+	unsigned int l2)
+{
+	unsigned long i, flags;
+	unsigned int val = value | CACHE_CLR | CACHE_OMS;
+	bool l2_sync;
+
+	if (unlikely((end - start) >= PAGE_SIZE) ||
+	    unlikely(start < PAGE_OFFSET) ||
+	    unlikely(start >= PAGE_OFFSET + LOWMEM_LIMIT)) {
+		cache_op_all(value, l2);
+		return;
+	}
+
+	if ((mfcr_ccr2() & CCR2_L2E) && l2)
+		l2_sync = 1;
+	else
+		l2_sync = 0;
+
+	spin_lock_irqsave(&cache_lock, flags);
+
+	i = start & ~(L1_CACHE_BYTES - 1);
+	for(; i < end; i += L1_CACHE_BYTES) {
+		cache_op_line(i, val);
+		if (l2_sync) {
+			SYNC;
+			mtcr("cr24", val);
+		}
+	}
+	spin_unlock_irqrestore(&cache_lock, flags);
+
+	SYNC;
+}
+
+void dcache_wb_line(unsigned long start)
+{
+	asm volatile("idly4\n":::"memory");
+	cache_op_line(start, DATA_CACHE|CACHE_CLR);
+	SYNC;
+}
+
+void icache_inv_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, INS_CACHE|CACHE_INV, 0);
+}
+
+void icache_inv_all(void)
+{
+	cache_op_all(INS_CACHE|CACHE_INV, 0);
+}
+
+void dcache_wb_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, DATA_CACHE|CACHE_CLR, 0);
+}
+
+void dcache_wbinv_all(void)
+{
+	cache_op_all(DATA_CACHE|CACHE_CLR|CACHE_INV, 0);
+}
+
+void cache_wbinv_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, INS_CACHE|DATA_CACHE|CACHE_CLR|CACHE_INV, 0);
+}
+
+void cache_wbinv_all(void)
+{
+	cache_op_all(INS_CACHE|DATA_CACHE|CACHE_CLR|CACHE_INV, 0);
+}
+
+void dma_wbinv_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, DATA_CACHE|CACHE_CLR|CACHE_INV, 1);
+}
+
+void dma_wb_range(unsigned long start, unsigned long end)
+{
+	cache_op_range(start, end, DATA_CACHE|CACHE_INV, 1);
+}
diff --git a/arch/csky/mm/cachev2.c b/arch/csky/mm/cachev2.c
new file mode 100644
index 0000000..8e61f1c
--- /dev/null
+++ b/arch/csky/mm/cachev2.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <asm/cache.h>
+#include <asm/barrier.h>
+
+void inline dcache_wb_line(unsigned long start)
+{
+	asm volatile("dcache.cval1 %0\n"::"r"(start):"memory");
+	sync_is();
+}
+
+void icache_inv_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (;i < end; i += L1_CACHE_BYTES)
+		asm volatile("icache.iva %0\n"::"r"(i):"memory");
+	sync_is();
+}
+
+void icache_inv_all(void)
+{
+	asm volatile("icache.ialls\n":::"memory");
+	sync_is();
+}
+
+void dcache_wb_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (;i < end; i += L1_CACHE_BYTES)
+		asm volatile("dcache.cval1 %0\n"::"r"(i):"memory");
+	sync_is();
+}
+
+void dcache_inv_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (;i < end; i += L1_CACHE_BYTES)
+		asm volatile("dcache.civa %0\n"::"r"(i):"memory");
+	sync_is();
+}
+
+void cache_wbinv_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (;i < end; i += L1_CACHE_BYTES) {
+		asm volatile("dcache.cval1 %0\n"::"r"(i):"memory");
+	}
+	sync_is();
+
+	i = start & ~(L1_CACHE_BYTES - 1);
+	for (;i < end; i += L1_CACHE_BYTES) {
+		asm volatile("icache.iva %0\n"::"r"(i):"memory");
+	}
+	sync_is();
+}
+
+void dma_wbinv_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (; i < end; i += L1_CACHE_BYTES)
+		asm volatile("dcache.civa %0\n"::"r"(i):"memory");
+	sync_is();
+}
+
+void dma_wb_range(unsigned long start, unsigned long end)
+{
+	unsigned long i = start & ~(L1_CACHE_BYTES - 1);
+
+	for (; i < end; i += L1_CACHE_BYTES)
+		asm volatile("dcache.civa %0\n"::"r"(i):"memory");
+	sync_is();
+}
diff --git a/arch/csky/mm/syscache.c b/arch/csky/mm/syscache.c
new file mode 100644
index 0000000..3e1b7c6
--- /dev/null
+++ b/arch/csky/mm/syscache.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/syscalls.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+#include <asm/cachectl.h>
+
+SYSCALL_DEFINE3(cacheflush,
+		void __user *, addr,
+		unsigned long, bytes,
+		int, cache)
+{
+	switch(cache) {
+	case ICACHE:
+		icache_inv_range((unsigned long)addr, (unsigned long)addr + bytes);
+		break;
+	case DCACHE:
+		dcache_wb_range((unsigned long)addr, (unsigned long)addr + bytes);
+		break;
+	case BCACHE:
+		cache_wbinv_range((unsigned long)addr, (unsigned long)addr + bytes);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/arch/csky/mm/tlb.c b/arch/csky/mm/tlb.c
new file mode 100644
index 0000000..de5877a
--- /dev/null
+++ b/arch/csky/mm/tlb.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+#define CSKY_TLB_SIZE CONFIG_CPU_TLB_SIZE
+
+void flush_tlb_all(void)
+{
+	tlb_invalid_all();
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	int cpu = smp_processor_id();
+
+	if (cpu_context(cpu, mm) != 0)
+		drop_mmu_context(mm,cpu);
+
+	tlb_invalid_all();
+}
+
+#define restore_asid_inv_utlb(oldpid, newpid) \
+do { \
+	if((oldpid & ASID_MASK) == newpid) \
+		write_mmu_entryhi(oldpid +1); \
+	write_mmu_entryhi(oldpid); \
+} while(0)
+
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			   unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int cpu = smp_processor_id();
+
+	if (cpu_context(cpu, mm) != 0) {
+		unsigned long size, flags;
+		int newpid = cpu_asid(cpu, mm);
+
+		local_irq_save(flags);
+		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+		size = (size + 1) >> 1;
+		if (size <= CSKY_TLB_SIZE/2) {
+			start &= (PAGE_MASK << 1);
+			end += ((PAGE_SIZE << 1) - 1);
+			end &= (PAGE_MASK << 1);
+#ifdef CONFIG_CPU_HAS_TLBI
+			while (start < end) {
+				asm volatile("tlbi.vaas %0"::"r"(start | newpid));
+				start += (PAGE_SIZE << 1);
+			}
+			sync_is();
+#else
+			{
+			int oldpid = read_mmu_entryhi();
+
+			while (start < end) {
+				int idx;
+
+				write_mmu_entryhi(start | newpid);
+				start += (PAGE_SIZE << 1);
+				tlb_probe();
+				idx = read_mmu_index();
+				if (idx >= 0)
+					tlb_invalid_indexed();
+			}
+			restore_asid_inv_utlb(oldpid, newpid);
+			}
+#endif
+		} else {
+			drop_mmu_context(mm, cpu);
+		}
+		local_irq_restore(flags);
+	}
+}
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+        unsigned long size, flags;
+
+        local_irq_save(flags);
+        size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+        if (size <= CSKY_TLB_SIZE) {
+		start &= (PAGE_MASK << 1);
+		end += ((PAGE_SIZE << 1) - 1);
+		end &= (PAGE_MASK << 1);
+#ifdef CONFIG_CPU_HAS_TLBI
+		while (start < end) {
+			asm volatile("tlbi.vaas %0"::"r"(start));
+			start += (PAGE_SIZE << 1);
+		}
+		sync_is();
+#else
+		{
+                int oldpid = read_mmu_entryhi();
+                while (start < end) {
+                        int idx;
+                        write_mmu_entryhi(start);
+			start += (PAGE_SIZE << 1);
+                        tlb_probe();
+                        idx = read_mmu_index();
+                        if (idx >= 0)
+                                tlb_invalid_indexed();
+                }
+		restore_asid_inv_utlb(oldpid, 0);
+		}
+#endif
+	} else
+		flush_tlb_all();
+
+        local_irq_restore(flags);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
+{
+	int cpu = smp_processor_id();
+	int newpid = cpu_asid(cpu, vma->vm_mm);
+
+	if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
+		page &= (PAGE_MASK << 1);
+
+#ifdef CONFIG_CPU_HAS_TLBI
+		asm volatile("tlbi.vaas %0"::"r"(page | newpid));
+		sync_is();
+#else
+		{
+		int oldpid, idx;
+		unsigned long flags;
+		local_irq_save(flags);
+		oldpid = read_mmu_entryhi();
+		write_mmu_entryhi(page | newpid);
+		tlb_probe();
+		idx = read_mmu_index();
+		if(idx >= 0)
+			tlb_invalid_indexed();
+
+		restore_asid_inv_utlb(oldpid, newpid);
+		local_irq_restore(flags);
+		}
+#endif
+	}
+}
+
+/*
+ * Remove one kernel space TLB entry.  This entry is assumed to be marked
+ * global so we don't do the ASID thing.
+ */
+void flush_tlb_one(unsigned long page)
+{
+	int oldpid;
+	oldpid = read_mmu_entryhi();
+	page &= (PAGE_MASK << 1);
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	page = page | (oldpid & 0xfff);
+	asm volatile("tlbi.vaas %0"::"r"(page));
+	sync_is();
+#else
+	{
+	int idx;
+	unsigned long flags;
+
+	page = page | (oldpid & 0xff);
+
+	local_irq_save(flags);
+	write_mmu_entryhi(page);
+	tlb_probe();
+	idx = read_mmu_index();
+	if (idx >= 0)
+		tlb_invalid_indexed();
+	restore_asid_inv_utlb(oldpid, oldpid);
+	local_irq_restore(flags);
+	}
+#endif
+}
+
+EXPORT_SYMBOL(flush_tlb_one);
+
+/* show current 32 jtlbs */
+void show_jtlb_table(void)
+{
+	unsigned long flags;
+	int entryhi, entrylo0, entrylo1;
+	int entry;
+	int oldpid;
+
+	local_irq_save(flags);
+	entry = 0;
+	pr_info("\n\n\n");
+
+	oldpid = read_mmu_entryhi();
+	while (entry < CSKY_TLB_SIZE)
+	{
+		write_mmu_index(entry);
+		tlb_read();
+		entryhi = read_mmu_entryhi();
+		entrylo0 = read_mmu_entrylo0();
+		entrylo0 = entrylo0;
+		entrylo1 = read_mmu_entrylo1();
+		entrylo1 = entrylo1;
+		pr_info("jtlb[%d]:	entryhi - 0x%x;	entrylo0 - 0x%x;"
+		        "	entrylo1 - 0x%x\n",
+			 entry, entryhi, entrylo0, entrylo1);
+		entry++;
+	}
+	write_mmu_entryhi(oldpid);
+	local_irq_restore(flags);
+}
-- 
2.7.4
