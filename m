Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH] set_pte() part 2 arch usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050226211910.79dbfa45.davem@davemloft.net>
References: <20050223200719.2d4e8918.davem@davemloft.net>
	 <1109222328.15027.12.camel@gaston>
	 <20050224143601.12c340ca.davem@davemloft.net>
	 <1109309524.14993.56.camel@gaston> <1109316055.14992.60.camel@gaston>
	 <20050225103730.75adf2f0.davem@davemloft.net>
	 <1109379369.15027.99.camel@gaston>
	 <20050226190943.7aa031e2.davem@davemloft.net>
	 <20050226211910.79dbfa45.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 13:22:18 +1100
Message-Id: <1109643738.6475.1.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

And here's an updated version of your 3rd patch to make it apply on top
of current bk (a small fix to hpte_update broke it).

Index: linux-work/arch/ppc/kernel/dma-mapping.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/dma-mapping.c	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/arch/ppc/kernel/dma-mapping.c	2005-03-01 12:50:55.000000000 +1100
@@ -219,7 +219,8 @@
 	c = vm_region_alloc(&consistent_head, size,
 			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
 	if (c) {
-		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
+		unsigned long vaddr = c->vm_start;
+		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(vaddr);
 		struct page *end = page + (1 << order);
 
 		/*
@@ -232,9 +233,11 @@
 
 			set_page_count(page, 1);
 			SetPageReserved(page);
-			set_pte(pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
+			set_pte_at(&init_mm, vaddr,
+				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
 			page++;
 			pte++;
+			vaddr += PAGE_SIZE;
 		} while (size -= PAGE_SIZE);
 
 		/*
Index: linux-work/arch/ppc/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc/mm/init.c	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/arch/ppc/mm/init.c	2005-03-01 12:50:55.000000000 +1100
@@ -490,18 +490,6 @@
 		printk(KERN_INFO "AGP special page: 0x%08lx\n", agp_special_page);
 #endif
 
-	/* Make sure all our pagetable pages have page->mapping
-	   and page->index set correctly. */
-	for (addr = KERNELBASE; addr != 0; addr += PGDIR_SIZE) {
-		struct page *pg;
-		pmd_t *pmd = pmd_offset(pgd_offset_k(addr), addr);
-		if (pmd_present(*pmd)) {
-			pg = pmd_page(*pmd);
-			pg->mapping = (void *) &init_mm;
-			pg->index = addr;
-		}
-	}
-
 	mem_init_done = 1;
 }
 
Index: linux-work/arch/ppc/mm/pgtable.c
===================================================================
--- linux-work.orig/arch/ppc/mm/pgtable.c	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/arch/ppc/mm/pgtable.c	2005-03-01 12:50:55.000000000 +1100
@@ -102,11 +102,6 @@
 
 	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
-		if (pte) {
-			struct page *ptepage = virt_to_page(pte);
-			ptepage->mapping = (void *) mm;
-			ptepage->index = address & PMD_MASK;
-		}
 	} else {
 		pte = (pte_t *)early_get_page();
 		if (pte)
@@ -126,11 +121,8 @@
 #endif
 
 	ptepage = alloc_pages(flags, 0);
-	if (ptepage) {
-		ptepage->mapping = (void *) mm;
-		ptepage->index = address & PMD_MASK;
+	if (ptepage)
 		clear_highpage(ptepage);
-	}
 	return ptepage;
 }
 
@@ -139,7 +131,6 @@
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
@@ -148,7 +139,6 @@
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	ptepage->mapping = NULL;
 	__free_page(ptepage);
 }
 
@@ -298,7 +288,7 @@
 	pg = pte_alloc_kernel(&init_mm, pd, va);
 	if (pg != 0) {
 		err = 0;
-		set_pte(pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
+		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		if (mem_init_done)
 			flush_HPTE(0, va, pmd_val(*pd));
 	}
Index: linux-work/arch/ppc/mm/tlb.c
===================================================================
--- linux-work.orig/arch/ppc/mm/tlb.c	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/arch/ppc/mm/tlb.c	2005-03-01 12:50:55.000000000 +1100
@@ -47,26 +47,6 @@
 }
 
 /*
- * Called by ptep_test_and_clear_young()
- */
-void flush_hash_one_pte(pte_t *ptep)
-{
-	struct page *ptepage;
-	struct mm_struct *mm;
-	unsigned long ptephys;
-	unsigned long addr;
-
-	if (Hash == 0)
-		return;
-	
-	ptepage = virt_to_page(ptep);
-	mm = (struct mm_struct *) ptepage->mapping;
-	ptephys = __pa(ptep) & PAGE_MASK;
-	addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) << 10);
-	flush_hash_pages(mm->context, addr, ptephys, 1);
-}
-
-/*
  * Called by ptep_set_access_flags, must flush on CPUs for which the
  * DSI handler can't just "fixup" the TLB on a write fault
  */
