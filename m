Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:38068 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbXF1QKa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jun 2007 12:10:30 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l5SGASik321460
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 16:10:28 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5SGASxf2121810
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 18:10:28 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5SGARp1015636
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 18:10:28 +0200
Received: from [9.152.198.78] (dyn-9-152-198-78.boeblingen.de.ibm.com [9.152.198.78])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l5SGARH9015621
	for <linux-arch@vger.kernel.org>; Thu, 28 Jun 2007 18:10:27 +0200
Subject: [RFC] CONFIG_HIGHPTE vs. sub-page page tables.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 28 Jun 2007 18:12:28 +0200
Message-Id: <1183047148.9687.18.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

I've hit a few problems while trying to implement 1K/2K page tables for
s390. We need the 1K/2K page tables to be able to properly support the
s390 virtualization instruction with KVM. The SIE instruction requires
that the pte tables have 256 page table entries (pte) followed by 256
page status table entries (pgste). The page status table is only required
if the process is using the SIE instruction. To avoid wasting memory the
standard pte table allocation should return 1K/2K (31/64 bit) and 2K/4K
if the process is using SIE.
Which means for s390 pte_alloc_one cannot return a page. Trouble is that
with the CONFIG_HIGHPTE feature on i386 pte_alloc_one cannot return a
pointer to a pte either, since that would require more than a 32 bit
for the return value of pte_alloc_one (and the pte * would not be
accessible since its not kmapped).

The only solution I found to this dilemma is a new typedef (urgh):
a ptetoken_t. For s390 ptetoken_t will be a (pte *) - to be introduced
with a later patch. For everybody else it is a (struct page *). The
additional problem with the initialization of the ptl lock and the
NR_PAGETABLE accounting is solved with a constructor __pte_page_ctor and
a destructor __pte_page_dtor. The page table allocation functions need
to call these two whenever a page table page is allocated/freed. To
complete the mess, a new function is required to dereference a pmd to
get the ptetoken_t back that has been installed with pmd_populate. It
replaces the pmd_page call in free_pte_range and apply_to_pte_range.

The patch is rather large as it touches every architecture. Anyone with
a better idea how to solve this?

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/frv/mm/pgalloc.c               |    8 +++--
 arch/i386/mm/pgtable.c              |    4 ++
 arch/powerpc/mm/pgtable_32.c        |   18 +++++++-----
 arch/ppc/mm/pgtable.c               |   11 +++++--
 arch/sparc/mm/srmmu.c               |   10 +++++--
 arch/sparc/mm/sun4c.c               |   14 +++++++---
 arch/um/kernel/mem.c                |    4 ++
 arch/xtensa/mm/init.c               |    1 
 include/asm-alpha/page.h            |    2 +
 include/asm-alpha/pgalloc.h         |   22 ++++++++++-----
 include/asm-alpha/tlb.h             |    2 -
 include/asm-arm/page.h              |    2 +
 include/asm-arm/pgalloc.h           |   11 +++++--
 include/asm-arm/tlb.h               |    2 -
 include/asm-arm26/page.h            |    3 ++
 include/asm-arm26/pgalloc.h         |   26 ++++++++++++++++--
 include/asm-arm26/tlb.h             |    2 -
 include/asm-avr32/page.h            |    1 
 include/asm-avr32/pgalloc.h         |   50 ++++++++++++++----------------------
 include/asm-cris/page.h             |    1 
 include/asm-cris/pgalloc.h          |   16 +++++++----
 include/asm-frv/page.h              |    1 
 include/asm-frv/pgalloc.h           |   14 +++++++---
 include/asm-i386/page.h             |    2 +
 include/asm-i386/pgalloc.h          |    9 ++++--
 include/asm-ia64/page.h             |    1 
 include/asm-ia64/pgalloc.h          |   24 +++++++++++------
 include/asm-m32r/page.h             |    1 
 include/asm-m32r/pgalloc.h          |   14 +++++-----
 include/asm-m68k/motorola_pgalloc.h |   16 ++++++-----
 include/asm-m68k/page.h             |    1 
 include/asm-m68k/sun3_pgalloc.h     |   19 +++++++++----
 include/asm-mips/page.h             |    1 
 include/asm-mips/pgalloc.h          |   21 ++++++++++-----
 include/asm-parisc/page.h           |    1 
 include/asm-parisc/pgalloc.h        |   13 +++++++--
 include/asm-parisc/tlb.h            |    2 -
 include/asm-powerpc/page.h          |    2 +
 include/asm-powerpc/pgalloc-32.h    |   10 ++++---
 include/asm-powerpc/pgalloc-64.h    |   28 ++++++++++++++------
 include/asm-ppc/page.h              |    2 +
 include/asm-ppc/pgalloc.h           |   10 ++++---
 include/asm-s390/page.h             |    2 +
 include/asm-s390/pgalloc.h          |   24 +++++++++++------
 include/asm-sh/page.h               |    2 +
 include/asm-sh/pgalloc.h            |   31 +++++++++++++++-------
 include/asm-sh64/page.h             |    2 +
 include/asm-sh64/pgalloc.h          |   29 +++++++++++++++-----
 include/asm-sparc/page.h            |    2 +
 include/asm-sparc/pgalloc.h         |   11 ++++---
 include/asm-sparc64/page.h          |    2 +
 include/asm-sparc64/pgalloc.h       |   22 ++++++++++-----
 include/asm-sparc64/tlb.h           |    2 -
 include/asm-um/page.h               |    2 +
 include/asm-um/pgalloc.h            |   14 +++++++---
 include/asm-x86_64/page.h           |    2 +
 include/asm-x86_64/pgalloc.h        |   26 +++++++++++++-----
 include/asm-xtensa/page.h           |    1 
 include/asm-xtensa/pgalloc.h        |   17 +++++++++---
 include/asm-xtensa/tlb.h            |    2 -
 include/linux/mm.h                  |   14 +++++++++-
 mm/memory.c                         |   32 ++++++++++-------------
 62 files changed, 431 insertions(+), 210 deletions(-)

diff -urpN linux-2.6/arch/frv/mm/pgalloc.c linux-2.6-patched/arch/frv/mm/pgalloc.c
--- linux-2.6/arch/frv/mm/pgalloc.c	2007-05-10 09:32:10.000000000 +0200
+++ linux-2.6-patched/arch/frv/mm/pgalloc.c	2007-06-28 17:58:44.000000000 +0200
@@ -28,7 +28,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	return pte;
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *page;
 
@@ -37,9 +37,11 @@ struct page *pte_alloc_one(struct mm_str
 #else
 	page = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
 #endif
-	if (page)
+	if (page) {
 		clear_highpage(page);
-	flush_dcache_page(page);
+		__pte_page_ctor(page);
+		flush_dcache_page(page);
+	}
 	return page;
 }
 
diff -urpN linux-2.6/arch/i386/mm/pgtable.c linux-2.6-patched/arch/i386/mm/pgtable.c
--- linux-2.6/arch/i386/mm/pgtable.c	2007-05-13 16:22:06.000000000 +0200
+++ linux-2.6-patched/arch/i386/mm/pgtable.c	2007-06-28 17:58:44.000000000 +0200
@@ -181,7 +181,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	return (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 
@@ -190,6 +190,8 @@ struct page *pte_alloc_one(struct mm_str
 #else
 	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 #endif
+	if (pte)
+		__pte_page_ctor(pte);
 	return pte;
 }
 
diff -urpN linux-2.6/arch/powerpc/mm/pgtable_32.c linux-2.6-patched/arch/powerpc/mm/pgtable_32.c
--- linux-2.6/arch/powerpc/mm/pgtable_32.c	2007-05-30 09:47:07.000000000 +0200
+++ linux-2.6-patched/arch/powerpc/mm/pgtable_32.c	2007-06-28 17:58:44.000000000 +0200
@@ -109,23 +109,24 @@ __init_refok pte_t *pte_alloc_one_kernel
 	return pte;
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *ptepage;
 
 #ifdef CONFIG_HIGHPTE
-	gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
+	gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT | __GFP_ZERO;
 #else
-	gfp_t flags = GFP_KERNEL | __GFP_REPEAT;
+	gfp_t flags = GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO;
 #endif
 
 	ptepage = alloc_pages(flags, 0);
-	if (ptepage)
-		clear_highpage(ptepage);
-	return ptepage;
+	if (!ptepage)
+		return NULL;
+	__pte_page_ctor(ptepage);
+	return page_address(ptepage);
 }
 
