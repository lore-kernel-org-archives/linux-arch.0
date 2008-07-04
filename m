From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 09/20] sparc64: use generic show_mem()
Date: Fri, 04 Jul 2008 18:07:46 +0200
Message-ID: <20080704161454.950040842@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38544 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758664AbYGDQvf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:51:35 -0400
Content-Disposition: inline; filename=sparc64-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- free swap pages, printed by show_swap_cache_info()
	- pages in swapcache, printed by show_swap_cache_info()
	- dirty pages, writeback pages, mapped pages, slab pages,
	  pagetables pages, printed by show_free_areas()

where show_mem() calls show_free_areas(), which calls
show_swap_cache_info().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/mm/init.c |   45 ---------------------------------------------
 1 file changed, 45 deletions(-)

--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -392,51 +392,6 @@ void __kprobes flush_icache_range(unsign
 	}
 }
 
-void show_mem(void)
-{
-	unsigned long total = 0, reserved = 0;
-	unsigned long shared = 0, cached = 0;
-	pg_data_t *pgdat;
-
-	printk(KERN_INFO "Mem-info:\n");
-	show_free_areas();
-	printk(KERN_INFO "Free swap:       %6ldkB\n",
-	       nr_swap_pages << (PAGE_SHIFT-10));
-	for_each_online_pgdat(pgdat) {
-		unsigned long i, flags;
-
-		pgdat_resize_lock(pgdat, &flags);
-		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			struct page *page = pgdat_page_nr(pgdat, i);
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
-
-	printk(KERN_INFO "%lu pages of RAM\n", total);
-	printk(KERN_INFO "%lu reserved pages\n", reserved);
-	printk(KERN_INFO "%lu pages shared\n", shared);
-	printk(KERN_INFO "%lu pages swap cached\n", cached);
-
-	printk(KERN_INFO "%lu pages dirty\n",
-	       global_page_state(NR_FILE_DIRTY));
-	printk(KERN_INFO "%lu pages writeback\n",
-	       global_page_state(NR_WRITEBACK));
-	printk(KERN_INFO "%lu pages mapped\n",
-	       global_page_state(NR_FILE_MAPPED));
-	printk(KERN_INFO "%lu pages slab\n",
-		global_page_state(NR_SLAB_RECLAIMABLE) +
-		global_page_state(NR_SLAB_UNRECLAIMABLE));
-	printk(KERN_INFO "%lu pages pagetables\n",
-	       global_page_state(NR_PAGETABLE));
-}
-
 void mmu_info(struct seq_file *m)
 {
 	if (tlb_type == cheetah)

-- 
