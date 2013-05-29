Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44808 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966235Ab3E2Opi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 10:45:38 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH, v2 07/13] mm/MIPS: prepare for killing free_all_bootmem_node()
Date: Wed, 29 May 2013 22:44:46 +0800
Message-ID: <1369838692-26860-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
References: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <20130529144446.J6009sxIlqD3gB0Qv5p_8pOJpXk0-9f6tE_7tTTcNHw@z>

Prepare for killing free_all_bootmem_node() by using
free_all_bootmem().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/sgi-ip27/ip27-memory.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index a0c9e34..a95c00f 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -477,18 +477,8 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	unsigned node;
-
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-
-	for_each_online_node(node) {
-		/*
-		 * This will free up the bootmem, ie, slot 0 memory.
-		 */
-		free_all_bootmem_node(NODE_DATA(node));
-	}
-
+	free_all_bootmem();
 	setup_zero_pages();	/* This comes from node 0 */
-
 	mem_init_print_info(NULL);
 }
-- 
1.8.1.2

