Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38889 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbcD1NYZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 09:24:25 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 15/20] tile: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:24:01 +0200
Message-ID: <1461849846-27209-16-git-send-email-mhocko@kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Chris Metcalf <cmetcalf@mellanox.com>, linux-arch@vger.kernel.org
Message-ID: <20160428132401.hoko6x-82vc4_OUoKzVOD0_wb2hdh5jmHuJ_fuE04tY@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pgtable_alloc_one uses __GFP_REPEAT flag for L2_USER_PGTABLE_ORDER but
the order is either 0 or 3 if L2_KERNEL_PGTABLE_SHIFT for HPAGE_SHIFT.
This means that this flag has never been actually useful here because it
has always been used only for PAGE_ALLOC_COSTLY requests.

Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/tile/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
index 7bf2491a9c1f..c4d5bf841a7f 100644
--- a/arch/tile/mm/pgtable.c
+++ b/arch/tile/mm/pgtable.c
@@ -231,7 +231,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 struct page *pgtable_alloc_one(struct mm_struct *mm, unsigned long address,
 			       int order)
 {
-	gfp_t flags = GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO;
+	gfp_t flags = GFP_KERNEL|__GFP_ZERO;
 	struct page *p;
 	int i;
 
-- 
2.8.0.rc3

