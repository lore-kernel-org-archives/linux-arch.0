From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 07/19] csky: MMU and page table management
Date: Mon,  2 Jul 2018 01:30:10 +0800
Message-ID: <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/ckmmu.h        |  80 +++++++++
 arch/csky/abiv1/inc/abi/page.h         |  26 +++
 arch/csky/abiv1/inc/abi/pgtable-bits.h |  36 ++++
 arch/csky/abiv1/mmap.c                 |  65 +++++++
 arch/csky/abiv2/inc/abi/ckmmu.h        |  88 ++++++++++
 arch/csky/abiv2/inc/abi/page.h         |  14 ++
 arch/csky/abiv2/inc/abi/pgtable-bits.h |  36 ++++
 arch/csky/include/asm/addrspace.h      |  10 ++
 arch/csky/include/asm/fixmap.h         |  65 +++++++
 arch/csky/include/asm/highmem.h        |  50 ++++++
 arch/csky/include/asm/mmu.h            |  11 ++
 arch/csky/include/asm/page.h           | 104 ++++++++++++
 arch/csky/include/asm/pgalloc.h        | 108 ++++++++++++
 arch/csky/include/asm/pgtable.h        | 301 +++++++++++++++++++++++++++++++++
 arch/csky/include/asm/segment.h        |  18 ++
 arch/csky/include/asm/shmparam.h       |  10 ++
 arch/csky/mm/dma-mapping.c             | 216 +++++++++++++++++++++++
 arch/csky/mm/highmem.c                 | 210 +++++++++++++++++++++++
 arch/csky/mm/init.c                    | 122 +++++++++++++
 arch/csky/mm/ioremap.c                 |  49 ++++++
 20 files changed, 1619 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv1/inc/abi/page.h
 create mode 100644 arch/csky/abiv1/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/abiv1/mmap.c
 create mode 100644 arch/csky/abiv2/inc/abi/ckmmu.h
 create mode 100644 arch/csky/abiv2/inc/abi/page.h
 create mode 100644 arch/csky/abiv2/inc/abi/pgtable-bits.h
 create mode 100644 arch/csky/include/asm/addrspace.h
 create mode 100644 arch/csky/include/asm/fixmap.h
 create mode 100644 arch/csky/include/asm/highmem.h
 create mode 100644 arch/csky/include/asm/mmu.h
 create mode 100644 arch/csky/include/asm/page.h
 create mode 100644 arch/csky/include/asm/pgalloc.h
 create mode 100644 arch/csky/include/asm/pgtable.h
 create mode 100644 arch/csky/include/asm/segment.h
 create mode 100644 arch/csky/include/asm/shmparam.h
 create mode 100644 arch/csky/mm/dma-mapping.c
 create mode 100644 arch/csky/mm/highmem.c
 create mode 100644 arch/csky/mm/init.c
 create mode 100644 arch/csky/mm/ioremap.c

diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
new file mode 100644
index 0000000..e8e7d43
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_CKMMUV1_H
+#define __ASM_CSKY_CKMMUV1_H
+#include <abi/reg_ops.h>
+
+static inline void select_mmu_cp(void)
+{
+	 asm volatile("cpseti cp15\n");
+}
+
+static inline int read_mmu_index(void)
+{
+	return cprcr("cpcr0");
+}
+
+static inline void write_mmu_index(int value)
+{
+	cpwcr("cpcr0", value);
+}
+
+static inline int read_mmu_entrylo0(void)
+{
+	return cprcr("cpcr2") << 6;
+}
+
+static inline int read_mmu_entrylo1(void)
+{
+	return cprcr("cpcr3") << 6;
+}
+
+static inline void write_mmu_pagemask(int value)
+{
+	cpwcr("cpcr6", value);
+}
+
+static inline int read_mmu_entryhi(void)
+{
+	return cprcr("cpcr4");
+}
+
+static inline void write_mmu_entryhi(int value)
+{
+	cpwcr("cpcr4", value);
+}
+
+/*
+ * TLB operations.
+ */
+static inline void tlb_probe(void)
+{
+	cpwcr("cpcr8", 0x80000000);
+}
+
+static inline void tlb_read(void)
+{
+	cpwcr("cpcr8", 0x40000000);
+}
+
+static inline void tlb_invalid_all(void)
+{
+	cpwcr("cpcr8", 0x04000000);
+}
+
+static inline void tlb_invalid_indexed(void)
+{
+	cpwcr("cpcr8", 0x02000000);
+}
+
+static inline void setup_pgd(unsigned long pgd)
+{
+	cpwcr("cpcr29", pgd);
+}
+
+static inline unsigned long get_pgd(void)
+{
+	return cprcr("cpcr29");
+}
+#endif /* __ASM_CSKY_CKMMUV1_H */
+
diff --git a/arch/csky/abiv1/inc/abi/page.h b/arch/csky/abiv1/inc/abi/page.h
new file mode 100644
index 0000000..b0d2122
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/page.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+extern unsigned long shm_align_mask;
+extern void flush_dcache_page(struct page *);
+
+static inline unsigned long pages_do_alias(unsigned long addr1,
+					   unsigned long addr2)
+{
+	return (addr1 ^ addr2) & shm_align_mask;
+}
+
+static inline void clear_user_page(void *addr, unsigned long vaddr,
+				   struct page *page)
+{
+	clear_page(addr);
+	if (pages_do_alias((unsigned long) addr, vaddr & PAGE_MASK))
+		flush_dcache_page(page);
+}
+
+static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
+				  struct page *page)
+{
+	copy_page(to, from);
+	if (pages_do_alias((unsigned long) to, vaddr & PAGE_MASK))
+		flush_dcache_page(page);
+}
diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
new file mode 100644
index 0000000..3d614f3
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_PGTABLE_BITS_H
+#define __ASM_CSKY_PGTABLE_BITS_H
+
+/* implemented in software */
+#define _PAGE_ACCESSED		(1<<3)
+#define PAGE_ACCESSED_BIT	(3)
+
+#define _PAGE_READ		(1<<1)
+#define _PAGE_WRITE		(1<<2)
+#define _PAGE_PRESENT		(1<<0)
+
+#define _PAGE_MODIFIED		(1<<4)
+#define PAGE_MODIFIED_BIT	(4)
+
+/* implemented in hardware */
+#define _PAGE_GLOBAL		(1<<6)
+
+#define _PAGE_VALID		(1<<7)
+#define PAGE_VALID_BIT		(7)
+
+#define _PAGE_DIRTY		(1<<8)
+#define PAGE_DIRTY_BIT		(8)
+
+#define _PAGE_CACHE		(3<<9)
+#define _PAGE_UNCACHE		(2<<9)
+
+#define _CACHE_MASK		(7<<9)
+
+#define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE)
+#define _CACHE_UNCACHED		(_PAGE_VALID | _PAGE_UNCACHE)
+
+#define HAVE_ARCH_UNMAPPED_AREA
+
+#endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
new file mode 100644
index 0000000..e70a74b
--- /dev/null
+++ b/arch/csky/abiv1/mmap.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/shm.h>
+#include <linux/sched.h>
+#include <linux/random.h>
+#include <linux/io.h>
+
+unsigned long shm_align_mask = (0x4000 >> 1) - 1;   /* Sane caches */
+
+#define COLOUR_ALIGN(addr,pgoff)                            \
+	((((addr) + shm_align_mask) & ~shm_align_mask) +        \
+	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_area_struct * vmm;
+	int do_color_align;
+
+	if (flags & MAP_FIXED) {
+		/*
+		 * We do not accept a shared mapping if it would violate
+		 * cache aliasing constraints.
+		 */
+		if ((flags & MAP_SHARED) &&
+				((addr - (pgoff << PAGE_SHIFT)) & shm_align_mask))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+	do_color_align = 0;
+	if (filp || (flags & MAP_SHARED))
+		do_color_align = 1;
+	if (addr) {
+		if (do_color_align)
+			addr = COLOUR_ALIGN(addr, pgoff);
+		else
+			addr = PAGE_ALIGN(addr);
+		vmm = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+				(!vmm || addr + len <= vmm->vm_start))
+			return addr;
+	}
+	addr = TASK_UNMAPPED_BASE;
+	if (do_color_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
+		/* At this point:  (!vmm || addr < vmm->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vmm || addr + len <= vmm->vm_start)
+			return addr;
+		addr = vmm->vm_end;
+		if (do_color_align)
+			addr = COLOUR_ALIGN(addr, pgoff);
+	}
+}
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
new file mode 100644
index 0000000..4b698f9
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_CKMMUV2_H
+#define __ASM_CSKY_CKMMUV2_H
+#include <abi/reg_ops.h>
+
+static inline void select_mmu_cp(void){}
+
+static inline int  read_mmu_index(void)
+{
+	return mfcr("cr<0, 15>");
+}
+
+static inline void  write_mmu_index(int value)
+{
+	mtcr("cr<0, 15>", value);
+}
+
+static inline int  read_mmu_entrylo0(void)
+{
+	return mfcr("cr<2, 15>");
+}
+
+static inline int  read_mmu_entrylo1(void)
+{
+	return mfcr("cr<3, 15>");
+}
+
+static inline void  write_mmu_pagemask(int value)
+{
+	mtcr("cr<6, 15>", value);
+}
+
+static inline int  read_mmu_entryhi(void)
+{
+	return mfcr("cr<4, 15>");
+}
+
+static inline void  write_mmu_entryhi(int value)
+{
+	mtcr("cr<4, 15>", value);
+}
+
+/*
+ * TLB operations.
+ */
+static inline void tlb_probe(void)
+{
+	mtcr("cr<8, 15>", 0x80000000);
+}
+
+static inline void tlb_read(void)
+{
+	mtcr("cr<8, 15>", 0x40000000);
+}
+
+static inline void tlb_invalid_all(void)
+{
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.alls\n");
+#else
+	mtcr("cr<8, 15>", 0x04000000);
+#endif
+}
+
+static inline void tlb_invalid_indexed(void)
+{
+	mtcr("cr<8, 15>", 0x02000000);
+}
+
+/* setup hardrefil pgd */
+static inline unsigned long get_pgd(void)
+{
+	return mfcr("cr<29, 15>");
+}
+
+static inline void setup_pgd(unsigned long pgd)
+{
+	mtcr("cr<29, 15>", pgd);
+}
+
+static inline void setup_pgd_kernel(unsigned long pgd)
+{
+	mtcr("cr<28, 15>", pgd);
+}
+
+#endif /* __ASM_CSKY_CKMMUV2_H */
+
diff --git a/arch/csky/abiv2/inc/abi/page.h b/arch/csky/abiv2/inc/abi/page.h
new file mode 100644
index 0000000..41f5633
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/page.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+static inline void clear_user_page(void *addr, unsigned long vaddr,
+				   struct page *page)
+{
+	clear_page(addr);
+}
+
+static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
+				  struct page *page)
+{
+	copy_page(to, from);
+}
+
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
new file mode 100644
index 0000000..3ca90fa
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_PGTABLE_BITS_H
+#define __ASM_CSKY_PGTABLE_BITS_H
+
+/* implemented in software */
+#define _PAGE_ACCESSED		(1<<7)
+#define PAGE_ACCESSED_BIT	(7)
+
+#define _PAGE_READ		(1<<8)
+#define _PAGE_WRITE		(1<<9)
+#define _PAGE_PRESENT		(1<<10)
+
+#define _PAGE_MODIFIED		(1<<11)
+#define PAGE_MODIFIED_BIT	(11)
+
+/* implemented in hardware */
+#define _PAGE_GLOBAL		(1<<0)
+
+#define _PAGE_VALID		(1<<1)
+#define PAGE_VALID_BIT		(1)
+
+#define _PAGE_DIRTY		(1<<2)
+#define PAGE_DIRTY_BIT		(2)
+
+#define _PAGE_SO		(1<<5)
+#define _PAGE_BUF		(1<<6)
+
+#define _PAGE_CACHE		(1<<3)
+
+#define _CACHE_MASK		_PAGE_CACHE
+
+#define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE | _PAGE_BUF)
+#define _CACHE_UNCACHED		(_PAGE_VALID | _PAGE_SO)
+
+#endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/include/asm/addrspace.h b/arch/csky/include/asm/addrspace.h
new file mode 100644
index 0000000..63f86ad
--- /dev/null
+++ b/arch/csky/include/asm/addrspace.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_ADDRSPACE_H
+#define __ASM_CSKY_ADDRSPACE_H
+
+#define KSEG0		0x80000000ul
+#define KSEG0ADDR(a)	(((unsigned long)a & 0x1fffffff) | KSEG0)
+
+#endif /* __ASM_CSKY_ADDRSPACE_H */
+
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
new file mode 100644
index 0000000..65a9cf5
--- /dev/null
+++ b/arch/csky/include/asm/fixmap.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_FIXMAP_H
+#define __ASM_CSKY_FIXMAP_H
+
+#include <asm/page.h>
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
+ * from the end of virtual memory (0xfffff000) backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * highger than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ *
+ * TLB entries of such buffers will not be flushed across
+ * task switches.
+ */
+
+/*
+ * on UP currently we will have no trace of the fixmap mechanizm,
+ * no page table allocations, etc. This might change in the
+ * future, say framebuffers for the console driver(s) could be
+ * fix-mapped?
+ */
+enum fixed_addresses {
+#define FIX_N_COLOURS 8
+	FIX_CMAP_BEGIN,
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * 2),
+#ifdef CONFIG_HIGHMEM
+	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+#endif
+	__end_of_fixed_addresses
+};
+
+/*
+ * used by vmalloc.c.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap, and leave one page empty
+ * at the top of mem..
+ */
+#define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
+#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+
+#include <asm-generic/fixmap.h>
+
+#define kmap_get_fixmap_pte(vaddr) \
+	pte_offset_kernel(pmd_offset((pud_t *)pgd_offset_k(vaddr), vaddr), (vaddr))
+
+#endif /* __ASM_CSKY_FIXMAP_H */
diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
new file mode 100644
index 0000000..976db37
--- /dev/null
+++ b/arch/csky/include/asm/highmem.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_HIGHMEM_H
+#define __ASM_CSKY_HIGHMEM_H
+
+#ifdef __KERNEL__
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/uaccess.h>
+#include <asm/kmap_types.h>
+#include <asm/cache.h>
+
+/* undef for production */
+#define HIGHMEM_DEBUG 1
+
+/* declarations for highmem.c */
+extern unsigned long highstart_pfn, highend_pfn;
+
+extern pte_t *pkmap_page_table;
+
+/*
+ * Right now we initialize only a single pte table. It can be extended
+ * easily, subsequent pte tables have to be allocated in one physical
+ * chunk of RAM.
+ */
+#define LAST_PKMAP 1024
+#define LAST_PKMAP_MASK (LAST_PKMAP-1)
+#define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
+
+extern void * kmap_high(struct page *page);
+extern void kunmap_high(struct page *page);
+
+extern void *kmap(struct page *page);
+extern void kunmap(struct page *page);
+extern void *kmap_atomic(struct page *page);
+extern void __kunmap_atomic(void *kvaddr);
+extern void *kmap_atomic_pfn(unsigned long pfn);
+extern struct page *kmap_atomic_to_page(void *ptr);
+
+#define flush_cache_kmaps() do {} while(0)
+
+extern void kmap_init(void);
+
+#define kmap_prot PAGE_KERNEL
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_CSKY_HIGHMEM_H */
diff --git a/arch/csky/include/asm/mmu.h b/arch/csky/include/asm/mmu.h
new file mode 100644
index 0000000..db29c17
--- /dev/null
+++ b/arch/csky/include/asm/mmu.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_MMU_H
+#define __ASM_CSKY_MMU_H
+
+typedef struct {
+	unsigned long asid[NR_CPUS];
+	void *vdso;
+} mm_context_t;
+
+#endif /* __ASM_CSKY_MMU_H */
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
new file mode 100644
index 0000000..cb4855c
--- /dev/null
+++ b/arch/csky/include/asm/page.h
@@ -0,0 +1,104 @@
+#ifndef __ASM_CSKY_PAGE_H
+#define __ASM_CSKY_PAGE_H
+
+#include <asm/setup.h>
+#include <asm/cache.h>
+#include <linux/const.h>
+
+/*
+ * PAGE_SHIFT determines the page size
+ */
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#define THREAD_SIZE	(PAGE_SIZE * 2)
+#define THREAD_MASK	(~(THREAD_SIZE -1))
+#define THREAD_SHIFT	(PAGE_SHIFT + 1)
+
+/*
+ * NOTE: virtual isn't really correct, actually it should be the offset into the
+ * memory node, but we have no highmem, so that works for now.
+ * TODO: implement (fast) pfn<->pgdat_idx conversion functions, this makes lots
+ * of the shifts unnecessary.
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/pfn.h>
+
+#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
+#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+
+#define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
+                                 (void *)(kaddr) < high_memory)
+extern unsigned long min_low_pfn, max_pfn;
+#define pfn_valid(pfn)		((pfn >= min_low_pfn) && (pfn < max_pfn))
+
+extern void *memset(void *dest, int c, size_t l);
+extern void *memcpy (void *to, const void *from, size_t l);
+
+#define clear_page(page)        memset((page), 0, PAGE_SIZE)
+#define copy_page(to,from)      memcpy((to), (from), PAGE_SIZE)
+
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
+
+struct page;
+
+#include <abi/page.h>
+
+struct vm_area_struct;
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { unsigned long pte_low; } pte_t;
+#define pte_val(x)    ((x).pte_low)
+
+typedef struct { unsigned long pgd; } pgd_t;
+typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *pgtable_t;
+
+#define pgd_val(x)	((x).pgd)
+#define pgprot_val(x)	((x).pgprot)
+
+#define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
+
+#define __pte(x)	((pte_t) { (x) } )
+#define __pgd(x)	((pgd_t) { (x) } )
+#define __pgprot(x)	((pgprot_t) { (x) } )
+
+#endif /* !__ASSEMBLY__ */
+
+#define PHYS_OFFSET		(CONFIG_RAM_BASE & ~(LOWMEM_LIMIT - 1))
+#define PHYS_OFFSET_OFFSET	(CONFIG_RAM_BASE & (LOWMEM_LIMIT - 1))
+#define ARCH_PFN_OFFSET		PFN_DOWN(CONFIG_RAM_BASE)
+
+#define	PAGE_OFFSET	0x80000000
+#define LOWMEM_LIMIT	0x20000000
+
+#define MASK_SSEG1(x) ((unsigned long)(x) & (~LOWMEM_LIMIT))
+
+#define __pa(x)		(MASK_SSEG1(x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
+#define __pa_symbol(x)  __pa(RELOC_HIDE(MASK_SSEG1(x), 0))
+
+#define MAP_NR(x)	PFN_DOWN(MASK_SSEG1(x) - PAGE_OFFSET - PHYS_OFFSET_OFFSET)
+#define virt_to_page(x)		(mem_map + MAP_NR(x))
+
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define UNCACHE_ADDR(x)		((unsigned long)(x) | LOWMEM_LIMIT)
+
+/*
+ * main RAM and kernel working space are coincident at 0x80000000, but to make
+ * life more interesting, there's also an uncached virtual shadow at 0xb0000000
+ * - these mappings are fixed in the MMU
+ */
+
+#define pfn_to_kaddr(x)       __va(PFN_PHYS(x))
+
+#include <asm-generic/memory_model.h>
+#include <asm-generic/getorder.h>
+
+#endif /* __ASM_CSKY_PAGE_H */
diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
new file mode 100644
index 0000000..5df106f
--- /dev/null
+++ b/arch/csky/include/asm/pgalloc.h
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_PGALLOC_H
+#define __ASM_CSKY_PGALLOC_H
+
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
+        pte_t *pte)
+{
+        set_pmd(pmd, __pmd(__pa(pte)));
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+        pgtable_t pte)
+{
+        set_pmd(pmd, __pmd(__pa(page_address(pte))));
+}
+
+#define pmd_pgtable(pmd) pmd_page(pmd)
+
+extern void pgd_init(unsigned long *p);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+        unsigned long address)
+{
+        pte_t *pte;
+	unsigned long *kaddr, i;
+
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL, PTE_ORDER);
+	kaddr = (unsigned long *)pte;
+	if (address & 0x80000000)
+		for(i=0; i<(PAGE_SIZE/4); i++)
+			*(kaddr + i) = 0x1;
+	else
+		clear_page(kaddr);
+
+        return pte;
+}
+
+static inline struct page *pte_alloc_one(struct mm_struct *mm,
+                                            unsigned long address)
+{
+	struct page *pte;
+	unsigned long *kaddr, i;
+
+        pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL, PTE_ORDER);
+        if (pte) {
+		kaddr = kmap_atomic(pte);
+		if (address & 0x80000000) {
+			for(i=0; i<(PAGE_SIZE/4); i++)
+				*(kaddr + i) = 0x1;
+		} else
+			clear_page(kaddr);
+		kunmap_atomic(kaddr);
+		pgtable_page_ctor(pte);
+        }
+        return pte;
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+        free_pages((unsigned long)pte, PTE_ORDER);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
+{
+        pgtable_page_dtor(pte);
+        __free_pages(pte, PTE_ORDER);
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+        free_pages((unsigned long)pgd, PGD_ORDER);
+}
+
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+        pgd_t *ret, *init;
+
+        ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+        if (ret) {
+                init = pgd_offset(&init_mm, 0UL);
+                pgd_init((unsigned long *)ret);
+                memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
+                       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+#ifdef CONFIG_CPU_NEED_TLBSYNC
+		dcache_wb_range((unsigned int)ret, (unsigned int)(ret + PTRS_PER_PGD));
+#endif
+        }
+
+        return ret;
+}
+
+#define __pte_free_tlb(tlb,pte,address)                 \
+do {                                                    \
+        pgtable_page_dtor(pte);                         \
+        tlb_remove_page((tlb), pte);                    \
+} while (0)
+
+#define check_pgt_cache()               do {} while(0)
+
+extern void pagetable_init(void);
+
+#endif /* __ASM_CSKY_PGALLOC_H */
+
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
new file mode 100644
index 0000000..fabdfcd
--- /dev/null
+++ b/arch/csky/include/asm/pgtable.h
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_PGTABLE_H
+#define __ASM_CSKY_PGTABLE_H
+
+#include <asm/fixmap.h>
+#include <asm/addrspace.h>
+#include <abi/pgtable-bits.h>
+#include <asm-generic/pgtable-nopmd.h>
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+#define PGDIR_SHIFT		22
+#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+#define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
+#define FIRST_USER_ADDRESS	0UL
+
+#define VMALLOC_START		(0xc0008000)
+#ifdef CONFIG_HIGHMEM
+#define PKMAP_BASE		(0xfe000000UL)
+#define VMALLOC_END		(PKMAP_BASE - 2*PAGE_SIZE)
+#else
+#define VMALLOC_END		(FIXADDR_START - 2*PAGE_SIZE)
+#endif
+
+/*
+ * traditional two-level paging structure:
+ */
+#define PGD_ORDER	0
+#define PTE_ORDER	0
+
+#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#define PTRS_PER_PMD	1
+#define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
+
+#define pte_ERROR(e) \
+	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+/* Find an entry in the third-level page table.. */
+#define __pte_offset_t(address) \
+	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_offset_kernel(dir, address) \
+	(pmd_page_vaddr(*(dir)) + __pte_offset_t(address))
+#define pte_offset_map(dir, address) \
+	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset_t(address))
+#define pmd_page(pmd)			(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
+#define pte_clear(mm,addr,ptep)		set_pte((ptep), \
+					(((unsigned int)addr&0x80000000)?__pte(1):__pte(0)))
+#define pte_none(pte)			(!(pte_val(pte)&0xfffffffe))
+#define pte_present(pte)		(pte_val(pte) & _PAGE_PRESENT )
+#define pte_pfn(x)			((unsigned long)((x).pte_low >> PAGE_SHIFT))
+#define pfn_pte(pfn, prot)		__pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
+						| pgprot_val(prot))
+
+#define __READABLE	(_PAGE_READ | _PAGE_VALID | _PAGE_ACCESSED)
+#define __WRITEABLE	(_PAGE_WRITE | _PAGE_DIRTY | _PAGE_MODIFIED)
+
+#define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
+
+#define pte_unmap(pte) ((void)(pte))
+
+#define __swp_type(x)			(((x).val >> 4) & 0xff)
+#define __swp_offset(x)			((x).val >> 12)
+#define __swp_entry(type, offset)	((swp_entry_t) {((type) << 4) | ((offset) << 12) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+
+#define pte_page(x)			pfn_to_page(pte_pfn(x))
+#define __mk_pte(page_nr,pgprot)	__pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
+
+/*
+ * CSKY can't do page protection for execute, and considers that the same like
+ * read. Also, write permissions imply read permissions. This is the closest
+ * we can get by reasonable means..
+ */
+#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHED)
+#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+				_CACHE_CACHED)
+#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _CACHE_CACHED)
+#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_READ | _CACHE_CACHED)
+#define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
+				_PAGE_GLOBAL | _CACHE_CACHED)
+#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+				_CACHE_CACHED)
+
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY
+#define __P101	PAGE_READONLY
+#define __P110	PAGE_COPY
+#define __P111	PAGE_COPY
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY
+#define __S101	PAGE_READONLY
+#define __S110	PAGE_SHARED
+#define __S111	PAGE_SHARED
+
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
+
+extern void load_pgd(unsigned long pg_dir);
+extern pte_t invalid_pte_table[PTRS_PER_PTE];
+
+static inline int pte_special(pte_t pte) { return 0; }
+static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
+
+static inline void set_pte(pte_t *p, pte_t pte)
+{
+	*p = pte;
+#if defined(CONFIG_CPU_NEED_TLBSYNC)
+	dcache_wb_line((u32)p);
+#endif
+}
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
+static inline pte_t *pmd_page_vaddr(pmd_t pmd)
+{
+	unsigned long ptr;
+
+	ptr = pmd_val(pmd);
+
+	return __va(ptr);
+}
+
+#define pmd_phys(pmd) pmd_val(pmd)
+
+static inline void set_pmd(pmd_t *p, pmd_t pmd)
+{
+	*p = pmd;
+#if defined(CONFIG_CPU_NEED_TLBSYNC)
+	dcache_wb_line((u32)p);
+#endif
+}
+
+
+static inline int pmd_none(pmd_t pmd)
+{
+	return pmd_val(pmd) == __pa(invalid_pte_table);
+}
+
+#define pmd_bad(pmd)	(pmd_val(pmd) & ~PAGE_MASK)
+
+static inline int pmd_present(pmd_t pmd)
+{
+        return (pmd_val(pmd) != __pa(invalid_pte_table));
+}
+
+static inline void pmd_clear(pmd_t *p)
+{
+        pmd_val(*p) = (__pa(invalid_pte_table));
+#if defined(CONFIG_CPU_NEED_TLBSYNC)
+        dcache_wb_line((u32)p);
+#endif
+}
+
+/*
+ * The following only work if pte_present() is true.
+ * Undefined behaviour if not..
+ */
+static inline int pte_read(pte_t pte)
+{
+	return pte.pte_low & _PAGE_READ;
+}
+
+static inline int pte_write(pte_t pte)
+{
+	return (pte).pte_low & _PAGE_WRITE;
+}
+
+static inline int pte_dirty(pte_t pte)
+{
+	return (pte).pte_low & _PAGE_MODIFIED;
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return (pte).pte_low & _PAGE_ACCESSED;
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_val(pte) &= ~(_PAGE_WRITE | _PAGE_DIRTY);
+	return pte;
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	pte_val(pte) &= ~(_PAGE_MODIFIED|_PAGE_DIRTY);
+	return pte;
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	pte_val(pte) &= ~(_PAGE_ACCESSED|_PAGE_VALID);
+	return pte;
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_WRITE;
+	if (pte_val(pte) & _PAGE_MODIFIED)
+		pte_val(pte) |= _PAGE_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_MODIFIED;
+	if (pte_val(pte) & _PAGE_WRITE)
+		pte_val(pte) |= _PAGE_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_ACCESSED;
+	if (pte_val(pte) & _PAGE_READ)
+		pte_val(pte) |= _PAGE_VALID;
+	return pte;
+}
+
+#define __pgd_offset(address)	pgd_index(address)
+#define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+
+/* to find an entry in a kernel page-table-directory */
+#define pgd_offset_k(address)	pgd_offset(&init_mm, address)
+
+#define pgd_index(address)	((address) >> PGDIR_SHIFT)
+
+/*
+ * Macro to make mark a page protection value as "uncacheable".  Note
+ * that "protection" is really a misnomer here as the protection value
+ * contains the memory attribute bits, dirty bits, and various other
+ * bits as well.
+ */
+#define pgprot_noncached pgprot_noncached
+
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
+
+	return __pgprot(prot);
+}
+
+/*
+ * Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ */
+#define mk_pte(page, pgprot)    pfn_pte(page_to_pfn(page), (pgprot))
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
+		     (pgprot_val(newprot)));
+}
+
+/* to find an entry in a page-table-directory */
+static inline pgd_t *pgd_offset(struct mm_struct *mm, unsigned long address)
+{
+	return mm->pgd + pgd_index(address);
+}
+
+/* Find an entry in the third-level page table.. */
+static inline pte_t *pte_offset(pmd_t * dir, unsigned long address)
+{
+	return (pte_t *) (pmd_page_vaddr(*dir)) +
+		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1));
+}
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern void paging_init(void);
+
+extern void show_jtlb_table(void);
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *pte);
+
+/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
+#define kern_addr_valid(addr)	(1)
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do {} while(0)
+
+#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
+	remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#include <asm-generic/pgtable.h>
+
+#endif /* __ASM_CSKY_PGTABLE_H */
diff --git a/arch/csky/include/asm/segment.h b/arch/csky/include/asm/segment.h
new file mode 100644
index 0000000..cf1440c
--- /dev/null
+++ b/arch/csky/include/asm/segment.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_SEGMENT_H
+#define __ASM_CSKY_SEGMENT_H
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#define KERNEL_DS		((mm_segment_t) { 0xFFFFFFFF })
+#define get_ds()		KERNEL_DS
+
+#define USER_DS			((mm_segment_t) { 0x80000000UL })
+#define get_fs()		(current_thread_info()->addr_limit)
+#define set_fs(x)		(current_thread_info()->addr_limit = (x))
+#define segment_eq(a,b)		((a).seg == (b).seg)
+
+#endif /* __ASM_CSKY_SEGMENT_H */
diff --git a/arch/csky/include/asm/shmparam.h b/arch/csky/include/asm/shmparam.h
new file mode 100644
index 0000000..ecf7b65
--- /dev/null
+++ b/arch/csky/include/asm/shmparam.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_SHMPARAM_H
+#define __ASM_CSKY_SHMPARAM_H
+
+#define SHMLBA	(4 * PAGE_SIZE)
+
+#define __ARCH_FORCE_SHMLBA
+
+#endif /* __ASM_CSKY_SHMPARAM_H */
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
new file mode 100644
index 0000000..f05e4b6
--- /dev/null
+++ b/arch/csky/mm/dma-mapping.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/types.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/io.h>
+#include <linux/cache.h>
+#include <asm/cache.h>
+
+static void *csky_dma_alloc(
+	struct device *dev,
+	size_t size,
+	dma_addr_t *dma_handle,
+	gfp_t gfp,
+	unsigned long attrs
+	)
+{
+	unsigned long ret;
+	void * vaddr;
+
+	if (DMA_ATTR_NON_CONSISTENT & attrs)
+		panic("csky %s panic DMA_ATTR_NON_CONSISTENT.\n", __func__);
+
+	ret =  __get_free_pages((gfp | __GFP_NORETRY) & (~__GFP_HIGHMEM), get_order(size));
+	if (!ret) {
+		pr_err("csky %s no more free pages, %ld.\n", __func__, ret);
+		return NULL;
+	}
+
+	memset((void *)ret, 0, size);
+
+	dma_wbinv_range(ret, ret + size);
+
+	*dma_handle = virt_to_phys((void*)ret);
+
+	vaddr = (void *) UNCACHE_ADDR(ret);
+
+	return vaddr;
+}
+
+static void csky_dma_free(
+	struct device *dev,
+	size_t size,
+	void *vaddr,
+	dma_addr_t dma_handle,
+	unsigned long attrs
+	)
+{
+	unsigned long addr = (unsigned long)phys_to_virt(dma_handle);
+
+	free_pages(addr, get_order(size));
+}
+
+static void __dma_sync(
+	void *va,
+	struct page *page,
+	unsigned long offset,
+	size_t size,
+	enum dma_data_direction direction)
+{
+	unsigned long vaddr = (unsigned long) va;
+
+	if (va == NULL && PageHighMem(page))
+		vaddr = (unsigned long) kmap_atomic(page);
+
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		dma_wb_range(vaddr + offset, vaddr + offset + size);
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		dma_wbinv_range(vaddr + offset, vaddr + offset + size);
+		break;
+	default:
+		BUG();
+	}
+
+	if (va == NULL && PageHighMem(page))
+		kunmap_atomic((void *) vaddr);
+}
+
+static dma_addr_t csky_dma_map_page(
+	struct device *dev,
+	struct page *page,
+	unsigned long offset,
+	size_t size,
+	enum dma_data_direction direction,
+	unsigned long attrs
+	)
+{
+	__dma_sync(page_address(page), page, offset, size, direction);
+
+	return page_to_phys(page) + offset;
+}
+
+static void csky_dma_unmap_page(
+	struct device *dev,
+	dma_addr_t handle,
+	size_t size,
+	enum dma_data_direction direction,
+	unsigned long attrs
+	)
+{
+	unsigned long offset = handle & ~PAGE_MASK;
+	struct page *page = pfn_to_page(__phys_to_pfn(handle));
+
+	__dma_sync(page_address(page), page, offset, size, direction);
+}
+
+static int csky_dma_map_sg(
+	struct device *dev,
+	struct scatterlist *sglist,
+	int nelems,
+	enum dma_data_direction dir,
+	unsigned long attrs
+	)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i)
+		sg->dma_address = csky_dma_map_page(dev, sg_page(sg), sg->offset, sg->length, dir, attrs);
+
+	return nelems;
+}
+
+static void csky_dma_unmap_sg(
+	struct device *dev,
+	struct scatterlist *sglist,
+	int nelems,
+	enum dma_data_direction dir,
+	unsigned long attrs
+	)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i)
+		csky_dma_unmap_page(dev, sg_dma_address(sg), sg_dma_len(sg), dir, attrs);
+}
+
+static void csky_dma_sync_single_for_all(
+	struct device *dev,
+	dma_addr_t handle,
+	size_t size,
+	enum dma_data_direction dir
+	)
+{
+	unsigned int offset = handle & ~PAGE_MASK;
+	struct page *page = pfn_to_page(__phys_to_pfn(handle));
+
+	__dma_sync(page_address(page), page, offset, size, dir);
+}
+
+static void csky_dma_sync_sg_for_cpu(
+	struct device *dev,
+	struct scatterlist *sglist,
+	int nelems,
+	enum dma_data_direction direction
+	)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
+		__dma_sync(page_address(sg_page(sg)), sg_page(sg), 0,
+			   sg->length, direction);
+}
+
+static void csky_dma_sync_sg_for_device(
+	struct device *dev,
+	struct scatterlist *sglist,
+	int nelems,
+	enum dma_data_direction direction
+	)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
+		__dma_sync(page_address(sg_page(sg)), sg_page(sg), 0,
+			   sg->length, direction);
+}
+
+int csky_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+int csky_dma_supported(struct device *dev, u64 mask)
+{
+	return DMA_BIT_MASK(32);
+}
+
+struct dma_map_ops csky_dma_map_ops = {
+	.alloc			= csky_dma_alloc,
+	.free			= csky_dma_free,
+	.mmap			= NULL,
+	.get_sgtable		= NULL,
+	.map_page		= csky_dma_map_page,
+	.unmap_page		= csky_dma_unmap_page,
+
+	.map_sg			= csky_dma_map_sg,
+	.unmap_sg		= csky_dma_unmap_sg,
+	.sync_single_for_cpu	= csky_dma_sync_single_for_all,
+	.sync_single_for_device	= csky_dma_sync_single_for_all,
+	.sync_sg_for_cpu	= csky_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= csky_dma_sync_sg_for_device,
+
+	.mapping_error		= csky_dma_mapping_error,
+	.dma_supported		= csky_dma_supported,
+};
+EXPORT_SYMBOL(csky_dma_map_ops);
+
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
new file mode 100644
index 0000000..a979b2d
--- /dev/null
+++ b/arch/csky/mm/highmem.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/smp.h>
+#include <linux/bootmem.h>
+#include <asm/fixmap.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+
+static pte_t *kmap_pte;
+
+unsigned long highstart_pfn, highend_pfn;
+
+void *kmap(struct page *page)
+{
+	void *addr;
+
+	might_sleep();
+	if (!PageHighMem(page))
+		return page_address(page);
+	addr = kmap_high(page);
+        flush_tlb_one((unsigned long)addr);
+
+	return addr;
+}
+EXPORT_SYMBOL(kmap);
+
+void kunmap(struct page *page)
+{
+	BUG_ON(in_interrupt());
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+EXPORT_SYMBOL(kunmap);
+
+/*
+ * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
+ * no global lock is needed and because the kmap code must perform a global TLB
+ * invalidation when the kmap pool wraps.
+ *
+ * However when holding an atomic kmap is is not legal to sleep, so atomic
+ * kmaps are appropriate for short, tight code paths only.
+ */
+
+void *kmap_atomic(struct page *page)
+{
+	unsigned long vaddr;
+	int idx, type;
+
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
+	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	type = kmap_atomic_idx_push();
+	idx = type + KM_TYPE_NR*smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+#ifdef CONFIG_DEBUG_HIGHMEM
+	BUG_ON(!pte_none(*(kmap_pte - idx)));
+#endif
+	set_pte(kmap_pte-idx, mk_pte(page, PAGE_KERNEL));
+	flush_tlb_one((unsigned long)vaddr);
+
+	return (void*) vaddr;
+}
+EXPORT_SYMBOL(kmap_atomic);
+
+void __kunmap_atomic(void *kvaddr)
+{
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
+	int type;
+	
+	if (vaddr < FIXADDR_START) {
+	    pagefault_enable();
+	    return;
+	}
+	
+	type = kmap_atomic_idx();
+#ifdef CONFIG_DEBUG_HIGHMEM
+	int idx = type + KM_TYPE_NR * smp_processor_id();
+
+	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+
+	/*
+	 * force other mappings to Oops if they'll try to access
+	 * this pte without first remap it
+	 */
+	pte_clear(&init_mm, vaddr, kmap_pte-idx);
+	flush_tlb_one(vaddr);
+#endif
+
+	kmap_atomic_idx_pop();
+	pagefault_enable();
+}
+EXPORT_SYMBOL(__kunmap_atomic);
+
+/*
+ * This is the same as kmap_atomic() but can map memory that doesn't
+ * have a struct page associated with it.
+ */
+void *kmap_atomic_pfn(unsigned long pfn)
+{
+	unsigned long vaddr;
+	int idx, type;
+
+	pagefault_disable();
+
+	type = kmap_atomic_idx_push();
+	idx = type + KM_TYPE_NR*smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
+	flush_tlb_one(vaddr);
+
+	return (void*) vaddr;
+}
+
+struct page *kmap_atomic_to_page(void *ptr)
+{
+	unsigned long idx, vaddr = (unsigned long)ptr;
+	pte_t *pte;
+
+	if (vaddr < FIXADDR_START)
+		return virt_to_page(ptr);
+
+	idx = virt_to_fix(vaddr);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	return pte_page(*pte);
+}
+
+static void __init fixrange_init (unsigned long start, unsigned long end,
+                   pgd_t *pgd_base)
+{
+#ifdef CONFIG_HIGHMEM
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int i, j, k;
+	unsigned long vaddr;
+
+	vaddr = start;
+	i = __pgd_offset(vaddr);
+	j = __pud_offset(vaddr);
+	k = __pmd_offset(vaddr);
+	pgd = pgd_base + i;
+
+	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
+		pud = (pud_t *)pgd;
+		for ( ; (j < PTRS_PER_PUD) && (vaddr != end); pud++, j++) {
+			pmd = (pmd_t *)pud;
+			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
+				if (pmd_none(*pmd)) {
+					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+					set_pmd(pmd, __pmd(__pa(pte)));
+					BUG_ON(pte != pte_offset_kernel(pmd, 0));
+				}
+				vaddr += PMD_SIZE;
+			}
+			k = 0;
+		}
+		j = 0;
+	}
+#endif
+}
+
+void __init fixaddr_kmap_pages_init(void)
+{
+	unsigned long vaddr;
+	pgd_t *pgd_base;
+#ifdef CONFIG_HIGHMEM
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pud_t *pud;
+	pte_t *pte;
+#endif
+	pgd_base = swapper_pg_dir;
+
+	/*
+	 * Fixed mappings:
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	fixrange_init(vaddr, 0, pgd_base);
+
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * Permanent kmaps:
+	 */
+	vaddr = PKMAP_BASE;
+	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+
+	pgd = swapper_pg_dir + __pgd_offset(vaddr);
+	pud = (pud_t *)pgd;
+	pmd = pmd_offset(pud, vaddr);
+	pte = pte_offset_kernel(pmd, vaddr);
+	pkmap_page_table = pte;
+#endif
+}
+
+void __init kmap_init(void)
+{
+	unsigned long kmap_vstart;
+
+	fixaddr_kmap_pages_init();
+
+	/* cache the first kmap pte */
+	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);
+}
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
new file mode 100644
index 0000000..37038d1
--- /dev/null
+++ b/arch/csky/mm/init.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/bug.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/pagemap.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+#include <linux/memblock.h>
+#include <linux/swap.h>
+#include <linux/proc_fs.h>
+#include <linux/pfn.h>
+
+#include <asm/setup.h>
+#include <asm/cachectl.h>
+#include <asm/dma.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
+#include <asm/sections.h>
+#include <asm/tlb.h>
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
+
+void __init mem_init(void)
+{
+#ifdef CONFIG_HIGHMEM
+	unsigned long tmp;
+	max_mapnr = highend_pfn;
+#else
+	max_mapnr = max_low_pfn;
+#endif
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
+
+	free_all_bootmem();
+
+#ifdef CONFIG_HIGHMEM
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
+
+		/* FIXME not sure about */
+		if (!memblock_is_reserved(tmp << PAGE_SHIFT))
+			free_highmem_page(page);
+	}
+#endif
+	mem_init_print_info(NULL);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+	if (start < end)
+		pr_info("Freeing initrd memory: %ldk freed\n",
+                     (end - start) >> 10);
+
+	for (; start < end; start += PAGE_SIZE) {
+	ClearPageReserved(virt_to_page(start));
+	init_page_count(virt_to_page(start));
+	free_page(start);
+	totalram_pages++;
+    }
+}
+#endif
+
+extern char __init_begin[], __init_end[];
+extern void __init prom_free_prom_memory(void);
+
+void free_initmem(void)
+{
+	unsigned long addr;
+
+	addr = (unsigned long) &__init_begin;
+	while (addr < (unsigned long) &__init_end) {
+	        ClearPageReserved(virt_to_page(addr));
+	        init_page_count(virt_to_page(addr));
+	        free_page(addr);
+	        totalram_pages++;
+	        addr += PAGE_SIZE;
+	}
+	pr_info("Freeing unused kernel memory: %dk freed\n",
+	        ((unsigned int)&__init_end - (unsigned int)&__init_begin) >> 10);
+}
+
+void pgd_init(unsigned long *p)
+{
+	int i;
+	for (i = 0; i<PTRS_PER_PGD; i++)
+		p[i] = __pa(invalid_pte_table);
+}
+
+void __init pre_mmu_init(void)
+{
+	/* Setup mmu as coprocessor */
+	select_mmu_cp();
+
+	/*
+	 * Setup page-table and enable TLB-hardrefill
+	 */
+	flush_tlb_all();
+	pgd_init((unsigned long *)swapper_pg_dir);
+	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
+
+#ifdef CONFIG_CPU_HAS_TLBI
+	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
+#endif
+
+	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
+
+	/* Setup page mask to 4k */
+	write_mmu_pagemask(0);
+}
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
new file mode 100644
index 0000000..000d3ce
--- /dev/null
+++ b/arch/csky/mm/ioremap.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+
+#include <asm/pgtable.h>
+
+void __iomem *ioremap(phys_addr_t addr, size_t size)
+{
+	phys_addr_t last_addr;
+	unsigned long offset, vaddr;
+	struct vm_struct *area;
+	pgprot_t prot;
+
+	last_addr = addr + size - 1;
+	if (!size || last_addr < addr) {
+		return NULL;
+	}
+
+	offset = addr & (~PAGE_MASK);
+	addr &= PAGE_MASK;
+	size = PAGE_ALIGN(size + offset);
+
+	area = get_vm_area_caller(size, VM_ALLOC, __builtin_return_address(0));
+	if (!area) {
+		return NULL;
+	}
+	vaddr = (unsigned long)area->addr;
+
+	prot = __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE |
+			_PAGE_GLOBAL | _CACHE_UNCACHED);
+
+	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	return (void __iomem *)(vaddr + offset);
+}
+EXPORT_SYMBOL(ioremap);
+
+void iounmap(void __iomem *addr)
+{
+	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+}
+EXPORT_SYMBOL(iounmap);
+
-- 
2.7.4
