From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 03/20] alpha: use generic show_mem()
Date: Fri, 04 Jul 2008 18:07:40 +0200
Message-ID: <20080704161453.041546916@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38518 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694AbYGDQvK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:51:10 -0400
Content-Disposition: inline; filename=alpha-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- free pages, printed by show_free_areas()
	- free swap pages, printed by show_swap_cache_info()
	- pages in swapcache, printed by show_swap_cache_info()

where show_mem() calls show_free_areas(), which calls
show_swap_cache_info().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
CC: Richard Henderson <rth@twiddle.net>
---
 arch/alpha/mm/init.c |   30 ------------------------------
 arch/alpha/mm/numa.c |   35 -----------------------------------
 2 files changed, 65 deletions(-)

--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -94,36 +94,6 @@ __bad_page(void)
 	return pte_mkdirty(mk_pte(virt_to_page(EMPTY_PGE), PAGE_SHARED));
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-void
-show_mem(void)
-{
-	long i,free = 0,total = 0,reserved = 0;
-	long shared = 0, cached = 0;
-
-	printk("\nMem-info:\n");
-	show_free_areas();
-	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	i = max_mapnr;
-	while (i-- > 0) {
-		total++;
-		if (PageReserved(mem_map+i))
-			reserved++;
-		else if (PageSwapCache(mem_map+i))
-			cached++;
-		else if (!page_count(mem_map+i))
-			free++;
-		else
-			shared += page_count(mem_map + i) - 1;
-	}
-	printk("%ld pages of RAM\n",total);
-	printk("%ld free pages\n",free);
-	printk("%ld reserved pages\n",reserved);
-	printk("%ld pages shared\n",shared);
-	printk("%ld pages swap cached\n",cached);
-}
-#endif
-
 static inline unsigned long
 load_PCB(struct pcb_struct *pcb)
 {
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -359,38 +359,3 @@ void __init mem_init(void)
 	mem_stress();
 #endif
 }
-
-void
-show_mem(void)
-{
-	long i,free = 0,total = 0,reserved = 0;
-	long shared = 0, cached = 0;
-	int nid;
-
-	printk("\nMem-info:\n");
-	show_free_areas();
-	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	for_each_online_node(nid) {
-		unsigned long flags;
-		pgdat_resize_lock(NODE_DATA(nid), &flags);
-		i = node_spanned_pages(nid);
-		while (i-- > 0) {
-			struct page *page = nid_page_nr(nid, i);
-			total++;
-			if (PageReserved(page))
-				reserved++;
-			else if (PageSwapCache(page))
-				cached++;
-			else if (!page_count(page))
-				free++;
-			else
-				shared += page_count(page) - 1;
-		}
-		pgdat_resize_unlock(NODE_DATA(nid), &flags);
-	}
-	printk("%ld pages of RAM\n",total);
-	printk("%ld free pages\n",free);
-	printk("%ld reserved pages\n",reserved);
-	printk("%ld pages shared\n",shared);
-	printk("%ld pages swap cached\n",cached);
-}

-- 
