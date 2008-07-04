From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 16/20] m68knommu: use generic show_mem()
Date: Fri, 04 Jul 2008 18:07:53 +0200
Message-ID: <20080704161457.056057813@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38572 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759885AbYGDQwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:52:04 -0400
Content-Disposition: inline; filename=m68knommu-use-generic-show_mem.patch
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
 arch/m68knommu/mm/init.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

--- a/arch/m68knommu/mm/init.c
+++ b/arch/m68knommu/mm/init.c
@@ -62,33 +62,6 @@ static unsigned long empty_bad_page;
 
 unsigned long empty_zero_page;
 
-void show_mem(void)
-{
-    unsigned long i;
-    int free = 0, total = 0, reserved = 0, shared = 0;
-    int cached = 0;
-
-    printk(KERN_INFO "\nMem-info:\n");
-    show_free_areas();
-    i = max_mapnr;
-    while (i-- > 0) {
-	total++;
-	if (PageReserved(mem_map+i))
-	    reserved++;
-	else if (PageSwapCache(mem_map+i))
-	    cached++;
-	else if (!page_count(mem_map+i))
-	    free++;
-	else
-	    shared += page_count(mem_map+i) - 1;
-    }
-    printk(KERN_INFO "%d pages of RAM\n",total);
-    printk(KERN_INFO "%d free pages\n",free);
-    printk(KERN_INFO "%d reserved pages\n",reserved);
-    printk(KERN_INFO "%d pages shared\n",shared);
-    printk(KERN_INFO "%d pages swap cached\n",cached);
-}
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 

-- 
