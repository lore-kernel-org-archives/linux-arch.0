From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 05/23] mips/jazz: remove the mapping_error dma_map_ops method
Date: Fri, 30 Nov 2018 14:22:13 +0100
Message-ID: <20181130132231.16512-6-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181130132231.16512-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

The Jazz iommu code already returns (~(dma_addr_t)0x0) on mapping
failures, so we can switch over to returning DMA_MAPPING_ERROR and
let the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/include/asm/jazzdma.h |  6 ------
 arch/mips/jazz/jazzdma.c        | 16 +++++-----------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/jazzdma.h b/arch/mips/include/asm/jazzdma.h
index d913439c738c..d13f940022d5 100644
--- a/arch/mips/include/asm/jazzdma.h
+++ b/arch/mips/include/asm/jazzdma.h
@@ -39,12 +39,6 @@ extern int vdma_get_enable(int channel);
 #define VDMA_PAGE(a)		((unsigned int)(a) >> 12)
 #define VDMA_OFFSET(a)		((unsigned int)(a) & (VDMA_PAGESIZE-1))
 
-/*
- * error code returned by vdma_alloc()
- * (See also arch/mips/kernel/jazzdma.c)
- */
-#define VDMA_ERROR		0xffffffff
-
 /*
  * VDMA pagetable entry description
  */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 4c41ed0a637e..6256d35dbf4d 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -104,12 +104,12 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid physical address: %08lx\n",
 			       paddr);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 	if (size > 0x400000 || size == 0) {
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid size: %08lx\n", size);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 
 	spin_lock_irqsave(&vdma_lock, flags);
@@ -123,7 +123,7 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		       first < VDMA_PGTBL_ENTRIES) first++;
 		if (first + pages > VDMA_PGTBL_ENTRIES) {	/* nothing free */
 			spin_unlock_irqrestore(&vdma_lock, flags);
-			return VDMA_ERROR;
+			return DMA_MAPPING_ERROR;
 		}
 
 		last = first + 1;
@@ -569,7 +569,7 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 
 	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == VDMA_ERROR) {
+	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
 		return NULL;
 	}
@@ -620,7 +620,7 @@ static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
 				dir);
 		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
-		if (sg->dma_address == VDMA_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR)
 			return 0;
 		sg_dma_len(sg) = sg->length;
 	}
@@ -674,11 +674,6 @@ static void jazz_dma_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
 }
 
-static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == VDMA_ERROR;
-}
-
 const struct dma_map_ops jazz_dma_ops = {
 	.alloc			= jazz_dma_alloc,
 	.free			= jazz_dma_free,
@@ -692,6 +687,5 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
 	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
-	.mapping_error		= jazz_dma_mapping_error,
 };
 EXPORT_SYMBOL(jazz_dma_ops);
-- 
2.19.1
