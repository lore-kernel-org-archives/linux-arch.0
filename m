From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v1 12/19] mm/ALPHA: clean up unused VALID_PAGE()
Date: Sat, 13 Apr 2013 23:36:32 +0800
Message-ID: <1365867399-21323-13-git-send-email-jiang.liu@huawei.com>
References: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

VALID_PAGE() has been removed from kernel long time ago, so clean up it.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/alpha/include/asm/mmzone.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
index c5b5d6b..14ce27b 100644
--- a/arch/alpha/include/asm/mmzone.h
+++ b/arch/alpha/include/asm/mmzone.h
@@ -71,8 +71,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, int n)
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
-
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> 32))
 #define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> 32))
 #define pte_pfn(pte)		(pte_val(pte) >> 32)
-- 
1.7.9.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
