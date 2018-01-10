From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/22] ia64: replace ZONE_DMA with ZONE_DMA32
Date: Wed, 10 Jan 2018 09:09:22 +0100
Message-ID: <20180110080932.14157-13-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

ia64 uses ZONE_DMA for allocations below 32-bits.  These days we
name the zone for that ZONE_DMA32, which will allow to use the
dma-direct and generic swiotlb code as-is, so rename it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/Kconfig              | 2 +-
 arch/ia64/kernel/pci-swiotlb.c | 2 +-
 arch/ia64/mm/contig.c          | 4 ++--
 arch/ia64/mm/discontig.c       | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 4d18fca885ee..888acdb163cb 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -66,7 +66,7 @@ config 64BIT
 	select ATA_NONSTANDARD if ATA
 	default y
 
-config ZONE_DMA
+config ZONE_DMA32
 	def_bool y
 	depends on !IA64_SGI_SN2
 
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index f1ae873a8c35..4a9a6e58ad6a 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -20,7 +20,7 @@ static void *ia64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					 unsigned long attrs)
 {
 	if (dev->coherent_dma_mask != DMA_BIT_MASK(64))
-		gfp |= GFP_DMA;
+		gfp |= GFP_DMA32;
 	return swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
 }
 
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 52715a71aede..7d64b30913d1 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -237,9 +237,9 @@ paging_init (void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	max_zone_pfns[ZONE_DMA] = max_dma;
+	max_zone_pfns[ZONE_DMA32] = max_dma;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 9b2d994cddf6..ac46f0d60b66 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -38,7 +38,7 @@ struct early_node_data {
 	struct ia64_node_data *node_data;
 	unsigned long pernode_addr;
 	unsigned long pernode_size;
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	unsigned long num_dma_physpages;
 #endif
 	unsigned long min_pfn;
@@ -669,7 +669,7 @@ static __init int count_node_pages(unsigned long start, unsigned long len, int n
 {
 	unsigned long end = start + len;
 
-#ifdef CONFIG_ZONE_DMA
+#ifdef CONFIG_ZONE_DMA32
 	if (start <= __pa(MAX_DMA_ADDRESS))
 		mem_data[node].num_dma_physpages +=
 			(min(end, __pa(MAX_DMA_ADDRESS)) - start) >>PAGE_SHIFT;
@@ -724,8 +724,8 @@ void __init paging_init(void)
 	}
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA] = max_dma;
+#ifdef CONFIG_ZONE_DMA32
+	max_zone_pfns[ZONE_DMA32] = max_dma;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 	free_area_init_nodes(max_zone_pfns);
-- 
2.14.2
