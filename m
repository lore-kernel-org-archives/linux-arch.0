Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34196 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbcD1NYU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 09:24:20 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 08/20] nios2: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:54 +0200
Message-ID: <1461849846-27209-9-git-send-email-mhocko@kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org
Message-ID: <20160428132354.BHNAUOVwRrKyQSHige1CkcchvkkNJhUSc53cL_DGDRs@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pte_alloc_one{_kernel} allocate PTE_ORDER which is 0. This means that
this flag has never been actually useful here because it has always been
used only for PAGE_ALLOC_COSTLY requests.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/nios2/include/asm/pgalloc.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 6e2985e0a7b9..bb47d08c8ef7 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -42,8 +42,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 {
 	pte_t *pte;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO,
-					PTE_ORDER);
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_ZERO, PTE_ORDER);
 
 	return pte;
 }
@@ -53,7 +52,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 {
 	struct page *pte;
 
-	pte = alloc_pages(GFP_KERNEL | __GFP_REPEAT, PTE_ORDER);
+	pte = alloc_pages(GFP_KERNEL, PTE_ORDER);
 	if (pte) {
 		if (!pgtable_page_ctor(pte)) {
 			__free_page(pte);
-- 
2.8.0.rc3

