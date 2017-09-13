From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 11/11] mm: Use updated pmdp_invalidate() interface to track dirty/accessed bits
Date: Wed, 13 Sep 2017 07:38:58 +0530
Message-ID: <87tw07uz7p.fsf@linux.vnet.ibm.com>
References: <20170912153941.47012-1-kirill.shutemov@linux.intel.com> <20170912153941.47012-12-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170912153941.47012-12-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org


How about this additional patch ?. This results in code reduction.

From fed62d0541ae78206a1a25caeb46a3ffa7ade9c8 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 12:21:33 +0530
Subject: [PATCH] mm/thp: Remove pmd_huge_split_prepare

Instead of marking the pmd ready for split, invalidate the pmd. This should
take care of powerpc requirement. Only side effect is that we mark the pmd
invalid early. This can result in us blocking access to the page a bit longer
if we race against a thp split.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 -
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  9 ----
 arch/powerpc/include/asm/book3s/64/radix.h    |  6 ---
 arch/powerpc/mm/pgtable-hash64.c              | 22 --------
 include/asm-generic/pgtable.h                 |  8 ---
 mm/huge_memory.c                              | 73 +++++++++++++--------------
 7 files changed, 35 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index d65dcb5826ff..2416edb74d28 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -112,8 +112,6 @@ extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
 extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 					 pgtable_t pgtable);
 extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
-extern void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
-				      unsigned long address, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
 extern int hash__has_transparent_hugepage(void);
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ab36323b8a3e..001202cabedf 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -162,8 +162,6 @@ extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
 extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 					 pgtable_t pgtable);
 extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
-extern void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
-				      unsigned long address, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
 extern int hash__has_transparent_hugepage(void);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6cf53dc70efc..fee01ffe3b60 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1114,15 +1114,6 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			     pmd_t *pmdp);
 
-#define __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
-static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
-					   unsigned long address, pmd_t *pmdp)
-{
-	if (radix_enabled())
-		return radix__pmdp_huge_split_prepare(vma, address, pmdp);
-	return hash__pmdp_huge_split_prepare(vma, address, pmdp);
-}
-
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
 static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index f5ece365d929..389be8b6c9f7 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -272,12 +272,6 @@ static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 		return __pmd(pmd_val(pmd) | _PAGE_PTE | R_PAGE_LARGE);
 	return __pmd(pmd_val(pmd) | _PAGE_PTE);
 }
-static inline void radix__pmdp_huge_split_prepare(struct vm_area_struct *vma,
-					    unsigned long address, pmd_t *pmdp)
-{
-	/* Nothing to do for radix. */
-	return;
-}
 
 extern unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 					  pmd_t *pmdp, unsigned long clr,
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index ec277913e01b..469808e77e58 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -296,28 +296,6 @@ pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	return pgtable;
 }
 
