From: Johannes Weiner <hannes@saeurebad.de>
Subject: [PATCH 01/20] mm: print swapcache page count in show_swap_cache_info()
Date: Fri, 04 Jul 2008 18:07:38 +0200
Message-ID: <20080704161452.426549011@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:38512 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758604AbYGDQvB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jul 2008 12:51:01 -0400
Content-Disposition: inline; filename=mm-show-swapcache-pages-in-show_swap_cache_info.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Most show_mem() implementations calculate the amount of pages within
the swapcache every time.  Move the output to a more appropriate place
and use the anyway available total_swapcache_pages variable.

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
---
 mm/swap_state.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -56,7 +56,8 @@ static struct {
 
 void show_swap_cache_info(void)
 {
-	printk("Swap cache: add %lu, delete %lu, find %lu/%lu\n",
+	printk("%lu pages in swap cache\n", total_swapcache_pages);
+	printk("Swap cache stats: add %lu, delete %lu, find %lu/%lu\n",
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total);
 	printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));

-- 
