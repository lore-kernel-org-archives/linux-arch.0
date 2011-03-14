From: Prasad Joshi <prasadjoshi124@gmail.com>
Subject: [RFC][PATCH v2 20/23] (xtensa) __vmalloc: add gfp flags variant of
 pte, pmd, and pud allocation
Date: Mon, 14 Mar 2011 18:07:26 +0000
Message-ID: <AANLkTikenEE4GOHM4VgLEOrQjDXaYW+TRy8RLT9V28mu__21878.9541315802$1300126057$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46826 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1CNSH2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2011 14:07:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>, Prasad Joshi <prasadjoshi124@gmail.com>, Anand Mitra <mitra@kqinfotech.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/xtensa/include/asm/pgalloc.h |    9 ++++++++-
arch/xtensa/mm/pgtable.c          |   11 +++++++++--
2 files changed, 17 insertions(+), 3 deletions(-)
---
diff --git a/arch/xtensa/include/asm/pgalloc.h
b/arch/xtensa/include/asm/pgalloc.h
index 40cf9bc..d5a23ae 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -42,10 +42,17 @@ static inline void pgd_free(struct mm_struct *mm,
pgd_t *pgd)

 extern struct kmem_cache *pgtable_cache;

+static inline pte_t *
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address,
+		gfp_t gfp_mask)
+{
+	return kmem_cache_alloc(pgtable_cache, gfp_mask);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					 unsigned long address)
 {
-	return kmem_cache_alloc(pgtable_cache, GFP_KERNEL|__GFP_REPEAT);
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }

 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
diff --git a/arch/xtensa/mm/pgtable.c b/arch/xtensa/mm/pgtable.c
index 6979927..eff6c1d 100644
--- a/arch/xtensa/mm/pgtable.c
+++ b/arch/xtensa/mm/pgtable.c
@@ -12,13 +12,15 @@

 #if (DCACHE_SIZE > PAGE_SIZE)

-pte_t* pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t*
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address,
+		gfp_t gfp_mask)
 {
 	pte_t *pte = NULL, *p;
 	int color = ADDR_COLOR(address);
 	int i;

-	p = (pte_t*) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, COLOR_ORDER);
+	p = (pte_t*) __get_free_pages(gfp_mask, COLOR_ORDER);

 	if (likely(p)) {
 		split_page(virt_to_page(p), COLOR_ORDER);
@@ -35,6 +37,11 @@ pte_t* pte_alloc_one_kernel(struct mm_struct *mm,
unsigned long address)
 	return pte;
 }

+pte_t* pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
+}
+
 #ifdef PROFILING

 int mask;
