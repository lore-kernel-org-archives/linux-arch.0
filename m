From: Prasad Joshi <prasadjoshi124@gmail.com>
Subject: [RFC][PATCH v2 02/23] (armho) __vmalloc: add gfp flags variant of pte
 and pmd allocation
Date: Mon, 14 Mar 2011 17:29:41 +0000
Message-ID: <AANLkTikpM6RRNoT1nPk0Jws3SKff81wJRbJUnJAi3J=3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45705 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1CNR3n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2011 13:29:43 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/arm/include/asm/pgalloc.h |   11 +++++++++--
1 files changed, 9 insertions(+), 2 deletions(-)
---
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 22de005..0696068 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -28,6 +28,7 @@
 /*
  * Since we have only two-level page tables, these are trivial
  */
+#define __pmd_alloc_one(mm,addr,mask)	({ BUG(); ((pmd_t *)2); })
 #define pmd_alloc_one(mm,addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(mm, pmd)		do { } while (0)
 #define pgd_populate(mm,pmd,pte)	BUG()
@@ -59,17 +60,23 @@ static inline void clean_pte_table(pte_t *pte)
  *  +------------+
  */
 static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr,
gfp_t gfp_mask)
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
+	pte = (pte_t *)__get_free_page(gfp_mask | __GFP_NOTRACK | __GFP_ZERO);
 	if (pte)
 		clean_pte_table(pte);

 	return pte;
 }

+static inline pte_t *
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+{
+	return __pte_alloc_one_kernel(mm, addr, GFP_KERNEL | __GFP_REPEAT);
+}
+
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
