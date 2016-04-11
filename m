Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33571 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbcDKLIm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2016 07:08:42 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 07/19] mips: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 13:08:00 +0200
Message-ID: <1460372892-8157-8-git-send-email-mhocko@kernel.org>
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, John Crispin <blogic@openwrt.org>, linux-arch@vger.kernel.org
Message-ID: <20160411110800.g6UnNPb2s2XATj4cWBMt6828qRKNqEDEaLEZRmcIO04@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pte_alloc_one{_kernel}, pmd_alloc_one allocate PTE_ORDER resp. PMD_ORDER
but both are not larger than 1. This means that this flag has never
been actually useful here because it has always been used only for
PAGE_ALLOC_COSTLY requests.

Cc: John Crispin <blogic@openwrt.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/mips/include/asm/pgalloc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index b336037e8768..93c079a1cfc8 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -69,7 +69,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 {
 	pte_t *pte;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_ZERO, PTE_ORDER);
 
 	return pte;
 }
@@ -79,7 +79,7 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
 {
 	struct page *pte;
 
-	pte = alloc_pages(GFP_KERNEL | __GFP_REPEAT, PTE_ORDER);
+	pte = alloc_pages(GFP_KERNEL, PTE_ORDER);
 	if (!pte)
 		return NULL;
 	clear_highpage(pte);
@@ -113,7 +113,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
 
-	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PMD_ORDER);
+	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL, PMD_ORDER);
 	if (pmd)
 		pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
 	return pmd;
-- 
2.8.0.rc3

