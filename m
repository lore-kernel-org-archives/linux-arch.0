Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267966AbUHRWsg@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:30174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267381AbUHRWsd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Aug 2004 18:48:33 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7IMmWe1011532
	for <linux-arch@vger.kernel.org>; Wed, 18 Aug 2004 18:48:32 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7IMmWa02008
	for <linux-arch@vger.kernel.org>; Wed, 18 Aug 2004 18:48:32 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.10) with SMTP id i7IMlemf009357
	for <linux-arch@vger.kernel.org>; Wed, 18 Aug 2004 18:47:40 -0400
Date: Wed, 18 Aug 2004 15:45:29 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: set_pte() taking mm and vaddr args
Message-Id: <20040818154529.5bca03a4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__18_Aug_2004_15_45_29_-0700_MbZaHBPfa2LALqBW"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Wed__18_Aug_2004_15_45_29_-0700_MbZaHBPfa2LALqBW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


I've modified set_pte() to take 'mm' and 'address' arguments.
This helps sparc64 and ppc platforms a lot in their batched
TLB shootdown implementations.

Before this, those platforms have to figure out the mm
and address at set_pte() time via rogue means.  In the
page_struct of the pte table, they store the 'mm' in
page->mapping, and the base virtual address in page->index

That is just silly, especially since we have all of this
information available at the set_pte() call sites.

I also encourage platforms other than sparc64 and ppc into
using this batched tlb shootdown scheme, it has been found
to be extremely effective.

Could people maintaining other platforms send me the necessary
changes?  For most it's a matter of adding the 'mm' and
'address' args to set_pte() and pte_clear().  If you override
any of the routines in asm-generic/pgtable.h you'll need to update
their args as well.  Finally, if you have set_pte()/pte_clear()
calls in your platform specific code, update those as well.

Thanks a lot to benh for doing the ppc bits for me.

Thanks.


--Multipart=_Wed__18_Aug_2004_15_45_29_-0700_MbZaHBPfa2LALqBW
Content-Type: text/plain;
 name="set_pte_1.diff"
Content-Disposition: attachment;
 filename="set_pte_1.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/14 22:21:11-07:00 davem@nuts.davemloft.net 
#   [MM]: Make set_pte() take mm and address arguments.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# mm/vmalloc.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -2
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/swapfile.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/rmap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -2
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/mremap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +1 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/mprotect.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +8 -8
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/memory.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +22 -19
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/fremap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +3 -3
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-sparc64/pgtable.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +6 -4
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-sparc64/pgalloc.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +5 -15
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-generic/pgtable.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +38 -37
#   [MM]: Make set_pte() take mm and address arguments.
# 
# fs/exec.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +1 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/tlb.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +7 -10
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/init.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/hugetlbpage.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +15 -7
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/generic.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +17 -8
#   [MM]: Make set_pte() take mm and address arguments.
# 
diff -Nru a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
--- a/arch/sparc64/mm/generic.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/generic.c	2004-08-18 15:30:39 -07:00
@@ -33,8 +33,12 @@
  * side-effect bit will be turned off.  This is used as a
  * performance improvement on FFB/AFB. -DaveM
  */
-static inline void io_remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long offset, pgprot_t prot, int space)
+static inline void io_remap_pte_range(struct mm_struct *mm, pte_t * pte,
+				      unsigned long address,
+				      unsigned long size,
+				      unsigned long offset,
+				      pgprot_t prot,
+				      int space)
 {
 	unsigned long end;
 
@@ -76,8 +80,8 @@
 			pte_val(entry) &= ~(_PAGE_E);
 		do {
 			oldpage = *pte;
-			pte_clear(pte);
-			set_pte(pte, entry);
+			pte_clear(mm, address, pte);
+			set_pte(mm, address, pte, entry);
 			forget_pte(oldpage);
 			address += PAGE_SIZE;
 			pte++;
@@ -85,8 +89,12 @@
 	} while (address < end);
 }
 
