Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264085AbUJLOMc@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:5251 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263962AbUJLOMc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Oct 2004 10:12:32 -0400
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id DF158D3F732
	for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2004 16:05:03 +0200 (CEST)
Date: Tue, 12 Oct 2004 16:05:03 +0200
From: Andi Kleen <ak@suse.de>
Subject: 4level page tables - need help for other architectures
Message-ID: <20041012140503.GC20992@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hi,

For x86-64 I did a patch to add a fourth page table level to the 
generic VM. The patch is now available on 
ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-1.gz

Please see my post to linux-kernel for more details.

One problem is that currently only i386 and x86-64 are supported.
All other architectures need some quite straight forward changes
to still compile.  I will need some help converting the other
architectures over and testing them.

I append the i386 changes for reference. I expect changes to any 2/3 level
arch who doesn't want to use the 4th level to not be significantly
more complicated.

Most of the compat macros are in include/asm-generic/nopml4-{page,pgtable,pgalloc}.h
and can just be included from there.

-Andi



diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/kernel/acpi/sleep.c linux-2.6.9rc4-4level/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.9rc4/arch/i386/kernel/acpi/sleep.c	2004-09-30 10:34:54.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/kernel/acpi/sleep.c	2004-10-12 15:31:28.000000000 +0200
@@ -23,8 +23,8 @@ static void init_low_mapping(pgd_t *pgd,
 {
 	int pgd_ofs = 0;
 
-	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PTRS_PER_PGD < PTRS_PER_PGD)) {
-		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
+	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PGDS_IN_LAST_PML4 < PTRS_PER_PGD)) {
+		set_pgd(pgd, *(pgd+USER_PGDS_IN_LAST_PML4));
 		pgd_ofs++, pgd++;
 	}
 }
@@ -39,7 +39,7 @@ int acpi_save_state_mem (void)
 {
 	if (!acpi_wakeup_address)
 		return 1;
-	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+	init_low_mapping(swapper_pg_dir, USER_PGDS_IN_LAST_PML4);
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
 
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/kernel/vm86.c linux-2.6.9rc4-4level/arch/i386/kernel/vm86.c
--- linux-2.6.9rc4/arch/i386/kernel/vm86.c	2004-09-30 10:34:54.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/kernel/vm86.c	2004-10-12 15:31:28.000000000 +0200
@@ -143,7 +143,7 @@ static void mark_screen_rdonly(struct ta
 
 	preempt_disable();
 	spin_lock(&tsk->mm->page_table_lock);
-	pgd = pgd_offset(tsk->mm, 0xA0000);
+	pgd = pml4_pgd_offset(pml4_offset(tsk->mm, 0xa0000), 0xA0000);
 	if (pgd_none(*pgd))
 		goto out;
 	if (pgd_bad(*pgd)) {
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/fault.c linux-2.6.9rc4-4level/arch/i386/mm/fault.c
--- linux-2.6.9rc4/arch/i386/mm/fault.c	2004-10-12 15:29:43.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/fault.c	2004-10-12 15:31:28.000000000 +0200
@@ -523,7 +523,7 @@ vmalloc_fault:
 
 		asm("movl %%cr3,%0":"=r" (pgd_paddr));
 		pgd = index + (pgd_t *)__va(pgd_paddr);
-		pgd_k = init_mm.pgd + index;
+		pgd_k = ((pgd_t *)(init_mm.pml4)) + index;
 
 		if (!pgd_present(*pgd_k))
 			goto no_context;
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/hugetlbpage.c linux-2.6.9rc4-4level/arch/i386/mm/hugetlbpage.c
--- linux-2.6.9rc4/arch/i386/mm/hugetlbpage.c	2004-08-15 19:45:04.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/hugetlbpage.c	2004-10-12 15:31:28.000000000 +0200
@@ -20,20 +20,25 @@
 
 static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4; 
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
 
-	pgd = pgd_offset(mm, addr);
-	pmd = pmd_alloc(mm, pgd, addr);
+	pml4 = pml4_offset(mm, addr);  
+	pgd = pgd_alloc(mm, pml4, addr);
+	if (pgd) 
+		pmd = pmd_alloc(mm, pgd, addr);
 	return (pte_t *) pmd;
 }
 
 static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pml4 = pml4_offset(mm, addr);
+	pgd = pml4_pgd_offset(pml4, addr);
 	pmd = pmd_offset(pgd, addr);
 	return (pte_t *) pmd;
 }
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/init.c linux-2.6.9rc4-4level/arch/i386/mm/init.c
--- linux-2.6.9rc4/arch/i386/mm/init.c	2004-10-12 15:29:43.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/init.c	2004-10-12 15:31:28.000000000 +0200
@@ -233,7 +233,7 @@ EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -345,7 +345,7 @@ static void __init pagetable_init (void)
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
-	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
+	pgd_base[0] = pgd_base[USER_PGDS_IN_LAST_PML4];
 #endif
 }
 
@@ -379,7 +379,7 @@ void zap_low_mappings (void)
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+	for (i = 0; i < USER_PGDS_IN_LAST_PML4; i++)
 #ifdef CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/ioremap.c linux-2.6.9rc4-4level/arch/i386/mm/ioremap.c
