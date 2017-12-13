From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 08/12] sparc64: Update pmdp_invalidate() to return old pmd value
Date: Wed, 13 Dec 2017 13:57:52 +0300
Message-ID: <20171213105756.69879-9-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nitin Gupta <nitin.m.gupta@oracle.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>

It's required to avoid losing dirty and accessed bits.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/sparc/include/asm/pgtable_64.h |  2 +-
 arch/sparc/mm/tlb.c                 | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 9937c5ff94a9..339920fdf9ed 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1010,7 +1010,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd);
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 4ae86bc0d35c..5a3ba863b48a 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -219,17 +219,28 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old;
+
+	{
+		old = *pmdp;
+	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
+
+	return old;
+}
+
 /*
  * This routine is only called when splitting a THP
  */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t entry = *pmdp;
-
-	pmd_val(entry) &= ~_PAGE_VALID;
+	pmd_t old, entry;
 
-	set_pmd_at(vma->vm_mm, address, pmdp, entry);
+	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
+	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 
 	/*
@@ -240,6 +251,8 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
 	    !is_huge_zero_page(pmd_page(entry)))
 		(vma->vm_mm)->context.thp_pte_count--;
+
+	return old;
 }
 
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-- 
2.15.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