-static inline int io_remap_pmd_range(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long offset, pgprot_t prot, int space)
+static inline int io_remap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
+				     unsigned long address,
+				     unsigned long size,
+				     unsigned long offset,
+				     pgprot_t prot,
+				     int space)
 {
 	unsigned long end;
 
@@ -99,7 +107,7 @@
 		pte_t * pte = pte_alloc_map(current->mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
-		io_remap_pte_range(pte, address, end - address, address + offset, prot, space);
+		io_remap_pte_range(mm, pte, address, end - address, address + offset, prot, space);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -126,7 +134,8 @@
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = io_remap_pmd_range(pmd, from, end - from, offset + from, prot, space);
+		error = io_remap_pmd_range(mm, pmd, from, end - from,
+					   offset + from, prot, space);
 		if (error)
 			break;
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
diff -Nru a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/hugetlbpage.c	2004-08-18 15:30:39 -07:00
@@ -53,8 +53,12 @@
 
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+static void set_huge_pte(struct mm_struct *mm,
+			 unsigned long addr,
+			 struct vm_area_struct *vma,
+			 struct page *page,
+			 pte_t *page_table,
+			 int write_access)
 {
 	unsigned long i;
 	pte_t entry;
@@ -70,7 +74,7 @@
 	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte(page_table, entry);
+		set_pte(mm, addr, page_table, entry);
 		page_table++;
 
 		pte_val(entry) += PAGE_SIZE;
@@ -108,12 +112,12 @@
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
+			set_pte(dst, addr, dst_pte, entry);
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
+			addr += PAGE_SIZE;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;
 
@@ -192,6 +196,8 @@
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
 	for (address = start; address < end; address += HPAGE_SIZE) {
+		unsigned long addr = address;
+
 		pte = huge_pte_offset(mm, address);
 		BUG_ON(!pte);
 		if (pte_none(*pte))
@@ -199,8 +205,9 @@
 		page = pte_page(*pte);
 		put_page(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(pte);
+			pte_clear(mm, addr, pte);
 			pte++;
+			addr += PAGE_SIZE;
 		}
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
@@ -253,7 +260,8 @@
 				goto out;
 			}
 		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		set_huge_pte(mm, addr, vma, page, pte,
+			     vma->vm_flags & VM_WRITE);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/init.c	2004-08-18 15:30:39 -07:00
@@ -430,7 +430,8 @@
 				if (tlb_type == spitfire)
 					val &= ~0x0003fe0000000000UL;
 
-				set_pte (ptep, __pte(val | _PAGE_MODIFIED));
+				set_pte(&init_mm, vaddr,
+					ptep, __pte(val | _PAGE_MODIFIED));
 				trans[i].data += BASE_PAGE_SIZE;
 			}
 		}
diff -Nru a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
--- a/arch/sparc64/mm/tlb.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/tlb.c	2004-08-18 15:30:39 -07:00
@@ -41,15 +41,11 @@
 	}
 }
 
