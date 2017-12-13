From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 06/12] powerpc/mm: update pmdp_invalidate to return old pmd value
Date: Wed, 13 Dec 2017 13:57:50 +0300
Message-ID: <20171213105756.69879-7-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

It's required to avoid losing dirty and accessed bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
 arch/powerpc/mm/pgtable-book3s64.c           | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 44697817ccc6..ee19d5bbee06 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1137,8 +1137,8 @@ static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
-			    pmd_t *pmdp);
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			     pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
 static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 3b65917785a5..422e80253a33 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -90,16 +90,19 @@ void serialize_against_pte_lookup(struct mm_struct *mm)
  * We use this to invalidate a pmdp entry before switching from a
  * hugepte to regular pmd entry.
  */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
+	unsigned long old_pmd;
+
+	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
 	 */
 	serialize_against_pte_lookup(vma->vm_mm);
+	return __pmd(old_pmd);
 }
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
-- 
2.15.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