-void pte_free_kernel(pte_t *pte)
+void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
@@ -133,11 +134,12 @@ void pte_free_kernel(pte_t *pte)
 	free_page((unsigned long)pte);
 }
 
-void pte_free(struct page *ptepage)
+void pte_free(struct mm_struct *mm, ptetoken_t ptepage)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	__pte_page_dtor(ptepage);
 	__free_page(ptepage);
 }
 
diff -urpN linux-2.6/arch/ppc/mm/pgtable.c linux-2.6-patched/arch/ppc/mm/pgtable.c
--- linux-2.6/arch/ppc/mm/pgtable.c	2007-05-30 09:47:07.000000000 +0200
+++ linux-2.6-patched/arch/ppc/mm/pgtable.c	2007-06-28 17:58:44.000000000 +0200
@@ -108,7 +108,7 @@ __init_refok pte_t *pte_alloc_one_kernel
 	return pte;
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *ptepage;
 
@@ -119,12 +119,14 @@ struct page *pte_alloc_one(struct mm_str
 #endif
 
 	ptepage = alloc_pages(flags, 0);
-	if (ptepage)
+	if (ptepage) {
 		clear_highpage(ptepage);
+		__pte_page_ctor(ptepage);
+	}
 	return ptepage;
 }
 
-void pte_free_kernel(pte_t *pte)
+void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
@@ -132,11 +134,12 @@ void pte_free_kernel(pte_t *pte)
 	free_page((unsigned long)pte);
 }
 
-void pte_free(struct page *ptepage)
+void pte_free(struct mm_struct *mm, ptetoken_t ptepage)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	__pte_page_dtor(ptepage);
 	__free_page(ptepage);
 }
 
diff -urpN linux-2.6/arch/sparc/mm/srmmu.c linux-2.6-patched/arch/sparc/mm/srmmu.c
--- linux-2.6/arch/sparc/mm/srmmu.c	2007-05-09 09:58:12.000000000 +0200
+++ linux-2.6-patched/arch/sparc/mm/srmmu.c	2007-06-28 17:58:44.000000000 +0200
@@ -493,14 +493,17 @@ srmmu_pte_alloc_one_kernel(struct mm_str
 	return (pte_t *)srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 }
 
-static struct page *
+static ptetoken_t
 srmmu_pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long pte;
+	struct page *page;
 
 	if ((pte = (unsigned long)srmmu_pte_alloc_one_kernel(mm, address)) == 0)
 		return NULL;
-	return pfn_to_page( __nocache_pa(pte) >> PAGE_SHIFT );
+	page = pfn_to_page( __nocache_pa(pte) >> PAGE_SHIFT );
+	__pte_page_ctor(page);
+	return page;
 }
 
 static void srmmu_free_pte_fast(pte_t *pte)
@@ -508,10 +511,11 @@ static void srmmu_free_pte_fast(pte_t *p
 	srmmu_free_nocache((unsigned long)pte, PTE_SIZE);
 }
 
-static void srmmu_pte_free(struct page *pte)
+static void srmmu_pte_free(ptetoken_t pte)
 {
 	unsigned long p;
 
+	__pte_page_dtor(pte);
 	p = (unsigned long)page_address(pte);	/* Cached address (for test) */
 	if (p == 0)
 		BUG();
diff -urpN linux-2.6/arch/sparc/mm/sun4c.c linux-2.6-patched/arch/sparc/mm/sun4c.c
--- linux-2.6/arch/sparc/mm/sun4c.c	2006-11-08 10:45:08.000000000 +0100
+++ linux-2.6-patched/arch/sparc/mm/sun4c.c	2007-06-28 17:58:44.000000000 +0200
@@ -1952,12 +1952,17 @@ static pte_t *sun4c_pte_alloc_one_kernel
 	return pte;
 }
 
-static struct page *sun4c_pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static ptetoken_t sun4c_pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = sun4c_pte_alloc_one_kernel(mm, address);
+	pte_t *pte;
+	struct page *page;
+
+	pte = sun4c_pte_alloc_one_kernel(mm, address);
 	if (pte == NULL)
 		return NULL;
-	return virt_to_page(pte);
+	page = virt_to_page(pte);
+	__pte_page_ctor(page);
+	return page;
 }
 
 static __inline__ void sun4c_free_pte_fast(pte_t *pte)
@@ -1967,8 +1972,9 @@ static __inline__ void sun4c_free_pte_fa
 	pgtable_cache_size++;
 }
 
-static void sun4c_pte_free(struct page *pte)
+static void sun4c_pte_free(ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	sun4c_free_pte_fast(page_address(pte));
 }
 
diff -urpN linux-2.6/arch/um/kernel/mem.c linux-2.6-patched/arch/um/kernel/mem.c
--- linux-2.6/arch/um/kernel/mem.c	2007-05-08 09:23:10.000000000 +0200
+++ linux-2.6-patched/arch/um/kernel/mem.c	2007-06-28 17:58:44.000000000 +0200
@@ -361,10 +361,12 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	return pte;
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 
 	pte = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	if (pte)
+		__pte_page_ctor(pte);
 	return pte;
 }
diff -urpN linux-2.6/arch/xtensa/mm/init.c linux-2.6-patched/arch/xtensa/mm/init.c
--- linux-2.6/arch/xtensa/mm/init.c	2007-06-08 09:32:30.000000000 +0200
+++ linux-2.6-patched/arch/xtensa/mm/init.c	2007-06-28 17:58:44.000000000 +0200
@@ -501,6 +501,7 @@ struct page* pte_alloc_one(struct mm_str
 			pte_clear(mm, addr, ptep);
 
 		kunmap_atomic(ptep, KM_USER0);
+		__pte_page_ctor(page);
 	}
 	return page;
 }
diff -urpN linux-2.6/include/asm-alpha/page.h linux-2.6-patched/include/asm-alpha/page.h
--- linux-2.6/include/asm-alpha/page.h	2006-11-08 10:45:39.000000000 +0100
+++ linux-2.6-patched/include/asm-alpha/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -62,6 +62,8 @@ typedef unsigned long pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+typedef struct page *ptetoken_t;
+
 #ifdef USE_48_BIT_KSEG
 #define PAGE_OFFSET		0xffff800000000000UL
 #else
diff -urpN linux-2.6/include/asm-alpha/pgalloc.h linux-2.6-patched/include/asm-alpha/pgalloc.h
--- linux-2.6/include/asm-alpha/pgalloc.h	2006-11-08 10:45:39.000000000 +0100
+++ linux-2.6-patched/include/asm-alpha/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -11,10 +11,11 @@
  */
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+pmd_populate(struct mm_struct *mm, pmd_t *pmd, ptetoken_t pte)
 {
 	pmd_set(pmd, (pte_t *)(page_to_pa(pte) + PAGE_OFFSET));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
@@ -52,23 +53,28 @@ pmd_free(pmd_t *pmd)
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 
 static inline void
-pte_free_kernel(pte_t *pte)
+pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline struct page *
-pte_alloc_one(struct mm_struct *mm, unsigned long addr)
+static inline ptetoken_t
+pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte = pte_alloc_one_kernel(mm, addr);
-	if (pte)
-		return virt_to_page(pte);
-	return NULL;
+	struct page *page;
+
+	if (!pte)
+		return NULL;
+	page = virt_to_page(pte);
+	__pte_page_ctor(page);
+	return page;
 }
 
 static inline void
-pte_free(struct page *page)
+pte_free(struct mm_struct *mm, ptetoken_t page)
 {
+	__pte_page_dtor(page);
 	__free_page(page);
 }
 
diff -urpN linux-2.6/include/asm-alpha/tlb.h linux-2.6-patched/include/asm-alpha/tlb.h
--- linux-2.6/include/asm-alpha/tlb.h	2006-11-08 10:45:39.000000000 +0100
+++ linux-2.6-patched/include/asm-alpha/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -9,7 +9,7 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb,pte)			pte_free(pte)
+#define __pte_free_tlb(tlb,pte)			pte_free((tlb)->mm, pte)
 #define __pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
  
 #endif
