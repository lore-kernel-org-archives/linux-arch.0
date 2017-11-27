From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 04/35] nds32: MMU definitions
Date: Mon, 27 Nov 2017 20:27:51 +0800
Message-ID: <11053ebb9a16c40f4d0ed048f9fe394bf10af70e.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch includes virtual memory layout, PHYS_OFFSET is defined as 0x0. It
also includes the 4KB/8KB page size configurations and pte operations.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/fixmap.h   |   42 ++++
 arch/nds32/include/asm/highmem.h  |   78 +++++++
 arch/nds32/include/asm/memory.h   |  118 ++++++++++
 arch/nds32/include/asm/mmu.h      |   25 +++
 arch/nds32/include/asm/page.h     |   78 +++++++
 arch/nds32/include/asm/pgalloc.h  |  109 ++++++++++
 arch/nds32/include/asm/pgtable.h  |  426 +++++++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/shmparam.h |   32 +++
 8 files changed, 908 insertions(+)
 create mode 100644 arch/nds32/include/asm/fixmap.h
 create mode 100644 arch/nds32/include/asm/highmem.h
 create mode 100644 arch/nds32/include/asm/memory.h
 create mode 100644 arch/nds32/include/asm/mmu.h
 create mode 100644 arch/nds32/include/asm/page.h
 create mode 100644 arch/nds32/include/asm/pgalloc.h
 create mode 100644 arch/nds32/include/asm/pgtable.h
 create mode 100644 arch/nds32/include/asm/shmparam.h

diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
new file mode 100644
index 0000000..daeddab
--- /dev/null
+++ b/arch/nds32/include/asm/fixmap.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_NDS32_FIXMAP_H
+#define __ASM_NDS32_FIXMAP_H
+
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+
+enum fixed_addresses {
+	FIX_HOLE,
+	FIX_KMAP_RESERVED,
+	FIX_KMAP_BEGIN,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS),
+#endif
+	FIX_EARLYCON_MEM_BASE,
+	__end_of_fixed_addresses
+};
+#define FIXADDR_TOP             ((unsigned long) (-(16 * PAGE_SIZE)))
+#define FIXADDR_SIZE		((__end_of_fixed_addresses) << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXMAP_PAGE_IO		__pgprot(PAGE_DEVICE)
+void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
+
+#include <asm-generic/fixmap.h>
+#endif /* __ASM_NDS32_FIXMAP_H */
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
new file mode 100644
index 0000000..6a569c1
--- /dev/null
+++ b/arch/nds32/include/asm/highmem.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_HIGHMEM_H
+#define _ASM_HIGHMEM_H
+
+#include <asm/proc-fns.h>
+#include <asm/kmap_types.h>
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
+
+/*
+ * Right now we initialize only a single pte table. It can be extended
+ * easily, subsequent pte tables have to be allocated in one physical
+ * chunk of RAM.
+ */
+/*
+ * Ordering is (from lower to higher memory addresses):
+ *
+ * high_memory
+ *			Persistent kmap area
+ * PKMAP_BASE
+ *			fixed_addresses
+ * FIXADDR_START
+ * FIXADDR_TOP
+ *			Vmalloc area
+ * VMALLOC_START
+ * VMALLOC_END
+ */
+#define PKMAP_BASE		((FIXADDR_START - PGDIR_SIZE) & (PGDIR_MASK))
+#define LAST_PKMAP		PTRS_PER_PTE
+#define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
+#define PKMAP_NR(virt)		(((virt) - (PKMAP_BASE)) >> PAGE_SHIFT)
+#define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
+#define kmap_prot		PAGE_KERNEL
+
+static inline void flush_cache_kmaps(void)
+{
+	cpu_dcache_wbinval_all();
+}
+
+/* declarations for highmem.c */
+extern unsigned long highstart_pfn, highend_pfn;
+
+extern pte_t *pkmap_page_table;
+
+extern void *kmap_high(struct page *page);
+extern void kunmap_high(struct page *page);
+
+extern void kmap_init(void);
+
+/*
+ * The following functions are already defined by <linux/highmem.h>
+ * when CONFIG_HIGHMEM is not set.
+ */
+#ifdef CONFIG_HIGHMEM
+extern void *kmap(struct page *page);
+extern void kunmap(struct page *page);
+extern void *kmap_atomic(struct page *page);
+extern void __kunmap_atomic(void *kvaddr);
+extern void *kmap_atomic_pfn(unsigned long pfn);
+extern struct page *kmap_atomic_to_page(void *ptr);
+#endif
+
+#endif
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
new file mode 100644
index 0000000..7891654
--- /dev/null
+++ b/arch/nds32/include/asm/memory.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_NDS32_MEMORY_H
+#define __ASM_NDS32_MEMORY_H
+
+#include <linux/compiler.h>
+#include <linux/sizes.h>
+
+#ifndef __ASSEMBLY__
+#include <asm/page.h>
+#endif
+
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET     (0x0)
+#endif
+
+#ifndef __virt_to_bus
+#define __virt_to_bus	__virt_to_phys
+#endif
+
+#ifndef __bus_to_virt
+#define __bus_to_virt	__phys_to_virt
+#endif
+
+/*
+ * TASK_SIZE - the maximum size of a user space task.
+ * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
+ */
+#define TASK_SIZE		((CONFIG_PAGE_OFFSET) - (SZ_32M))
+#define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_32M)
+#define PAGE_OFFSET		(CONFIG_PAGE_OFFSET)
+
+/*
+ * Physical vs virtual RAM address space conversion.  These are
+ * private definitions which should NOT be used outside memory.h
+ * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
+ */
+#ifndef __virt_to_phys
+#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+#endif
+
+/*
+ * The module space lives between the addresses given by TASK_SIZE
+ * and PAGE_OFFSET - it must be within 32MB of the kernel text.
+ */
+#define MODULES_END	(PAGE_OFFSET)
+#define MODULES_VADDR	(MODULES_END - SZ_32M)
+
+#if TASK_SIZE > MODULES_VADDR
+#error Top of user space clashes with start of module space
+#endif
+
+#ifndef __ASSEMBLY__
+
+/*
+ * PFNs are used to describe any physical page; this means
+ * PFN 0 == physical address 0.
+ *
+ * This is the PFN of the first RAM page in the kernel
+ * direct-mapped view.  We assume this is the first page
+ * of RAM in the mem_map as well.
+ */
+#define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
+
+/*
+ * Drivers should NOT use these either.
+ */
+#define __pa(x)			__virt_to_phys((unsigned long)(x))
+#define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+
+/*
+ * Conversion between a struct page and a physical address.
+ *
+ * Note: when converting an unknown physical address to a
+ * struct page, the resulting pointer must be validated
+ * using VALID_PAGE().  It must return an invalid struct page
+ * for any physical address not corresponding to a system
+ * RAM address.
+ *
+ *  pfn_valid(pfn)	indicates whether a PFN number is valid
+ *
+ *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
+ *  virt_addr_valid(k)	indicates whether a virtual address is valid
+ */
+#ifndef CONFIG_DISCONTIGMEM
+
+#define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
+#define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
+
+#define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
+#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
+
+#else /* CONFIG_DISCONTIGMEM */
+#error CONFIG_DISCONTIGMEM is not supported yet.
+#endif /* !CONFIG_DISCONTIGMEM */
+
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
+
+#endif
+
+#include <asm-generic/memory_model.h>
+
+#endif
diff --git a/arch/nds32/include/asm/mmu.h b/arch/nds32/include/asm/mmu.h
new file mode 100644
index 0000000..147fd06
--- /dev/null
+++ b/arch/nds32/include/asm/mmu.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __NDS32_MMU_H
+#define __NDS32_MMU_H
+
+typedef struct {
+	unsigned int id;
+	void *vdso;
+} mm_context_t;
+
+#endif
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
new file mode 100644
index 0000000..7e93d69
--- /dev/null
+++ b/arch/nds32/include/asm/page.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASMNDS32_PAGE_H
+#define _ASMNDS32_PAGE_H
+
+#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
+#define PAGE_SHIFT      12
+#endif
+#ifdef CONFIG_ANDES_PAGE_SIZE_8KB
+#define PAGE_SHIFT      13
+#endif
+#include <linux/const.h>
+#define PAGE_SIZE       (_AC(1,UL) << PAGE_SHIFT)
+#define PAGE_MASK       (~(PAGE_SIZE-1))
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+struct page;
+struct vm_area_struct;
+#ifndef CONFIG_CPU_CACHE_NONALIASING
+extern void copy_user_highpage(struct page *to, struct page *from,
+			       unsigned long vaddr, struct vm_area_struct *vma);
+extern void clear_user_highpage(struct page *page, unsigned long vaddr);
+
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
+#define clear_user_highpage	clear_user_highpage
+#else
+#define clear_user_page(page, vaddr, pg)        clear_page(page)
+#define copy_user_page(to, from, vaddr, pg)     copy_page(to, from)
+#endif
+
+void clear_page(void *page);
+void copy_page(void *to, void *from);
+
+typedef unsigned long pte_t;
+typedef unsigned long pmd_t;
+typedef unsigned long pgd_t;
+typedef unsigned long pgprot_t;
+
+#define pte_val(x)      (x)
+#define pmd_val(x)      (x)
+#define pgd_val(x)	(x)
+#define pgprot_val(x)   (x)
+
+#define __pte(x)        (x)
+#define __pmd(x)        (x)
+#define __pgd(x)        (x)
+#define __pgprot(x)     (x)
+
+typedef struct page *pgtable_t;
+
+#include <asm/memory.h>
+#include <asm-generic/getorder.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
new file mode 100644
index 0000000..0b7530b
--- /dev/null
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASMNDS32_PGALLOC_H
+#define _ASMNDS32_PGALLOC_H
+
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/proc-fns.h>
+
+/*
+ * Since we have only two-level page tables, these are trivial
+ */
+#define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
+#define pmd_free(mm, pmd)			do { } while (0)
+#define pgd_populate(mm, pmd, pte)	BUG()
+#define pmd_pgtable(pmd) pmd_page(pmd)
+
+extern pgd_t *pgd_alloc(struct mm_struct *mm);
+extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
+
+#define check_pgt_cache()		do { } while (0)
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long addr)
+{
+	pte_t *pte;
+
+	pte =
+	    (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+				      __GFP_ZERO);
+
+	return pte;
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	pgtable_t pte;
+
+	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO, 0);
+	if (pte)
+		cpu_dcache_wb_page((unsigned long)page_address(pte));
+
+	return pte;
+}
+
+/*
+ * Free one PTE table.
+ */
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t * pte)
+{
+	if (pte) {
+		free_page((unsigned long)pte);
+	}
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
+{
+	__free_page(pte);
+}
+
+/*
+ * Populate the pmdp entry with a pointer to the pte.  This pmd is part
+ * of the mm address space.
+ *
+ * Ensure that we always set both PMD entries.
+ */
+static inline void
+pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmdp, pte_t * ptep)
+{
+	unsigned long pte_ptr = (unsigned long)ptep;
+	unsigned long pmdval;
+
+	BUG_ON(mm != &init_mm);
+
+	/*
+	 * The pmd must be loaded with the physical
+	 * address of the PTE table
+	 */
+	pmdval = __pa(pte_ptr) | _PAGE_KERNEL_TABLE;
+	set_pmd(pmdp, __pmd(pmdval));
+}
+
+static inline void
+pmd_populate(struct mm_struct *mm, pmd_t * pmdp, pgtable_t ptep)
+{
+	unsigned long pmdval;
+
+	BUG_ON(mm == &init_mm);
+
+	pmdval = page_to_pfn(ptep) << PAGE_SHIFT | _PAGE_USER_TABLE;
+	set_pmd(pmdp, __pmd(pmdval));
+}
+
+#endif
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
new file mode 100644
index 0000000..a09f1f8
--- /dev/null
+++ b/arch/nds32/include/asm/pgtable.h
@@ -0,0 +1,426 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASMNDS32_PGTABLE_H
+#define _ASMNDS32_PGTABLE_H
+
+#define __PAGETABLE_PMD_FOLDED
+#include <asm-generic/4level-fixup.h>
+#include <asm-generic/sizes.h>
+
+#include <asm/memory.h>
+#include <asm/nds32.h>
+#ifndef __ASSEMBLY__
+#include <asm/fixmap.h>
+#include <asm-generic/io.h>
+#include <nds32_intrinsic.h>
+#endif
+
+#ifdef CONFIG_CACHE_L2
+#include <asm/l2_cache.h>
+#endif
+
+#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
+#define PGDIR_SHIFT      22
+#define PTRS_PER_PGD     1024
+#define PMD_SHIFT        22
+#define PTRS_PER_PMD     1
+#define PTRS_PER_PTE     1024
+#endif
+
+#ifdef CONFIG_ANDES_PAGE_SIZE_8KB
+#define PGDIR_SHIFT      24
+#define PTRS_PER_PGD     256
+#define PMD_SHIFT        24
+#define PTRS_PER_PMD     1
+#define PTRS_PER_PTE     2048
+#endif
+
+#ifndef __ASSEMBLY__
+extern void __pte_error(const char *file, int line, unsigned long val);
+extern void __pmd_error(const char *file, int line, unsigned long val);
+extern void __pgd_error(const char *file, int line, unsigned long val);
+
+#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
+#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
+#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
+#endif /* !__ASSEMBLY__ */
+
+#define PMD_SIZE		(1UL << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE-1))
+#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+/*
+ * This is the lowest virtual address we can permit any user space
+ * mapping to be mapped at.  This is particularly important for
+ * non-high vector CPUs.
+ */
+#define FIRST_USER_ADDRESS	0x8000
+
+#ifdef CONFIG_HIGHMEM
+#define CONSISTENT_BASE		((PKMAP_BASE) - (SZ_2M))
+#define CONSISTENT_END		(PKMAP_BASE)
+#else
+#define CONSISTENT_BASE		(FIXADDR_START - SZ_2M)
+#define CONSISTENT_END		(FIXADDR_START)
+#endif
+#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
+
+#ifdef CONFIG_HIGHMEM
+#ifndef __ASSEMBLY__
+#include <asm/highmem.h>
+#endif
+#endif
+
+#define VMALLOC_RESERVE 	SZ_128M
+#define VMALLOC_END		(CONSISTENT_BASE - PAGE_SIZE)
+#define VMALLOC_START		((VMALLOC_END) - VMALLOC_RESERVE)
+#define VMALLOC_VMADDR(x)	((unsigned long)(x))
+#define MAXMEM			__pa(VMALLOC_START)
+#define MAXMEM_PFN		PFN_DOWN(MAXMEM)
+
+#define FIRST_USER_PGD_NR	0
+#define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) + FIRST_USER_PGD_NR)
+
+/* L2 PTE */
+#define _PAGE_V			(1UL << 0)
+
+#define _PAGE_M_XKRW            (0UL << 1)
+#define _PAGE_M_UR_KR		(1UL << 1)
+#define _PAGE_M_UR_KRW		(2UL << 1)
+#define _PAGE_M_URW_KRW		(3UL << 1)
+#define _PAGE_M_KR		(5UL << 1)
+#define _PAGE_M_KRW		(7UL << 1)
+
+#define _PAGE_D			(1UL << 4)
+#define _PAGE_E			(1UL << 5)
+#define _PAGE_A			(1UL << 6)
+#define _PAGE_G			(1UL << 7)
+
+#define _PAGE_C_DEV		(0UL << 8)
+#define _PAGE_C_DEV_WB		(1UL << 8)
+#define _PAGE_C_MEM		(2UL << 8)
+#define _PAGE_C_MEM_SHRD_WB	(4UL << 8)
+#define _PAGE_C_MEM_SHRD_WT	(5UL << 8)
+#define _PAGE_C_MEM_WB		(6UL << 8)
+#define _PAGE_C_MEM_WT		(7UL << 8)
+
+#define _PAGE_L			(1UL << 11)
+
+#define _HAVE_PAGE_L		(_PAGE_L)
+#define _PAGE_FILE		(1UL << 1)
+#define _PAGE_YOUNG		0
+#define _PAGE_M_MASK		_PAGE_M_KRW
+#define _PAGE_C_MASK		_PAGE_C_MEM_WT
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
+#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_SHRD_WT
+#else
+#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_SHRD_WB
+#endif
+#else
+#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
+#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_WT
+#else
+#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_WB
+#endif
+#endif
+
+#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
+#define _PAGE_CACHE		_PAGE_C_MEM_WT
+#else
+#define _PAGE_CACHE		_PAGE_C_MEM_WB
+#endif
+
+/*
+ * + Level 1 descriptor (PMD)
+ */
+#define PMD_TYPE_TABLE		0
+
+#ifndef __ASSEMBLY__
+
+#define _PAGE_USER_TABLE     PMD_TYPE_TABLE
+#define _PAGE_KERNEL_TABLE   PMD_TYPE_TABLE
+
+#define PAGE_EXEC	__pgprot(_PAGE_V | _PAGE_M_XKRW | _PAGE_E)
+#define PAGE_NONE	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_A)
+#define PAGE_READ	__pgprot(_PAGE_V | _PAGE_M_UR_KR)
+#define PAGE_RDWR	__pgprot(_PAGE_V | _PAGE_M_URW_KRW | _PAGE_D)
+#define PAGE_COPY	__pgprot(_PAGE_V | _PAGE_M_UR_KR)
+
+#define PAGE_UXKRWX_V1	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_UXKRWX_V2	__pgprot(_PAGE_V | _PAGE_M_XKRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_URXKRWX_V2	__pgprot(_PAGE_V | _PAGE_M_UR_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_CACHE_L1	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE)
+#define PAGE_MEMORY	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_KERNEL	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
+#define PAGE_DEVICE    __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
+#endif /* __ASSEMBLY__ */
+
+/*         xwr */
+#define __P000  (PAGE_NONE | _PAGE_CACHE_SHRD)
+#define __P001  (PAGE_READ | _PAGE_CACHE_SHRD)
+#define __P010  (PAGE_COPY | _PAGE_CACHE_SHRD)
+#define __P011  (PAGE_COPY | _PAGE_CACHE_SHRD)
+#define __P100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
+#define __P101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
+#define __P110  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
+#define __P111  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
+
+#define __S000  (PAGE_NONE | _PAGE_CACHE_SHRD)
+#define __S001  (PAGE_READ | _PAGE_CACHE_SHRD)
+#define __S010  (PAGE_RDWR | _PAGE_CACHE_SHRD)
+#define __S011  (PAGE_RDWR | _PAGE_CACHE_SHRD)
+#define __S100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
+#define __S101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
+#define __S110  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
+#define __S111  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
+
+#ifndef __ASSEMBLY__
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern struct page *empty_zero_page;
+extern void paging_init(void);
+#define ZERO_PAGE(vaddr)	(empty_zero_page)
+
+#define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
+#define pfn_pte(pfn,prot)	(__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
+
+#define pte_none(pte)	        !(pte_val(pte))
+#define pte_clear(mm,addr,ptep)	set_pte_at((mm),(addr),(ptep), __pte(0))
+#define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
+
+#define pte_index(address)                   (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_offset_kernel(dir, address)	     ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
+#define pte_offset_map(dir, address)	     ((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address)  pte_offset_map(dir, address)
+#define pmd_page_kernel(pmd)	  	     ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+
+#define pte_unmap(pte)		do { } while (0)
+#define pte_unmap_nested(pte)	do { } while (0)
+
+#define pmd_off_k(address)	pmd_offset(pgd_offset_k(address), address)
+
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+/*
+ * Set a level 1 translation table entry, and clean it out of
+ * any caches such that the MMUs can load it correctly.
+ */
+static inline void set_pmd(pmd_t * pmdp, pmd_t pmd)
+{
+
+	*pmdp = pmd;
+#if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
+	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (pmdp):"memory");
+	__nds32__msync_all();
+	__nds32__dsb();
+#endif
+}
+
+/*
+ * Set a PTE and flush it out
+ */
+static inline void set_pte(pte_t * ptep, pte_t pte)
+{
+
+	*ptep = pte;
+#if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
+	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (ptep):"memory");
+	__nds32__msync_all();
+	__nds32__dsb();
+#endif
+}
+
+/*
+ * The following only work if pte_present() is true.
+ * Undefined behaviour if not..
+ */
+
+/*
+ * pte_write: 	     this page is writeable for user mode
+ * pte_read:         this page is readable for user mode
+ * pte_kernel_write: this page is writeable for kernel mode
+ *
+ * We don't have pte_kernel_read because kernel always can read.
+ *
+ * */
+
+#define pte_present(pte)        (pte_val(pte) & _PAGE_V)
+#define pte_write(pte)          ((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW)
+#define pte_read(pte)		(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KR) || \
+				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
+				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW))
+#define pte_kernel_write(pte)   (((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW) || \
+				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
+				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_KRW) || \
+				(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_XKRW) && pte_exec(pte)))
+#define pte_exec(pte)		(pte_val(pte) & _PAGE_E)
+#define pte_dirty(pte)		(pte_val(pte) & _PAGE_D)
+#define pte_young(pte)		(pte_val(pte) & _PAGE_YOUNG)
+
+/*
+ * The following only works if pte_present() is not true.
+ */
+#define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
+#define pte_to_pgoff(x)		(pte_val(x) >> 2)
+#define pgoff_to_pte(x)		__pte(((x) << 2) | _PAGE_FILE)
+
+#define PTE_FILE_MAX_BITS	29
+
+#define PTE_BIT_FUNC(fn,op) \
+static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
+	pte_val(pte) = pte_val(pte) | _PAGE_M_UR_KR;
+	return pte;
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
+	pte_val(pte) = pte_val(pte) | _PAGE_M_URW_KRW;
+	return pte;
+}
+
+PTE_BIT_FUNC(exprotect, &=~_PAGE_E);
+PTE_BIT_FUNC(mkexec, |=_PAGE_E);
+PTE_BIT_FUNC(mkclean, &=~_PAGE_D);
+PTE_BIT_FUNC(mkdirty, |=_PAGE_D);
+PTE_BIT_FUNC(mkold, &=~_PAGE_YOUNG);
+PTE_BIT_FUNC(mkyoung, |=_PAGE_YOUNG);
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
+
+/*
+ * Mark the prot value as uncacheable and unbufferable.
+ */
+#define pgprot_noncached(prot)	   __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV)
+#define pgprot_writecombine(prot)  __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV_WB)
+
+#define pmd_none(pmd)         (pmd_val(pmd)&0x1)
+#define pmd_present(pmd)      (!pmd_none(pmd))
+#define	pmd_bad(pmd)	      pmd_none(pmd)
+
+#define copy_pmd(pmdpd,pmdps)	set_pmd((pmdpd), *(pmdps))
+#define pmd_clear(pmdp)		set_pmd((pmdp), __pmd(1))
+
+static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
+{
+	unsigned long ptr = (unsigned long)ptep;
+	pmd_t pmd;
+
+	/*
+	 * The pmd must be loaded with the physical
+	 * address of the PTE table
+	 */
+
+	pmd_val(pmd) = __virt_to_phys(ptr) | prot;
+	return pmd;
+}
+
+#define pmd_page(pmd)        virt_to_page(__va(pmd_val(pmd)))
+
+/*
+ * Permanent address of a page. We never have highmem, so this is trivial.
+ */
+#define pages_to_mb(x)       ((x) >> (20 - PAGE_SHIFT))
+
+/*
+ * Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ */
+#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
+
+/*
+ * The "pgd_xxx()" functions here are trivial for a folded two-level
+ * setup: the pgd is never bad, and a pmd always exists (as it's folded
+ * into the pgd entry)
+ */
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_present(pgd)  	(1)
+#define pgd_clear(pgdp)		do { } while (0)
+
+#define page_pte_prot(page,prot)     	mk_pte(page, prot)
+#define page_pte(page)		        mk_pte(page, __pgprot(0))
+/*
+ *     L1PTE = $mr1 + ((virt >> PMD_SHIFT) << 2);
+ *     L2PTE = (((virt >> PAGE_SHIFT) & (PTRS_PER_PTE -1 )) << 2);
+ *     PPN = (phys & 0xfffff000);
+ *
+*/
+
+/* to find an entry in a page-table-directory */
+#define pgd_index(address)      (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
+/* to find an entry in a kernel page-table-directory */
+#define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(dir, addr)	((pmd_t *)(dir))
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	const unsigned long mask = 0xfff;
+	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+	return pte;
+}
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
+/* Encode and decode a swap entry.
+ *
+ * We support up to 32GB of swap on 4k machines
+ */
+#define __swp_type(x)	 	     (((x).val >> 2) & 0x7f)
+#define __swp_offset(x)	   	     ((x).val >> 9)
+#define __swp_entry(type,offset)     ((swp_entry_t) { ((type) << 2) | ((offset) << 9) })
+#define __pte_to_swp_entry(pte)	     ((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(swp)	     ((pte_t) { (swp).val })
+
+/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
+#define kern_addr_valid(addr)	(1)
+
+#include <asm-generic/pgtable.h>
+
+/*
+ * We provide our own arch_get_unmapped_area to cope with VIPT caches.
+ */
+#define HAVE_ARCH_UNMAPPED_AREA
+
+/*
+ * remap a physical address `phys' of size `size' with page protection `prot'
+ * into virtual address `from'
+ */
+
+#define pgtable_cache_init()       do { } while (0)
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASMNDS32_PGTABLE_H */
diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
new file mode 100644
index 0000000..f05c539
--- /dev/null
+++ b/arch/nds32/include/asm/shmparam.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASMNDS32_SHMPARAM_H
+#define _ASMNDS32_SHMPARAM_H
+
+/*
+ * This should be the size of the virtually indexed cache/ways,
+ * whichever is greater since the cache aliases every size/ways
+ * bytes.
+ */
+#define	SHMLBA	(4 * SZ_8K)	/* attach addr a multiple of this */
+
+/*
+ * Enforce SHMLBA in shmat
+ */
+#define __ARCH_FORCE_SHMLBA
+
+#endif /* _ASMNDS32_SHMPARAM_H */
-- 
1.7.9.5
