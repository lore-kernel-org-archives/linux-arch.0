Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33562 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbcE3JPN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2016 05:15:13 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 06/17] arc: get rid of superfluous __GFP_REPEAT
Date: Mon, 30 May 2016 11:14:48 +0200
Message-ID: <1464599699-30131-7-git-send-email-mhocko@kernel.org>
In-Reply-To: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
References: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org
Message-ID: <20160530091448.at1bquJRwqTNDarKT5Q5lu4H4xD1qEt_H9LBOsjt-tY@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pte_alloc_one_kernel uses __get_order_pte but this is obviously
always zero because BITS_FOR_PTE is not larger than 9 yet the page
size is always larger than 4K.  This means that this flag has never
been actually useful here because it has always been used only for
PAGE_ALLOC_COSTLY requests.

Cc: linux-arch@vger.kernel.org
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/arc/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 86ed671286df..3749234b7419 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -95,7 +95,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 {
 	pte_t *pte;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO,
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					 __get_order_pte());
 
 	return pte;
@@ -107,7 +107,7 @@ pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	pgtable_t pte_pg;
 	struct page *page;
 
-	pte_pg = (pgtable_t)__get_free_pages(GFP_KERNEL | __GFP_REPEAT, __get_order_pte());
+	pte_pg = (pgtable_t)__get_free_pages(GFP_KERNEL, __get_order_pte());
 	if (!pte_pg)
 		return 0;
 	memzero((void *)pte_pg, PTRS_PER_PTE * sizeof(pte_t));
-- 
2.8.1

