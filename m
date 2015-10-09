From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 10/12] mm,thp: introduce flush_pmd_tlb_range
Date: Fri, 9 Oct 2015 16:24:29 +0530
Message-ID: <56179CE5.5000807@synopsys.com>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-11-git-send-email-vgupta@synopsys.com>
 <20151009100816.GC7873@node>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151009100816.GC7873@node>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew
 Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Friday 09 October 2015 03:38 PM, Kirill A. Shutemov wrote:
> On Tue, Sep 22, 2015 at 04:04:54PM +0530, Vineet Gupta wrote:
> 
> Commit message: -ENOENT.
> 
> Otherwise, looks good:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

With updated change log and some reworking in the source code comment !

---------------->
From 96537a576f99be29f65c5682d6e0e7b31028d5ba Mon Sep 17 00:00:00 2001
From: Vineet Gupta <vgupta@synopsys.com>
Date: Fri, 20 Feb 2015 10:36:28 +0530
Subject: [PATCH v3] mm,thp: introduce flush_pmd_tlb_range

ARCHes with special requirements for evicting THP backing TLB entries
can implement this.

Otherwise also, it can help optimize TLB flush in THP regime.
stock flush_tlb_range() typically has optimization to nuke the entire
TLB if flush span is greater than a certain threshhold, which will
likely be true for a single huge page. Thus a single thp flush will
invalidate the entrire TLB which is not desirable.

e.g. see arch/arc: flush_pmd_tlb_range

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 mm/huge_memory.c     |  2 +-
 mm/pgtable-generic.c | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4b06b8db9df2..e25eb3d2081a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1880,7 +1880,7 @@ static int __split_huge_page_map(struct page *page,
 		 * here). But it is generally safer to never allow
 		 * small and huge TLB entries for the same virtual
 		 * address to be loaded simultaneously. So instead of
-		 * doing "pmd_populate(); flush_tlb_range();" we first
+		 * doing "pmd_populate(); flush_pmd_tlb_range();" we first
 		 * mark the current pmd notpresent (atomically because
 		 * here the pmd_trans_huge and pmd_trans_splitting
 		 * must remain set at all times on the pmd until the
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c9c59bb75a17..7d3db0247983 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -84,6 +84,20 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned
long address,

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE

+#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+
+/*
+ * ARCHes with special requirements for evicting THP backing TLB entries can
+ * implement this. Otherwise also, it can help optimize normal TLB flush in
+ * THP regime. stock flush_tlb_range() typically has optimization to nuke the
+ * entire TLB TLB if flush span is greater than a threshhold, which will
+ * likely be true for a single huge page. Thus a single thp flush will
+ * invalidate the entire TLB which is not desitable.
+ * e.g. see arch/arc: flush_pmd_tlb_range
+ */
+#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 int pmdp_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pmd_t *pmdp,
@@ -93,7 +107,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	if (changed) {
 		set_pmd_at(vma->vm_mm, address, pmdp, entry);
-		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
@@ -107,7 +121,7 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	young = pmdp_test_and_clear_young(vma, address, pmdp);
 	if (young)
-		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return young;
 }
 #endif
@@ -120,7 +134,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
unsigned long address,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(!pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
 }
 #endif
@@ -133,7 +147,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned
long address,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
 	/* tlb flush only to serialize against gup-fast */
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 }
 #endif

@@ -179,7 +193,7 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long
address,
 {
 	pmd_t entry = *pmdp;
 	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mknotpresent(entry));
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 }
 #endif

@@ -196,7 +210,7 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned
long address,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
 }
 #endif
-- 
1.9.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