diff -urpN linux-2.6/include/asm-arm/page.h linux-2.6-patched/include/asm-arm/page.h
--- linux-2.6/include/asm-arm/page.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -174,6 +174,8 @@ typedef unsigned long pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+typedef struct page *ptetoken_t;
+
 #endif /* CONFIG_MMU */
 
 #include <asm/memory.h>
diff -urpN linux-2.6/include/asm-arm/pgalloc.h linux-2.6-patched/include/asm-arm/pgalloc.h
--- linux-2.6/include/asm-arm/pgalloc.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -66,7 +66,7 @@ pte_alloc_one_kernel(struct mm_struct *m
 	return pte;
 }
 
-static inline struct page *
+static inline ptetoken_t
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	struct page *pte;
@@ -75,6 +75,7 @@ pte_alloc_one(struct mm_struct *mm, unsi
 	if (pte) {
 		void *page = page_address(pte);
 		clean_dcache_area(page, sizeof(pte_t) * PTRS_PER_PTE);
+		__pte_page_ctor(pte);
 	}
 
 	return pte;
@@ -83,7 +84,7 @@ pte_alloc_one(struct mm_struct *mm, unsi
 /*
  * Free one PTE table.
  */
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	if (pte) {
 		pte -= PTRS_PER_PTE;
@@ -91,8 +92,9 @@ static inline void pte_free_kernel(pte_t
 	}
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
@@ -123,10 +125,11 @@ pmd_populate_kernel(struct mm_struct *mm
 }
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
+pmd_populate(struct mm_struct *mm, pmd_t *pmdp, ptetoken_t ptep)
 {
 	__pmd_populate(pmdp, page_to_pfn(ptep) << PAGE_SHIFT | _PAGE_USER_TABLE);
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 #endif /* CONFIG_MMU */
 
diff -urpN linux-2.6/include/asm-arm/tlb.h linux-2.6-patched/include/asm-arm/tlb.h
--- linux-2.6/include/asm-arm/tlb.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -85,7 +85,7 @@ tlb_end_vma(struct mmu_gather *tlb, stru
 }
 
 #define tlb_remove_page(tlb,page)	free_page_and_swap_cache(page)
-#define pte_free_tlb(tlb,ptep)		pte_free(ptep)
+#define pte_free_tlb(tlb,ptep)		pte_free((tlb)->mm, ptep)
 #define pmd_free_tlb(tlb,pmdp)		pmd_free(pmdp)
 
 #define tlb_migrate_finish(mm)		do { } while (0)
diff -urpN linux-2.6/include/asm-arm26/page.h linux-2.6-patched/include/asm-arm26/page.h
--- linux-2.6/include/asm-arm26/page.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm26/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -67,6 +67,9 @@ typedef unsigned long pgprot_t;
 #define __pgprot(x)     (x)
 
 #endif /* STRICT_MM_TYPECHECKS */
+
+typedef struct page *ptetoken_t;
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
diff -urpN linux-2.6/include/asm-arm26/pgalloc.h linux-2.6-patched/include/asm-arm26/pgalloc.h
--- linux-2.6/include/asm-arm26/pgalloc.h	2006-12-08 10:06:06.000000000 +0100
+++ linux-2.6-patched/include/asm-arm26/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -21,7 +21,8 @@ static inline pte_t *pte_alloc_one_kerne
 	return kmem_cache_alloc(pte_cache, GFP_KERNEL);
 }
 
-static inline void pte_free_kernel(pte_t *pte){
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
         if (pte)
                 kmem_cache_free(pte_cache, pte);
 }
@@ -44,9 +45,28 @@ pmd_populate_kernel(struct mm_struct *mm
  * FIXME - We use the old 2.5.5-rmk1 hack for this.
  * This is not truly correct, but should be functional.
  */
-#define pte_alloc_one(mm,addr)  ((struct page *)pte_alloc_one_kernel(mm,addr))
-#define pte_free(pte)           pte_free_kernel((pte_t *)pte)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	pte_t *pte = pte_alloc_one_kernel(mm, addr);
+	if (!pte)
+		return NULL;
+	/*
+	 * This is sick: __pte_page_ctor is called with a pointer to
+	 * a memory area containing zeroes which is interpreted as a
+	 * struct page .. not truly correct, but should be functional.
+	 */
+	__pte_page_ctor((struct page *) pte);
+	return (ptetoken_t) pte;
+}
+
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
+{
+	__pte_page_dtor(pte);
+	pte_free_kernel(mm, pte);
+}
+
 #define pmd_populate(mm,pmdp,ptep) pmd_populate_kernel(mm,pmdp,(pte_t *)ptep)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Since we have only two-level page tables, these are trivial
diff -urpN linux-2.6/include/asm-arm26/tlb.h linux-2.6-patched/include/asm-arm26/tlb.h
--- linux-2.6/include/asm-arm26/tlb.h	2006-11-08 10:45:43.000000000 +0100
+++ linux-2.6-patched/include/asm-arm26/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -57,7 +57,7 @@ tlb_remove_page(struct mmu_gather *tlb, 
         free_page_and_swap_cache(page);
 }
 
-#define pte_free_tlb(tlb,ptep)          pte_free(ptep)
+#define pte_free_tlb(tlb,ptep)		pte_free((tlb)->mm, ptep)
 #define pmd_free_tlb(tlb,pmdp)          pmd_free(pmdp)
 
 #endif
diff -urpN linux-2.6/include/asm-avr32/page.h linux-2.6-patched/include/asm-avr32/page.h
--- linux-2.6/include/asm-avr32/page.h	2006-11-08 10:45:44.000000000 +0100
+++ linux-2.6-patched/include/asm-avr32/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -36,6 +36,7 @@ extern void copy_page(void *to, void *fr
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *ptetoken_t;
 
 #define pte_val(x)		((x).pte)
 #define pgd_val(x)		((x).pgd)
diff -urpN linux-2.6/include/asm-avr32/pgalloc.h linux-2.6-patched/include/asm-avr32/pgalloc.h
--- linux-2.6/include/asm-avr32/pgalloc.h	2006-12-14 09:46:01.000000000 +0100
+++ linux-2.6-patched/include/asm-avr32/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -17,10 +17,11 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
 
 static __inline__ void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				    struct page *pte)
+				    ptetoken_t pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE + page_to_phys(pte)));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables
@@ -44,52 +45,41 @@ static inline void pgd_free(pgd_t *pgd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	int count = 0;
 	pte_t *pte;
 
-	do {
-		pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT);
-		if (pte)
-			clear_page(pte);
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
-
+	pte = (pte_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	if (!pte)
+		return NULL;
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	int count = 0;
-	struct page *pte;
-
-	do {
-		pte = alloc_pages(GFP_KERNEL, 0);
-		if (pte)
-			clear_page(page_address(pte));
-		else {
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
-	} while (!pte && (count++ < 10));
+	struct page *page;
 
-	return pte;
+	page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	if (!page)
+		return NULL;
+	__pte_page_ctor(page);
+	return page_address(page);
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb), pte);			\
+} while (0)
 
 #define check_pgt_cache() do { } while(0)
 
diff -urpN linux-2.6/include/asm-cris/page.h linux-2.6-patched/include/asm-cris/page.h
--- linux-2.6/include/asm-cris/page.h	2006-11-08 10:45:44.000000000 +0100
+++ linux-2.6-patched/include/asm-cris/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -30,6 +30,7 @@
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *ptetoken_t;
 #endif
 
 #define pte_val(x)	((x).pte)
diff -urpN linux-2.6/include/asm-cris/pgalloc.h linux-2.6-patched/include/asm-cris/pgalloc.h
--- linux-2.6/include/asm-cris/pgalloc.h	2006-11-08 10:45:44.000000000 +0100
+++ linux-2.6-patched/include/asm-cris/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -6,6 +6,7 @@
 
 #define pmd_populate_kernel(mm, pmd, pte) pmd_set(pmd, pte)
 #define pmd_populate(mm, pmd, pte) pmd_set(pmd, page_address(pte))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
@@ -27,25 +28,30 @@ static inline pte_t *pte_alloc_one_kerne
  	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline ptetoken_t  *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
+	__pte_page_ctor(pte);
 	return pte;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
-
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb), pte);			\
+} while (0)
 
 #define check_pgt_cache()          do { } while (0)
 
