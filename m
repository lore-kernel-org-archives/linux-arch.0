Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35261 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbcD1NYX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 09:24:23 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 13/20] s390: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:59 +0200
Message-ID: <1461849846-27209-14-git-send-email-mhocko@kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160428132359.odbIjbe8UbMOK9Kdy-uL3wEvZbA0fq0XFfo4uQBGPJk@z>

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
index f6c3de26cda8..3f716741797a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -198,7 +198,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			return table;
 	}
 	/* Allocate a fresh page */
-	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+	page = alloc_page(GFP_KERNEL);
 	if (!page)
 		return NULL;
 	if (!pgtable_page_ctor(page)) {
-- 
2.8.0.rc3

