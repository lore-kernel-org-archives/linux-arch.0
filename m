Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41024 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423252Ab3DFOpd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Apr 2013 10:45:33 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v4, part3 25/41] mm/metag: prepare for removing num_physpages and simplify mem_init()
Date: Sat,  6 Apr 2013 22:32:24 +0800
Message-ID: <1365258760-30821-26-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130406143224.DOpwsdS_5-7pY8auh6pGdFFti_LnxKg_JQtUodQTY3A@z>

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/metag/mm/init.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/metag/mm/init.c b/arch/metag/mm/init.c
index 279d701..e00586f 100644
--- a/arch/metag/mm/init.c
+++ b/arch/metag/mm/init.c
@@ -388,22 +388,16 @@ void __init mem_init(void)
 	reset_all_zones_managed_pages();
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++)
 		free_highmem_page(pfn_to_page(tmp));
-	num_physpages += totalhigh_pages;
 #endif /* CONFIG_HIGHMEM */
 
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
 
-		num_physpages += pgdat->node_present_pages;
-
 		if (pgdat->node_spanned_pages)
 			free_all_bootmem_node(pgdat);
 	}
 
-	pr_info("Memory: %luk/%luk available\n",
-		(unsigned long)nr_free_pages() << (PAGE_SHIFT - 10),
-		num_physpages << (PAGE_SHIFT - 10));
-
+	mem_init_print_info(NULL);
 	show_mem(0);
 
 	return;
-- 
1.7.9.5