diff -urpN linux-2.6/include/asm-frv/page.h linux-2.6-patched/include/asm-frv/page.h
--- linux-2.6/include/asm-frv/page.h	2007-02-05 20:28:26.000000000 +0100
+++ linux-2.6-patched/include/asm-frv/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -27,6 +27,7 @@ typedef struct { unsigned long	ste[64];}
 typedef struct { pmd_t		pue[1]; } pud_t;
 typedef struct { pud_t		pge[1];	} pgd_t;
 typedef struct { unsigned long	pgprot;	} pgprot_t;
+typedef struct page *ptetoken_t;
 
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).ste[0])
diff -urpN linux-2.6/include/asm-frv/pgalloc.h linux-2.6-patched/include/asm-frv/pgalloc.h
--- linux-2.6/include/asm-frv/pgalloc.h	2006-11-08 10:45:44.000000000 +0100
+++ linux-2.6-patched/include/asm-frv/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -25,6 +25,7 @@
 do {										\
 	__set_pmd((PMD), page_to_pfn(PAGE) << PAGE_SHIFT | _PAGE_TABLE);	\
 } while(0)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
@@ -35,19 +36,24 @@ extern void pgd_free(pgd_t *);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
 
-extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
+extern ptetoken_t pte_alloc_one(struct mm_struct *, unsigned long);
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
-#define __pte_free_tlb(tlb,pte)		tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb),(pte));			\
+} while (0)
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -urpN linux-2.6/include/asm-i386/page.h linux-2.6-patched/include/asm-i386/page.h
--- linux-2.6/include/asm-i386/page.h	2007-05-06 10:18:28.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -116,6 +116,8 @@ static inline pte_t native_make_pte(unsi
 #include <asm-generic/pgtable-nopmd.h>
 #endif	/* CONFIG_X86_PAE */
 
+typedef struct page *ptetoken_t;
+
 #define PTE_MASK	PAGE_MASK
 
 #ifdef CONFIG_HUGETLB_PAGE
diff -urpN linux-2.6/include/asm-i386/pgalloc.h linux-2.6-patched/include/asm-i386/pgalloc.h
--- linux-2.6/include/asm-i386/pgalloc.h	2007-05-13 16:22:06.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -28,6 +28,7 @@ do {								\
 		((unsigned long long)page_to_pfn(pte) <<	\
 			(unsigned long long) PAGE_SHIFT)));	\
 } while (0)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
@@ -36,21 +37,23 @@ extern pgd_t *pgd_alloc(struct mm_struct
 extern void pgd_free(pgd_t *pgd);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
-extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
+extern ptetoken_t pte_alloc_one(struct mm_struct *, unsigned long);
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
 
 #define __pte_free_tlb(tlb,pte) 					\
 do {									\
+	__pte_page_dtor(pte);						\
 	paravirt_release_pt(page_to_pfn(pte));				\
 	tlb_remove_page((tlb),(pte));					\
 } while (0)
diff -urpN linux-2.6/include/asm-ia64/page.h linux-2.6-patched/include/asm-ia64/page.h
--- linux-2.6/include/asm-ia64/page.h	2006-12-08 10:06:06.000000000 +0100
+++ linux-2.6-patched/include/asm-ia64/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -207,6 +207,7 @@ get_order (unsigned long size)
     typedef unsigned long pmd_t;
     typedef unsigned long pgd_t;
     typedef unsigned long pgprot_t;
+    typedef struct page *ptetoken_t;
 # endif
 
 # define pte_val(x)	(x)
diff -urpN linux-2.6/include/asm-ia64/pgalloc.h linux-2.6-patched/include/asm-ia64/pgalloc.h
--- linux-2.6/include/asm-ia64/pgalloc.h	2007-05-12 20:16:10.000000000 +0200
+++ linux-2.6-patched/include/asm-ia64/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -70,10 +70,11 @@ static inline void pmd_free(pmd_t * pmd)
 #define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t * pmd_entry, struct page *pte)
+pmd_populate(struct mm_struct *mm, pmd_t * pmd_entry, ptetoken_t pte)
 {
 	pmd_val(*pmd_entry) = page_to_phys(pte);
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmd_entry, pte_t * pte)
@@ -81,11 +82,17 @@ pmd_populate_kernel(struct mm_struct *mm
 	pmd_val(*pmd_entry) = __pa(pte);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long addr)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	void *pg = quicklist_alloc(0, GFP_KERNEL, NULL);
-	return pg ? virt_to_page(pg) : NULL;
+	struct page *page;
+	void *pg;
+
+	pg = quicklist_alloc(0, GFP_KERNEL, NULL);
+	if (!pg)
+		return NULL;
+	page = virt_to_page(pg);
+	__pte_page_ctor(page);
+	return page;
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
@@ -94,12 +101,13 @@ static inline pte_t *pte_alloc_one_kerne
 	return quicklist_alloc(0, GFP_KERNEL, NULL);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	quicklist_free_page(0, NULL, pte);
 }
 
-static inline void pte_free_kernel(pte_t * pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t * pte)
 {
 	quicklist_free(0, NULL, pte);
 }
@@ -109,6 +117,6 @@ static inline void check_pgt_cache(void)
 	quicklist_trim(0, NULL, 25, 16);
 }
 
-#define __pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, pte)
 
 #endif				/* _ASM_IA64_PGALLOC_H */
diff -urpN linux-2.6/include/asm-m32r/page.h linux-2.6-patched/include/asm-m32r/page.h
--- linux-2.6/include/asm-m32r/page.h	2007-02-12 12:09:06.000000000 +0100
+++ linux-2.6-patched/include/asm-m32r/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -28,6 +28,7 @@ typedef struct { unsigned long pgd; } pg
 #define PTE_MASK	PAGE_MASK
 
 typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *ptetoken_t;
 
 #define pmd_val(x)	((x).pmd)
 #define pgd_val(x)	((x).pgd)
diff -urpN linux-2.6/include/asm-m32r/pgalloc.h linux-2.6-patched/include/asm-m32r/pgalloc.h
--- linux-2.6/include/asm-m32r/pgalloc.h	2007-02-12 12:09:06.000000000 +0100
+++ linux-2.6-patched/include/asm-m32r/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -9,10 +9,11 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
 
 static __inline__ void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-	struct page *pte)
+	ptetoken_t pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE + page_to_phys(pte)));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
@@ -37,26 +38,27 @@ static __inline__ pte_t *pte_alloc_one_k
 	return pte;
 }
 
-static __inline__ struct page *pte_alloc_one(struct mm_struct *mm,
+static __inline__ ptetoken_t pte_alloc_one(struct mm_struct *mm,
 	unsigned long address)
 {
 	struct page *pte = alloc_page(GFP_KERNEL|__GFP_ZERO);
 
-
+	__pte_page_ctor(pte);
 	return pte;
 }
 
-static __inline__ void pte_free_kernel(pte_t *pte)
+static __inline__ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static __inline__ void pte_free(struct page *pte)
+static __inline__ void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
-#define __pte_free_tlb(tlb, pte)	pte_free((pte))
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, (pte))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -urpN linux-2.6/include/asm-m68k/motorola_pgalloc.h linux-2.6-patched/include/asm-m68k/motorola_pgalloc.h
--- linux-2.6/include/asm-m68k/motorola_pgalloc.h	2006-11-08 10:45:46.000000000 +0100
+++ linux-2.6-patched/include/asm-m68k/motorola_pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -7,7 +7,6 @@
 extern pmd_t *get_pointer_table(void);
 extern int free_pointer_table(pmd_t *);
 
-
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
@@ -22,13 +21,13 @@ static inline pte_t *pte_alloc_one_kerne
 	return pte;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	cache_page(pte);
 	free_page((unsigned long) pte);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	pte_t *pte;
@@ -43,19 +42,21 @@ static inline struct page *pte_alloc_one
 		nocache_page(pte);
 	}
 	kunmap(pte);
-
+	__pte_page_ctor(page);
 	return page;
 }
 
