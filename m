Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26821 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab2FMLvT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2012 07:51:19 -0400
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 4/6] ARM: dma-mapping: add support for dma_get_sgtable()
Date: Wed, 13 Jun 2012 13:50:16 +0200
Message-ID: <1339588218-24398-5-git-send-email-m.szyprowski@samsung.com>
In-reply-to: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subash.ramaswamy@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Abhinav Kochhar <abhinav.k@samsung.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>
Message-ID: <20120613115016.dLi4xVXRbq-CYbtxWUd395m6a2UgUMWVUjjGec1xRWg@z>

This patch adds support for dma_get_sgtable() function which is required
to let drivers to share the buffers allocated by DMA-mapping subsystem.

Generic implementation based on virt_to_page() is not suitable for ARM
dma-mapping subsystem.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/common/dmabounce.c        |    1 +
 arch/arm/include/asm/dma-mapping.h |    3 +++
 arch/arm/mm/dma-mapping.c          |   31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9d7eb53..1486124 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -452,6 +452,7 @@ static struct dma_map_ops dmabounce_ops = {
 	.alloc			= arm_dma_alloc,
 	.free			= arm_dma_free,
 	.mmap			= arm_dma_mmap,
+	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= dmabounce_map_page,
 	.unmap_page		= dmabounce_unmap_page,
 	.sync_single_for_cpu	= dmabounce_sync_for_cpu,
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 80777d87..804bf65 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -280,6 +280,9 @@ extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
+extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		struct dma_attrs *attrs);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5d8b8b2..3840997 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -125,6 +125,7 @@ struct dma_map_ops arm_dma_ops = {
 	.alloc			= arm_dma_alloc,
 	.free			= arm_dma_free,
 	.mmap			= arm_dma_mmap,
+	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= arm_dma_map_page,
 	.unmap_page		= arm_dma_unmap_page,
 	.map_sg			= arm_dma_map_sg,
@@ -659,6 +660,21 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	}
 }
 
+int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+		 void *cpu_addr, dma_addr_t handle, size_t size,
+		 struct dma_attrs *attrs)
+{
+	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (unlikely(ret))
+		return ret;
+
+	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return 0;
+}
+
 static void dma_cache_maint_page(struct page *page, unsigned long offset,
 	size_t size, enum dma_data_direction dir,
 	void (*op)(const void *, size_t, int))
@@ -1171,6 +1187,20 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	__iommu_free_buffer(dev, pages, size);
 }
 
+static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
+				 void *cpu_addr, dma_addr_t dma_addr,
+				 size_t size, struct dma_attrs *attrs)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
+
+	if (!pages)
+		return -ENXIO;
+
+	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
+					 GFP_KERNEL);
+}
+
 /*
  * Map a part of the scatter-gather list into contiguous io address space
  */
@@ -1430,6 +1460,7 @@ struct dma_map_ops iommu_ops = {
 	.alloc		= arm_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
+	.get_sgtable	= arm_iommu_get_sgtable,
 
 	.map_page		= arm_iommu_map_page,
 	.unmap_page		= arm_iommu_unmap_page,
-- 
1.7.1.569.g6f426

