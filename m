From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 11/20] s390: use generic show_mem()
Date: Fri, 04 Jul 2008 18:07:48 +0200
Message-ID: <20080704161455.557529499@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38555 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582AbYGDQvo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:51:44 -0400
Content-Disposition: inline; filename=s390-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- pages in swapcache, printed by show_swap_cache_info()

where show_mem() calls show_free_areas(), which calls
show_swap_cache_info().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/mm/init.c |   32 --------------------------------
 1 file changed, 32 deletions(-)

--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -42,38 +42,6 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
-void show_mem(void)
-{
-	unsigned long i, total = 0, reserved = 0;
-	unsigned long shared = 0, cached = 0;
-	unsigned long flags;
-	struct page *page;
-	pg_data_t *pgdat;
-
-	printk("Mem-info:\n");
-	show_free_areas();
-	for_each_online_pgdat(pgdat) {
-		pgdat_resize_lock(pgdat, &flags);
-		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			if (!pfn_valid(pgdat->node_start_pfn + i))
-				continue;
-			page = pfn_to_page(pgdat->node_start_pfn + i);
-			total++;
-			if (PageReserved(page))
-				reserved++;
-			else if (PageSwapCache(page))
-				cached++;
-			else if (page_count(page))
-				shared += page_count(page) - 1;
-		}
-		pgdat_resize_unlock(pgdat, &flags);
-	}
-	printk("%ld pages of RAM\n", total);
-	printk("%ld reserved pages\n", reserved);
-	printk("%ld pages shared\n", shared);
-	printk("%ld pages swap cached\n", cached);
-}
-
 /*
  * paging_init() sets up the page tables
  */

-- 