-static inline void pte_free(struct page *page)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t page)
 {
+	__pte_page_dtor(page);
 	cache_page(kmap(page));
 	kunmap(page);
 	__free_page(page);
 }
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *page)
+static inline void __pte_free_tlb(struct mmu_gather *tlb, ptetoken_t page)
 {
+	__pte_page_dtor(page);
 	cache_page(kmap(page));
 	kunmap(page);
 	__free_page(page);
@@ -94,10 +95,11 @@ static inline void pmd_populate_kernel(s
 	pmd_set(pmd, pte);
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, ptetoken_t page)
 {
 	pmd_set(pmd, page_address(page));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
 {
diff -urpN linux-2.6/include/asm-m68k/page.h linux-2.6-patched/include/asm-m68k/page.h
--- linux-2.6/include/asm-m68k/page.h	2007-06-01 10:06:01.000000000 +0200
+++ linux-2.6-patched/include/asm-m68k/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -94,6 +94,7 @@ typedef struct { unsigned long pte; } pt
 typedef struct { unsigned long pmd[16]; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *ptetoken_t;
 
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((&x)->pmd[0])
diff -urpN linux-2.6/include/asm-m68k/sun3_pgalloc.h linux-2.6-patched/include/asm-m68k/sun3_pgalloc.h
--- linux-2.6/include/asm-m68k/sun3_pgalloc.h	2006-11-08 10:45:46.000000000 +0100
+++ linux-2.6-patched/include/asm-m68k/sun3_pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -21,17 +21,22 @@ extern const char bad_pmd_string[];
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 
 
-static inline void pte_free_kernel(pte_t * pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t * pte)
 {
         free_page((unsigned long) pte);
 }
 
-static inline void pte_free(struct page *page)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t page)
 {
+	__pte_page_dtor(page);
         __free_page(page);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb), pte);			\
+} while (0)
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
@@ -45,8 +50,8 @@ static inline pte_t *pte_alloc_one_kerne
 	return (pte_t *) (page);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
 {
         struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
 
@@ -54,6 +59,7 @@ static inline struct page *pte_alloc_one
 		return NULL;
 
 	clear_highpage(page);
+	__pte_page_ctor(page);
 	return page;
 
 }
@@ -63,10 +69,11 @@ static inline void pmd_populate_kernel(s
 	pmd_val(*pmd) = __pa((unsigned long)pte);
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, ptetoken_t page)
 {
 	pmd_val(*pmd) = __pa((unsigned long)page_address(page));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -urpN linux-2.6/include/asm-mips/page.h linux-2.6-patched/include/asm-mips/page.h
--- linux-2.6/include/asm-mips/page.h	2007-05-12 20:16:11.000000000 +0200
+++ linux-2.6-patched/include/asm-mips/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -100,6 +100,7 @@ typedef struct { unsigned long pte; } pt
 #define pte_val(x)	((x).pte)
 #define __pte(x)	((pte_t) { (x) } )
 #endif
+typedef struct page *ptetoken_t;
 
 /*
  * For 3-level pagetables we defines these ourselves, for 2-level the
diff -urpN linux-2.6/include/asm-mips/pgalloc.h linux-2.6-patched/include/asm-mips/pgalloc.h
--- linux-2.6/include/asm-mips/pgalloc.h	2007-05-22 09:49:49.000000000 +0200
+++ linux-2.6-patched/include/asm-mips/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -20,10 +20,11 @@ static inline void pmd_populate_kernel(s
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-	struct page *pte)
+	ptetoken_t pte)
 {
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Initialize a new pmd table with invalid pointers.
@@ -73,29 +74,35 @@ static inline pte_t *pte_alloc_one_kerne
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
 	unsigned long address)
 {
 	struct page *pte;
 
 	pte = alloc_pages(GFP_KERNEL | __GFP_REPEAT, PTE_ORDER);
-	if (pte)
+	if (pte) {
 		clear_highpage(pte);
-
+		__pte_page_ctor(pte);
+	}
 	return pte;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_pages((unsigned long)pte, PTE_ORDER);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_dtor(pte);
 	__free_pages(pte, PTE_ORDER);
 }
 
-#define __pte_free_tlb(tlb,pte)		tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb),(pte));			\
+} while (0)
 
 #ifdef CONFIG_32BIT
 
diff -urpN linux-2.6/include/asm-parisc/page.h linux-2.6-patched/include/asm-parisc/page.h
--- linux-2.6/include/asm-parisc/page.h	2007-02-27 15:33:34.000000000 +0100
+++ linux-2.6-patched/include/asm-parisc/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -91,6 +91,7 @@ typedef unsigned long pgprot_t;
 
 #endif /* STRICT_MM_TYPECHECKS */
 
+typedef struct page *ptetoken_t;
 
 typedef struct __physmem_range {
 	unsigned long start_pfn;
diff -urpN linux-2.6/include/asm-parisc/pgalloc.h linux-2.6-patched/include/asm-parisc/pgalloc.h
--- linux-2.6/include/asm-parisc/pgalloc.h	2007-02-27 15:33:34.000000000 +0100
+++ linux-2.6-patched/include/asm-parisc/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -115,11 +115,14 @@ pmd_populate_kernel(struct mm_struct *mm
 
 #define pmd_populate(mm, pmd, pte_page) \
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
-static inline struct page *
+static inline ptetoken_t
 pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	if (page)
+		__pte_page_ctor(page);
 	return page;
 }
 
@@ -130,12 +133,16 @@ pte_alloc_one_kernel(struct mm_struct *m
 	return pte;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-#define pte_free(page)	pte_free_kernel(page_address(page))
+static inline void pte_free_kernel(struct mm_struct *mm, ptetoken_t pte)
+{
+	__pte_page_dtor(pte);
+	__free_page(pte);
+}
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urpN linux-2.6/include/asm-parisc/tlb.h linux-2.6-patched/include/asm-parisc/tlb.h
--- linux-2.6/include/asm-parisc/tlb.h	2006-11-08 10:45:47.000000000 +0100
+++ linux-2.6-patched/include/asm-parisc/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -22,6 +22,6 @@ do {	if (!(tlb)->fullmm)	\
 #include <asm-generic/tlb.h>
 
 #define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
-#define __pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, pte)
 
 #endif
diff -urpN linux-2.6/include/asm-powerpc/page.h linux-2.6-patched/include/asm-powerpc/page.h
--- linux-2.6/include/asm-powerpc/page.h	2007-05-09 09:58:15.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -192,6 +192,8 @@ extern int page_is_ram(unsigned long pfn
 struct vm_area_struct;
 extern const char *arch_vma_name(struct vm_area_struct *vma);
 
+typedef struct page *ptetoken_t;
+
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
 
diff -urpN linux-2.6/include/asm-powerpc/pgalloc-32.h linux-2.6-patched/include/asm-powerpc/pgalloc-32.h
--- linux-2.6/include/asm-powerpc/pgalloc-32.h	2007-05-09 09:58:15.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/pgalloc-32.h	2007-06-28 17:58:44.000000000 +0200
@@ -22,19 +22,21 @@ extern void pgd_free(pgd_t *pgd);
 		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 #else
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)lowmem_page_address(pte) | _PMD_PRESENT)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 #endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern struct page *pte_alloc_one(struct mm_struct *mm, unsigned long addr);
-extern void pte_free_kernel(pte_t *pte);
-extern void pte_free(struct page *pte);
+extern ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+extern void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
+extern void pte_free(struct mm_struct *mm, ptetoken_t pte);
 
-#define __pte_free_tlb(tlb, pte)	pte_free((pte))
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, (pte))
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urpN linux-2.6/include/asm-powerpc/pgalloc-64.h linux-2.6-patched/include/asm-powerpc/pgalloc-64.h
--- linux-2.6/include/asm-powerpc/pgalloc-64.h	2007-06-04 10:06:47.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/pgalloc-64.h	2007-06-28 17:58:44.000000000 +0200
@@ -53,6 +53,7 @@ static inline void pud_populate(struct m
 #define pmd_populate(mm, pmd, pte_page) \
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 #define pmd_populate_kernel(mm, pmd, pte) pmd_set(pmd, (unsigned long)(pte))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 
 #else /* CONFIG_PPC_64K_PAGES */
@@ -87,20 +88,28 @@ static inline pte_t *pte_alloc_one_kerne
         return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
 {
-	pte_t *pte = pte_alloc_one_kernel(mm, address);
-	return pte ? virt_to_page(pte) : NULL;
+	struct page *page;
+	pte_t *pte;
+
+	pte = pte_alloc_one_kernel(mm, address);
+	if (!pte)
+		return NULL;
+	page = virt_to_page(pte);
+	__pte_page_ctor(page);
+	return page;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-static inline void pte_free(struct page *ptepage)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t ptepage)
 {
+	__pte_page_dtor(ptepage);
 	__free_page(ptepage);
 }
 
@@ -131,9 +140,12 @@ static inline void pgtable_free(pgtable_
 
 extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
 
-#define __pte_free_tlb(tlb, ptepage)	\
+#define __pte_free_tlb(tlb,pte)	\
+do { \
+	__pte_page_dtor(ptepage); \
 	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
-		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1))
+		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
+} while (0)
 #define __pmd_free_tlb(tlb, pmd) 	\
 	pgtable_free_tlb(tlb, pgtable_free_cache(pmd, \
 		PMD_CACHE_NUM, PMD_TABLE_SIZE-1))
diff -urpN linux-2.6/include/asm-ppc/page.h linux-2.6-patched/include/asm-ppc/page.h
--- linux-2.6/include/asm-ppc/page.h	2006-11-08 10:45:47.000000000 +0100
+++ linux-2.6-patched/include/asm-ppc/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -97,6 +97,8 @@ extern void clear_user_page(void *page, 
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
 			   struct page *pg);
 
+typedef struct page *ptetoken_t;
+
 #ifndef CONFIG_APUS
 #define PPC_MEMSTART	0
 #define PPC_PGSTART	0
diff -urpN linux-2.6/include/asm-ppc/pgalloc.h linux-2.6-patched/include/asm-ppc/pgalloc.h
--- linux-2.6/include/asm-ppc/pgalloc.h	2006-11-08 10:45:47.000000000 +0100
+++ linux-2.6-patched/include/asm-ppc/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -23,19 +23,21 @@ extern void pgd_free(pgd_t *pgd);
 		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 #else
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = (unsigned long)lowmem_page_address(pte) | _PMD_PRESENT)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 #endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern struct page *pte_alloc_one(struct mm_struct *mm, unsigned long addr);
-extern void pte_free_kernel(pte_t *pte);
-extern void pte_free(struct page *pte);
+extern ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+extern void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
+extern void pte_free(struct mm_struct *mm, ptetoken_t pte);
 
-#define __pte_free_tlb(tlb, pte)	pte_free((pte))
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, (pte))
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urpN linux-2.6/include/asm-s390/page.h linux-2.6-patched/include/asm-s390/page.h
--- linux-2.6/include/asm-s390/page.h	2006-12-09 21:08:22.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -104,6 +104,8 @@ typedef struct { unsigned long pgd; } pg
 
 #endif /* __s390x__ */
 
+typedef struct page *ptetoken_t;
+
 #define __pte(x)        ((pte_t) { (x) } )
 #define __pmd(x)        ((pmd_t) { (x) } )
 #define __pgd(x)        ((pgd_t) { (x) } )
diff -urpN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-patched/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	2007-02-07 15:42:46.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -159,7 +159,7 @@ pmd_populate_kernel(struct mm_struct *mm
 }
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+pmd_populate(struct mm_struct *mm, pmd_t *pmd, ptetoken_t page)
 {
 	pte_t *pte = (pte_t *)page_to_phys(page);
 	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
@@ -169,6 +169,7 @@ pmd_populate(struct mm_struct *mm, pmd_t
 	if (shadow_pmd && shadow_pte)
 		pmd_populate_kernel(mm, shadow_pmd, shadow_pte);
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * page table entry allocation/free routines.
@@ -199,16 +200,21 @@ pte_alloc_one_kernel(struct mm_struct *m
 	return pte;
 }
 
-static inline struct page *
+static inline ptetoken_t
 pte_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
-	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
-	if (pte)
-		return virt_to_page(pte);
-	return NULL;
+	struct page *page;
+	pte_t *pte;
+
+	pte = pte_alloc_one_kernel(mm, vmaddr);
+	if (!pte)
+		return NULL;
+	page = virt_to_page(pte);
+	__pte_page_ctor(page);
+	return page;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	pte_t *shadow_pte = get_shadow_pte(pte);
 
@@ -217,10 +223,11 @@ static inline void pte_free_kernel(pte_t
 	free_page((unsigned long) pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
 	struct page *shadow_page = get_shadow_page(pte);
 
+	__pte_page_dtor(pte);
 	if (shadow_page)
 		__free_page(shadow_page);
 	__free_page(pte);
@@ -231,6 +238,7 @@ static inline void pte_free(struct page 
 	struct mmu_gather *__tlb = (tlb);				\
 	struct page *__pte = (pte);					\
 	struct page *shadow_page = get_shadow_page(__pte);		\
+	__pte_page_ctor(__pte);						\
 	if (shadow_page)						\
 		tlb_remove_page(__tlb, shadow_page);			\
 	tlb_remove_page(__tlb, __pte);					\
diff -urpN linux-2.6/include/asm-sh/page.h linux-2.6-patched/include/asm-sh/page.h
--- linux-2.6/include/asm-sh/page.h	2007-05-08 09:23:16.000000000 +0200
+++ linux-2.6-patched/include/asm-sh/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -106,6 +106,8 @@ typedef struct { unsigned long pgd; } pg
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
+typedef struct page *ptetoken_t;
+
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
diff -urpN linux-2.6/include/asm-sh/pgalloc.h linux-2.6-patched/include/asm-sh/pgalloc.h
--- linux-2.6/include/asm-sh/pgalloc.h	2007-05-10 09:32:11.000000000 +0200
+++ linux-2.6-patched/include/asm-sh/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -14,10 +14,11 @@ static inline void pmd_populate_kernel(s
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				struct page *pte)
+				ptetoken_t pte)
 {
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void pgd_ctor(void *x)
 {
@@ -47,24 +48,36 @@ static inline pte_t *pte_alloc_one_kerne
 	return quicklist_alloc(QUICK_PT, GFP_KERNEL | __GFP_REPEAT, NULL);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
 {
-	void *pg = quicklist_alloc(QUICK_PT, GFP_KERNEL | __GFP_REPEAT, NULL);
-	return pg ? virt_to_page(pg) : NULL;
+	struct page *page;
+	void *pg;
+
+	pg = quicklist_alloc(QUICK_PT, GFP_KERNEL | __GFP_REPEAT, NULL);
+	if (!pg)
+		return NULL;
+	page = virt_to_page(pg);
+	__pte_page_ctor(page);
+	return page;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	quicklist_free(QUICK_PT, NULL, pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
-	quicklist_free_page(QUICK_PT, NULL, pte);
+	__pte_page_dtor(pte);
+	quicklist_free_page(0, NULL, pte);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff -urpN linux-2.6/include/asm-sh64/page.h linux-2.6-patched/include/asm-sh64/page.h
--- linux-2.6/include/asm-sh64/page.h	2006-11-08 10:45:48.000000000 +0100
+++ linux-2.6-patched/include/asm-sh64/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -83,6 +83,8 @@ typedef struct { unsigned long pgprot; }
 #define __pgd(x) ((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
+typedef struct page *ptetoken_t;
+
 #endif /* !__ASSEMBLY__ */
 
 /* to align the pointer to the (next) page boundary */
diff -urpN linux-2.6/include/asm-sh64/pgalloc.h linux-2.6-patched/include/asm-sh64/pgalloc.h
--- linux-2.6/include/asm-sh64/pgalloc.h	2007-05-16 08:53:54.000000000 +0200
+++ linux-2.6-patched/include/asm-sh64/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -51,20 +51,28 @@ static inline void pgd_free(pgd_t *pgd)
 	quicklist_free(0, NULL, pgd);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
 {
-	void *pg = quicklist_alloc(0, GFP_KERNEL, NULL);
-	return pg ? virt_to_page(pg) : NULL;
+	struct page *page;
+	void *pg;
+
+	pg = quicklist_alloc(0, GFP_KERNEL, NULL);
+	if (!pg)
+		return NULL;
+	page = virt_to_page(pg);
+	__pte_page_ctor(page);
+	return page;
 }
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	quicklist_free(0, NULL, pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	quicklist_free_page(0, NULL, pte);
 }
 
@@ -74,7 +82,11 @@ static inline pte_t *pte_alloc_one_kerne
 	return quicklist_alloc(0, GFP_KERNEL, NULL);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb),(pte));			\
+} while (0)
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
@@ -112,10 +124,11 @@ static inline void pmd_free(pmd_t *pmd)
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) (pte)))
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				struct page *pte)
+				ptetoken_t pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) page_address (pte)));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void check_pgt_cache(void)
 {
diff -urpN linux-2.6/include/asm-sparc/page.h linux-2.6-patched/include/asm-sparc/page.h
--- linux-2.6/include/asm-sparc/page.h	2006-11-08 10:45:48.000000000 +0100
+++ linux-2.6-patched/include/asm-sparc/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -125,6 +125,8 @@ typedef unsigned long iopgprot_t;
 
 #endif
 
+typedef struct page *ptetoken_t;
+
 extern unsigned long sparc_unmapped_base;
 
 BTFIXUPDEF_SETHI(sparc_unmapped_base)
diff -urpN linux-2.6/include/asm-sparc/pgalloc.h linux-2.6-patched/include/asm-sparc/pgalloc.h
--- linux-2.6/include/asm-sparc/pgalloc.h	2006-11-08 10:45:48.000000000 +0100
+++ linux-2.6-patched/include/asm-sparc/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -50,19 +50,20 @@ BTFIXUPDEF_CALL(void, free_pmd_fast, pmd
 
 BTFIXUPDEF_CALL(void, pmd_populate, pmd_t *, struct page *)
 #define pmd_populate(MM, PMD, PTE)        BTFIXUP_CALL(pmd_populate)(PMD, PTE)
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 BTFIXUPDEF_CALL(void, pmd_set, pmd_t *, pte_t *)
 #define pmd_populate_kernel(MM, PMD, PTE) BTFIXUP_CALL(pmd_set)(PMD, PTE)
 
-BTFIXUPDEF_CALL(struct page *, pte_alloc_one, struct mm_struct *, unsigned long)
+BTFIXUPDEF_CALL(ptetoken_t , pte_alloc_one, struct mm_struct *, unsigned long)
 #define pte_alloc_one(mm, address)	BTFIXUP_CALL(pte_alloc_one)(mm, address)
 BTFIXUPDEF_CALL(pte_t *, pte_alloc_one_kernel, struct mm_struct *, unsigned long)
 #define pte_alloc_one_kernel(mm, addr)	BTFIXUP_CALL(pte_alloc_one_kernel)(mm, addr)
 
 BTFIXUPDEF_CALL(void, free_pte_fast, pte_t *)
-#define pte_free_kernel(pte)	BTFIXUP_CALL(free_pte_fast)(pte)
+#define pte_free_kernel(mm,pte)	BTFIXUP_CALL(free_pte_fast)(pte)
 
-BTFIXUPDEF_CALL(void, pte_free, struct page *)
-#define pte_free(pte)		BTFIXUP_CALL(pte_free)(pte)
-#define __pte_free_tlb(tlb, pte)	pte_free(pte)
+BTFIXUPDEF_CALL(void, pte_free, ptetoken_t )
+#define pte_free(mm,pte)	BTFIXUP_CALL(pte_free)(pte)
+#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, pte)
 
 #endif /* _SPARC_PGALLOC_H */
diff -urpN linux-2.6/include/asm-sparc64/page.h linux-2.6-patched/include/asm-sparc64/page.h
--- linux-2.6/include/asm-sparc64/page.h	2007-05-09 09:58:16.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -106,6 +106,8 @@ typedef unsigned long pgprot_t;
 
 #endif /* (STRICT_MM_TYPECHECKS) */
 
+typedef struct page *ptetoken_t;
+
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
 				 (_AC(0x0000000070000000,UL)) : \
 				 (_AC(0xfffff80000000000,UL) + (1UL << 32UL)))
diff -urpN linux-2.6/include/asm-sparc64/pgalloc.h linux-2.6-patched/include/asm-sparc64/pgalloc.h
--- linux-2.6/include/asm-sparc64/pgalloc.h	2007-05-08 09:23:16.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -43,27 +43,35 @@ static inline pte_t *pte_alloc_one_kerne
 	return quicklist_alloc(0, GFP_KERNEL, NULL);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-					 unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm,
+					unsigned long address)
 {
-	void *pg = quicklist_alloc(0, GFP_KERNEL, NULL);
-	return pg ? virt_to_page(pg) : NULL;
+	struct page *page;
+	void *pg;
+
+	pg = quicklist_alloc(0, GFP_KERNEL, NULL);
+	if (!pg)
+		return NULL;
+	page = virt_to_page(pg);
+	__pte_page_ctor(page);
+	return page;
 }
 		
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	quicklist_free(0, NULL, pte);
 }
 