--- linux-2.6.9rc4/arch/i386/mm/ioremap.c	2004-09-30 10:34:55.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/ioremap.c	2004-10-12 15:31:28.000000000 +0200
@@ -74,7 +74,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(pml4_offset(&init_mm, address), address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/pageattr.c linux-2.6.9rc4-4level/arch/i386/mm/pageattr.c
--- linux-2.6.9rc4/arch/i386/mm/pageattr.c	2004-09-30 10:34:55.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/pageattr.c	2004-10-12 15:31:28.000000000 +0200
@@ -19,7 +19,7 @@ static struct list_head df_list = LIST_H
 
 pte_t *lookup_address(unsigned long address) 
 { 
-	pgd_t *pgd = pgd_offset_k(address); 
+	pgd_t *pgd = pml4_pgd_offset(pml4_offset_k(address), address); 
 	pmd_t *pmd;
 	if (pgd_none(*pgd))
 		return NULL;
@@ -92,7 +92,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 static inline void revert_page(struct page *kpte_page, unsigned long address)
 {
 	pte_t *linear = (pte_t *) 
-		pmd_offset(pgd_offset(&init_mm, address), address);
+		pmd_offset(pml4_pgd_offset(pml4_offset_k(address), address), address);
 	set_pmd_pte(linear,  address,
 		    pfn_pte((__pa(address) & LARGE_PAGE_MASK) >> PAGE_SHIFT,
 			    PAGE_KERNEL_LARGE));
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/pgtable.c linux-2.6.9rc4-4level/arch/i386/mm/pgtable.c
--- linux-2.6.9rc4/arch/i386/mm/pgtable.c	2004-08-15 19:45:04.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/pgtable.c	2004-10-12 15:31:28.000000000 +0200
@@ -201,16 +201,16 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 	if (PTRS_PER_PMD == 1)
 		spin_lock_irqsave(&pgd_lock, flags);
 
-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	memcpy((pgd_t *)pgd + USER_PGDS_IN_LAST_PML4,
+			swapper_pg_dir + USER_PGDS_IN_LAST_PML4,
+			(PTRS_PER_PGD - USER_PGDS_IN_LAST_PML4) * sizeof(pgd_t));
 
 	if (PTRS_PER_PMD > 1)
 		return;
 
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+	memset(pgd, 0, USER_PGDS_IN_LAST_PML4*sizeof(pgd_t));
 }
 
 /* never called when PTRS_PER_PMD > 1 */
@@ -223,7 +223,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
@@ -231,7 +231,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (PTRS_PER_PMD == 1 || !pgd)
 		return pgd;
 
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+	for (i = 0; i < USER_PGDS_IN_LAST_PML4; ++i) {
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
@@ -252,7 +252,7 @@ void pgd_free(pgd_t *pgd)
 
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
+		for (i = 0; i < USER_PGDS_IN_LAST_PML4; ++i)
 			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/include/asm-i386/mmu_context.h linux-2.6.9rc4-4level/include/asm-i386/mmu_context.h
--- linux-2.6.9rc4/include/asm-i386/mmu_context.h	2004-09-30 10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/mmu_context.h	2004-10-12 15:31:28.000000000 +0200
@@ -39,7 +39,7 @@ static inline void switch_mm(struct mm_s
 		cpu_set(cpu, next->cpu_vm_mask);
 
 		/* Re-load page tables */
-		load_cr3(next->pgd);
+		load_cr3(next->pml4);
 
 		/*
 		 * load the LDT, if the LDT is different:
@@ -56,7 +56,7 @@ static inline void switch_mm(struct mm_s
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
-			load_cr3(next->pgd);
+			load_cr3(next->pml4);
 			load_LDT_nolock(&next->context, cpu);
 		}
 	}
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/include/asm-i386/page.h linux-2.6.9rc4-4level/include/asm-i386/page.h
--- linux-2.6.9rc4/include/asm-i386/page.h	2004-09-30 10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/page.h	2004-10-12 15:31:28.000000000 +0200
@@ -118,6 +118,8 @@ static __inline__ int get_order(unsigned
 
 extern int sysctl_legacy_va_layout;
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/include/asm-i386/pgalloc.h linux-2.6.9rc4-4level/include/asm-i386/pgalloc.h
--- linux-2.6.9rc4/include/asm-i386/pgalloc.h	2004-03-21 21:11:56.000000000 +0100
+++ linux-2.6.9rc4-4level/include/asm-i386/pgalloc.h	2004-10-12 15:31:28.000000000 +0200
@@ -20,9 +20,6 @@ static inline void pmd_populate(struct m
  * Allocate and free page tables.
  */
 
-extern pgd_t *pgd_alloc(struct mm_struct *);
-extern void pgd_free(pgd_t *pgd);
-
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
 extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
 
@@ -52,4 +49,8 @@ static inline void pte_free(struct page 
 
 #define check_pgt_cache()	do { } while (0)
 
+extern void pgd_free(pgd_t *);
+
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _I386_PGALLOC_H */
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/include/asm-i386/pgtable.h linux-2.6.9rc4-4level/include/asm-i386/pgtable.h
--- linux-2.6.9rc4/include/asm-i386/pgtable.h	2004-09-30 10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/pgtable.h	2004-10-12 15:31:28.000000000 +0200
@@ -59,7 +59,7 @@ void paging_init(void);
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PGDS_IN_LAST_PML4	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
@@ -312,18 +312,6 @@ static inline pte_t pte_modify(pte_t pte
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
 /*
- * pgd_offset() returns a (pgd_t *)
- * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
- */
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
-/*
- * a shortcut which implies the use of the kernel's pgd, instead
- * of a process's
- */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
-
-/*
  * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
  *
  * this macro returns the index of the entry in the pmd page which would
@@ -398,6 +386,8 @@ extern pte_t *lookup_address(unsigned lo
 		}							  \
 	} while (0)
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_DISCONTIGMEM
