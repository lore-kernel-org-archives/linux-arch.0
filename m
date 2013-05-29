Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37256 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966521Ab3E2Opq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 10:45:46 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH, v2 09/13] mm/PPC: prepare for killing free_all_bootmem_node()
Date: Wed, 29 May 2013 22:44:48 +0800
Message-ID: <1369838692-26860-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
References: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20130529144448.aQtmZ2iwYAVRMlEvKdVtvDk8irw5MFrVySmWlX9M7bI@z>

Prepare for killing free_all_bootmem_node() by using
free_all_bootmem().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/mm/mem.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 49c18b6..1cb1ea1 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -304,22 +304,8 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	{
-		pg_data_t *pgdat;
-
-		for_each_online_pgdat(pgdat)
-			if (pgdat->node_spanned_pages != 0) {
-				printk("freeing bootmem node %d\n",
-					pgdat->node_id);
-				free_all_bootmem_node(pgdat);
-			}
-	}
-#else
-	max_mapnr = max_pfn;
+	set_max_mapnr(max_pfn);
 	free_all_bootmem();
-#endif
 
 #ifdef CONFIG_HIGHMEM
 	{
-- 
1.8.1.2

