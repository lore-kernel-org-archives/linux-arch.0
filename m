Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:38381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbYAMDKQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 12 Jan 2008 22:10:16 -0500
Date: Sun, 13 Jan 2008 04:10:13 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080113031013.GD22285@wotan.suse.de>
References: <20080113030810.GB22285@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080113030810.GB22285@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org


mm: introduce pte_special pte bit

Rather than play interesting games with vmas to work out whether the mapped
page should be refcounted or not, use a new bit in the "present" pte to
distinguish such pages.

This allows much simpler "vm_normal_page" implementation, and more flexible
rules for COW pages in pfn mappings (eg. our proposed VM_MIXEDMAP mode would
becomes a noop). vm_normal_page() can be in the top several kernel functions
in a profile (I've seen it use ~5% kernel time in fork/exit intensive
workloads).

Special bits also provides one of the required pieces for the lockless
get_user_pages; and allows s390 to implement pfn-only XIP mappings (although
granted they could also do so if they modified their memory model somewhat).

Unfortunately, not all architectures can spare a bit in the pte for this. So
add an ifdefs, depending on whether the arch can support it or not.  Although
pte_special can remove all restrictions that pfn mappings currently have, we
continue to enforce those restrictions even on architectures that have the new
pte bit, for consistency.

Provide an implementation for x86 and uml.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: Jared Hulbert <jaredeh@gmail.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org
---
 include/asm-alpha/pgtable.h         |    4 -
 include/asm-avr32/pgtable.h         |    8 +++
 include/asm-cris/pgtable.h          |    2 
 include/asm-frv/pgtable.h           |    2 
 include/asm-ia64/pgtable.h          |    3 +
 include/asm-m32r/pgtable.h          |   10 ++++
 include/asm-m68k/motorola_pgtable.h |    2 
 include/asm-m68k/sun3_pgtable.h     |    2 
 include/asm-mips/pgtable.h          |    2 
 include/asm-parisc/pgtable.h        |    2 
 include/asm-powerpc/pgtable-ppc32.h |    3 +
 include/asm-powerpc/pgtable-ppc64.h |    3 +
 include/asm-ppc/pgtable.h           |    3 +
 include/asm-s390/pgtable.h          |   10 ++++
 include/asm-sh64/pgtable.h          |    2 
 include/asm-sparc/pgtable.h         |    7 +++
 include/asm-sparc64/pgtable.h       |   10 ++++
 include/asm-um/pgtable.h            |   13 +++++
 include/asm-x86/pgtable_32.h        |    5 ++
 include/asm-x86/pgtable_64.h        |    5 ++
 include/asm-xtensa/pgtable.h        |    4 +
 include/linux/mm.h                  |    3 -
 mm/memory.c                         |   79 ++++++++++++++++++++----------------
 23 files changed, 147 insertions(+), 37 deletions(-)

Index: linux-2.6/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-um/pgtable.h
+++ linux-2.6/include/asm-um/pgtable.h
@@ -21,6 +21,8 @@
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
 #define _PAGE_DIRTY	0x100
+#define _PAGE_SPECIAL	0x200
+#define __HAVE_ARCH_PTE_SPECIAL
 /* If _PAGE_PRESENT is clear, we use these: */
 #define _PAGE_FILE	0x008	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_PROTNONE	0x010	/* if the user mapped it with PROT_NONE;
@@ -220,6 +222,11 @@ static inline int pte_newprot(pte_t pte)
 	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
 }
 
