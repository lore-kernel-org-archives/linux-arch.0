From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top of
 generic dma ops
Date: Mon, 20 Jun 2011 09:50:09 +0200
Message-ID: <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

This patch converts all dma_sg methods to be generic (independent of the
current DMA mapping implementation for ARM architecture). All dma sg
operations are now implemented on top of respective
dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/include/asm/dma-mapping.h |   10 +++---
 arch/arm/mm/dma-mapping.c          |   59 ++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f4e4968..fa73efc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -340,15 +340,15 @@ static inline void __dma_unmap_page(struct device *dev, dma_addr_t handle,
 #endif /* CONFIG_DMABOUNCE */
 
 /*
- * The scatter list versions of the above methods.
+ * The generic scatter list versions of dma methods.
  */
-extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
+extern int generic_dma_map_sg(struct device *, struct scatterlist *, int,
 		enum dma_data_direction, struct dma_attrs *attrs);
-extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
+extern void generic_dma_unmap_sg(struct device *, struct scatterlist *, int,
 		enum dma_data_direction, struct dma_attrs *attrs);
-extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
+extern void generic_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
-extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
+extern void generic_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
 		enum dma_data_direction);
 
 #endif /* __KERNEL__ */
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5264552..ebbd76c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -107,12 +107,12 @@ static int arm_dma_set_mask(struct device *dev, u64 dma_mask)
 struct dma_map_ops dma_ops = {
 	.map_page		= arm_dma_map_page,
 	.unmap_page		= arm_dma_unmap_page,
-	.map_sg			= arm_dma_map_sg,
-	.unmap_sg		= arm_dma_unmap_sg,
 	.sync_single_for_cpu	= arm_dma_sync_single_for_cpu,
 	.sync_single_for_device	= arm_dma_sync_single_for_device,
-	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
+	.map_sg			= generic_dma_map_sg,
+	.unmap_sg		= generic_dma_unmap_sg,
+	.sync_sg_for_cpu	= generic_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= generic_dma_sync_sg_for_device,
 	.set_dma_mask		= arm_dma_set_mask,
 };
 EXPORT_SYMBOL(dma_ops);
@@ -635,7 +635,7 @@ void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
 EXPORT_SYMBOL(___dma_page_dev_to_cpu);
 
 /**
- * dma_map_sg - map a set of SG buffers for streaming mode DMA
+ * generic_map_sg - map a set of SG buffers for streaming mode DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map
@@ -650,15 +650,16 @@ EXPORT_SYMBOL(___dma_page_dev_to_cpu);
  * Device ownership issues as mentioned for dma_map_single are the same
  * here.
  */
-int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+int generic_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
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
@@ -666,12 +667,12 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
  bad_mapping:
 	for_each_sg(sg, s, i, j)
-		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
 	return 0;
 }
 
 /**
- * dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
+ * generic_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
@@ -680,60 +681,54 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+void generic_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
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
+ * generic_sync_sg_for_cpu
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+void generic_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
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
+		ops->sync_single_for_cpu(dev, sg_dma_address(s) + s->offset,
+					 s->length, dir);
 }
 
 /**
- * dma_sync_sg_for_device
+ * generic_sync_sg_for_device
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+void generic_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
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
+		ops->sync_single_for_device(dev, sg_dma_address(s) + s->offset,
+					    s->length, dir);
 }
 
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
-- 
1.7.1.569.g6f426

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
