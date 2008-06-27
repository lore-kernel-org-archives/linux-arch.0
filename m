From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 06/20] cris: use generic show_mem()
Date: Fri, 27 Jun 2008 13:53:55 +0200
Message-ID: <20080627120048.662712384@saeurebad.de>
References: <20080627115349.743368154@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:39006 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759101AbYF0MFj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 08:05:39 -0400
Content-Disposition: inline; filename=0007-cris-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mikael Starvik <starvik@axis.com>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- free pages, printed by show_free_areas()
	- pages in swapcache, printed by show_swap_cache_info()

where show_mem() calls show_free_areas(), which calls
show_swap_cache_info().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
Acked-by: Mikael Starvik <starvik@axis.com>
---
 arch/cris/Kconfig   |    1 +
 arch/cris/mm/init.c |   30 ------------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -55,6 +55,7 @@ config CRIS
 	bool
 	default y
 	select HAVE_IDE
+	select HAVE_GENERIC_SHOW_MEM
 
 config HZ
 	int
--- a/arch/cris/mm/init.c
+++ b/arch/cris/mm/init.c
@@ -19,36 +19,6 @@ unsigned long empty_zero_page;
 extern char _stext, _edata, _etext; /* From linkerscript */
 extern char __init_begin, __init_end;
 
-void 
-show_mem(void)
-{
-	int i,free = 0,total = 0,cached = 0, reserved = 0, nonshared = 0;
-	int shared = 0;
-
-	printk("\nMem-info:\n");
-	show_free_areas();
-	i = max_mapnr;
-	while (i-- > 0) {
-		total++;
-		if (PageReserved(mem_map+i))
-			reserved++;
-		else if (PageSwapCache(mem_map+i))
-			cached++;
-		else if (!page_count(mem_map+i))
-			free++;
-		else if (page_count(mem_map+i) == 1)
-			nonshared++;
-		else
-			shared += page_count(mem_map+i) - 1;
-	}
-	printk("%d pages of RAM\n",total);
-	printk("%d free pages\n",free);
-	printk("%d reserved pages\n",reserved);
-	printk("%d pages nonshared\n",nonshared);
-	printk("%d pages shared\n",shared);
-	printk("%d pages swap cached\n",cached);
-}
-
 void __init
 mem_init(void)
 {

-- 
