Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40354 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1CNRsc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2011 13:48:32 -0400
MIME-Version: 1.0
Date: Mon, 14 Mar 2011 17:48:31 +0000
Message-ID: <AANLkTikbco0iTe05iD4S+=Tsoi=k=STU-2aiv7+EDF9j@mail.gmail.com>
Subject: [RFC][PATCH v2 11/23] (mn10300) __vmalloc: add gfp flags variant of
 pte and pmd allocation
From: Prasad Joshi <prasadjoshi124@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Prasad Joshi <prasadjoshi124@gmail.com>, Anand Mitra <mitra@kqinfotech.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20110314174831.4Fu-nwP4kdcr4KIQwZhLtqqTSFHJt_fhCVCybRSqeoU@z>

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/mn10300/include/asm/pgalloc.h |    2 ++
arch/mn10300/mm/pgtable.c          |   10 ++++++++--
2 files changed, 10 insertions(+), 2 deletions(-)
---
diff --git a/arch/mn10300/include/asm/pgalloc.h
b/arch/mn10300/include/asm/pgalloc.h
index 146bacf..35150ae 100644
--- a/arch/mn10300/include/asm/pgalloc.h
+++ b/arch/mn10300/include/asm/pgalloc.h
@@ -37,6 +37,8 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *, pgd_t *);

 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
+extern pte_t *__pte_alloc_one_kernel(struct mm_struct *, unsigned long, gfp_t);
+
 extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);

 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/mn10300/mm/pgtable.c b/arch/mn10300/mm/pgtable.c
index 450f7ba..05077b4 100644
--- a/arch/mn10300/mm/pgtable.c
+++ b/arch/mn10300/mm/pgtable.c
@@ -62,14 +62,20 @@ void set_pmd_pfn(unsigned long vaddr, unsigned
long pfn, pgprot_t flags)
 	local_flush_tlb_one(vaddr);
 }

-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t *__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address,
+		gfp_t gfp_mask)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte_t *pte = (pte_t *)__get_free_page(gfp_mask);
 	if (pte)
 		clear_page(pte);
 	return pte;
 }

+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
+}
+
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