-static inline void pte_free(struct page *ptepage)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(ptepage);
 	quicklist_free_page(0, NULL, ptepage);
 }
 
-
 #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(PMD, PTE)
 #define pmd_populate(MM,PMD,PTE_PAGE)		\
 	pmd_populate_kernel(MM,PMD,page_address(PTE_PAGE))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 static inline void check_pgt_cache(void)
 {
diff -urpN linux-2.6/include/asm-sparc64/tlb.h linux-2.6-patched/include/asm-sparc64/tlb.h
--- linux-2.6/include/asm-sparc64/tlb.h	2006-11-08 10:45:48.000000000 +0100
+++ linux-2.6-patched/include/asm-sparc64/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -99,7 +99,7 @@ static inline void tlb_remove_page(struc
 }
 
 #define tlb_remove_tlb_entry(mp,ptep,addr) do { } while (0)
-#define pte_free_tlb(mp,ptepage) pte_free(ptepage)
+#define pte_free_tlb(mp,ptepage) pte_free((tlb)->mm, ptepage)
 #define pmd_free_tlb(mp,pmdp) pmd_free(pmdp)
 #define pud_free_tlb(tlb,pudp) __pud_free_tlb(tlb,pudp)
 
diff -urpN linux-2.6/include/asm-um/page.h linux-2.6-patched/include/asm-um/page.h
--- linux-2.6/include/asm-um/page.h	2007-05-08 09:23:16.000000000 +0200
+++ linux-2.6-patched/include/asm-um/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -78,6 +78,8 @@ typedef unsigned long phys_t;
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
+typedef struct page *ptetoken_t;
+
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
 
diff -urpN linux-2.6/include/asm-um/pgalloc.h linux-2.6-patched/include/asm-um/pgalloc.h
--- linux-2.6/include/asm-um/pgalloc.h	2006-11-08 10:45:49.000000000 +0100
+++ linux-2.6-patched/include/asm-um/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -18,6 +18,7 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
 			(unsigned long long) PAGE_SHIFT)))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 /*
  * Allocate and free page tables.
@@ -26,19 +27,24 @@ extern pgd_t *pgd_alloc(struct mm_struct
 extern void pgd_free(pgd_t *pgd);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
-extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
+extern ptetoken_t pte_alloc_one(struct mm_struct *, unsigned long);
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long) pte);
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
 }
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor(pte);				\
+	tlb_remove_page((tlb),(pte));			\
+} while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
diff -urpN linux-2.6/include/asm-x86_64/page.h linux-2.6-patched/include/asm-x86_64/page.h
--- linux-2.6/include/asm-x86_64/page.h	2007-05-12 20:16:11.000000000 +0200
+++ linux-2.6-patched/include/asm-x86_64/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -61,6 +61,8 @@ typedef struct { unsigned long pgd; } pg
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
+typedef struct page *ptetoken_t;
+
 extern unsigned long phys_base;
 
 #define pte_val(x)	((x).pte)
diff -urpN linux-2.6/include/asm-x86_64/pgalloc.h linux-2.6-patched/include/asm-x86_64/pgalloc.h
--- linux-2.6/include/asm-x86_64/pgalloc.h	2007-05-06 10:18:31.000000000 +0200
+++ linux-2.6-patched/include/asm-x86_64/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -12,6 +12,8 @@
 #define pgd_populate(mm, pgd, pud) \
 		set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(pud)))
 
+#define pmd_ptetoken(pmd) pmd_page(pmd)
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
 	set_pmd(pmd, __pmd(_PAGE_TABLE | (page_to_pfn(pte) << PAGE_SHIFT)));
@@ -89,29 +91,39 @@ static inline pte_t *pte_alloc_one_kerne
 	return (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline ptetoken_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	void *p = (void *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
+	struct page *page;
+	void *p;
+
+	p = (void *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 	if (!p)
 		return NULL;
-	return virt_to_page(p);
+	page = virt_to_page(p);
+	__pte_page_ctor(page);
+	return page;
 }
 
 /* Should really implement gc for free page table pages. This could be
    done with a reference count in struct page. */
 