-void tlb_batch_add(pte_t *ptep, pte_t orig)
+void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
+		   pte_t *ptep, pte_t orig)
 {
-	struct mmu_gather *mp = &__get_cpu_var(mmu_gathers);
-	struct page *ptepage;
-	struct mm_struct *mm;
-	unsigned long vaddr, nr;
-
-	ptepage = virt_to_page(ptep);
-	mm = (struct mm_struct *) ptepage->mapping;
+	struct mmu_gather *mp;
+	unsigned long nr;
 
 	/* It is more efficient to let flush_tlb_kernel_range()
 	 * handle these cases.
@@ -57,8 +53,9 @@
 	if (mm == &init_mm)
 		return;
 
-	vaddr = ptepage->index +
-		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
+	mp = &__get_cpu_var(mmu_gathers);
+
+	vaddr &= PAGE_MASK;
 	if (pte_exec(orig))
 		vaddr |= 0x1UL;
 
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2004-08-18 15:30:39 -07:00
+++ b/fs/exec.c	2004-08-18 15:30:39 -07:00
@@ -321,7 +321,7 @@
 	}
 	mm->rss++;
 	lru_cache_add_active(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
+	set_pte(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
 	pte_unmap(pte);
diff -Nru a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
--- a/include/asm-generic/pgtable.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-generic/pgtable.h	2004-08-18 15:30:39 -07:00
@@ -15,7 +15,7 @@
  */
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {				  					\
-	set_pte(__ptep, __entry);					\
+	set_pte((__vma)->vm_mm, (__address), __ptep, __entry);		\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
 #endif
@@ -29,26 +29,30 @@
  */
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
 do {				  					  \
-	set_pte(__ptep, __entry);					  \
+	set_pte((__vma)->vm_mm, (__address), __ptep, __entry);		  \
 	flush_tlb_page(__vma, __address);				  \
 } while (0)
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	if (!pte_young(pte))
-		return 0;
-	set_pte(ptep, pte_mkold(pte));
-	return 1;
-}
+#define ptep_test_and_clear_young(__vma, __address, __ptep)		\
+({									\
+	pte_t __pte = *(__ptep);					\
+	int r = 1;							\
+	if (!pte_young(__pte))						\
+		r = 0;							\
+	else								\
+		set_pte((__vma)->vm_mm, (__address),			\
+			(__ptep), pte_mkold(__pte));			\
+	r;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young = ptep_test_and_clear_young(__ptep);		\
+	int __young;							\
+	__young = ptep_test_and_clear_young(__vma, __address, __ptep);	\
 	if (__young)							\
 		flush_tlb_page(__vma, __address);			\
 	__young;							\
@@ -56,20 +60,24 @@
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	if (!pte_dirty(pte))
-		return 0;
-	set_pte(ptep, pte_mkclean(pte));
-	return 1;
-}
+#define ptep_test_and_clear_dirty(__vma, __address, __ptep)		\
+({									\
+	pte_t __pte = *ptep;						\
+	int r = 1;							\
+	if (!pte_dirty(__pte))						\
+		r = 0;							\
+	else								\
+		set_pte((__vma)->vm_mm, (__address), (__ptep),		\
+			pte_mkclean(__pte));				\
+	r;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
 ({									\
-	int __dirty = ptep_test_and_clear_dirty(__ptep);		\
+	int __dirty;							\
+	__dirty = ptep_test_and_clear_dirty(__vma, __address, __ptep);	\
 	if (__dirty)							\
 		flush_tlb_page(__vma, __address);			\
 	__dirty;							\
@@ -77,36 +85,29 @@
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	pte_clear(ptep);
-	return pte;
-}
+#define ptep_get_and_clear(__mm, __address, __ptep)			\
+({									\
+	pte_t __pte = *(__ptep);					\
+	pte_clear((__mm), (__address), (__ptep));			\
+	__pte;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define ptep_clear_flush(__vma, __address, __ptep)			\
 ({									\
-	pte_t __pte = ptep_get_and_clear(__ptep);			\
+	pte_t __pte;							\
+	__pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);	\
 	flush_tlb_page(__vma, __address);				\
 	__pte;								\
 })
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(pte_t *ptep)
-{
-	pte_t old_pte = *ptep;
-	set_pte(ptep, pte_wrprotect(old_pte));
-}
-#endif
-
-#ifndef __HAVE_ARCH_PTEP_MKDIRTY
-static inline void ptep_mkdirty(pte_t *ptep)
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
-	set_pte(ptep, pte_mkdirty(old_pte));
+	set_pte(mm, address, ptep, pte_wrprotect(old_pte));
 }
 #endif
 
diff -Nru a/include/asm-sparc64/pgalloc.h b/include/asm-sparc64/pgalloc.h
--- a/include/asm-sparc64/pgalloc.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-sparc64/pgalloc.h	2004-08-18 15:30:39 -07:00
@@ -192,25 +192,17 @@
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = __pte_alloc_one_kernel(mm, address);
-	if (pte) {
-		struct page *page = virt_to_page(pte);
-		page->mapping = (void *) mm;
-		page->index = address & PMD_MASK;
-	}
-	return pte;
+	return __pte_alloc_one_kernel(mm, address);
 }
 
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *pte = __pte_alloc_one_kernel(mm, addr);
-	if (pte) {
-		struct page *page = virt_to_page(pte);
-		page->mapping = (void *) mm;
-		page->index = addr & PMD_MASK;
-		return page;
-	}
+
+	if (pte)
+		return virt_to_page(pte);
+
 	return NULL;
 }
 
@@ -247,13 +239,11 @@
 
 static inline void pte_free_kernel(pte_t *pte)
 {
-	virt_to_page(pte)->mapping = NULL;
 	free_pte_fast(pte);
 }
 
 static inline void pte_free(struct page *ptepage)
 {
-	ptepage->mapping = NULL;
 	free_pte_fast(page_address(ptepage));
 }
 
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-sparc64/pgtable.h	2004-08-18 15:30:39 -07:00
@@ -326,18 +326,20 @@
 #define pte_unmap_nested(pte)		do { } while (0)
 
 /* Actual page table PTE updates.  */
-extern void tlb_batch_add(pte_t *ptep, pte_t orig);
+extern void tlb_batch_add(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t orig);
 
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte)
 {
 	pte_t orig = *ptep;
 
 	*ptep = pte;
 	if (pte_present(orig))
-		tlb_batch_add(ptep, orig);
+		tlb_batch_add(mm, addr, ptep, orig);
 }
 
-#define pte_clear(ptep)		set_pte((ptep), __pte(0UL))
+#define pte_clear(mm,addr,ptep)		set_pte((mm),(addr),(ptep), __pte(0UL))
 
 extern pgd_t swapper_pg_dir[1];
 
diff -Nru a/mm/fremap.c b/mm/fremap.c
--- a/mm/fremap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/fremap.c	2004-08-18 15:30:39 -07:00
@@ -44,7 +44,7 @@
 	} else {
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
+		pte_clear(mm, addr, ptep);
 	}
 }
 
