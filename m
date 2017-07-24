Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932936AbdGXRd7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jul 2017 13:33:59 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [RFC PATCH 2/2] mm/hugetlb: Support swap entries in huge_pte_offset()
Date: Mon, 24 Jul 2017 18:33:18 +0100
Message-ID: <20170724173318.966-3-punit.agrawal@arm.com>
In-Reply-To: <20170724173318.966-1-punit.agrawal@arm.com>
References: <20170724173318.966-1-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20170724173318.7kGKsPzn1_W8JtOUutwa6oKio3QuBGoIthTRlruc1X8@z>

Although huge_pte_offset() returns NULL when encountering swap page
table entries, the callers of huge_pte_offset() correctly handling swap
entries.

Add support to the huge_pte_offset() to return the swap entries when it
encounters them during the page table walks.

Also update the function documentation to explicitly state this
behaviour. This is to help clarify expectations for architecture
specific implementations of huge_pte_offset().

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 mm/hugetlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 686eb6fa9eb1..72dd1139a8e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4607,8 +4607,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
  * huge_pte_offset() - Walk the page table to resolve the hugepage
  * entry at address @addr
  *
- * Return: Pointer to page table entry (PUD or PMD) for address @addr
- * or NULL if the entry is not present.
+ * Return: Pointer to page table or swap entry (PUD or PMD) for address @addr
+ * or NULL if the entry is p*d_none().
  */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
@@ -4626,15 +4626,17 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		return NULL;
 
 	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
+	if (pud_none(*pud))
 		return NULL;
-	if (pud_huge(*pud))
+	/* hugepage or swap? */
+	if (pud_huge(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
+	if (pmd_none(*pmd))
 		return NULL;
-	if (pmd_huge(*pmd))
+	/* hugepage or swap? */
+	if (pmd_huge(*pmd) || !pmd_present(*pmd))
 		return (pte_t *) pmd;
 
 	return NULL;
-- 
2.11.0
