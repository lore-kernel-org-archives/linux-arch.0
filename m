Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61836 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933665Ab3CZQI7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Mar 2013 12:08:59 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1348383pbc.31
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2013 09:08:58 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3, part4 31/39] mm/SH: prepare for removing num_physpages and simplify mem_init()
Date: Tue, 26 Mar 2013 23:54:50 +0800
Message-ID: <1364313298-17336-32-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1364313298-17336-1-git-send-email-jiang.liu@huawei.com>
References: <1364313298-17336-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tang Chen <tangchen@cn.fujitsu.com>, linux-sh@vger.kernel.org
Message-ID: <20130326155450.qiBwWD2WnFPWLibO16JGDhsJPLNLEHH5bZ5uzvTDIME@z>

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Wen Congyang <wency@cn.fujitsu.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Hi all,
	Sorry for my mistake that my previous patch series has been screwed up.
So I regenerate a third version and also set up a git tree at:
	git://github.com/jiangliu/linux.git mem_init
	Any help to review and test are welcomed!

	Regards!
	Gerry
---
 arch/sh/mm/init.c |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index aecd913..3826596 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -407,24 +407,18 @@ unsigned int mem_init_done = 0;
 
 void __init mem_init(void)
 {
-	int codesize, datasize, initsize;
-	int nid;
+	pg_data_t *pgdat;
 
 	iommu_init();
 
-	num_physpages = 0;
 	high_memory = NULL;
 
-	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
+	for_each_online_pgdat(pgdat) {
 		void *node_high_memory;
 
-		num_physpages += pgdat->node_present_pages;
-
 		if (pgdat->node_spanned_pages)
 			free_all_bootmem_node(pgdat);
 
-
 		node_high_memory = (void *)__va((pgdat->node_start_pfn +
 						 pgdat->node_spanned_pages) <<
 						 PAGE_SHIFT);
@@ -441,19 +435,8 @@ void __init mem_init(void)
 
 	vsyscall_init();
 
-	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
-	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
-	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
-
-	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, "
-	       "%dk data, %dk init)\n",
-		nr_free_pages() << (PAGE_SHIFT-10),
-		num_physpages << (PAGE_SHIFT-10),
-		codesize >> 10,
-		datasize >> 10,
-		initsize >> 10);
-
-	printk(KERN_INFO "virtual kernel memory layout:\n"
+	mem_init_print_info(NULL);
+	pr_info("virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #ifdef CONFIG_HIGHMEM
 		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-- 
1.7.9.5