@@ -88,7 +88,7 @@
 
 	mm->rss++;
 	flush_icache_page(vma, page);
-	set_pte(pte, mk_pte(page, prot));
+	set_pte(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
 	pte_val = *pte;
 	pte_unmap(pte);
@@ -128,7 +128,7 @@
 
 	zap_pte(mm, vma, addr, pte);
 
-	set_pte(pte, pgoff_to_pte(pgoff));
+	set_pte(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2004-08-18 15:30:39 -07:00
+++ b/mm/memory.c	2004-08-18 15:30:39 -07:00
@@ -290,7 +290,7 @@
 				if (!pte_present(pte)) {
 					if (!pte_file(pte))
 						swap_duplicate(pte_to_swp_entry(pte));
-					set_pte(dst_pte, pte);
+					set_pte(dst, address, dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
 				pfn = pte_pfn(pte);
@@ -304,7 +304,7 @@
 					page = pfn_to_page(pfn); 
 
 				if (!page || PageReserved(page)) {
-					set_pte(dst_pte, pte);
+					set_pte(dst, address, dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
 
@@ -313,7 +313,7 @@
 				 * in the parent and the child
 				 */
 				if (cow) {
-					ptep_set_wrprotect(src_pte);
+					ptep_set_wrprotect(src, address, src_pte);
 					pte = *src_pte;
 				}
 
@@ -326,7 +326,7 @@
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
-				set_pte(dst_pte, pte);
+				set_pte(dst, address, dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
@@ -406,14 +406,15 @@
 				     page->index > details->last_index))
 					continue;
 			}
-			pte = ptep_get_and_clear(ptep);
+			pte = ptep_get_and_clear(tlb->mm, address+offset, ptep);
 			tlb_remove_tlb_entry(tlb, ptep, address+offset);
 			if (unlikely(!page))
 				continue;
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 					address+offset) != page->index)
-				set_pte(ptep, pgoff_to_pte(page->index));
+				set_pte(tlb->mm, address+offset,
+					ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
 			if (pte_young(pte) && !PageAnon(page))
@@ -431,7 +432,7 @@
 			continue;
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
+		pte_clear(tlb->mm, address+offset, ptep);
 	}
 	pte_unmap(ptep-1);
 }
@@ -831,8 +832,9 @@
 
 EXPORT_SYMBOL(get_user_pages);
 
-static void zeromap_pte_range(pte_t * pte, unsigned long address,
-                                     unsigned long size, pgprot_t prot)
+static void zeromap_pte_range(struct mm_struct *mm, pte_t * pte,
+			      unsigned long address,
+			      unsigned long size, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -843,7 +845,7 @@
 	do {
 		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
 		BUG_ON(!pte_none(*pte));
-		set_pte(pte, zero_pte);
+		set_pte(mm, address, pte, zero_pte);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
@@ -863,7 +865,7 @@
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		zeromap_pte_range(pte, base + address, end - address, prot);
+		zeromap_pte_range(mm, pte, base + address, end - address, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -909,8 +911,9 @@
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+static inline void remap_pte_range(struct mm_struct *mm, pte_t * pte,
+				   unsigned long address, unsigned long size,
+				   unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long end;
 	unsigned long pfn;
@@ -923,7 +926,7 @@
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
- 			set_pte(pte, pfn_pte(pfn, prot));
+ 			set_pte(mm, address, pte, pfn_pte(pfn, prot));
 		address += PAGE_SIZE;
 		pfn++;
 		pte++;
@@ -945,7 +948,7 @@
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
+		remap_pte_range(mm, pte, base + address, end - address, address + phys_addr, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -1386,7 +1389,7 @@
 	unlock_page(page);
 
 	flush_icache_page(vma, page);
-	set_pte(page_table, pte);
+	set_pte(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
 	if (write_access) {
@@ -1451,7 +1454,7 @@
 		page_add_anon_rmap(page, vma, addr);
 	}
 
-	set_pte(page_table, entry);
+	set_pte(mm, addr, page_table, entry);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1556,7 +1559,7 @@
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		set_pte(mm, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
@@ -1600,7 +1603,7 @@
 	 */
 	if (!vma->vm_ops || !vma->vm_ops->populate || 
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
-		pte_clear(pte);
+		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, write_access, pte, pmd);
 	}
 
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	2004-08-18 15:30:39 -07:00
+++ b/mm/mprotect.c	2004-08-18 15:30:39 -07:00
@@ -25,8 +25,8 @@
 #include <asm/tlbflush.h>
 
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pte_range(struct mm_struct *mm, pmd_t *pmd, unsigned long address,
+		 unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
 	unsigned long end;
@@ -51,8 +51,8 @@
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			entry = ptep_get_and_clear(pte);
-			set_pte(pte, pte_modify(entry, newprot));
+			entry = ptep_get_and_clear(mm, address, pte);
+			set_pte(mm, address, pte, pte_modify(entry, newprot));
 		}
 		address += PAGE_SIZE;
 		pte++;
@@ -61,8 +61,8 @@
 }
 
 static inline void
-change_pmd_range(pgd_t *pgd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pmd_range(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
+		 unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
 	unsigned long end;
@@ -80,7 +80,7 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
+		change_pte_range(mm, pmd, address, end - address, newprot);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -99,7 +99,7 @@
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
 	do {
-		change_pmd_range(dir, start, end - start, newprot);
+		change_pmd_range(current->mm, dir, start, end - start, newprot);
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
diff -Nru a/mm/mremap.c b/mm/mremap.c
--- a/mm/mremap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/mremap.c	2004-08-18 15:30:39 -07:00
@@ -128,7 +128,7 @@
 			if (dst) {
 				pte_t pte;
 				pte = ptep_clear_flush(vma, old_addr, src);
-				set_pte(dst, pte);
+				set_pte(mm, new_addr, dst, pte);
 			} else
 				error = -ENOMEM;
 			pte_unmap_nested(src);
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/rmap.c	2004-08-18 15:30:39 -07:00
@@ -508,7 +508,7 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		set_pte(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 	}
 
@@ -606,7 +606,7 @@
 
 		/* If nonlinear, store the file page offset in the pte. */
 		if (page->index != linear_page_index(vma, address))
-			set_pte(pte, pgoff_to_pte(page->index));
+			set_pte(mm, address, pte, pgoff_to_pte(page->index));
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	2004-08-18 15:30:39 -07:00
+++ b/mm/swapfile.c	2004-08-18 15:30:39 -07:00
@@ -432,7 +432,8 @@
 {
 	vma->vm_mm->rss++;
 	get_page(page);
-	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	set_pte(vma->vm_mm, address, dir,
+		pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
 }
diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	2004-08-18 15:30:39 -07:00
+++ b/mm/vmalloc.c	2004-08-18 15:30:39 -07:00
@@ -45,7 +45,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(pte);
+		page = ptep_get_and_clear(&init_mm, address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -101,7 +101,7 @@
 		if (!page)
 			return -ENOMEM;
 
-		set_pte(pte, mk_pte(page, prot));
+		set_pte(&init_mm, address, pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
 		(*pages)++;

--Multipart=_Wed__18_Aug_2004_15_45_29_-0700_MbZaHBPfa2LALqBW
Content-Type: text/plain;
 name="set_pte_2.diff"
Content-Disposition: attachment;
 filename="set_pte_2.diff"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 14:50:10-07:00 benh@kernel.crashing.org 
#   [PPC]: Use new set_pte() w/mm+address args.
#   
#   Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# mm/highmem.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +4 -2
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# include/asm-ppc64/pgtable.h
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +43 -30
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# include/asm-ppc64/pgalloc.h
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +6 -22
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# include/asm-ppc/pgtable.h
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +35 -34
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# include/asm-ppc/highmem.h
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +2 -2
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# arch/ppc64/mm/tlb.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +2 -9
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# arch/ppc64/mm/init.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +8 -8
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# arch/ppc/mm/tlb.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +0 -20
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# arch/ppc/mm/pgtable.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +4 -14
#   [PPC]: Use new set_pte() w/mm+address args.
# 
# arch/ppc/mm/init.c
#   2004/08/18 14:49:26-07:00 benh@kernel.crashing.org +0 -13
#   [PPC]: Use new set_pte() w/mm+address args.
# 
diff -Nru a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c	2004-08-18 15:33:21 -07:00
+++ b/arch/ppc/mm/init.c	2004-08-18 15:33:21 -07:00
@@ -484,19 +484,6 @@
 	if (agp_special_page)
 		printk(KERN_INFO "AGP special page: 0x%08lx\n", agp_special_page);
 #endif
-
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
 
diff -Nru a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c	2004-08-18 15:33:21 -07:00
+++ b/arch/ppc/mm/pgtable.c	2004-08-18 15:33:21 -07:00
@@ -100,14 +100,9 @@
 	extern int mem_init_done;
 	extern void *early_get_page(void);
 
-	if (mem_init_done) {
+	if (mem_init_done)
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-		if (pte) {
-			struct page *ptepage = virt_to_page(pte);
-			ptepage->mapping = (void *) mm;
-			ptepage->index = address & PMD_MASK;
-		}
-	} else
+	else
 		pte = (pte_t *)early_get_page();
 	if (pte)
 		clear_page(pte);
@@ -125,11 +120,8 @@
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
 
@@ -138,7 +130,6 @@
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
@@ -147,7 +138,6 @@
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	ptepage->mapping = NULL;
 	__free_page(ptepage);
 }
 
@@ -285,7 +275,7 @@
 	pg = pte_alloc_kernel(&init_mm, pd, va);
 	if (pg != 0) {
 		err = 0;
-		set_pte(pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
+		set_pte(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		if (mem_init_done)
 			flush_HPTE(0, va, pmd_val(*pd));
 	}
diff -Nru a/arch/ppc/mm/tlb.c b/arch/ppc/mm/tlb.c
--- a/arch/ppc/mm/tlb.c	2004-08-18 15:33:21 -07:00
+++ b/arch/ppc/mm/tlb.c	2004-08-18 15:33:21 -07:00
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
-	addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) << 9);
-	flush_hash_pages(mm->context, addr, ptephys, 1);
-}
-
-/*
  * Called by ptep_set_access_flags, must flush on CPUs for which the
  * DSI handler can't just "fixup" the TLB on a write fault
  */
diff -Nru a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	2004-08-18 15:33:21 -07:00
+++ b/arch/ppc64/mm/init.c	2004-08-18 15:33:21 -07:00
@@ -155,7 +155,7 @@
 		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
 
 		pa = abs_to_phys(pa);
-		set_pte(ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
+		set_pte(&ioremap_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		spin_unlock(&ioremap_mm.page_table_lock);
 	} else {
 		unsigned long va, vpn, hash, hpteg;
@@ -287,8 +287,8 @@
 	return 0;
 }
 
-static void unmap_im_area_pte(pmd_t *pmd, unsigned long address,
-				  unsigned long size)
+static void unmap_im_area_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long address,
+			      unsigned long size)
 {
 	unsigned long end;
 	pte_t *pte;
@@ -309,7 +309,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(pte);
+		page = ptep_get_and_clear(mm, address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -320,8 +320,8 @@
 	} while (address < end);
 }
 
-static void unmap_im_area_pmd(pgd_t *dir, unsigned long address,
-				  unsigned long size)
+static void unmap_im_area_pmd(struct mm_struct *mm, pgd_t *dir, unsigned long address,
+			      unsigned long size)
 {
 	unsigned long end;
 	pmd_t *pmd;
@@ -341,7 +341,7 @@
 		end = PGDIR_SIZE;
 
 	do {
-		unmap_im_area_pte(pmd, address, end - address);
+		unmap_im_area_pte(mm, pmd, address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
@@ -382,7 +382,7 @@
 	dir = pgd_offset_i(address);
 	flush_cache_vunmap(address, end);
 	do {
-		unmap_im_area_pmd(dir, address, end - address);
+		unmap_im_area_pmd(mm, dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
diff -Nru a/arch/ppc64/mm/tlb.c b/arch/ppc64/mm/tlb.c
--- a/arch/ppc64/mm/tlb.c	2004-08-18 15:33:21 -07:00
+++ b/arch/ppc64/mm/tlb.c	2004-08-18 15:33:21 -07:00
@@ -74,19 +74,12 @@
  * change the existing HPTE to read-only rather than removing it
  * (if we remove it we should clear the _PTE_HPTEFLAGS bits).
  */
-void hpte_update(pte_t *ptep, unsigned long pte, int wrprot)
+void hpte_update(struct mm_struct *mm, unsigned long addr, unsigned long pte,
+		 int wrprot)
 {
-	struct page *ptepage;
-	struct mm_struct *mm;
-	unsigned long addr;
 	int i;
 	unsigned long context = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
-
-	ptepage = virt_to_page(ptep);
-	mm = (struct mm_struct *) ptepage->mapping;
-	addr = ptepage->index +
-		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
 
 	if (REGION_ID(addr) == USER_REGION_ID)
 		context = mm->context.id;
diff -Nru a/include/asm-ppc/highmem.h b/include/asm-ppc/highmem.h
--- a/include/asm-ppc/highmem.h	2004-08-18 15:33:21 -07:00
+++ b/include/asm-ppc/highmem.h	2004-08-18 15:33:21 -07:00
@@ -90,7 +90,7 @@
 #ifdef HIGHMEM_DEBUG
 	BUG_ON(!pte_none(*(kmap_pte+idx)));
 #endif
-	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
+	set_pte(&init_mm, vaddr, kmap_pte+idx, mk_pte(page, kmap_prot));
 	flush_tlb_page(NULL, vaddr);
 
 	return (void*) vaddr;
@@ -114,7 +114,7 @@
 	 * force other mappings to Oops if they'll try to access
 	 * this pte without first remap it
 	 */
-	pte_clear(kmap_pte+idx);
+	pte_clear(&init_mm, vaddr, kmap_pte+idx);
 	flush_tlb_page(NULL, vaddr);
 #endif
 	dec_preempt_count();
diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2004-08-18 15:33:21 -07:00
+++ b/include/asm-ppc/pgtable.h	2004-08-18 15:33:21 -07:00
@@ -445,7 +445,7 @@
 
 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
-#define pte_clear(ptep)		do { set_pte((ptep), __pte(0)); } while (0)
+#define pte_clear(mm,addr,ptep)	do { set_pte((mm), (addr), (ptep), __pte(0)); } while (0)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -509,6 +509,17 @@
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
@@ -539,7 +550,8 @@
  * On machines which use an MMU hash table we avoid changing the
  * _PAGE_HASHPTE bit.
  */
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte)
 {
 #if _PAGE_HASHPTE != 0
 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
@@ -548,43 +560,48 @@
 #endif
 }
 
-extern void flush_hash_one_pte(pte_t *ptep);
-
 /*
  * 2.6 calles this without flushing the TLB entry, this is wrong
  * for our hash-based implementation, we fix that up here
  */
-static inline int ptep_test_and_clear_young(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int __ptep_test_and_clear_young(unsigned context, unsigned long addr,
+					      pte_t *ptep)
 {
 	unsigned long old;
 	old = (pte_update(ptep, _PAGE_ACCESSED, 0) & _PAGE_ACCESSED);
 #if _PAGE_HASHPTE != 0
-	if (old & _PAGE_HASHPTE)
-		flush_hash_one_pte(ptep);
+	if (old & _PAGE_HASHPTE) {
+		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
+		flush_hash_pages(context, addr, ptephys, 1);
+	}
 #endif
 	return old != 0;
 }
+#define ptep_test_and_clear_young(__vma, __addr, __ptep) \
+	__ptep_test_and_clear_young((__vma)->vm_mm->context, __addr, __ptep)
 
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep)
 {
 	return (pte_update(ptep, (_PAGE_DIRTY | _PAGE_HWWRITE), 0) & _PAGE_DIRTY) != 0;
 }
 
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep)
 {
 	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
 }
 
-static inline void ptep_set_wrprotect(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), 0);
 }
 
-static inline void ptep_mkdirty(pte_t *ptep)
-{
-	pte_update(ptep, 0, _PAGE_DIRTY);
-}
-
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
 {
@@ -604,6 +621,7 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+#define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
 /*
@@ -656,17 +674,6 @@
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
@@ -723,15 +730,9 @@
 
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
 
-#endif /* !__ASSEMBLY__ */
-
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define __HAVE_ARCH_PTEP_MKDIRTY
-#define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _PPC_PGTABLE_H */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc64/pgalloc.h b/include/asm-ppc64/pgalloc.h
--- a/include/asm-ppc64/pgalloc.h	2004-08-18 15:33:21 -07:00
+++ b/include/asm-ppc64/pgalloc.h	2004-08-18 15:33:21 -07:00
@@ -47,42 +47,26 @@
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
 
diff -Nru a/include/asm-ppc64/pgtable.h b/include/asm-ppc64/pgtable.h
--- a/include/asm-ppc64/pgtable.h	2004-08-18 15:33:21 -07:00
+++ b/include/asm-ppc64/pgtable.h	2004-08-18 15:33:21 -07:00
@@ -310,9 +310,10 @@
  * batch, doesn't actually triggers the hash flush immediately,
  * you need to call flush_tlb_pending() to do that.
  */
-extern void hpte_update(pte_t *ptep, unsigned long pte, int wrprot);
+extern void hpte_update(struct mm_struct *mm, unsigned long addr, unsigned long pte,
+			int wrprot);
 
-static inline int ptep_test_and_clear_young(pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
@@ -320,18 +321,26 @@
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
+#define ptep_test_and_clear_young(__vma, __addr, __ptep)			\
+({										\
+	int __r;								\
+	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep);	\
+	__r;									\
+})
+
 
 /*
  * On RW/DIRTY bit transitions we can avoid flushing the hpte. For the
  * moment we always flush but we need to fix hpte_update and test if the
  * optimisation is worth it.
  */
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+static inline int __ptep_test_and_clear_dirty(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
@@ -339,11 +348,19 @@
 		return 0;
 	old = pte_update(ptep, _PAGE_DIRTY);
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 	return (old & _PAGE_DIRTY) != 0;
 }
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+#define ptep_test_and_clear_dirty(__vma, __addr, __ptep)			\
+({										\
+	int __r;								\
+	__r = __ptep_test_and_clear_dirty((__vma)->vm_mm, __addr, __ptep);	\
+	__r;									\
+})
 
-static inline void ptep_set_wrprotect(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 
@@ -351,7 +368,7 @@
        		return;
 	old = pte_update(ptep, _PAGE_RW);
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 }
 
 /*
@@ -363,44 +380,45 @@
  * these functions and force a tlb flush unconditionally
  */
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-#define ptep_clear_flush_young(__vma, __address, __ptep)		\
-({									\
-	int __young = ptep_test_and_clear_young(__ptep);		\
-	__young;							\
+#define ptep_clear_flush_young(__vma, __address, __ptep)				\
+({											\
+	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, __ptep);	\
+	__young;									\
 })
 
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
-#define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
-({									\
-	int __dirty = ptep_test_and_clear_dirty(__ptep);		\
-	flush_tlb_page(__vma, __address);				\
-	__dirty;							\
+#define ptep_clear_flush_dirty(__vma, __address, __ptep)				\
+({											\
+	int __dirty = __ptep_test_and_clear_dirty((__vma)->vm_mm, __address, __ptep); 	\
+	flush_tlb_page(__vma, __address);						\
+	__dirty;									\
 })
 
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	unsigned long old = pte_update(ptep, ~0UL);
 
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 	return __pte(old);
 }
 
-static inline void pte_clear(pte_t * ptep)
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t * ptep)
 {
 	unsigned long old = pte_update(ptep, ~0UL);
 
 	if (old & _PAGE_HASHPTE)
-		hpte_update(ptep, old, 0);
+		hpte_update(mm, addr, old, 0);
 }
 
 /*
  * set_pte stores a linux PTE into the linux page table.
  */
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
 {
 	if (pte_present(*ptep)) {
-		pte_clear(ptep);
+		pte_clear(mm, addr, ptep);
 		flush_tlb_pending();
 	}
 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
@@ -438,6 +456,7 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+#define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
 extern unsigned long ioremap_bot, ioremap_base;
@@ -538,14 +557,8 @@
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
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* _PPC64_PGTABLE_H */
diff -Nru a/mm/highmem.c b/mm/highmem.c
--- a/mm/highmem.c	2004-08-18 15:33:21 -07:00
+++ b/mm/highmem.c	2004-08-18 15:33:21 -07:00
@@ -90,7 +90,8 @@
 		 * So no dangers, even with speculative execution.
 		 */
 		page = pte_page(pkmap_page_table[i]);
-		pte_clear(&pkmap_page_table[i]);
+		pte_clear(&init_mm, (unsigned long)page_address(page),
+			  &pkmap_page_table[i]);
 
 		set_page_address(page, NULL);
 	}
@@ -138,7 +139,8 @@
 		}
 	}
 	vaddr = PKMAP_ADDR(last_pkmap_nr);
-	set_pte(&(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
+	set_pte(&init_mm, vaddr,
+		&(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
 
 	pkmap_count[last_pkmap_nr] = 1;
 	set_page_address(page, (void *)vaddr);

--Multipart=_Wed__18_Aug_2004_15_45_29_-0700_MbZaHBPfa2LALqBW--
