Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34105 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbcE3JPS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2016 05:15:18 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 13/17] s390: get rid of superfluous __GFP_REPEAT
Date: Mon, 30 May 2016 11:14:55 +0200
Message-ID: <1464599699-30131-14-git-send-email-mhocko@kernel.org>
In-Reply-To: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
References: <1464599699-30131-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
Message-ID: <20160530091455.FbATkmhvsA8FNWr3anwZ09tMdEVxPQzHPYvtt9fumJo@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

page_table_alloc then uses the flag for a single page allocation. This
means that this flag has never been actually useful here because it has
always been used only for PAGE_ALLOC_COSTLY requests.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/s390/mm/pgalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index e8b5962ac12a..e2565d2d0c32 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -169,7 +169,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			return table;
 	}
 	/* Allocate a fresh page */
-	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+	page = alloc_page(GFP_KERNEL);
 	if (!page)
 		return NULL;
 	if (!pgtable_page_ctor(page)) {
-- 
2.8.1

