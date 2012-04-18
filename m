From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv9 06/10] ARM: dma-mapping: implement dma sg methods on top of
 any generic dma ops
Date: Wed, 18 Apr 2012 15:44:08 +0200
Message-ID: <1334756652-30830-7-git-send-email-m.szyprowski@samsung.com>
References: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55441 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2DRNob (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Apr 2012 09:44:31 -0400
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M2O0086FGS1RP@mailout1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 18 Apr 2012 14:43:13 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M2O007UJGU2MP@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 18 Apr 2012 14:44:27 +0100 (BST)
In-reply-to: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>

This patch converts all dma_sg methods to be generic (independent of the
current DMA mapping implementation for ARM architecture). All dma sg
operations are now implemented on top of respective
dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.

Before this patch there were custom methods for all scatter/gather
related operations. They iterated over the whole scatter list and called
cache related operations directly (which in turn checked if we use dma
bounce code or not and called respective version). This patch changes
them not to use such shortcut. Instead it provides similar loop over
scatter list and calls methods from the device's dma_map_ops structure.
This enables us to use device dependent implementations of cache related
operations (direct linear or dma bounce) depending on the provided
dma_map_ops structure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Tested-By: Subash Patel <subash.ramaswamy@linaro.org>
---
 arch/arm/mm/dma-mapping.c |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 92ffb0a..c08909e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -619,7 +619,7 @@ void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
 EXPORT_SYMBOL(___dma_page_dev_to_cpu);
 
 /**
- * dma_map_sg - map a set of SG buffers for streaming mode DMA
+ * arm_dma_map_sg - map a set of SG buffers for streaming mode DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map
@@ -637,12 +637,13 @@ EXPORT_SYMBOL(___dma_page_dev_to_cpu);
 int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, struct dma_attrs *attrs)
 {
+	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
 	int i, j;
 
 	for_each_sg(sg, s, nents, i) {
-		s->dma_address = __dma_map_page(dev, sg_page(s), s->offset,
-						s->length, dir);
+		s->dma_address = ops->map_page(dev, sg_page(s), s->offset,
+						s->length, dir, attrs);
 		if (dma_mapping_error(dev, s->dma_address))
 			goto bad_mapping;
 	}
@@ -650,12 +651,12 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
  bad_mapping:
 	for_each_sg(sg, s, i, j)
-		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
 	return 0;
 }
 
 /**
- * dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
+ * arm_dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
@@ -667,15 +668,17 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, struct dma_attrs *attrs)
 {
+	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
+
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
 }
 
 /**
- * dma_sync_sg_for_cpu
+ * arm_dma_sync_sg_for_cpu
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map (returned from dma_map_sg)
@@ -684,21 +687,17 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
+	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i) {
-		if (!dmabounce_sync_for_cpu(dev, sg_dma_address(s),
-					    sg_dma_len(s), dir))
-			continue;
-
-		__dma_page_dev_to_cpu(sg_page(s), s->offset,
-				      s->length, dir);
-	}
+	for_each_sg(sg, s, nents, i)
+		ops->sync_single_for_cpu(dev, sg_dma_address(s), s->length,
+					 dir);
 }
 
 /**
- * dma_sync_sg_for_device
+ * arm_dma_sync_sg_for_device
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map (returned from dma_map_sg)
@@ -707,17 +706,13 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
+	struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i) {
-		if (!dmabounce_sync_for_device(dev, sg_dma_address(s),
-					sg_dma_len(s), dir))
-			continue;
-
-		__dma_page_cpu_to_dev(sg_page(s), s->offset,
-				      s->length, dir);
-	}
+	for_each_sg(sg, s, nents, i)
+		ops->sync_single_for_device(dev, sg_dma_address(s), s->length,
+					    dir);
 }
 
 /*
-- 
1.7.1.569.g6f426
