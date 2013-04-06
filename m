From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v4,
 part3 14/41] mm/ARM64: prepare for removing num_physpages and
 simplify mem_init()
Date: Sat,  6 Apr 2013 22:32:13 +0800
Message-ID: <1365258760-30821-15-git-send-email-jiang.liu@huawei.com>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, David Howells <dhowells@redhat.com>, Russell King <linux@arm.linux.org.uk>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Jianguo Wu <wujianguo@huawei.com>
List-Id: linux-arch.vger.kernel.org

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/mm/init.c |   48 +++---------------------------------------------
 1 file changed, 3 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0f2cf5d..821e788 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -272,59 +272,17 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
-	unsigned long reserved_pages, free_pages;
-	struct memblock_region *reg;
-
 	arm64_swiotlb_init();
 
 	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-	/* this will put all unused low memory onto the freelists */
 	free_unused_memmap();
 #endif
-
+	/* this will put all unused low memory onto the freelists */
 	free_all_bootmem();
 
-	reserved_pages = free_pages = 0;
-
-	for_each_memblock(memory, reg) {
-		unsigned int pfn1, pfn2;
-		struct page *page, *end;
-
-		pfn1 = __phys_to_pfn(reg->base);
-		pfn2 = pfn1 + __phys_to_pfn(reg->size);
-
-		page = pfn_to_page(pfn1);
-		end  = pfn_to_page(pfn2 - 1) + 1;
-
-		do {
-			if (PageReserved(page))
-				reserved_pages++;
-			else if (!page_count(page))
-				free_pages++;
-			page++;
-		} while (page < end);
-	}
-
-	/*
-	 * Since our memory may not be contiguous, calculate the real number
-	 * of pages we have in this system.
-	 */
-	pr_info("Memory:");
-	num_physpages = 0;
-	for_each_memblock(memory, reg) {
-		unsigned long pages = memblock_region_memory_end_pfn(reg) -
-			memblock_region_memory_base_pfn(reg);
-		num_physpages += pages;
-		printk(" %ldMB", pages >> (20 - PAGE_SHIFT));
-	}
-	printk(" = %luMB total\n", num_physpages >> (20 - PAGE_SHIFT));
-
-	pr_notice("Memory: %luk/%luk available, %luk reserved\n",
-		  nr_free_pages() << (PAGE_SHIFT-10),
-		  free_pages << (PAGE_SHIFT-10),
-		  reserved_pages << (PAGE_SHIFT-10));
+	mem_init_print_info();
 
 #define MLK(b, t) b, t, ((t) - (b)) >> 10
 #define MLM(b, t) b, t, ((t) - (b)) >> 20
@@ -366,7 +324,7 @@ void __init mem_init(void)
 	BUILD_BUG_ON(TASK_SIZE_64			> MODULES_VADDR);
 	BUG_ON(TASK_SIZE_64				> MODULES_VADDR);
 
-	if (PAGE_SIZE >= 16384 && num_physpages <= 128) {
+	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
 		/*
 		 * On a machine this small we won't get anywhere without
-- 
1.7.9.5