-static inline void pte_free_kernel(pte_t *pte)
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	BUG_ON((unsigned long)pte & (PAGE_SIZE-1));
 	free_page((unsigned long)pte); 
 }
 
-static inline void pte_free(struct page *pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
 {
+	__pte_page_dtor(pte);
 	__free_page(pte);
-} 
+}
 
-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte)				\
+do {							\
+	__pte_page_dtor((pte));				\
+	tlb_remove_page((tlb),(pte));			\
+} while (0)
 
 #define __pmd_free_tlb(tlb,x)   tlb_remove_page((tlb),virt_to_page(x))
 #define __pud_free_tlb(tlb,x)   tlb_remove_page((tlb),virt_to_page(x))
diff -urpN linux-2.6/include/asm-xtensa/page.h linux-2.6-patched/include/asm-xtensa/page.h
--- linux-2.6/include/asm-xtensa/page.h	2007-06-08 09:32:31.000000000 +0200
+++ linux-2.6-patched/include/asm-xtensa/page.h	2007-06-28 17:58:44.000000000 +0200
@@ -47,6 +47,7 @@
 typedef struct { unsigned long pte; } pte_t;		/* page table entry */
 typedef struct { unsigned long pgd; } pgd_t;		/* PGD table entry */
 typedef struct { unsigned long pgprot; } pgprot_t;