Index: linux-work/arch/ppc64/mm/tlb.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/tlb.c	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/arch/ppc64/mm/tlb.c	2005-03-01 12:50:55.000000000 +1100
@@ -74,24 +74,13 @@
  * change the existing HPTE to read-only rather than removing it
  * (if we remove it we should clear the _PTE_HPTEFLAGS bits).
  */
-void hpte_update(pte_t *ptep, unsigned long pte, int wrprot)
+ void hpte_update(struct mm_struct *mm, unsigned long addr,
+		  unsigned long pte, int wrprot)
 {
-	struct page *ptepage;
-	struct mm_struct *mm;
-	unsigned long addr;
 	int i;
 	unsigned long context = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 
-	ptepage = virt_to_page(ptep);
-	mm = (struct mm_struct *) ptepage->mapping;
-	addr = ptepage->index;
-	if (pte_huge(pte))
-		addr +=  ((unsigned long)ptep & ~PAGE_MASK)
-			/ sizeof(*ptep) * HPAGE_SIZE;
-	else
-		addr += ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
-
 	if (REGION_ID(addr) == USER_REGION_ID)
 		context = mm->context.id;
 	i = batch->index;
Index: linux-work/include/asm-ppc/highmem.h
===================================================================
--- linux-work.orig/include/asm-ppc/highmem.h	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/include/asm-ppc/highmem.h	2005-03-01 12:50:55.000000000 +1100
@@ -90,7 +90,7 @@
 #ifdef HIGHMEM_DEBUG
 	BUG_ON(!pte_none(*(kmap_pte+idx)));
 #endif
-	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
+	set_pte_at(&init_mm, vaddr, kmap_pte+idx, mk_pte(page, kmap_prot));
 	flush_tlb_page(NULL, vaddr);
 
 	return (void*) vaddr;
Index: linux-work/include/asm-ppc/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc/pgtable.h	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/include/asm-ppc/pgtable.h	2005-03-01 12:50:55.000000000 +1100
@@ -512,6 +512,17 @@
 }
 
 /*
+ * When flushing the tlb entry for a page, we also need to flush the hash
+ * table entry.  flush_hash_pages is assembler (for speed) in hashtable.S.
+ */
+extern int flush_hash_pages(unsigned context, unsigned long va,
+			    unsigned long pmdval, int count);
+
+/* Add an HPTE to the hash table */
+extern void add_hash_page(unsigned context, unsigned long va,
+			  unsigned long pmdval);
+
+/*
  * Atomic PTE updates.
  *
  * pte_update clears and sets bit atomically, and returns
@@ -542,7 +553,8 @@
  * On machines which use an MMU hash table we avoid changing the
  * _PAGE_HASHPTE bit.
  */
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
 {
 #if _PAGE_HASHPTE != 0
 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
@@ -550,36 +562,44 @@
 	*ptep = pte;
 #endif
 }
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
-extern void flush_hash_one_pte(pte_t *ptep);
 
 /*
  * 2.6 calles this without flushing the TLB entry, this is wrong
  * for our hash-based implementation, we fix that up here
  */
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 #if _PAGE_HASHPTE != 0
-	if (old & _PAGE_HASHPTE)
-		flush_hash_one_pte(ptep);
+	if (old & _PAGE_HASHPTE) {
+		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
+		flush_hash_pages(context, addr, ptephys, 1);
+	}
 #endif
 	return (old & _PAGE_ACCESSED) != 0;
 }
+#define ptep_test_and_clear_young(__vma, __addr, __ptep) \
+	__ptep_test_and_clear_young((__vma)->vm_mm->context, __addr, __ptep)
 
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep)
 {
 	return (pte_update(ptep, (_PAGE_DIRTY | _PAGE_HWWRITE), 0) & _PAGE_DIRTY) != 0;
 }
 
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep)
 {
 	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
 }
 
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), 0);
 }
