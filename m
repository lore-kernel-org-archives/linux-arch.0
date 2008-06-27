From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 09/20] m68k: use generic show_mem()
Date: Fri, 27 Jun 2008 13:53:58 +0200
Message-ID: <20080627120049.118036361@saeurebad.de>
References: <20080627115349.743368154@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:39019 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759987AbYF0MF4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 08:05:56 -0400
Content-Disposition: inline; filename=0010-m68k-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- free pages, printed by show_free_areas()
	- pages in swapcache, printed by show_swap_cache_info()

where show_mem() calls show_free_areas(), which calls
show_swap_cache_info().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig   |    1 +
 arch/m68k/mm/init.c |   30 ------------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -6,6 +6,7 @@ config M68K
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_GENERIC_SHOW_MEM
 
 config MMU
 	bool
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -69,36 +69,6 @@ void __init m68k_setup_node(int node)
 void *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
-void show_mem(void)
-{
-	pg_data_t *pgdat;
-	int free = 0, total = 0, reserved = 0, shared = 0;
-	int cached = 0;
-	int i;
-
-	printk("\nMem-info:\n");
-	show_free_areas();
-	for_each_online_pgdat(pgdat) {
-		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			struct page *page = pgdat->node_mem_map + i;
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
-	}
-	printk("%d pages of RAM\n",total);
-	printk("%d free pages\n",free);
-	printk("%d reserved pages\n",reserved);
-	printk("%d pages shared\n",shared);
-	printk("%d pages swap cached\n",cached);
-}
-
 extern void init_pointer_table(unsigned long ptable);
 
 /* References to section boundaries */

-- 
