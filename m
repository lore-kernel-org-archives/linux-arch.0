Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270600AbUJUEq5@vger.kernel.org>
Received: from krynn.se.axis.com ([193.13.178.10]:23438 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S270570AbUJUEpB
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Oct 2004 00:45:01 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: 4level page tables - need help for other architectures
Date: Thu, 21 Oct 2004 06:44:45 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C741B@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0391_01C4B739.74222470"
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668018AF8B7@exmail1.se.axis.com>
To: 'Andi Kleen' <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0391_01C4B739.74222470
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Patch for CRIS attached. Compiles and boots.

/Mikael

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]=20
Sent: Tuesday, October 12, 2004 4:05 PM
To: linux-arch@vger.kernel.org
Subject: 4level page tables - need help for other architectures



Hi,

For x86-64 I did a patch to add a fourth page table level to the=20
generic VM. The patch is now available on=20
ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-1.gz

Please see my post to linux-kernel for more details.

One problem is that currently only i386 and x86-64 are supported.
All other architectures need some quite straight forward changes
to still compile.  I will need some help converting the other
architectures over and testing them.

I append the i386 changes for reference. I expect changes to any 2/3 =
level
arch who doesn't want to use the 4th level to not be significantly
more complicated.

Most of the compat macros are in
include/asm-generic/nopml4-{page,pgtable,pgalloc}.h
and can just be included from there.

-Andi



diff -urpN -X ../KDIFX -x '*-4L'
linux-2.6.9rc4/arch/i386/kernel/acpi/sleep.c
linux-2.6.9rc4-4level/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.9rc4/arch/i386/kernel/acpi/sleep.c	2004-09-30
10:34:54.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/kernel/acpi/sleep.c	2004-10-12
15:31:28.000000000 +0200
@@ -23,8 +23,8 @@ static void init_low_mapping(pgd_t *pgd,
 {
 	int pgd_ofs =3D 0;
=20
-	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PTRS_PER_PGD <
PTRS_PER_PGD)) {
-		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
+	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PGDS_IN_LAST_PML4 <
PTRS_PER_PGD)) {
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
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end -
&wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
=20
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/kernel/vm86.c
linux-2.6.9rc4-4level/arch/i386/kernel/vm86.c
--- linux-2.6.9rc4/arch/i386/kernel/vm86.c	2004-09-30
10:34:54.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/kernel/vm86.c	2004-10-12
15:31:28.000000000 +0200
@@ -143,7 +143,7 @@ static void mark_screen_rdonly(struct ta
=20
 	preempt_disable();
 	spin_lock(&tsk->mm->page_table_lock);
-	pgd =3D pgd_offset(tsk->mm, 0xA0000);
+	pgd =3D pml4_pgd_offset(pml4_offset(tsk->mm, 0xa0000), 0xA0000);
 	if (pgd_none(*pgd))
 		goto out;
 	if (pgd_bad(*pgd)) {
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/fault.c
linux-2.6.9rc4-4level/arch/i386/mm/fault.c
--- linux-2.6.9rc4/arch/i386/mm/fault.c	2004-10-12 15:29:43.000000000 =
+0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/fault.c	2004-10-12
15:31:28.000000000 +0200
@@ -523,7 +523,7 @@ vmalloc_fault:
=20
 		asm("movl %%cr3,%0":"=3Dr" (pgd_paddr));
 		pgd =3D index + (pgd_t *)__va(pgd_paddr);
-		pgd_k =3D init_mm.pgd + index;
+		pgd_k =3D ((pgd_t *)(init_mm.pml4)) + index;
=20
 		if (!pgd_present(*pgd_k))
 			goto no_context;
diff -urpN -X ../KDIFX -x '*-4L' =
linux-2.6.9rc4/arch/i386/mm/hugetlbpage.c
linux-2.6.9rc4-4level/arch/i386/mm/hugetlbpage.c
--- linux-2.6.9rc4/arch/i386/mm/hugetlbpage.c	2004-08-15
19:45:04.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/hugetlbpage.c	2004-10-12
15:31:28.000000000 +0200
@@ -20,20 +20,25 @@
=20
 static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4;=20
 	pgd_t *pgd;
 	pmd_t *pmd =3D NULL;
=20
-	pgd =3D pgd_offset(mm, addr);
-	pmd =3D pmd_alloc(mm, pgd, addr);
+	pml4 =3D pml4_offset(mm, addr); =20
+	pgd =3D pgd_alloc(mm, pml4, addr);
+	if (pgd)=20
+		pmd =3D pmd_alloc(mm, pgd, addr);
 	return (pte_t *) pmd;
 }
=20
 static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd =3D NULL;
=20
-	pgd =3D pgd_offset(mm, addr);
+	pml4 =3D pml4_offset(mm, addr);
+	pgd =3D pml4_pgd_offset(pml4, addr);
 	pmd =3D pmd_offset(pgd, addr);
 	return (pte_t *) pmd;
 }
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/init.c
linux-2.6.9rc4-4level/arch/i386/mm/init.c
--- linux-2.6.9rc4/arch/i386/mm/init.c	2004-10-12 15:29:43.000000000 =
+0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/init.c	2004-10-12
15:31:28.000000000 +0200
@@ -233,7 +233,7 @@ EXPORT_SYMBOL(kmap_prot);
 EXPORT_SYMBOL(kmap_pte);
=20
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr),
vaddr), (vaddr)), (vaddr))
=20
 void __init kmap_init(void)
 {
@@ -345,7 +345,7 @@ static void __init pagetable_init (void)
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
-	pgd_base[0] =3D pgd_base[USER_PTRS_PER_PGD];
+	pgd_base[0] =3D pgd_base[USER_PGDS_IN_LAST_PML4];
 #endif
 }
