From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 19/20] frv: use generic show_mem()
Date: Fri, 04 Jul 2008 18:07:56 +0200
Message-ID: <20080704161457.953788873@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38583 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901AbYGDQwR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:52:17 -0400
Content-Disposition: inline; filename=frv-use-generic-show_mem.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>

Remove arch-specific show_mem() in favor of the generic version.

This also removes the following redundant information display:

	- free pages, printed by show_free_areas()

where show_mem() calls show_free_areas().

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
Acked-by: David Howells <dhowells@redhat.com>
---
 arch/frv/mm/init.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -63,37 +63,6 @@ EXPORT_SYMBOL(empty_zero_page);
 
 /*****************************************************************************/
 /*
- *
- */
-void show_mem(void)
-{
-	unsigned long i;
-	int free = 0, total = 0, reserved = 0, shared = 0;
-
-	printk("\nMem-info:\n");
-	show_free_areas();
-	i = max_mapnr;
-	while (i-- > 0) {
-		struct page *page = &mem_map[i];
-
-		total++;
-		if (PageReserved(page))
-			reserved++;
-		else if (!page_count(page))
-			free++;
-		else
-			shared += page_count(page) - 1;
-	}
-
-	printk("%d pages of RAM\n",total);
-	printk("%d free pages\n",free);
-	printk("%d reserved pages\n",reserved);
-	printk("%d pages shared\n",shared);
-
-} /* end show_mem() */
-
-/*****************************************************************************/
-/*
  * paging_init() continues the virtual memory environment setup which
  * was begun by the code in arch/head.S.
  * The parameters are pointers to where to stick the starting and ending

-- 
