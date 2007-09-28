Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51060 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756802AbXI1IBe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Sep 2007 04:01:34 -0400
Message-Id: <20070928080042.020756000@chello.nl>
References: <20070928074200.436463000@chello.nl>
Date: Fri, 28 Sep 2007 09:42:06 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/12] mm: remove raw SetPageLocked() usage
Content-Disposition: inline; filename=lock_page.patch
Sender: linux-arch-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Zach Brown <zach.brown@oracle.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-ID: <linux-arch.vger.kernel.org>

Remove the last few SetPageLocked() instances.

use trylock_page() instead of SetPageLocked() because we hold tree_lock
so we cannot suffer the might_sleep(). Also at least add_to_page_cache() can
be handed a locked page.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/filemap.c    |    2 +-
 mm/swap_state.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -445,7 +445,7 @@ int add_to_page_cache(struct page *page,
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			page_cache_get(page);
-			SetPageLocked(page);
+			trylock_page(page);
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -83,7 +83,7 @@ static int __add_to_swap_cache(struct pa
 						entry.val, page);
 		if (!error) {
 			page_cache_get(page);
-			SetPageLocked(page);
+			trylock_page(page);
 			SetPageSwapCache(page);
 			set_page_private(page, entry.val);
 			total_swapcache_pages++;

--