+static inline int pte_special(pte_t pte)
+{
+	return pte_get_bits(pte, _PAGE_SPECIAL);
+}
+
 /*
  * =================================
  * Flags setting section.
@@ -288,6 +295,12 @@ static inline pte_t pte_mknewpage(pte_t 
 	return(pte);
 }
 
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	pte_set_bits(pte, _PAGE_SPECIAL);
+	return(pte);
+}
+
 static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	pte_copy(*pteptr, pteval);
Index: linux-2.6/include/asm-x86/pgtable_32.h
===================================================================
--- linux-2.6.orig/include/asm-x86/pgtable_32.h
+++ linux-2.6/include/asm-x86/pgtable_32.h
@@ -102,6 +102,7 @@ void paging_init(void);
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
 #define _PAGE_BIT_NX		63
+#define _PAGE_BIT_SPECIAL	_PAGE_BIT_UNUSED1
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_RW	0x002
@@ -115,6 +116,8 @@ void paging_init(void);
 #define _PAGE_UNUSED1	0x200	/* available for programmer */
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800
+#define _PAGE_SPECIAL	PAGE_UNUSED1
+#define __HAVE_ARCH_PTE_SPECIAL
 
 /* If _PAGE_PRESENT is clear, we use these: */
 #define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
@@ -219,6 +222,7 @@ static inline int pte_dirty(pte_t pte)		
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
 static inline int pte_huge(pte_t pte)		{ return (pte).pte_low & _PAGE_PSE; }
+static inline int pte_special(pte_t pte)	{ return (pte).pte_low & _PAGE_SPECIAL; }
 
 /*
  * The following only works if pte_present() is not true.
@@ -232,6 +236,7 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PSE; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ (pte).pte_low |= _PAGE_SPECIAL; return pte; }
 
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
Index: linux-2.6/include/asm-x86/pgtable_64.h
===================================================================
--- linux-2.6.orig/include/asm-x86/pgtable_64.h
+++ linux-2.6/include/asm-x86/pgtable_64.h
@@ -151,6 +151,7 @@ static inline pte_t ptep_get_and_clear_f
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
+#define _PAGE_BIT_SPECIAL	9
 #define _PAGE_BIT_NX           63       /* No execute: only valid after cpuid check */
 
 #define _PAGE_PRESENT	0x001
@@ -163,6 +164,8 @@ static inline pte_t ptep_get_and_clear_f
 #define _PAGE_PSE	0x080	/* 2MB page */
 #define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
+#define _PAGE_SPECIAL	0x200
+#define __HAVE_ARCH_PTE_SPECIAL
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
 #define _PAGE_NX        (_AC(1,UL)<<_PAGE_BIT_NX)
@@ -272,6 +275,7 @@ static inline int pte_young(pte_t pte)		
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_huge(pte_t pte)		{ return pte_val(pte) & _PAGE_PSE; }
+static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 
 static inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_ACCESSED)); return pte; }
@@ -282,6 +286,7 @@ static inline pte_t pte_mkyoung(pte_t pt
 static inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_PSE)); return pte; }
 static inline pte_t pte_clrhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_PSE)); return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SPECIAL)); return pte; }
 
 struct vm_area_struct;
 
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -699,7 +699,8 @@ struct zap_details {
 	unsigned long truncate_count;		/* Compare vm_truncate_count */
 };
 
