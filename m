Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:33531 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbcBJBFj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 20:05:39 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 4/8] arm: dma-mapping: add {map,unmap}_resource for iommu ops
Date: Wed, 10 Feb 2016 01:57:54 +0100
Message-ID: <1455065878-11906-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160210005754.gle6P1p7ou7zbCaXgkf8E3SkSJJlZS0tc8_sLlF_u5U@z>

Add methods to map/unmap device resources addresses for dma_map_ops that
are IOMMU aware. This is needed to map a device MMIO register from a
physical address.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0eca381..ae2b175 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1814,6 +1814,63 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
 
+/**
+ * arm_iommu_map_resource - map a device resource for DMA
+ * @dev: valid struct device pointer
+ * @phys_addr: physical address of resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static dma_addr_t arm_iommu_map_resource(struct device *dev,
+		phys_addr_t phys_addr, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	dma_addr_t dma_addr;
+	int ret, prot;
+	phys_addr_t addr = phys_addr & PAGE_MASK;
+	int offset = phys_addr & ~PAGE_MASK;
+	int len = PAGE_ALIGN(size + offset);
+
+	dma_addr = __alloc_iova(mapping, size);
+	if (dma_addr == DMA_ERROR_CODE)
+		return dma_addr;
+
+	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
+
+	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
+	if (ret < 0)
+		goto fail;
+
+	return dma_addr + offset;
+fail:
+	__free_iova(mapping, dma_addr, size);
+	return DMA_ERROR_CODE;
+}
+
+/**
+ * arm_iommu_unmap_resource - unmap a device DMA resource
+ * @dev: valid struct device pointer
+ * @dma_handle: DMA address to resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	dma_addr_t iova = dma_handle & PAGE_MASK;
+	int offset = dma_handle & ~PAGE_MASK;
+	int len = PAGE_ALIGN(size + offset);
+
+	if (!iova)
+		return;
+
+	iommu_unmap(mapping->domain, iova, len);
+	__free_iova(mapping, iova, len);
+}
+
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1858,6 +1915,9 @@ struct dma_map_ops iommu_ops = {
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 
+	.map_resource		= arm_iommu_map_resource,
+	.unmap_resource		= arm_iommu_unmap_resource,
+
 	.set_dma_mask		= arm_dma_set_mask,
 };
 
@@ -1873,6 +1933,9 @@ struct dma_map_ops iommu_coherent_ops = {
 	.map_sg		= arm_coherent_iommu_map_sg,
 	.unmap_sg	= arm_coherent_iommu_unmap_sg,
 
+	.map_resource	= arm_iommu_map_resource,
+	.unmap_resource	= arm_iommu_unmap_resource,
+
 	.set_dma_mask	= arm_dma_set_mask,
 };
 
-- 
2.7.1

