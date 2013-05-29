From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH, v2 11/13] mm: kill free_all_bootmem_node()
Date: Wed, 29 May 2013 22:44:50 +0800
Message-ID: <1369838692-26860-12-git-send-email-jiang.liu@huawei.com>
References: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, "David S. Miller" <davem@davemloft.net>, Yinghai Lu <yinghai@kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-arch.vger.kernel.org

Now nobody makes use of free_all_bootmem_node(), kill it.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/bootmem.h |  1 -
 mm/bootmem.c            | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 0e48c32..f1f07d3 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -44,7 +44,6 @@ extern unsigned long init_bootmem_node(pg_data_t *pgdat,
 				       unsigned long endpfn);
 extern unsigned long init_bootmem(unsigned long addr, unsigned long memend);
 
-extern unsigned long free_all_bootmem_node(pg_data_t *pgdat);
 extern unsigned long free_all_bootmem(void);
 extern void reset_all_zones_managed_pages(void);
 
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 58609bb..6ab7744 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -264,24 +264,6 @@ void __init reset_all_zones_managed_pages(void)
 }
 
 /**
- * free_all_bootmem_node - release a node's free pages to the buddy allocator
- * @pgdat: node to be released
- *
- * Returns the number of pages actually released.
- */
-unsigned long __init free_all_bootmem_node(pg_data_t *pgdat)
-{
-	unsigned long pages;
-
-	register_page_bootmem_info_node(pgdat);
-	reset_node_managed_pages(pgdat);
-	pages = free_all_bootmem_core(pgdat->bdata);
-	totalram_pages += pages;
-
-	return pages;
-}
-
-/**
  * free_all_bootmem - release free pages to the buddy allocator
  *
  * Returns the number of pages actually released.
-- 
1.8.1.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
