From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 10/20] m68knommu: use generic show_mem()
Date: Fri, 27 Jun 2008 13:53:59 +0200
Message-ID: <20080627120049.269621765@saeurebad.de>
References: <20080627115349.743368154@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:39023 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760593AbYF0MGC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 08:06:02 -0400
Content-Disposition: inline; filename=0011-m68knommu-use-generic-show_mem.patch
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
 arch/m68knommu/Kconfig   |    1 +
 arch/m68knommu/mm/init.c |   27 ---------------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -9,6 +9,7 @@ config M68K
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_GENERIC_SHOW_MEM
 
 config MMU
 	bool
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
