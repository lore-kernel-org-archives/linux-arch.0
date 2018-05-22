Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeEVMFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:10 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/25] nds32: consolidate DMA cache maintainance routines
Date: Tue, 22 May 2018 14:04:13 +0200
Message-ID: <20180522120430.28709-9-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Message-ID: <20180522120413.A2V-_KyBaKQhsnItv2IYql0ysL-dGY2SUYgmtLmM7MU@z>

Make sure all other DMA methods call nds32_dma_sync_single_for_{device,cpu}
to perform cache maintaince, and remove the consisteny_sync helper that
implemented both with entirely separate code based off an argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 140 +++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 79 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index e1bf7206e015..4e6fb4ffd3f7 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -22,11 +22,6 @@
 static pte_t *consistent_pte;
 static DEFINE_RAW_SPINLOCK(consistent_lock);
 
-enum master_type {
-	FOR_CPU = 0,
-	FOR_DEVICE = 1,
-};
-
 /*
  * VM region handling support.
  *
@@ -333,15 +328,53 @@ static int __init consistent_init(void)
 }
 
 core_initcall(consistent_init);
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type);
+
+static void
+nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
+				 size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_wb_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void
+nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+			      size_t size, enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(handle);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cpu_dma_inval_range(start, start + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static dma_addr_t nds32_dma_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
+	dma_addr_t dma_addr = page_to_phys(page) + offset;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync((void *)(page_address(page) + offset), size, dir, FOR_DEVICE);
-	return page_to_phys(page) + offset;
+		nds32_dma_sync_single_for_device(dev, handle, size, dir);
+	return dma_addr;
 }
 
 static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
@@ -349,75 +382,19 @@ static void nds32_dma_unmap_page(struct device *dev, dma_addr_t handle,
 				 unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		consistent_sync(phys_to_virt(handle), size, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, handle, size, dir);
 }
 
-/*
- * Make an area consistent for devices.
- */
-static void consistent_sync(void *vaddr, size_t size, int direction, int master_type)
-{
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end = start + size;
-
-	if (master_type == FOR_CPU) {
-		switch (direction) {
-		case DMA_TO_DEVICE:
-			break;
-		case DMA_FROM_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_inval_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	} else {
-		/* FOR_DEVICE */
-		switch (direction) {
-		case DMA_FROM_DEVICE:
-			break;
-		case DMA_TO_DEVICE:
-		case DMA_BIDIRECTIONAL:
-			cpu_dma_wb_range(start, end);
-			break;
-		default:
-			BUG();
-		}
-	}
-}
-
-static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction dir,
-			    unsigned long attrs)
+static void
+nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction dir)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
-	return nents;
-}
-
-static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nhwentries, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static void
-nds32_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-			      size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_CPU);
-}
-
-static void
-nds32_dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				 size_t size, enum dma_data_direction dir)
-{
-	consistent_sync((void *)phys_to_virt(handle), size, dir, FOR_DEVICE);
 }
 
 static void
@@ -427,23 +404,28 @@ nds32_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_CPU);
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
 }
 
-static void
-nds32_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			     int nents, enum dma_data_direction dir)
+static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
+			    int nents, enum dma_data_direction dir,
+			    unsigned long attrs)
 {
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		char *virt =
-		    page_address((struct page *)sg->page_link) + sg->offset;
-		consistent_sync(virt, sg->length, dir, FOR_DEVICE);
+		nds32_dma_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
 	}
+	return nents;
+}
+
+static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nhwentries, enum dma_data_direction dir,
+			       unsigned long attrs)
+{
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0
