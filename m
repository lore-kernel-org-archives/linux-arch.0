From: Prasad Joshi <prasadjoshi124@gmail.com>
Subject: [RFC][PATCH v2 10/23] (mips) __vmalloc: add gfp flags variant of pte
 and pmd allocation
Date: Mon, 14 Mar 2011 17:46:21 +0000
Message-ID: <AANLkTin2c2wTpqBNF_ZjmeTex9m5+3h6vhH7=jD1JX0K__5587.02103230662$1300124791$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33574 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1CNRqW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2011 13:46:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Prasad Joshi <prasadjoshi124@gmail.com>, Anand Mitra <mitra@kqinfotech.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@v

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/mips/include/asm/pgalloc.h |   22 +++++++++++++++-------
1 files changed, 15 insertions(+), 7 deletions(-)
---
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 881d18b..f2c5439 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -64,14 +64,16 @@ static inline void pgd_free(struct mm_struct *mm,
pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }

+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm,
+	unsigned long address, gfp_t gfp_mask)
+{
+	return (pte_t *) __get_free_pages(gfp_mask | __GFP_ZERO, PTE_ORDER);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO,
PTE_ORDER);
-
-	return pte;
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }

 static inline struct page *pte_alloc_one(struct mm_struct *mm,
@@ -106,16 +108,22 @@ do {							\

 #ifndef __PAGETABLE_PMD_FOLDED

-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
 {
 	pmd_t *pmd;

-	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PMD_ORDER);
+	pmd = (pmd_t *) __get_free_pages(gfp_mask, PMD_ORDER);
 	if (pmd)
 		pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
 	return pmd;
 }

+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	return __pmd_alloc_one(mm, address, GFP_KERNEL | __GFP_REPEAT);
+}
+
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	free_pages((unsigned long)pmd, PMD_ORDER);
