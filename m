From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 28/33] powerpc/dma: use phys_to_dma instead of get_dma_offset
Date: Tue,  9 Oct 2018 15:24:55 +0200
Message-ID: <20181009132500.17643-29-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Use the standard portable helper instead of the powerpc specific one,
which is about to go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma-swiotlb.c |  2 +-
 arch/powerpc/kernel/dma.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index dba216dd70fd..d33caff8c684 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -11,7 +11,7 @@
  *
  */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/of_platform.h>
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 795afe387c91..7f7f3a069b63 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-debug.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
@@ -42,7 +42,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 int dma_nommu_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PPC64
-	u64 limit = get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
+	u64 limit = phys_to_dma(dev, (memblock_end_of_DRAM() - 1));
 
 	/* Limit fits in the mask, we are good */
 	if (mask >= limit)
@@ -100,7 +100,7 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = __pa(ret) + get_dma_offset(dev);
+	*dma_handle = phys_to_dma(dev,__pa(ret));
 
 	return ret;
 }
@@ -139,7 +139,7 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) + get_dma_offset(dev);
+		sg->dma_address = phys_to_dma(dev, sg_phys(sg));
 		sg->dma_length = sg->length;
 
 		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
@@ -158,7 +158,7 @@ dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync_page(page, offset, size, dir);
 
-	return page_to_phys(page) + offset + get_dma_offset(dev);
+	return phys_to_dma(dev, page_to_phys(page)) + offset;
 }
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
-- 
2.19.0
