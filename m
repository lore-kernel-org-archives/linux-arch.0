Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57066 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966350Ab3E2N6q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 09:58:46 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v6, part4 10/41] mm/hotplug: prepare for removing num_physpages
Date: Wed, 29 May 2013 21:57:28 +0800
Message-ID: <1369835879-23553-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369835879-23553-1-git-send-email-jiang.liu@huawei.com>
References: <1369835879-23553-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Message-ID: <20130529135728.EALIVV0ImhG5DpttH1sVmNft7KnRHLkj2rI1ATVcURk@z>

Prepare for removing num_physpages.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Wen Congyang <wency@cn.fujitsu.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memory_hotplug.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7244e67..8acc4ab 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -763,10 +763,6 @@ EXPORT_SYMBOL_GPL(restore_online_page_callback);
 
 void __online_page_set_limits(struct page *page)
 {
-	unsigned long pfn = page_to_pfn(page);
-
-	if (pfn >= num_physpages)
-		num_physpages = pfn + 1;
 }
 EXPORT_SYMBOL_GPL(__online_page_set_limits);
 
-- 
1.8.1.2