-void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
-			       unsigned long address, pmd_t *pmdp)
-{
-	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(REGION_ID(address) != USER_REGION_ID);
-	VM_BUG_ON(pmd_devmap(*pmdp));
-
-	/*
-	 * We can't mark the pmd none here, because that will cause a race
-	 * against exit_mmap. We need to continue mark pmd TRANS HUGE, while
-	 * we spilt, but at the same time we wan't rest of the ppc64 code
-	 * not to insert hash pte on this, because we will be modifying
-	 * the deposited pgtable in the caller of this function. Hence
-	 * clear the _PAGE_USER so that we move the fault handling to
-	 * higher level function and that will serialize against ptl.
-	 * We need to flush existing hash pte entries here even though,
-	 * the translation is still valid, because we will withdraw
-	 * pgtable_t after this.
-	 */
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, 0, _PAGE_PRIVILEGED);
-}
-
 /*
  * A linux hugepage PMD was changed and the corresponding hash table entries
  * neesd to be flushed.
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index ece5e399567a..b934e41277ac 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -313,14 +313,6 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
-#ifndef __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
-static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
-					   unsigned long address, pmd_t *pmdp)
-{
-
-}
-#endif
-
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d72c2d20e9c6..59ec8c916368 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1944,8 +1944,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
 	pgtable_t pgtable;
-	pmd_t old, _pmd;
-	bool young, write, soft_dirty;
+	pmd_t old_pmd, _pmd;
+	bool young, write, dirty, soft_dirty;
 	unsigned long addr;
 	int i;
 
@@ -1977,14 +1977,39 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
-	page = pmd_page(*pmd);
+	/*
+	 * Up to this point the pmd is present and huge and userland has the
+	 * whole access to the hugepage during the split (which happens in
+	 * place). If we overwrite the pmd with the not-huge version pointing
+	 * to the pte here (which of course we could if all CPUs were bug
+	 * free), userland could trigger a small page size TLB miss on the
+	 * small sized TLB while the hugepage TLB entry is still established in
+	 * the huge TLB. Some CPU doesn't like that.
+	 * See http://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
+	 * 383 on page 93. Intel should be safe but is also warns that it's
+	 * only safe if the permission and cache attributes of the two entries
+	 * loaded in the two TLB is identical (which should be the case here).
+	 * But it is generally safer to never allow small and huge TLB entries
+	 * for the same virtual address to be loaded simultaneously. So instead
+	 * of doing "pmd_populate(); flush_pmd_tlb_range();" we first mark the
+	 * current pmd notpresent (atomically because here the pmd_trans_huge
+	 * and pmd_trans_splitting must remain set at all times on the pmd
+	 * until the split is complete for this pmd), then we flush the SMP TLB
+	 * and finally we write the non-huge version of the pmd entry with
+	 * pmd_populate.
+	 */
+	old_pmd = pmdp_invalidate(vma, haddr, pmd);
+
+	page = pmd_page(old_pmd);
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
-	write = pmd_write(*pmd);
-	young = pmd_young(*pmd);
-	soft_dirty = pmd_soft_dirty(*pmd);
-
-	pmdp_huge_split_prepare(vma, haddr, pmd);
+	write = pmd_write(old_pmd);
+	young = pmd_young(old_pmd);
+	dirty = pmd_dirty(old_pmd);
+	soft_dirty = pmd_soft_dirty(old_pmd);
+	/*
+	 * withdraw the table only after we mark the pmd entry invalid
+	 */
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
 	pmd_populate(mm, &_pmd, pgtable);
 
@@ -2011,6 +2036,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 		}
+		if (dirty)
+			SetPageDirty(page + i);
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
@@ -2038,36 +2065,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
-	/*
-	 * Up to this point the pmd is present and huge and userland has the
-	 * whole access to the hugepage during the split (which happens in
-	 * place). If we overwrite the pmd with the not-huge version pointing
-	 * to the pte here (which of course we could if all CPUs were bug
-	 * free), userland could trigger a small page size TLB miss on the
-	 * small sized TLB while the hugepage TLB entry is still established in
-	 * the huge TLB. Some CPU doesn't like that.
-	 * See http://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
-	 * 383 on page 93. Intel should be safe but is also warns that it's
-	 * only safe if the permission and cache attributes of the two entries
-	 * loaded in the two TLB is identical (which should be the case here).
-	 * But it is generally safer to never allow small and huge TLB entries
-	 * for the same virtual address to be loaded simultaneously. So instead
-	 * of doing "pmd_populate(); flush_pmd_tlb_range();" we first mark the
-	 * current pmd notpresent (atomically because here the pmd_trans_huge
-	 * and pmd_trans_splitting must remain set at all times on the pmd
-	 * until the split is complete for this pmd), then we flush the SMP TLB
-	 * and finally we write the non-huge version of the pmd entry with
-	 * pmd_populate.
-	 */
-	old = pmdp_invalidate(vma, haddr, pmd);
-
-	/*
-	 * Transfer dirty bit using value returned by pmd_invalidate() to be
-	 * sure we don't race with CPU that can set the bit under us.
-	 */
-	if (pmd_dirty(old))
-		SetPageDirty(page);
-
 	pmd_populate(mm, pmd, pgtable);
 
 	if (freeze) {
-- 
2.13.5


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
