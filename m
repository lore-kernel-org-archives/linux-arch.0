Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933719AbdEVNhX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 May 2017 09:37:23 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v3 6/6] mm: rmap: Use correct helper when poisoning hugepages
Date: Mon, 22 May 2017 14:36:04 +0100
Message-ID: <20170522133604.11392-7-punit.agrawal@arm.com>
In-Reply-To: <20170522133604.11392-1-punit.agrawal@arm.com>
References: <20170522133604.11392-1-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, hillf.zj@alibaba-inc.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20170522133604.LYkSxP5Fa9_TVKLrYblJ71wFOeqTRued3xGej1KtZbE@z>

Using set_pte_at() does not do the right thing when putting down
HWPOISON swap entries for hugepages on architectures that support
contiguous ptes.

Fix this problem by using set_huge_swap_pte_at() which was introduced to
fix exactly this problem.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
---
 mm/rmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index d405f0e0ee96..feb2352aa95f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1379,15 +1379,18 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		update_hiwater_rss(mm);
 
 		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
+			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (PageHuge(page)) {
 				int nr = 1 << compound_order(page);
 				hugetlb_count_sub(nr, mm);
+				set_huge_swap_pte_at(mm, address,
+						     pvmw.pte, pteval,
+						     vma_mmu_pagesize(vma));
 			} else {
 				dec_mm_counter(mm, mm_counter(page));
+				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
-			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
-			set_pte_at(mm, address, pvmw.pte, pteval);
 		} else if (pte_unused(pteval)) {
 			/*
 			 * The guest indicated that the page content is of no
-- 
2.11.0
