From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v3.1 5/6] mm/hugetlb: Introduce set_huge_swap_pte_at() helper
Date: Mon, 22 May 2017 17:30:31 +0100
Message-ID: <20170522163031.4480-1-punit.agrawal@arm.com>
References: <20170522133604.11392-6-punit.agrawal@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933650AbdEVQbQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 May 2017 12:31:16 -0400
In-Reply-To: <20170522133604.11392-6-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com

set_huge_pte_at(), an architecture callback to populate hugepage ptes,
does not provide the range of virtual memory that is targeted. This
leads to ambiguity when dealing with swap entries on architectures that
support hugepages consisting of contiguous ptes.

Fix the problem by introducing an overridable helper for architectures
needing this support. The helper is called when populating the page
tables with swap entries. The size of the targeted region is provided to
the helper to help determine the number of entries to be updated.

Provide a default implementation that maintains the current behaviour.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
---

Changes since v3:

* Use #ifndef block instead of weak function

 include/linux/hugetlb.h | 8 ++++++++
 mm/hugetlb.c            | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 23010a3b2047..879eb063fb95 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -435,6 +435,14 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef set_huge_swap_pte_at
+static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte, unsigned long sz)
+{
+	set_huge_pte_at(mm, addr, ptep, pte);
+}
+#endif
+
 static inline struct hstate *page_hstate(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ddfed20cd637..e3052c16d29a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3263,9 +3263,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 */
 				make_migration_entry_read(&swp_entry);
 				entry = swp_entry_to_pte(swp_entry);
-				set_huge_pte_at(src, addr, src_pte, entry);
+				set_huge_swap_pte_at(src, addr, src_pte,
+						     entry, sz);
 			}
-			set_huge_pte_at(dst, addr, dst_pte, entry);
+			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
 			if (cow) {
 				huge_ptep_set_wrprotect(src, addr, src_pte);
@@ -4277,7 +4278,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 				make_migration_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
-				set_huge_pte_at(mm, address, ptep, newpte);
+				set_huge_swap_pte_at(mm, address, ptep,
+						     newpte, huge_page_size(h));
 				pages++;
 			}
 			spin_unlock(ptl);
-- 
2.11.0
