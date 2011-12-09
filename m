Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41807 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab1LIQkM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2011 11:40:12 -0500
Date: Fri, 09 Dec 2011 17:39:53 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/8] ARM: dma-mapping: implement dma sg methods on top of any
 generic dma ops
In-reply-to: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1323448798-18184-4-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1323448798-18184-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20111209163953.V5cbJ7TMuetAcl3oztYbJznOyLj8liDRM1Iolc4Z-JY@z>

This patch converts all dma_sg methods to be generic (independent of the
current DMA mapping implementation for ARM architecture). All dma sg
operations are now implemented on top of respective
dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 91fe436..31ff699 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -635,12 +635,13 @@ EXPORT_SYMBOL(___dma_page_dev_to_cpu);
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
@@ -648,7 +649,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
  bad_mapping:
 	for_each_sg(sg, s, i, j)
-		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
 	return 0;
 }
 
@@ -665,11 +666,13 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
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
@@ -682,17 +685,13 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
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
@@ -705,17 +704,13 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
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

