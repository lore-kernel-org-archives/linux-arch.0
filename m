From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 7/9] RISC-V: Paging and MMU
Date: Wed, 28 Jun 2017 11:55:36 -0700
Message-ID: <20170628185538.1804-8-palmer@dabbelt.com>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628185538.1804-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

This patch contains code to manage the RISC-V MMU, including definitions
of the page tables and the page walking code.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/mmu_context.h  |  69 ++++++
 arch/riscv/include/asm/page.h         | 138 +++++++++++
 arch/riscv/include/asm/pgalloc.h      | 124 ++++++++++
 arch/riscv/include/asm/pgtable-32.h   |  25 ++
 arch/riscv/include/asm/pgtable-64.h   |  84 +++++++
 arch/riscv/include/asm/pgtable-bits.h |  48 ++++
 arch/riscv/include/asm/pgtable.h      | 427 ++++++++++++++++++++++++++++++++++
 arch/riscv/mm/fault.c                 | 280 ++++++++++++++++++++++
 8 files changed, 1195 insertions(+)
 create mode 100644 arch/riscv/include/asm/mmu_context.h
 create mode 100644 arch/riscv/include/asm/page.h
 create mode 100644 arch/riscv/include/asm/pgalloc.h
 create mode 100644 arch/riscv/include/asm/pgtable-32.h
 create mode 100644 arch/riscv/include/asm/pgtable-64.h
 create mode 100644 arch/riscv/include/asm/pgtable-bits.h
 create mode 100644 arch/riscv/include/asm/pgtable.h
 create mode 100644 arch/riscv/mm/fault.c

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
new file mode 100644
index 000000000000..de1fc1631fc4
--- /dev/null
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_MMU_CONTEXT_H
+#define _ASM_RISCV_MMU_CONTEXT_H
+
+#include <asm-generic/mm_hooks.h>
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <asm/tlbflush.h>
+
+static inline void enter_lazy_tlb(struct mm_struct *mm,
+	struct task_struct *task)
+{
+}
+
+/* Initialize context-related info for a new mm_struct */
+static inline int init_new_context(struct task_struct *task,
+	struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void destroy_context(struct mm_struct *mm)
+{
+}
+
+static inline pgd_t *current_pgdir(void)
+{
+	return pfn_to_virt(csr_read(sptbr) & SPTBR_PPN);
+}
+
+static inline void set_pgdir(pgd_t *pgd)
+{
+	csr_write(sptbr, virt_to_pfn(pgd) | SPTBR_MODE);
+}
+
+static inline void switch_mm(struct mm_struct *prev,
+	struct mm_struct *next, struct task_struct *task)
+{
+	if (likely(prev != next)) {
+		set_pgdir(next->pgd);
+		local_flush_tlb_all();
+	}
+}
+
+static inline void activate_mm(struct mm_struct *prev,
+			       struct mm_struct *next)
+{
+	switch_mm(prev, next, NULL);
+}
+
+static inline void deactivate_mm(struct task_struct *task,
+	struct mm_struct *mm)
+{
+}
+
+#endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
new file mode 100644
index 000000000000..e1491c20d6fd
--- /dev/null
+++ b/arch/riscv/include/asm/page.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2017 XiaojingZhu <zhuxiaoj@ict.ac.cn>
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PAGE_H
+#define _ASM_RISCV_PAGE_H
+
+#include <linux/pfn.h>
+#include <linux/const.h>
+
+#define PAGE_SHIFT	(12)
+#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+
+#ifdef __KERNEL__
+
+/*
+ * PAGE_OFFSET -- the first address of the first page of memory.
+ * When not using MMU this corresponds to the first free page in
+ * physical memory (aligned on a page boundary).
+ */
+#ifdef CONFIG_64BIT
+#define PAGE_OFFSET		_AC(0xffffffff80000000, UL)
+#else
+#define PAGE_OFFSET		_AC(0xc0000000, UL)
+#endif
+
+#define KERN_VIRT_SIZE (-PAGE_OFFSET)
+
+#ifndef __ASSEMBLY__
+
+#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
+#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
+
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
+
+/* align addr on a size boundary - adjust address up if needed */
+#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
+
+#define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
+#define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)
+
+#define clear_user_page(pgaddr, vaddr, page)	memset((pgaddr), 0, PAGE_SIZE)
+#define copy_user_page(vto, vfrom, vaddr, topg) \
+			memcpy((vto), (vfrom), PAGE_SIZE)
+
+/*
+ * Use struct definitions to apply C type checking
+ */
+
+/* Page Global Directory entry */
+typedef struct {
+	unsigned long pgd;
+} pgd_t;
+
+/* Page Table entry */
+typedef struct {
+	unsigned long pte;
+} pte_t;
+
+typedef struct {
+	unsigned long pgprot;
+} pgprot_t;
+
+typedef struct page *pgtable_t;
+
+#define pte_val(x)	((x).pte)
+#define pgd_val(x)	((x).pgd)
+#define pgprot_val(x)	((x).pgprot)
+
+#define __pte(x)	((pte_t) { (x) })
+#define __pgd(x)	((pgd_t) { (x) })
+#define __pgprot(x)	((pgprot_t) { (x) })
+
+#ifdef CONFIG_64BITS
+#define PTE_FMT "%016lx"
+#else
+#define PTE_FMT "%08lx"
+#endif
+
+extern unsigned long va_pa_offset;
+extern unsigned long pfn_base;
+
+extern unsigned long max_low_pfn;
+extern unsigned long min_low_pfn;
+
+#define __pa(x)		((unsigned long)(x) - va_pa_offset)
+#define __va(x)		((void *)((unsigned long) (x) + va_pa_offset))
+
+#define phys_to_pfn(phys)	(PFN_DOWN(phys))
+#define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
+
+#define virt_to_pfn(vaddr)	(phys_to_pfn(__pa(vaddr)))
+#define pfn_to_virt(pfn)	(__va(pfn_to_phys(pfn)))
+
+#define virt_to_page(vaddr)	(pfn_to_page(virt_to_pfn(vaddr)))
+#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
+
+#define page_to_phys(page)	(pfn_to_phys(page_to_pfn(page)))
+#define page_to_bus(page)	(page_to_phys(page))
+#define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
+
+#define pfn_valid(pfn) \
+	(((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
+
+#define ARCH_PFN_OFFSET		(pfn_base)
+
+#endif /* __ASSEMBLY__ */
+
+#define virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
+
+#endif /* __KERNEL__ */
+
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#include <asm-generic/memory_model.h>
+#include <asm-generic/getorder.h>
+
+/* vDSO support */
+/* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
+#define __HAVE_ARCH_GATE_AREA
+
+#endif /* _ASM_RISCV_PAGE_H */
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
new file mode 100644
index 000000000000..b40074bcb164
--- /dev/null
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGALLOC_H
+#define _ASM_RISCV_PGALLOC_H
+
+#include <linux/mm.h>
+#include <asm/tlb.h>
+
+static inline void pmd_populate_kernel(struct mm_struct *mm,
+	pmd_t *pmd, pte_t *pte)
+{
+	unsigned long pfn = virt_to_pfn(pte);
+
+	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+
+static inline void pmd_populate(struct mm_struct *mm,
+	pmd_t *pmd, pgtable_t pte)
+{
+	unsigned long pfn = virt_to_pfn(page_address(pte));
+
+	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	unsigned long pfn = virt_to_pfn(pmd);
+
+	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+#define pmd_pgtable(pmd)	pmd_page(pmd)
+
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd;
+
+	pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	if (likely(pgd != NULL)) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		/* Copy kernel mappings */
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			init_mm.pgd + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	free_page((unsigned long)pgd);
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return (pmd_t *)__get_free_page(
+		GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	free_page((unsigned long)pmd);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+	unsigned long address)
+{
+	return (pte_t *)__get_free_page(
+		GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+}
+
+static inline struct page *pte_alloc_one(struct mm_struct *mm,
+	unsigned long address)
+{
+	struct page *pte;
+
+	pte = alloc_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+	if (likely(pte != NULL))
+		pgtable_page_ctor(pte);
+	return pte;
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
+{
+	pgtable_page_dtor(pte);
+	__free_page(pte);
+}
+
+#define __pte_free_tlb(tlb, pte, buf)   \
+do {                                    \
+	pgtable_page_dtor(pte);         \
+	tlb_remove_page((tlb), pte);    \
+} while (0)
+
+static inline void check_pgt_cache(void)
+{
+}
+
+#endif /* _ASM_RISCV_PGALLOC_H */
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
new file mode 100644
index 000000000000..d61974b74182
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_32_H
+#define _ASM_RISCV_PGTABLE_32_H
+
+#include <asm-generic/pgtable-nopmd.h>
+#include <linux/const.h>
+
+/* Size of region mapped by a page global directory */
+#define PGDIR_SHIFT     22
+#define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK      (~(PGDIR_SIZE - 1))
+
+#endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
new file mode 100644
index 000000000000..7aa0ea9bd8bb
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_64_H
+#define _ASM_RISCV_PGTABLE_64_H
+
+#include <linux/const.h>
+
+#define PGDIR_SHIFT     30
+/* Size of region mapped by a page global directory */
+#define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK      (~(PGDIR_SIZE - 1))
+
+#define PMD_SHIFT       21
+/* Size of region mapped by a page middle directory */
+#define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK        (~(PMD_SIZE - 1))
+
+/* Page Middle Directory entry */
+typedef struct {
+	unsigned long pmd;
+} pmd_t;
+
+#define pmd_val(x)      ((x).pmd)
+#define __pmd(x)        ((pmd_t) { (x) })
+
+#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+
+static inline int pud_present(pud_t pud)
+{
+	return (pud_val(pud) & _PAGE_PRESENT);
+}
+
+static inline int pud_none(pud_t pud)
+{
+	return (pud_val(pud) == 0);
+}
+
+static inline int pud_bad(pud_t pud)
+{
+	return !pud_present(pud);
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pud)
+{
+	*pudp = pud;
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	set_pud(pudp, __pud(0));
+}
+
+static inline unsigned long pud_page_vaddr(pud_t pud)
+{
+	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+}
+
+#define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
+{
+	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
+}
+
+static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+{
+	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+#define pmd_ERROR(e) \
+	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+
+#endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
new file mode 100644
index 000000000000..997ddbb1d370
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_BITS_H
+#define _ASM_RISCV_PGTABLE_BITS_H
+
+/*
+ * PTE format:
+ * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ */
+
+#define _PAGE_ACCESSED_OFFSET 6
+
+#define _PAGE_PRESENT   (1 << 0)
+#define _PAGE_READ      (1 << 1)    /* Readable */
+#define _PAGE_WRITE     (1 << 2)    /* Writable */
+#define _PAGE_EXEC      (1 << 3)    /* Executable */
+#define _PAGE_USER      (1 << 4)    /* User */
+#define _PAGE_GLOBAL    (1 << 5)    /* Global */
+#define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
+#define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
+#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
+
+#define _PAGE_SPECIAL   _PAGE_SOFT
+#define _PAGE_TABLE     _PAGE_PRESENT
+
+#define _PAGE_PFN_SHIFT 10
+
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL))
+
+/* Advertise support for _PAGE_SPECIAL */
+#define __HAVE_ARCH_PTE_SPECIAL
+
+#endif /* _ASM_RISCV_PGTABLE_BITS_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
new file mode 100644
index 000000000000..8bb44014f5c3
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable.h
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_H
+#define _ASM_RISCV_PGTABLE_H
+
+#include <linux/mmzone.h>
+
+#include <asm/pgtable-bits.h>
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_MMU
+
+/* Page Upper Directory not used in RISC-V */
+#include <asm-generic/pgtable-nopud.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
+#include <linux/mm_types.h>
+
+#ifdef CONFIG_64BIT
+#include <asm/pgtable-64.h>
+#else
+#include <asm/pgtable-32.h>
+#endif /* CONFIG_64BIT */
+
+/* Number of entries in the page global directory */
+#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
+/* Number of entries in the page table */
+#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+
+/* Number of PGD entries that a user-mode program can use */
+#define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
+#define FIRST_USER_ADDRESS  0
+
+/* Page protection bits */
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
+
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_WRITE		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE)
+#define PAGE_EXEC		__pgprot(_PAGE_BASE | _PAGE_EXEC)
+#define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+#define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
+					 _PAGE_EXEC | _PAGE_WRITE)
+
+#define PAGE_COPY		PAGE_READ
+#define PAGE_COPY_EXEC		PAGE_EXEC
+#define PAGE_COPY_READ_EXEC	PAGE_READ_EXEC
+#define PAGE_SHARED		PAGE_WRITE
+#define PAGE_SHARED_EXEC	PAGE_WRITE_EXEC
+
+#define _PAGE_KERNEL		(_PAGE_READ \
+				| _PAGE_WRITE \
+				| _PAGE_PRESENT \
+				| _PAGE_ACCESSED \
+				| _PAGE_DIRTY)
+
+#define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+
+extern pgd_t swapper_pg_dir[];
+
+/* MAP_PRIVATE permissions: xwr (copy-on-write) */
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READ
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_EXEC
+#define __P101	PAGE_READ_EXEC
+#define __P110	PAGE_COPY_EXEC
+#define __P111	PAGE_COPY_READ_EXEC
+
+/* MAP_SHARED permissions: xwr */
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READ
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_EXEC
+#define __S101	PAGE_READ_EXEC
+#define __S110	PAGE_SHARED_EXEC
+#define __S111	PAGE_SHARED_EXEC
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero,
+ * used for zero-mapped memory areas, etc.
+ */
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PAGE_PRESENT);
+}
+
+static inline int pmd_none(pmd_t pmd)
+{
+	return (pmd_val(pmd) == 0);
+}
+
+static inline int pmd_bad(pmd_t pmd)
+{
+	return !pmd_present(pmd);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	set_pmd(pmdp, __pmd(0));
+}
+
+
+static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
+{
+	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+#define pgd_index(addr) (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+
+/* Locate an entry in the page global directory */
+static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
+{
+	return mm->pgd + pgd_index(addr);
+}
+/* Locate an entry in the kernel page global directory */
+#define pgd_offset_k(addr)      pgd_offset(&init_mm, (addr))
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+}
+
+static inline unsigned long pmd_page_vaddr(pmd_t pmd)
+{
+	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+}
+
+/* Yields the page frame number (PFN) of a page table entry */
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
+}
+
+#define pte_page(x)     pfn_to_page(pte_pfn(x))
+
+/* Constructs a page table entry */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
+{
+	return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+static inline pte_t mk_pte(struct page *page, pgprot_t prot)
+{
+	return pfn_pte(page_to_pfn(page), prot);
+}
+
+#define pte_index(addr) (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+
+static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long addr)
+{
+	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(addr);
+}
+
+#define pte_offset_map(dir, addr)	pte_offset_kernel((dir), (addr))
+#define pte_unmap(pte)			((void)(pte))
+
+/*
+ * Certain architectures need to do special things when PTEs within
+ * a page table are directly modified.  Thus, the following hook is
+ * made available.
+ */
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+}
+
+static inline void set_pte_at(struct mm_struct *mm,
+	unsigned long addr, pte_t *ptep, pte_t pteval)
+{
+	set_pte(ptep, pteval);
+}
+
+static inline void pte_clear(struct mm_struct *mm,
+	unsigned long addr, pte_t *ptep)
+{
+	set_pte_at(mm, addr, ptep, __pte(0));
+}
+
+static inline int pte_present(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT);
+}
+
+static inline int pte_none(pte_t pte)
+{
+	return (pte_val(pte) == 0);
+}
+
+/* static inline int pte_read(pte_t pte) */
+
+static inline int pte_write(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_WRITE;
+}
+
+static inline int pte_huge(pte_t pte)
+{
+	return pte_present(pte)
+		&& (pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+/* static inline int pte_exec(pte_t pte) */
+
+static inline int pte_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DIRTY;
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
+static inline int pte_special(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SPECIAL;
+}
+
+/* static inline pte_t pte_rdprotect(pte_t pte) */
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+}
+
+/* static inline pte_t pte_mkread(pte_t pte) */
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_WRITE);
+}
+
+/* static inline pte_t pte_mkexec(pte_t pte) */
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_DIRTY));
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_ACCESSED));
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+/* Modify page protection bits */
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))
+
+
+/* Commit new configuration to MMU hardware */
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep)
+{
+	/* The kernel assumes that TLBs don't cache invalid entries, but
+	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
+	 * cache flush; it is necessary even after writing invalid entries.
+	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
+	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
+	 */
+	local_flush_tlb_page(address);
+}
+
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+	return pte_val(pte_a) == pte_val(pte_b);
+}
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline int ptep_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pte_t *ptep,
+					pte_t entry, int dirty)
+{
+	if (!pte_same(*ptep, entry))
+		set_pte_at(vma->vm_mm, address, ptep, entry);
+	/* update_mmu_cache will unconditionally execute, handling both
+	 * the case that the PTE changed and the spurious fault case.
+	 */
+	return true;
+}
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+}
+
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+}
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pte_t *ptep)
+{
+	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+}
+
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	/*
+	 * This comment is borrowed from x86, but applies equally to RISC-V:
+	 *
+	 * Clearing the accessed bit without a TLB flush
+	 * doesn't cause data corruption. [ It could cause incorrect
+	 * page aging and the (mistaken) reclaim of hot pages, but the
+	 * chance of that should be relatively low. ]
+	 *
+	 * So as a performance optimization don't flush the TLB when
+	 * clearing the accessed bit, it will eventually be flushed by
+	 * a context switch or a VM operation anyway. [ In the rare
+	 * event of it not getting flushed for a long time the delay
+	 * shouldn't really matter because there's no real memory
+	 * pressure for swapout to react to. ]
+	 */
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
+/*
+ * Encode and decode a swap entry
+ *
+ * Format of swap PTE:
+ *	bit            0:	_PAGE_PRESENT (zero)
+ *	bit            1:	reserved for future use (zero)
+ *	bits      2 to 6:	swap type
+ *	bits 7 to XLEN-1:	swap offset
+ */
+#define __SWP_TYPE_SHIFT	2
+#define __SWP_TYPE_BITS		5
+#define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
+#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+
+#define MAX_SWAPFILES_CHECK()	\
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
+
+#define __swp_type(x)	(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
+#define __swp_offset(x)	((x).val >> __SWP_OFFSET_SHIFT)
+#define __swp_entry(type, offset) ((swp_entry_t) \
+	{ ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+#ifdef CONFIG_FLATMEM
+#define kern_addr_valid(addr)   (1) /* FIXME */
+#endif
+
+extern void paging_init(void);
+
+static inline void pgtable_cache_init(void)
+{
+	/* No page table caches to initialize */
+}
+
+#endif /* CONFIG_MMU */
+
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+/* Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
+ * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
+ */
+#ifdef CONFIG_64BIT
+#define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#else
+#define TASK_SIZE VMALLOC_START
+#endif
+
+#include <asm-generic/pgtable.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PGTABLE_H */
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
new file mode 100644
index 000000000000..b2a431c7f233
--- /dev/null
+++ b/arch/riscv/mm/fault.c
@@ -0,0 +1,280 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/perf_event.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+
+#include <asm/pgalloc.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+
+/*
+ * This routine handles page faults.  It determines the address and the
+ * problem, and then passes it off to one of the appropriate routines.
+ */
+asmlinkage void do_page_fault(struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long addr, cause;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	int fault, code = SEGV_MAPERR;
+
+	cause = regs->scause;
+	addr = regs->sbadaddr;
+
+	tsk = current;
+	mm = tsk->mm;
+
+	/*
+	 * Fault-in kernel-space virtual memory on-demand.
+	 * The 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 */
+	if (unlikely((addr >= VMALLOC_START) && (addr <= VMALLOC_END)))
+		goto vmalloc_fault;
+
+	/* Enable interrupts if they were enabled in the parent context. */
+	if (likely(regs->sstatus & SR_PIE))
+		local_irq_enable();
+
+	/*
+	 * If we're in an interrupt, have no user context, or are running
+	 * in an atomic region, then we must not take the fault.
+	 */
+	if (unlikely(faulthandler_disabled() || !mm))
+		goto no_context;
+
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
+
+retry:
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, addr);
+	if (unlikely(!vma))
+		goto bad_area;
+	if (likely(vma->vm_start <= addr))
+		goto good_area;
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		goto bad_area;
+	if (unlikely(expand_stack(vma, addr)))
+		goto bad_area;
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it.
+	 */
+good_area:
+	code = SEGV_ACCERR;
+
+	switch (cause) {
+	case EXC_INST_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_EXEC))
+			goto bad_area;
+		break;
+	case EXC_LOAD_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_READ))
+			goto bad_area;
+		break;
+	case EXC_STORE_PAGE_FAULT:
+		if (!(vma->vm_flags & VM_WRITE))
+			goto bad_area;
+		flags |= FAULT_FLAG_WRITE;
+		break;
+	default:
+		panic("%s: unhandled cause %lu", __func__, cause);
+	}
+
+	/*
+	 * If for any reason at all we could not handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+	fault = handle_mm_fault(vma, addr, flags);
+
+	/*
+	 * If we need to retry but a fatal signal is pending, handle the
+	 * signal first. We do not need to release the mmap_sem because it
+	 * would already be released in __lock_page_or_retry in mm/filemap.c.
+	 */
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
+		return;
+
+	if (unlikely(fault & VM_FAULT_ERROR)) {
+		if (fault & VM_FAULT_OOM)
+			goto out_of_memory;
+		else if (fault & VM_FAULT_SIGBUS)
+			goto do_sigbus;
+		BUG();
+	}
+
+	/*
+	 * Major/minor page fault accounting is only done on the
+	 * initial attempt. If we go through a retry, it is extremely
+	 * likely that the page will be found in page cache at that point.
+	 */
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR) {
+			tsk->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+				      1, regs, addr);
+		} else {
+			tsk->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+				      1, regs, addr);
+		}
+		if (fault & VM_FAULT_RETRY) {
+			/*
+			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
+			 * of starvation.
+			 */
+			flags &= ~(FAULT_FLAG_ALLOW_RETRY);
+			flags |= FAULT_FLAG_TRIED;
+
+			/*
+			 * No need to up_read(&mm->mmap_sem) as we would
+			 * have already released it in __lock_page_or_retry
+			 * in mm/filemap.c.
+			 */
+			goto retry;
+		}
+	}
+
+	up_read(&mm->mmap_sem);
+	return;
+
+	/*
+	 * Something tried to access memory that isn't in our memory map.
+	 * Fix it, but check if it's kernel or user first.
+	 */
+bad_area:
+	up_read(&mm->mmap_sem);
+	/* User mode accesses just cause a SIGSEGV */
+	if (user_mode(regs)) {
+		do_trap(regs, SIGSEGV, code, addr, tsk);
+		return;
+	}
+
+no_context:
+	/* Are we prepared to handle this kernel fault? */
+	if (fixup_exception(regs))
+		return;
+
+	/*
+	 * Oops. The kernel tried to access some bad page. We'll have to
+	 * terminate things with extreme prejudice.
+	 */
+	bust_spinlocks(1);
+	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
+		(addr < PAGE_SIZE) ? "NULL pointer dereference" :
+		"paging request", addr);
+	die(regs, "Oops");
+	do_exit(SIGKILL);
+
+	/*
+	 * We ran out of memory, call the OOM killer, and return the userspace
+	 * (which will retry the fault, or kill us if we got oom-killed).
+	 */
+out_of_memory:
+	up_read(&mm->mmap_sem);
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
+
+do_sigbus:
+	up_read(&mm->mmap_sem);
+	/* Kernel mode? Handle exceptions or die */
+	if (!user_mode(regs))
+		goto no_context;
+	do_trap(regs, SIGBUS, BUS_ADRERR, addr, tsk);
+	return;
+
+vmalloc_fault:
+	{
+		pgd_t *pgd, *pgd_k;
+		pud_t *pud, *pud_k;
+		p4d_t *p4d, *p4d_k;
+		pmd_t *pmd, *pmd_k;
+		pte_t *pte_k;
+		int index;
+
+		if (user_mode(regs))
+			goto bad_area;
+
+		/*
+		 * Synchronize this task's top level page-table
+		 * with the 'reference' page table.
+		 *
+		 * Do _not_ use "tsk->active_mm->pgd" here.
+		 * We might be inside an interrupt in the middle
+		 * of a task switch.
+		 */
+		index = pgd_index(addr);
+		pgd = (pgd_t *)pfn_to_virt(csr_read(sptbr)) + index;
+		pgd_k = init_mm.pgd + index;
+
+		if (!pgd_present(*pgd_k))
+			goto no_context;
+		set_pgd(pgd, *pgd_k);
+
+		p4d = p4d_offset(pgd, addr);
+		p4d_k = p4d_offset(pgd_k, addr);
+		if (!p4d_present(*p4d_k))
+			goto no_context;
+
+		pud = pud_offset(p4d, addr);
+		pud_k = pud_offset(p4d_k, addr);
+		if (!pud_present(*pud_k))
+			goto no_context;
+
+		/* Since the vmalloc area is global, it is unnecessary
+		 * to copy individual PTEs
+		 */
+		pmd = pmd_offset(pud, addr);
+		pmd_k = pmd_offset(pud_k, addr);
+		if (!pmd_present(*pmd_k))
+			goto no_context;
+		set_pmd(pmd, *pmd_k);
+
+		/* Make sure the actual PTE exists as well to
+		 * catch kernel vmalloc-area accesses to non-mapped
+		 * addresses. If we don't do this, this will just
+		 * silently loop forever.
+		 */
+		pte_k = pte_offset_kernel(pmd_k, addr);
+		if (!pte_present(*pte_k))
+			goto no_context;
+		return;
+	}
+}
-- 
2.13.0