=20
@@ -379,7 +379,7 @@ void zap_low_mappings (void)
 	 * Note that "pgd_clear()" doesn't do it for
 	 * us, because pgd_clear() is a no-op on i386.
 	 */
-	for (i =3D 0; i < USER_PTRS_PER_PGD; i++)
+	for (i =3D 0; i < USER_PGDS_IN_LAST_PML4; i++)
 #ifdef CONFIG_X86_PAE
 		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
 #else
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/ioremap.c
linux-2.6.9rc4-4level/arch/i386/mm/ioremap.c
--- linux-2.6.9rc4/arch/i386/mm/ioremap.c	2004-09-30
10:34:55.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/ioremap.c	2004-10-12
15:31:28.000000000 +0200
@@ -74,7 +74,7 @@ static int remap_area_pages(unsigned lon
 	unsigned long end =3D address + size;
=20
 	phys_addr -=3D address;
-	dir =3D pgd_offset(&init_mm, address);
+	dir =3D pml4_pgd_offset(pml4_offset(&init_mm, address), address);
 	flush_cache_all();
 	if (address >=3D end)
 		BUG();
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/pageattr.c
linux-2.6.9rc4-4level/arch/i386/mm/pageattr.c
--- linux-2.6.9rc4/arch/i386/mm/pageattr.c	2004-09-30
10:34:55.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/pageattr.c	2004-10-12
15:31:28.000000000 +0200
@@ -19,7 +19,7 @@ static struct list_head df_list =3D LIST_H
=20
 pte_t *lookup_address(unsigned long address)=20
 {=20
-	pgd_t *pgd =3D pgd_offset_k(address);=20
+	pgd_t *pgd =3D pml4_pgd_offset(pml4_offset_k(address), address);=20
 	pmd_t *pmd;
 	if (pgd_none(*pgd))
 		return NULL;
@@ -92,7 +92,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 static inline void revert_page(struct page *kpte_page, unsigned long
address)
 {
 	pte_t *linear =3D (pte_t *)=20
-		pmd_offset(pgd_offset(&init_mm, address), address);
+		pmd_offset(pml4_pgd_offset(pml4_offset_k(address), address),
address);
 	set_pmd_pte(linear,  address,
 		    pfn_pte((__pa(address) & LARGE_PAGE_MASK) >> PAGE_SHIFT,
 			    PAGE_KERNEL_LARGE));
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/arch/i386/mm/pgtable.c
linux-2.6.9rc4-4level/arch/i386/mm/pgtable.c
--- linux-2.6.9rc4/arch/i386/mm/pgtable.c	2004-08-15
19:45:04.000000000 +0200
+++ linux-2.6.9rc4-4level/arch/i386/mm/pgtable.c	2004-10-12
15:31:28.000000000 +0200
@@ -201,16 +201,16 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 	if (PTRS_PER_PMD =3D=3D 1)
 		spin_lock_irqsave(&pgd_lock, flags);
=20
-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	memcpy((pgd_t *)pgd + USER_PGDS_IN_LAST_PML4,
+			swapper_pg_dir + USER_PGDS_IN_LAST_PML4,
+			(PTRS_PER_PGD - USER_PGDS_IN_LAST_PML4) *
sizeof(pgd_t));
=20
 	if (PTRS_PER_PMD > 1)
 		return;
=20
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+	memset(pgd, 0, USER_PGDS_IN_LAST_PML4*sizeof(pgd_t));
 }
=20
 /* never called when PTRS_PER_PMD > 1 */
@@ -223,7 +223,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
=20
-pgd_t *pgd_alloc(struct mm_struct *mm)
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long
address)
 {
 	int i;
 	pgd_t *pgd =3D kmem_cache_alloc(pgd_cache, GFP_KERNEL);
@@ -231,7 +231,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (PTRS_PER_PMD =3D=3D 1 || !pgd)
 		return pgd;
=20
-	for (i =3D 0; i < USER_PTRS_PER_PGD; ++i) {
+	for (i =3D 0; i < USER_PGDS_IN_LAST_PML4; ++i) {
 		pmd_t *pmd =3D kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
@@ -252,7 +252,7 @@ void pgd_free(pgd_t *pgd)
=20
 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i =3D 0; i < USER_PTRS_PER_PGD; ++i)
+		for (i =3D 0; i < USER_PGDS_IN_LAST_PML4; ++i)
 			kmem_cache_free(pmd_cache, (void
*)__va(pgd_val(pgd[i])-1));
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries
*/
 	kmem_cache_free(pgd_cache, pgd);
diff -urpN -X ../KDIFX -x '*-4L'
linux-2.6.9rc4/include/asm-i386/mmu_context.h
linux-2.6.9rc4-4level/include/asm-i386/mmu_context.h
--- linux-2.6.9rc4/include/asm-i386/mmu_context.h	2004-09-30
10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/mmu_context.h	2004-10-12
15:31:28.000000000 +0200
@@ -39,7 +39,7 @@ static inline void switch_mm(struct mm_s
 		cpu_set(cpu, next->cpu_vm_mask);
=20
 		/* Re-load page tables */
-		load_cr3(next->pgd);
+		load_cr3(next->pml4);
=20
 		/*
 		 * load the LDT, if the LDT is different:
@@ -56,7 +56,7 @@ static inline void switch_mm(struct mm_s
 			/* We were in lazy tlb mode and leave_mm disabled=20
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
-			load_cr3(next->pgd);
+			load_cr3(next->pml4);
 			load_LDT_nolock(&next->context, cpu);
 		}
 	}
diff -urpN -X ../KDIFX -x '*-4L' linux-2.6.9rc4/include/asm-i386/page.h
linux-2.6.9rc4-4level/include/asm-i386/page.h
--- linux-2.6.9rc4/include/asm-i386/page.h	2004-09-30
10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/page.h	2004-10-12
15:31:28.000000000 +0200
@@ -118,6 +118,8 @@ static __inline__ int get_order(unsigned
=20
 extern int sysctl_legacy_va_layout;
=20
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __ASSEMBLY__ */
=20
 #ifdef __ASSEMBLY__
diff -urpN -X ../KDIFX -x '*-4L' =
linux-2.6.9rc4/include/asm-i386/pgalloc.h
linux-2.6.9rc4-4level/include/asm-i386/pgalloc.h
--- linux-2.6.9rc4/include/asm-i386/pgalloc.h	2004-03-21
21:11:56.000000000 +0100
+++ linux-2.6.9rc4-4level/include/asm-i386/pgalloc.h	2004-10-12
15:31:28.000000000 +0200
@@ -20,9 +20,6 @@ static inline void pmd_populate(struct m
  * Allocate and free page tables.
  */
=20
-extern pgd_t *pgd_alloc(struct mm_struct *);
-extern void pgd_free(pgd_t *pgd);
-
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
 extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
=20
@@ -52,4 +49,8 @@ static inline void pte_free(struct page=20
=20
 #define check_pgt_cache()	do { } while (0)
=20
+extern void pgd_free(pgd_t *);
+
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _I386_PGALLOC_H */
diff -urpN -X ../KDIFX -x '*-4L' =
linux-2.6.9rc4/include/asm-i386/pgtable.h
linux-2.6.9rc4-4level/include/asm-i386/pgtable.h
--- linux-2.6.9rc4/include/asm-i386/pgtable.h	2004-09-30
10:35:45.000000000 +0200
+++ linux-2.6.9rc4-4level/include/asm-i386/pgtable.h	2004-10-12
15:31:28.000000000 +0200
@@ -59,7 +59,7 @@ void paging_init(void);
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
=20
-#define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
+#define USER_PGDS_IN_LAST_PML4	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_PGD_NR	0
=20
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
@@ -312,18 +312,6 @@ static inline pte_t pte_modify(pte_t pte
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & =
(PTRS_PER_PGD-1))
=20
 /*
- * pgd_offset() returns a (pgd_t *)
- * pgd_index() is used get the offset into the pgd page's array of =
pgd_t's;
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
  * the pmd page can be thought of an array like this: =
pmd_t[PTRS_PER_PMD]
  *
  * this macro returns the index of the entry in the pmd page which =
would
@@ -398,6 +386,8 @@ extern pte_t *lookup_address(unsigned lo
 		}							  \
 	} while (0)
=20
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* !__ASSEMBLY__ */
=20
 #ifndef CONFIG_DISCONTIGMEM

------=_NextPart_000_0391_01C4B739.74222470
Content-Type: application/octet-stream;
	name="cris_4level_patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris_4level_patch"

diff -Nurp linux-2.6.9/arch/cris/arch-v10/mm/fault.c =
linux-modified/arch/cris/arch-v10/mm/fault.c=0A=
--- linux-2.6.9/arch/cris/arch-v10/mm/fault.c	Mon Oct 18 23:55:28 2004=0A=
+++ linux-modified/arch/cris/arch-v10/mm/fault.c	Wed Oct 20 21:03:19 2004=0A=
@@ -24,7 +24,7 @@=0A=
 #define D(x)=0A=
 #endif=0A=
 =0A=
-extern volatile pgd_t *current_pgd;=0A=
+extern volatile pml4_t *current_pml4;=0A=
 =0A=
 extern const struct exception_table_entry=0A=
 	*search_exception_tables(unsigned long addr);=0A=
@@ -92,7 +92,7 @@ handle_mmu_bus_fault(struct pt_regs *reg=0A=
 		 * refer through current_pgd, dont use mm->pgd=0A=
 		 */=0A=
 =0A=
-		pmd =3D (pmd_t *)(current_pgd + pgd_index(address));=0A=
+		pmd =3D (pmd_t *)(current_pml4 + pgd_index(address));=0A=
 		if (pmd_none(*pmd)) {=0A=
 			do_page_fault(address, regs, 0, writeac);=0A=
 			return;=0A=
diff -Nurp linux-2.6.9/arch/cris/arch-v10/mm/init.c =
linux-modified/arch/cris/arch-v10/mm/init.c=0A=
--- linux-2.6.9/arch/cris/arch-v10/mm/init.c	Mon Oct 18 23:53:43 2004=0A=
+++ linux-modified/arch/cris/arch-v10/mm/init.c	Wed Oct 20 21:03:51 2004=0A=
@@ -37,12 +37,12 @@ paging_init(void)=0A=
 	for(i =3D 0; i < PTRS_PER_PGD; i++)=0A=
 		swapper_pg_dir[i] =3D __pgd(0);=0A=
 	=0A=
-	/* make sure the current pgd table points to something sane=0A=
+	/* make sure the current pml4 table points to something sane=0A=
 	 * (even if it is most probably not used until the next =0A=
 	 *  switch_mm)=0A=
 	 */=0A=
 =0A=
-	current_pgd =3D init_mm.pgd;=0A=
+	current_pml4 =3D init_mm.pml4;=0A=
 =0A=
 	/* initialise the TLB (tlb.c) */=0A=
 =0A=
diff -Nurp linux-2.6.9/arch/cris/arch-v10/mm/tlb.c =
linux-modified/arch/cris/arch-v10/mm/tlb.c=0A=
--- linux-2.6.9/arch/cris/arch-v10/mm/tlb.c	Mon Oct 18 23:55:29 2004=0A=
+++ linux-modified/arch/cris/arch-v10/mm/tlb.c	Wed Oct 20 21:04:09 2004=0A=
@@ -225,7 +225,7 @@ switch_mm(struct mm_struct *prev, struct=0A=
 	 * the pgd.=0A=
 	 */=0A=
 =0A=
-	current_pgd =3D next->pgd;=0A=
+	current_pml4 =3D next->pml4;=0A=
 =0A=
 	/* switch context in the MMU */=0A=
 	=0A=
diff -Nurp linux-2.6.9/arch/cris/mm/fault.c =
linux-modified/arch/cris/mm/fault.c=0A=
--- linux-2.6.9/arch/cris/mm/fault.c	Mon Oct 18 23:55:06 2004=0A=
+++ linux-modified/arch/cris/mm/fault.c	Wed Oct 20 21:05:23 2004=0A=
@@ -118,7 +118,7 @@ extern void die_if_kernel(const char *, =0A=
 =0A=
 /* current active page directory */=0A=
 =0A=
-volatile pgd_t *current_pgd;=0A=
+volatile pml4_t *current_pml4;=0A=
 =0A=
 /*=0A=
  * This routine handles page faults.  It determines the address,=0A=
@@ -337,7 +337,7 @@ vmalloc_fault:=0A=
 		 * Synchronize this task's top level page-table=0A=
 		 * with the 'reference' page table.=0A=
 		 *=0A=
-		 * Use current_pgd instead of tsk->active_mm->pgd=0A=
+		 * Use current_pml4 instead of tsk->active_mm->pgd=0A=
 		 * since the latter might be unavailable if this=0A=
 		 * code is executed in a misfortunately run irq=0A=
 		 * (like inside schedule() between switch_mm and=0A=
@@ -349,9 +349,9 @@ vmalloc_fault:=0A=
 		pmd_t *pmd, *pmd_k;=0A=
 		pte_t *pte_k;=0A=
 =0A=
-		pgd =3D (pgd_t *)current_pgd + offset;=0A=
-		pgd_k =3D init_mm.pgd + offset;=0A=
-=0A=
+		pgd =3D (pgd_t *)current_pml4 + offset;=0A=
+		pgd_k =3D ((pgd_t *)(init_mm.pml4)) + offset;=0A=
+ =0A=
 		/* Since we're two-level, we don't need to do both=0A=
 		 * set_pgd and set_pmd (they do the same thing). If=0A=
 		 * we go three-level at some point, do the right thing=0A=
diff -Nurp linux-2.6.9/arch/cris/mm/ioremap.c =
linux-modified/arch/cris/mm/ioremap.c=0A=
--- linux-2.6.9/arch/cris/mm/ioremap.c	Mon Oct 18 23:53:13 2004=0A=
+++ linux-modified/arch/cris/mm/ioremap.c	Wed Oct 20 21:05:48 2004=0A=
@@ -71,7 +71,7 @@ static int remap_area_pages(unsigned lon=0A=
 	unsigned long end =3D address + size;=0A=
 =0A=
 	phys_addr -=3D address;=0A=
-	dir =3D pgd_offset(&init_mm, address);=0A=
+	dir =3D pml4_pgd_offset(pml4_offset(&init_mm, address), address);=0A=
 	flush_cache_all();=0A=
 	if (address >=3D end)=0A=
 		BUG();=0A=
diff -Nurp linux-2.6.9/include/asm-cris/mmu_context.h =
linux-modified/include/asm-cris/mmu_context.h=0A=
--- linux-2.6.9/include/asm-cris/mmu_context.h	Mon Oct 18 23:53:46 2004=0A=
+++ linux-modified/include/asm-cris/mmu_context.h	Wed Oct 20 21:06:22 =
2004=0A=
@@ -11,11 +11,11 @@ extern void switch_mm(struct mm_struct *=0A=
 =0A=
 #define activate_mm(prev,next) switch_mm((prev),(next),NULL)=0A=
 =0A=
-/* current active pgd - this is similar to other processors pgd =0A=
+/* current active pml4 - this is similar to other processors pgd =0A=
  * registers like cr3 on the i386=0A=
  */=0A=
 =0A=
-extern volatile pgd_t *current_pgd;   /* defined in =
arch/cris/mm/fault.c */=0A=
+extern volatile pml4_t *current_pml4;   /* defined in =
arch/cris/mm/fault.c */=0A=
 =0A=
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct =
task_struct *tsk)=0A=
 {=0A=
diff -Nurp linux-2.6.9/include/asm-cris/page.h =
linux-modified/include/asm-cris/page.h=0A=
--- linux-2.6.9/include/asm-cris/page.h	Mon Oct 18 23:53:46 2004=0A=
+++ linux-modified/include/asm-cris/page.h	Wed Oct 20 21:06:43 2004=0A=
@@ -95,6 +95,7 @@ static inline int get_order(unsigned lon=0A=
 =0A=
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \=0A=
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)=0A=
+#include <asm-generic/nopml4-page.h>=0A=
 =0A=
 #endif /* __KERNEL__ */=0A=
 =0A=
diff -Nurp linux-2.6.9/include/asm-cris/pgalloc.h =
linux-modified/include/asm-cris/pgalloc.h=0A=
--- linux-2.6.9/include/asm-cris/pgalloc.h	Mon Oct 18 23:55:06 2004=0A=
+++ linux-modified/include/asm-cris/pgalloc.h	Wed Oct 20 21:07:26 2004=0A=
@@ -12,9 +12,9 @@=0A=
  * Allocate and free page tables.=0A=
  */=0A=
 =0A=
-extern inline pgd_t *pgd_alloc (struct mm_struct *mm)=0A=
+extern inline pgd_t *__pgd_alloc (struct mm_struct *mm, pml4_t *pml4, =
unsigned long address)=0A=
 {=0A=
-	return (pgd_t *)get_zeroed_page(GFP_KERNEL);=0A=
+ 	return (pgd_t *)get_zeroed_page(GFP_KERNEL);=0A=
 }=0A=
 =0A=
 extern inline void pgd_free (pgd_t *pgd)=0A=
@@ -64,4 +64,6 @@ extern inline void pte_free(struct page =0A=
 =0A=
 #define check_pgt_cache()          do { } while (0)=0A=
 =0A=
+#include <asm-generic/nopml4-pgalloc.h>=0A=
+=0A=
 #endif=0A=
diff -Nurp linux-2.6.9/include/asm-cris/pgtable.h =
linux-modified/include/asm-cris/pgtable.h=0A=
--- linux-2.6.9/include/asm-cris/pgtable.h	Mon Oct 18 23:53:06 2004=0A=
+++ linux-modified/include/asm-cris/pgtable.h	Wed Oct 20 21:08:06 2004=0A=
@@ -272,12 +272,7 @@ extern inline void pmd_set(pmd_t * pmdp,=0A=
 =0A=
 /* to find an entry in a page-table-directory. */=0A=
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))=0A=
-=0A=
-/* to find an entry in a page-table-directory */=0A=
-extern inline pgd_t * pgd_offset(struct mm_struct * mm, unsigned long =
address)=0A=
-{=0A=
-	return mm->pgd + pgd_index(address);=0A=
-}=0A=
+#define pgd_index_k(addr) pgd_index(addr)=0A=
 =0A=
 /* to find an entry in a kernel page-table-directory */=0A=
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)=0A=
@@ -344,5 +339,8 @@ extern inline void update_mmu_cache(stru=0A=
 #define pte_to_pgoff(x)	(pte_val(x) >> 6)=0A=
 #define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)=0A=
 =0A=
+#include <asm-generic/pgtable.h>=0A=
+#include <asm-generic/nopml4-pgtable.h>=0A=
+=0A=
 #endif /* __ASSEMBLY__ */=0A=
 #endif /* _CRIS_PGTABLE_H */=0A=

------=_NextPart_000_0391_01C4B739.74222470--