-struct page *vm_normal_page(struct vm_area_struct *, unsigned long, pte_t);
+struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr, pte_t pte);
+
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
 unsigned long unmap_vmas(struct mmu_gather **tlb,
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -361,34 +361,38 @@ static inline int is_cow_mapping(unsigne
 }
 
 /*
- * This function gets the "struct page" associated with a pte or returns
- * NULL if no "struct page" is associated with the pte.
+ * vm_normal_page -- This function gets the "struct page" associated with a pte.
  *
- * A raw VM_PFNMAP mapping (ie. one that is not COWed) may not have any "struct
- * page" backing, and even if they do, they are not refcounted. COWed pages of
- * a VM_PFNMAP do always have a struct page, and they are normally refcounted
- * (they are _normal_ pages).
- *
- * So a raw PFNMAP mapping will have each page table entry just pointing
- * to a page frame number, and as far as the VM layer is concerned, those do
- * not have pages associated with them - even if the PFN might point to memory
- * that otherwise is perfectly fine and has a "struct page".
+ * "Special" mappings do not wish to be associated with a "struct page" (either
+ * it doesn't exist, or it exists but they don't want to touch it). In this
+ * case, NULL is returned here. "Normal" mappings do have a struct page.
+ *
+ * There are 2 broad cases. Firstly, an architecture may define a pte_special()
+ * pte bit, in which case this function is trivial. Secondly, an architecture may
+ * not have a spare pte bit, which requires a more complicated scheme, described
+ * below.
+ *
+ * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
+ * special mapping (even if there are underlying and valid "struct pages").
+ * COWed pages of a VM_PFNMAP are always normal.
  *
  * The way we recognize COWed pages within VM_PFNMAP mappings is through the
  * rules set up by "remap_pfn_range()": the vma will have the VM_PFNMAP bit
- * set, and the vm_pgoff will point to the first PFN mapped: thus every
- * page that is a raw mapping will always honor the rule
+ * set, and the vm_pgoff will point to the first PFN mapped: thus every special
+ * mapping will always honor the rule
  *
  *	pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)
  *
- * A call to vm_normal_page() will return NULL for such a page.
+ * And for normal mappings this is false.
  *
- * If the page doesn't follow the "remap_pfn_range()" rule in a VM_PFNMAP
- * then the page has been COW'ed.  A COW'ed page _does_ have a "struct page"
- * associated with it even if it is in a VM_PFNMAP range.  Calling
- * vm_normal_page() on such a page will therefore return the "struct page".
+ * This restricts such mappings to be a linear translation from virtual address to
+ * pfn. To get around this restriction, we allow arbitrary mappings so long as the
+ * vma is not a COW mapping; in that case, we know that all ptes are special (because
+ * none can have been COWed).
  *
  *
+ * In order to support COW of arbitrary special mappings, we have VM_MIXEDMAP.
+ *
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
  * page" backing, however the difference is that _all_ pages with a struct
  * page (that is, those where pfn_valid is true) are refcounted and considered
@@ -397,15 +401,18 @@ static inline int is_cow_mapping(unsigne
  * advantage is that we don't have to follow the strict linearity rule of
  * PFNMAP mappings in order to support COWable mappings.
  *
- * A call to vm_normal_page() with a VM_MIXEDMAP mapping will return the
- * associated "struct page" or NULL for memory not backed by a "struct page".
- *
- *
- * All other mappings should have a valid struct page, which will be
- * returned by a call to vm_normal_page().
  */
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
+#ifdef __HAVE_ARCH_PTE_SPECIAL
+	if (likely(!pte_special(pte))) {
+		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+		return pte_page(pte);
+	}
+	VM_BUG_ON(!(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
+	return NULL;
+#else
+
 	unsigned long pfn = pte_pfn(pte);
 
 	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
@@ -423,10 +430,9 @@ struct page *vm_normal_page(struct vm_ar
 	}
 
 	/*
-	 * Add some anal sanity checks for now. Eventually,
-	 * we should just do "return pfn_to_page(pfn)", but
-	 * in the meantime we check that we get a valid pfn,
-	 * and that the resulting page looks ok.
+	 * Add some anal sanity checks for now. Eventually, we should just do
+	 * "return pfn_to_page(pfn)", but in the meantime we check that we get
+	 * a valid pfn, and that the resulting page looks ok.
 	 */
 	if (unlikely(!pfn_valid(pfn))) {
 		print_bad_pte(vma, pte, addr);
@@ -434,14 +440,13 @@ struct page *vm_normal_page(struct vm_ar
 	}
 
 	/*
-	 * NOTE! We still have PageReserved() pages in the page 
-	 * tables. 
+	 * NOTE! We still have PageReserved() pages in the page tables.
 	 *
-	 * The PAGE_ZERO() pages and various VDSO mappings can
-	 * cause them to exist.
+	 * Eg. VDSO mappings can cause them to exist.
 	 */
 out:
 	return pfn_to_page(pfn);
+#endif
 }
 
 /*
@@ -1242,6 +1247,12 @@ int vm_insert_pfn(struct vm_area_struct 
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
+	/*
+	 * Technically, architectures with pte_special can avoid all these
+	 * restrictions (same for remap_pfn_range).  However we would like
+	 * consistency in testing and feature parity among all, so we should
+	 * try to keep these invariants in place for everybody.
+	 */
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
@@ -1257,7 +1268,7 @@ int vm_insert_pfn(struct vm_area_struct 
 		goto out_unlock;
 
 	/* Ok, finally just insert the thing.. */
-	entry = pfn_pte(pfn, vma->vm_page_prot);
+	entry = pte_mkspecial(pfn_pte(pfn, vma->vm_page_prot));
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, entry);
 
@@ -1288,7 +1299,7 @@ static int remap_pte_range(struct mm_str
 	arch_enter_lazy_mmu_mode();
 	do {
 		BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, addr, pte, pfn_pte(pfn, prot));
+		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
Index: linux-2.6/include/asm-alpha/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/pgtable.h
+++ linux-2.6/include/asm-alpha/pgtable.h
@@ -269,7 +269,7 @@ extern inline int pte_write(pte_t pte)		
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 extern inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
-extern inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
+extern inline int pte_special(pte_t pte)	{ return 0; }
 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_FOW; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~(__DIRTY_BITS); return pte; }
@@ -277,7 +277,7 @@ extern inline pte_t pte_mkold(pte_t pte)
 extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &= ~_PAGE_FOW; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
-extern inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
+extern inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
Index: linux-2.6/include/asm-avr32/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-avr32/pgtable.h
+++ linux-2.6/include/asm-avr32/pgtable.h
@@ -211,6 +211,10 @@ static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_ACCESSED;
 }
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
 
 /*
  * The following only work if pte_present() is not true.
@@ -251,6 +255,10 @@ static inline pte_t pte_mkyoung(pte_t pt
 	set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED));
 	return pte;
 }
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
 
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
Index: linux-2.6/include/asm-cris/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-cris/pgtable.h
+++ linux-2.6/include/asm-cris/pgtable.h
@@ -115,6 +115,7 @@ static inline int pte_write(pte_t pte)  
 static inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)           { return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -162,6 +163,7 @@ static inline pte_t pte_mkyoung(pte_t pt
         }
         return pte;
 }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
Index: linux-2.6/include/asm-frv/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-frv/pgtable.h
+++ linux-2.6/include/asm-frv/pgtable.h
@@ -380,6 +380,7 @@ static inline pmd_t *pmd_offset(pud_t *d
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return !((pte).pte & _PAGE_WP); }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte &= ~_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ (pte).pte &= ~_PAGE_ACCESSED; return pte; }
@@ -387,6 +388,7 @@ static inline pte_t pte_wrprotect(pte_t 
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte &= ~_PAGE_WP; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
Index: linux-2.6/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/pgtable.h
+++ linux-2.6/include/asm-ia64/pgtable.h
@@ -302,6 +302,8 @@ ia64_phys_addr_valid (unsigned long addr
 #define pte_dirty(pte)		((pte_val(pte) & _PAGE_D) != 0)
 #define pte_young(pte)		((pte_val(pte) & _PAGE_A) != 0)
 #define pte_file(pte)		((pte_val(pte) & _PAGE_FILE) != 0)
+#define pte_special(pte)	0
+
 /*
  * Note: we convert AR_RWX to AR_RX and AR_RW to AR_R by clearing the 2nd bit in the
  * access rights:
@@ -313,6 +315,7 @@ ia64_phys_addr_valid (unsigned long addr
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte)))
+#define pte_mkspecial(pte)	(pte)
 
 /*
  * Because ia64's Icache and Dcache is not coherent (on a cpu), we need to
Index: linux-2.6/include/asm-m32r/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/pgtable.h
+++ linux-2.6/include/asm-m32r/pgtable.h
@@ -214,6 +214,11 @@ static inline int pte_file(pte_t pte)
 	return pte_val(pte) & _PAGE_FILE;
 }
 
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_val(pte) &= ~_PAGE_DIRTY;
@@ -250,6 +255,11 @@ static inline pte_t pte_mkwrite(pte_t pt
 	return pte;
 }
 
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
+
 static inline  int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep);
Index: linux-2.6/include/asm-m68k/motorola_pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/motorola_pgtable.h
+++ linux-2.6/include/asm-m68k/motorola_pgtable.h
@@ -168,6 +168,7 @@ static inline int pte_write(pte_t pte)		
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
@@ -185,6 +186,7 @@ static inline pte_t pte_mkcache(pte_t pt
 	pte_val(pte) = (pte_val(pte) & _CACHEMASK040) | m68k_supervisor_cachemode;
 	return pte;
 }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
Index: linux-2.6/include/asm-m68k/sun3_pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/sun3_pgtable.h
+++ linux-2.6/include/asm-m68k/sun3_pgtable.h
@@ -169,6 +169,7 @@ static inline int pte_write(pte_t pte)		
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_MODIFIED; return pte; }
@@ -181,6 +182,7 @@ static inline pte_t pte_mknocache(pte_t 
 //static inline pte_t pte_mkcache(pte_t pte)	{ pte_val(pte) &= SUN3_PAGE_NOCACHE; return pte; }
 // until then, use:
 static inline pte_t pte_mkcache(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
Index: linux-2.6/include/asm-mips/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-mips/pgtable.h
+++ linux-2.6/include/asm-mips/pgtable.h
@@ -285,6 +285,8 @@ static inline pte_t pte_mkyoung(pte_t pt
 	return pte;
 }
 #endif
+static inline int pte_special(pte_t pte)	{ return 0; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 /*
  * Macro to make mark a page protection value as "uncacheable".  Note
Index: linux-2.6/include/asm-parisc/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/pgtable.h
+++ linux-2.6/include/asm-parisc/pgtable.h
@@ -331,6 +331,7 @@ static inline int pte_dirty(pte_t pte)		
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &= ~_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
@@ -338,6 +339,7 @@ static inline pte_t pte_wrprotect(pte_t 
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |= _PAGE_WRITE; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
Index: linux-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable-ppc32.h
+++ linux-2.6/include/asm-powerpc/pgtable-ppc32.h
@@ -514,6 +514,7 @@ static inline int pte_write(pte_t pte)		
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline void pte_uncache(pte_t pte)       { pte_val(pte) |= _PAGE_NO_CACHE; }
 static inline void pte_cache(pte_t pte)         { pte_val(pte) &= ~_PAGE_NO_CACHE; }
@@ -531,6 +532,8 @@ static inline pte_t pte_mkdirty(pte_t pt
 	pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte) {
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte) {
+	return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
Index: linux-2.6/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable-ppc64.h
+++ linux-2.6/include/asm-powerpc/pgtable-ppc64.h
@@ -239,6 +239,7 @@ static inline int pte_write(pte_t pte) {
 static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY;}
 static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED;}
 static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE;}
+static inline int pte_special(pte_t pte) { return 0; }
 
 static inline void pte_uncache(pte_t pte) { pte_val(pte) |= _PAGE_NO_CACHE; }
 static inline void pte_cache(pte_t pte)   { pte_val(pte) &= ~_PAGE_NO_CACHE; }
@@ -257,6 +258,8 @@ static inline pte_t pte_mkyoung(pte_t pt
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte) {
 	return pte; }
+static inline pte_t pte_mkspecial(pte_t pte) {
+	return pte; }
 
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
Index: linux-2.6/include/asm-ppc/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/pgtable.h
+++ linux-2.6/include/asm-ppc/pgtable.h
@@ -537,6 +537,7 @@ static inline int pte_write(pte_t pte)		
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline void pte_uncache(pte_t pte)       { pte_val(pte) |= _PAGE_NO_CACHE; }
 static inline void pte_cache(pte_t pte)         { pte_val(pte) &= ~_PAGE_NO_CACHE; }
@@ -554,6 +555,8 @@ static inline pte_t pte_mkdirty(pte_t pt
 	pte_val(pte) |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte) {
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte) {
+	return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
Index: linux-2.6/include/asm-s390/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-s390/pgtable.h
+++ linux-2.6/include/asm-s390/pgtable.h
@@ -504,6 +504,11 @@ static inline int pte_file(pte_t pte)
 	return (pte_val(pte) & mask) == _PAGE_TYPE_FILE;
 }
 
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(a,b)  (pte_val(a) == pte_val(b))
 
@@ -654,6 +659,11 @@ static inline pte_t pte_mkyoung(pte_t pt
 	return pte;
 }
 
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
Index: linux-2.6/include/asm-sh64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/pgtable.h
+++ linux-2.6/include/asm-sh64/pgtable.h
@@ -419,6 +419,7 @@ static inline int pte_dirty(pte_t pte){ 
 static inline int pte_young(pte_t pte){ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_write(pte_t pte){ return pte_val(pte) & _PAGE_WRITE; }
+static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_WRITE)); return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }
@@ -427,6 +428,7 @@ static inline pte_t pte_mkwrite(pte_t pt
 static inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_SZHUGE)); return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
 
 
 /*
Index: linux-2.6/include/asm-sparc/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/pgtable.h
+++ linux-2.6/include/asm-sparc/pgtable.h
@@ -219,6 +219,11 @@ static inline int pte_file(pte_t pte)
 	return pte_val(pte) & BTFIXUP_HALF(pte_filei);
 }
 
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
 /*
  */
 BTFIXUPDEF_HALF(pte_wrprotecti)
@@ -251,6 +256,8 @@ BTFIXUPDEF_CALL_CONST(pte_t, pte_mkyoung
 #define pte_mkdirty(pte) BTFIXUP_CALL(pte_mkdirty)(pte)
 #define pte_mkyoung(pte) BTFIXUP_CALL(pte_mkyoung)(pte)
 
+#define pte_mkspecial(pte_t pte)    (pte)
+
 #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
 BTFIXUPDEF_CALL(unsigned long,	 pte_pfn, pte_t)
Index: linux-2.6/include/asm-sparc64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/pgtable.h
+++ linux-2.6/include/asm-sparc64/pgtable.h
@@ -506,6 +506,11 @@ static inline pte_t pte_mkyoung(pte_t pt
 	return __pte(pte_val(pte) | mask);
 }
 
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return pte;
+}
+
 static inline unsigned long pte_young(pte_t pte)
 {
 	unsigned long mask;
@@ -608,6 +613,11 @@ static inline unsigned long pte_present(
 	return val;
 }
 
+static inline int pte_special(pte_t pte)
+{
+	return 0;
+}
+
 #define pmd_set(pmdp, ptep)	\
 	(pmd_val(*(pmdp)) = (__pa((unsigned long) (ptep)) >> 11UL))
 #define pud_set(pudp, pmdp)	\
Index: linux-2.6/include/asm-xtensa/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/pgtable.h
+++ linux-2.6/include/asm-xtensa/pgtable.h
@@ -212,6 +212,8 @@ static inline int pte_write(pte_t pte) {
 static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)  { return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte) { return 0; }
+
 static inline pte_t pte_wrprotect(pte_t pte)	
 	{ pte_val(pte) &= ~(_PAGE_WRITABLE | _PAGE_HW_WRITE); return pte; }
 static inline pte_t pte_mkclean(pte_t pte)
@@ -224,6 +226,8 @@ static inline pte_t pte_mkyoung(pte_t pt
 	{ pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)
 	{ pte_val(pte) |= _PAGE_WRITABLE; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)
+	{ return pte; }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