@@ -603,6 +623,7 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+#define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
 /*
@@ -655,17 +676,6 @@
 extern void paging_init(void);
 
 /*
- * When flushing the tlb entry for a page, we also need to flush the hash
- * table entry.  flush_hash_pages is assembler (for speed) in hashtable.S.
- */
-extern int flush_hash_pages(unsigned context, unsigned long va,
-			    unsigned long pmdval, int count);
-
-/* Add an HPTE to the hash table */
-extern void add_hash_page(unsigned context, unsigned long va,
-			  unsigned long pmdval);
-
-/*
  * Encode and decode a swap entry.
  * Note that the bits we use in a PTE for representing a swap entry
  * must not include the _PAGE_PRESENT bit, the _PAGE_FILE bit, or the
@@ -737,14 +747,9 @@
 
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
 
-#endif /* !__ASSEMBLY__ */
-
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
Index: linux-work/include/asm-ppc64/pgalloc.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pgalloc.h	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/include/asm-ppc64/pgalloc.h	2005-03-01 12:50:55.000000000 +1100
@@ -48,42 +48,26 @@
 #define pmd_populate(mm, pmd, pte_page) \
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
-	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
-	if (pte) {
-		struct page *ptepage = virt_to_page(pte);
-		ptepage->mapping = (void *) mm;
-		ptepage->index = address & PMD_MASK;
-	}
-	return pte;
+	return kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
 }
 
-static inline struct page *
-pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
-	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
-	if (pte) {
-		struct page *ptepage = virt_to_page(pte);
-		ptepage->mapping = (void *) mm;
-		ptepage->index = address & PMD_MASK;
-		return ptepage;
-	}
+	pte_t *pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	if (pte)
+		return virt_to_page(pte);
 	return NULL;
 }
 		
 static inline void pte_free_kernel(pte_t *pte)
 {
-	virt_to_page(pte)->mapping = NULL;
 	kmem_cache_free(zero_cache, pte);
 }
 
 static inline void pte_free(struct page *ptepage)
 {
-	ptepage->mapping = NULL;
 	kmem_cache_free(zero_cache, page_address(ptepage));
 }
 
Index: linux-work/include/asm-ppc64/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pgtable.h	2005-03-01 12:50:50.000000000 +1100
+++ linux-work/include/asm-ppc64/pgtable.h	2005-03-01 12:50:55.000000000 +1100
@@ -315,9 +315,10 @@
  * batch, doesn't actually triggers the hash flush immediately,
  * you need to call flush_tlb_pending() to do that.
  */
-extern void hpte_update(pte_t *ptep, unsigned long pte, int wrprot);
+extern void hpte_update(struct mm_struct *mm, unsigned long addr, unsigned long pte,
+			int wrprot);
 
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
@@ -325,18 +326,25 @@
 		return 0;
 	old = pte_update(ptep, _PAGE_ACCESSED);
 	if (old & _PAGE_HASHPTE) {
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 		flush_tlb_pending();
 	}
 	return (old & _PAGE_ACCESSED) != 0;
 }
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young(__vma, __addr, __ptep)		   \
+({									   \
+	int __r;							   \
+	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
+	__r;								   \
+})
 
 /*
  * On RW/DIRTY bit transitions we can avoid flushing the hpte. For the
  * moment we always flush but we need to fix hpte_update and test if the
  * optimisation is worth it.
  */
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_dirty(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
@@ -344,10 +352,18 @@
 		return 0;
 	old = pte_update(ptep, _PAGE_DIRTY);
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 	return (old & _PAGE_DIRTY) != 0;
 }
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+#define ptep_test_and_clear_dirty(__vma, __addr, __ptep)		   \
+({									   \
+	int __r;							   \
+	__r = __ptep_test_and_clear_dirty((__vma)->vm_mm, __addr, __ptep); \
+	__r;								   \
+})
 
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
@@ -356,7 +372,7 @@
        		return;
 	old = pte_update(ptep, _PAGE_RW);
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 }
 
 /*
@@ -370,26 +386,27 @@
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young;							\
-	__young = ptep_test_and_clear_young(__vma, __address, __ptep);	\
+	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, \
+						  __ptep);		\
 	__young;							\
 })
 
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
 ({									\
-	int __dirty;							\
-	__dirty = ptep_test_and_clear_dirty(__vma, __address, __ptep);	\
+	int __dirty = __ptep_test_and_clear_dirty((__vma)->vm_mm, __address, \
+						  __ptep); 		\
 	flush_tlb_page(__vma, __address);				\
 	__dirty;							\
 })
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old = pte_update(ptep, ~0UL);
 
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 	return __pte(old);
 }
 
@@ -398,7 +415,7 @@
 	unsigned long old = pte_update(ptep, ~0UL);
 
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 }
 
 /*
@@ -446,6 +463,7 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+#define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
 extern unsigned long ioremap_bot, ioremap_base;
@@ -553,14 +571,8 @@
 	return pt;
 }
 
-#endif /* __ASSEMBLY__ */
-
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define __HAVE_ARCH_PTEP_MKDIRTY
-#define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _PPC64_PGTABLE_H */