+typedef struct page *ptetoken_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)
diff -urpN linux-2.6/include/asm-xtensa/pgalloc.h linux-2.6-patched/include/asm-xtensa/pgalloc.h
--- linux-2.6/include/asm-xtensa/pgalloc.h	2006-11-08 10:45:49.000000000 +0100
+++ linux-2.6-patched/include/asm-xtensa/pgalloc.h	2007-06-28 17:58:44.000000000 +0200
@@ -18,7 +18,6 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 
-
 /* Cache aliasing:
  *
  * If the cache size for one way is greater than the page size, we have to
@@ -80,6 +79,7 @@ pmd_populate(struct mm_struct *mm, pmd_t
 	pmd_val(*(pmdp)) = (unsigned long)page_to_virt(page);
 	__asm__ __volatile__ ("memw; dhwb %0, 0; dsync" :: "a" (pmdp));
 }
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 
 
@@ -89,6 +89,7 @@ pmd_populate(struct mm_struct *mm, pmd_t
 	(pmd_val(*(pmdp)) = (unsigned long)(pte))
 # define pmd_populate(mm, pmdp, page)					     \
 	(pmd_val(*(pmdp)) = (unsigned long)page_to_virt(page))
+#define pmd_ptetoken(pmd) pmd_page(pmd)
 
 #endif
 
@@ -106,10 +107,18 @@ pgd_alloc(struct mm_struct *mm)
 }
 
 extern pte_t* pte_alloc_one_kernel(struct mm_struct* mm, unsigned long addr);
-extern struct page* pte_alloc_one(struct mm_struct* mm, unsigned long addr);
+extern pte_token_t *pte_alloc_one(struct mm_struct* mm, unsigned long addr);
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
 
-#define pte_free_kernel(pte) free_page((unsigned long)pte)
-#define pte_free(pte) __free_page(pte)
+static inline void pte_free(struct mm_struct *mm, ptetoken_t pte)
+{
+	__pte_page_dtor(pte);
+	__free_page(pte);
+}
 
 #endif /* __KERNEL__ */
 #endif /* _XTENSA_PGALLOC_H */
diff -urpN linux-2.6/include/asm-xtensa/tlb.h linux-2.6-patched/include/asm-xtensa/tlb.h
--- linux-2.6/include/asm-xtensa/tlb.h	2006-11-08 10:45:49.000000000 +0100
+++ linux-2.6-patched/include/asm-xtensa/tlb.h	2007-06-28 17:58:44.000000000 +0200
@@ -20,6 +20,6 @@
 #include <asm-generic/tlb.h>
 #include <asm/page.h>
 
-#define __pte_free_tlb(tlb,pte)			pte_free(pte)
+#define __pte_free_tlb(tlb,pte)			pte_free((tlb)->mm, pte)
 
 #endif	/* _XTENSA_TLB_H */
diff -urpN linux-2.6/include/linux/mm.h linux-2.6-patched/include/linux/mm.h
--- linux-2.6/include/linux/mm.h	2007-06-22 14:11:55.000000000 +0200
+++ linux-2.6-patched/include/linux/mm.h	2007-06-28 17:58:44.000000000 +0200
@@ -932,6 +932,18 @@ static inline pmd_t *pmd_alloc(struct mm
 #define pte_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
 #endif /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 
+static inline void __pte_page_ctor(struct page *page)
+{
+	pte_lock_init(page);
+	inc_zone_page_state(page, NR_PAGETABLE);
+}
+
+static inline void __pte_page_dtor(struct page *page)
+{
+	pte_lock_deinit(page);
+	dec_zone_page_state(page, NR_PAGETABLE);
+}
+
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
 ({							\
 	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
@@ -1167,7 +1179,7 @@ struct page *follow_page(struct vm_area_
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_ANON	0x08	/* give ZERO_PAGE if no pgtable */
 
-typedef int (*pte_fn_t)(pte_t *pte, struct page *pmd_page, unsigned long addr,
+typedef int (*pte_fn_t)(pte_t *pte, ptetoken_t token, unsigned long addr,
 			void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2007-06-18 09:43:22.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2007-06-28 17:58:44.000000000 +0200
@@ -124,11 +124,9 @@ void pmd_clear_bad(pmd_t *pmd)
  */
 static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct page *page = pmd_page(*pmd);
+	ptetoken_t token = pmd_ptetoken(*pmd);
 	pmd_clear(pmd);
-	pte_lock_deinit(page);
-	pte_free_tlb(tlb, page);
-	dec_zone_page_state(page, NR_PAGETABLE);
+	pte_free_tlb(tlb, token);
 	tlb->mm->nr_ptes--;
 }
 
@@ -302,21 +300,19 @@ void free_pgtables(struct mmu_gather **t
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
-	struct page *new = pte_alloc_one(mm, address);
+	ptetoken_t new = pte_alloc_one(mm, address);
 	if (!new)
 		return -ENOMEM;
 
-	pte_lock_init(new);
 	spin_lock(&mm->page_table_lock);
-	if (pmd_present(*pmd)) {	/* Another has populated it */
-		pte_lock_deinit(new);
-		pte_free(new);
-	} else {
+	if (!pmd_present(*pmd)) {	/* Has another populated it ? */
 		mm->nr_ptes++;
-		inc_zone_page_state(new, NR_PAGETABLE);
 		pmd_populate(mm, pmd, new);
+		new = NULL;
 	}
 	spin_unlock(&mm->page_table_lock);
+	if (new)
+		pte_free(mm, new);
 	return 0;
 }
 
@@ -327,11 +323,13 @@ int __pte_alloc_kernel(pmd_t *pmd, unsig
 		return -ENOMEM;
 
 	spin_lock(&init_mm.page_table_lock);
-	if (pmd_present(*pmd))		/* Another has populated it */
-		pte_free_kernel(new);
-	else
+	if (!pmd_present(*pmd)) {	/* Has another populated it ? */
 		pmd_populate_kernel(&init_mm, pmd, new);
+		new = NULL;
+	}
 	spin_unlock(&init_mm.page_table_lock);
+	if (new)
+		pte_free_kernel(&init_mm, new);
 	return 0;
 }
 
@@ -1454,7 +1452,7 @@ static int apply_to_pte_range(struct mm_
 {
 	pte_t *pte;
 	int err;
-	struct page *pmd_page;
+	ptetoken_t token;
 	spinlock_t *uninitialized_var(ptl);
 
 	pte = (mm == &init_mm) ?
@@ -1465,10 +1463,10 @@ static int apply_to_pte_range(struct mm_
 
 	BUG_ON(pmd_huge(*pmd));
 
-	pmd_page = pmd_page(*pmd);
+	token = pmd_ptetoken(*pmd);
 
 	do {
-		err = fn(pte, pmd_page, addr, data);
+		err = fn(pte, token, addr, data);
 		if (err)
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);


