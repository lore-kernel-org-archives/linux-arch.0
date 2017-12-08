From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 07/33] nds32: MMU initialization
Date: Fri,  8 Dec 2017 17:11:50 +0800
Message-ID: <0964714c3dcac46ac700085717b0f414b7978112.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch includes memory initializations and highmem supporting.

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 arch/nds32/mm/highmem.c  |   92 +++++++++++++++
 arch/nds32/mm/init.c     |  290 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/mm-nds32.c |  103 ++++++++++++++++
 3 files changed, 485 insertions(+)
 create mode 100644 arch/nds32/mm/highmem.c
 create mode 100644 arch/nds32/mm/init.c
 create mode 100644 arch/nds32/mm/mm-nds32.c

diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
new file mode 100644
index 0000000..d5101bd
--- /dev/null
+++ b/arch/nds32/mm/highmem.c
@@ -0,0 +1,92 @@
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
+#include <linux/export.h>
+#include <linux/highmem.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <asm/fixmap.h>
+#include <asm/tlbflush.h>
+
+void *kmap(struct page *page)
+{
+	unsigned long vaddr;
+	might_sleep();
+	if (!PageHighMem(page))
+		return page_address(page);
+	vaddr = (unsigned long)kmap_high(page);
+	return (void *)vaddr;
+}
+
+EXPORT_SYMBOL(kmap);
+
+void kunmap(struct page *page)
+{
+	BUG_ON(in_interrupt());
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+
+EXPORT_SYMBOL(kunmap);
+
+void *kmap_atomic(struct page *page)
+{
+	unsigned int idx;
+	unsigned long vaddr, pte;
+	int type;
+	pte_t *ptep;
+
+	preempt_disable();
+	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	type = kmap_atomic_idx_push();
+
+	idx = type + KM_TYPE_NR * smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	pte = (page_to_pfn(page) << PAGE_SHIFT) | (PAGE_KERNEL);
+	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
+	set_pte(ptep, pte);
+
+	__nds32__tlbop_inv(vaddr);
+	__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);
+	__nds32__tlbop_rwr(pte);
+	__nds32__isb();
+	return (void *)vaddr;
+}
+
+EXPORT_SYMBOL(kmap_atomic);
+
+void __kunmap_atomic(void *kvaddr)
+{
+	if (kvaddr >= (void *)FIXADDR_START) {
+		unsigned long vaddr = (unsigned long)kvaddr;
+		pte_t *ptep;
+		kmap_atomic_idx_pop();
+		__nds32__tlbop_inv(vaddr);
+		__nds32__isb();
+		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
+		set_pte(ptep, 0);
+	}
+	pagefault_enable();
+	preempt_enable();
+}
+
+EXPORT_SYMBOL(__kunmap_atomic);
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
new file mode 100644
index 0000000..05e072a
--- /dev/null
+++ b/arch/nds32/mm/init.c
@@ -0,0 +1,290 @@
+/*
+ * Copyright (C) 1995-2005 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2013-2017 Andes Technology Corporation
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
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/swap.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mman.h>
+#include <linux/nodemask.h>
+#include <linux/initrd.h>
+#include <linux/highmem.h>
+#include <linux/memblock.h>
+
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/tlb.h>
+#include <asm/page.h>
+
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_SPINLOCK(anon_alias_lock);
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern unsigned long phys_initrd_start;
+extern unsigned long phys_initrd_size;
+
+/*
+ * empty_zero_page is a special page that is used for
+ * zero-initialized data and COW.
+ */
+struct page *empty_zero_page;
+
+static void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES];
+
+	/* Clear the zone sizes */
+	memset(zones_size, 0, sizeof(zones_size));
+
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+#ifdef CONFIG_HIGHMEM
+	zones_size[ZONE_HIGHMEM] = max_pfn;
+#endif
+	free_area_init(zones_size);
+
+}
+
+/*
+ * Map all physical memory under high_memory into kernel's address space.
+ *
+ * This is explicitly coded for two-level page tables, so if you need
+ * something else then this needs to change.
+ */
+static void __init map_ram(void)
+{
+	unsigned long v, p, e;
+	pgd_t *pge;
+	pud_t *pue;
+	pmd_t *pme;
+	pte_t *pte;
+	/* These mark extents of read-only kernel pages...
+	 * ...from vmlinux.lds.S
+	 */
+
+	p = (u32) memblock_start_of_DRAM() & PAGE_MASK;
+	e = min((u32) memblock_end_of_DRAM(), (u32) __pa(high_memory));
+
+	v = (u32) __va(p);
+	pge = pgd_offset_k(v);
+
+	while (p < e) {
+		int j;
+		pue = pud_offset(pge, v);
+		pme = pmd_offset(pue, v);
+
+		if ((u32) pue != (u32) pge || (u32) pme != (u32) pge) {
+			panic("%s: Kernel hardcoded for "
+			      "two-level page tables", __func__);
+		}
+
+		/* Alloc one page for holding PTE's... */
+		pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+		memset(pte, 0, PAGE_SIZE);
+		set_pmd(pme, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
+
+		/* Fill the newly allocated page with PTE'S */
+		for (j = 0; p < e && j < PTRS_PER_PTE;
+		     v += PAGE_SIZE, p += PAGE_SIZE, j++, pte++) {
+			/* Create mapping between p and v. */
+			/* TODO: more fine grant for page access permission */
+			set_pte(pte, __pte(p + pgprot_val(PAGE_KERNEL)));
+		}
+
+		pge++;
+	}
+}
+static pmd_t *fixmap_pmd_p;
+static void __init fixedrange_init(void)
+{
+	unsigned long vaddr;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+#ifdef CONFIG_HIGHMEM
+	pte_t *pte;
+#endif /* CONFIG_HIGHMEM */
+
+	/*
+	 * Fixed mappings:
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
+	pgd = swapper_pg_dir + pgd_index(vaddr);
+	pud = pud_offset(pgd, vaddr);
+	pmd = pmd_offset(pud, vaddr);
+	fixmap_pmd_p = (pmd_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+	memset(fixmap_pmd_p, 0, PAGE_SIZE);
+	set_pmd(pmd, __pmd(__pa(fixmap_pmd_p) + _PAGE_KERNEL_TABLE));
+
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * Permanent kmaps:
+	 */
+	vaddr = PKMAP_BASE;
+
+	pgd = swapper_pg_dir + pgd_index(vaddr);
+	pud = pud_offset(pgd, vaddr);
+	pmd = pmd_offset(pud, vaddr);
+	pte = (pte_t *) __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+	memset(pte, 0, PAGE_SIZE);
+	set_pmd(pmd, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
+	pkmap_page_table = pte;
+#endif /* CONFIG_HIGHMEM */
+}
+
+/*
+ * paging_init() sets up the page tables, initialises the zone memory
+ * maps, and sets up the zero page, bad page and bad page tables.
+ */
+void __init paging_init(void)
+{
+	int i;
+	void *zero_page;
+
+	pr_info("Setting up paging and PTEs.\n");
+	/* clear out the init_mm.pgd that will contain the kernel's mappings */
+	for (i = 0; i < PTRS_PER_PGD; i++)
+		swapper_pg_dir[i] = __pgd(1);
+
+	map_ram();
+
+	fixedrange_init();
+
+	/* allocate space for empty_zero_page */
+	zero_page = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+	memset(zero_page, 0, PAGE_SIZE);
+	zone_sizes_init();
+
+	empty_zero_page = virt_to_page(zero_page);
+	flush_dcache_page(empty_zero_page);
+}
+
+static inline void __init free_highmem(void)
+{
+#ifdef CONFIG_HIGHMEM
+	unsigned long pfn;
+	for (pfn = PFN_UP(__pa(high_memory)); pfn < max_pfn; pfn++) {
+		phys_addr_t paddr = (phys_addr_t) pfn << PAGE_SHIFT;
+		if (!memblock_is_reserved(paddr))
+			free_highmem_page(pfn_to_page(pfn));
+	}
+#endif
+}
+
+static void __init set_max_mapnr_init(void)
+{
+	max_mapnr = max_pfn;
+}
+
+/*
+ * mem_init() marks the free areas in the mem_map and tells us how much
+ * memory is free.  This is done after various parts of the system have
+ * claimed their memory after the kernel image.
+ */
+void __init mem_init(void)
+{
+	phys_addr_t memory_start = memblock_start_of_DRAM();
+	BUG_ON(!mem_map);
+	set_max_mapnr_init();
+
+	free_highmem();
+
+	/* this will put all low memory onto the freelists */
+	free_all_bootmem();
+	mem_init_print_info(NULL);
+
+	pr_info("virtual kernel memory layout:\n"
+		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#ifdef CONFIG_HIGHMEM
+		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#endif
+		"    consist : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
+		FIXADDR_START, FIXADDR_TOP, (FIXADDR_TOP - FIXADDR_START) >> 10,
+#ifdef CONFIG_HIGHMEM
+		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
+		(LAST_PKMAP * PAGE_SIZE) >> 10,
+#endif
+		CONSISTENT_BASE, CONSISTENT_END,
+		((CONSISTENT_END) - (CONSISTENT_BASE)) >> 20, VMALLOC_START,
+		(unsigned long)VMALLOC_END, (VMALLOC_END - VMALLOC_START) >> 20,
+		(unsigned long)__va(memory_start), (unsigned long)high_memory,
+		((unsigned long)high_memory -
+		 (unsigned long)__va(memory_start)) >> 20,
+		(unsigned long)&__init_begin, (unsigned long)&__init_end,
+		((unsigned long)&__init_end -
+		 (unsigned long)&__init_begin) >> 10, (unsigned long)&_etext,
+		(unsigned long)&_edata,
+		((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
+		(unsigned long)&_text, (unsigned long)&_etext,
+		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
+
+	/*
+	 * Check boundaries twice: Some fundamental inconsistencies can
+	 * be detected at build time already.
+	 */
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > FIXADDR_START);
+	BUILD_BUG_ON((CONSISTENT_END) > PKMAP_BASE);
+#endif
+	BUILD_BUG_ON(VMALLOC_END > CONSISTENT_BASE);
+	BUILD_BUG_ON(VMALLOC_START >= VMALLOC_END);
+
+#ifdef CONFIG_HIGHMEM
+	BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > FIXADDR_START);
+	BUG_ON(CONSISTENT_END > PKMAP_BASE);
+#endif
+	BUG_ON(VMALLOC_END > CONSISTENT_BASE);
+	BUG_ON(VMALLOC_START >= VMALLOC_END);
+	BUG_ON((unsigned long)high_memory > VMALLOC_START);
+
+	return;
+}
+
+void free_initmem(void)
+{
+	free_initmem_default(-1);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
+void __set_fixmap(enum fixed_addresses idx,
+			       phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *pte;
+
+	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
+
+	pte = (pte_t *)&fixmap_pmd_p[pte_index(addr)];;
+
+	if (pgprot_val(flags)) {
+		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
+	} else {
+		pte_clear(&init_mm, addr, pte);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	}
+}
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
new file mode 100644
index 0000000..2801496
--- /dev/null
+++ b/arch/nds32/mm/mm-nds32.c
@@ -0,0 +1,103 @@
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
+#include <linux/init_task.h>
+#include <asm/pgalloc.h>
+
+#define FIRST_KERNEL_PGD_NR	(USER_PTRS_PER_PGD)
+
+/*
+ * need to get a page for level 1
+ */
+
+pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *new_pgd, *init_pgd;
+	int i;
+
+	new_pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, 0);
+	if (!new_pgd)
+		return NULL;
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		(*new_pgd) = 1;
+		new_pgd++;
+	}
+	new_pgd -= PTRS_PER_PGD;
+
+	init_pgd = pgd_offset_k(0);
+
+	memcpy(new_pgd + FIRST_KERNEL_PGD_NR, init_pgd + FIRST_KERNEL_PGD_NR,
+	       (PTRS_PER_PGD - FIRST_KERNEL_PGD_NR) * sizeof(pgd_t));
+
+	cpu_dcache_wb_range((unsigned long)new_pgd,
+			    (unsigned long)new_pgd +
+			    PTRS_PER_PGD * sizeof(pgd_t));
+	inc_zone_page_state(virt_to_page((unsigned long *)new_pgd),
+			    NR_PAGETABLE);
+
+	return new_pgd;
+}
+
+void pgd_free(struct mm_struct *mm, pgd_t * pgd)
+{
+	pmd_t *pmd;
+	struct page *pte;
+
+	if (!pgd)
+		return;
+
+	pmd = (pmd_t *) pgd;
+	if (pmd_none(*pmd))
+		goto free;
+	if (pmd_bad(*pmd)) {
+		pmd_ERROR(*pmd);
+		pmd_clear(pmd);
+		goto free;
+	}
+
+	pte = pmd_page(*pmd);
+	pmd_clear(pmd);
+	dec_zone_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
+	pte_free(mm, pte);
+	atomic_long_dec(&mm->nr_ptes);
+	pmd_free(mm, pmd);
+free:
+	free_pages((unsigned long)pgd, 0);
+}
+
+/*
+ * In order to soft-boot, we need to insert a 1:1 mapping in place of
+ * the user-mode pages.  This will then ensure that we have predictable
+ * results when turning the mmu off
+ */
+void setup_mm_for_reboot(char mode)
+{
+	unsigned long pmdval;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	int i;
+
+	if (current->mm && current->mm->pgd)
+		pgd = current->mm->pgd;
+	else
+		pgd = init_mm.pgd;
+
+	for (i = 0; i < USER_PTRS_PER_PGD; i++) {
+		pmdval = (i << PGDIR_SHIFT);
+		pmd = pmd_offset(pgd + i, i << PGDIR_SHIFT);
+		set_pmd(pmd, __pmd(pmdval));
+	}
+}
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
