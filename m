From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: [PATCH v1 1/2] dma-mapping-common: add dma_map_page_attrs API
Date: Sun, 25 Oct 2015 09:37:57 -0700
Message-ID: <1445791078-28244-1-git-send-email-shamir.rabinovitch@oracle.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

SPARC64 arch need the ability to pass DMA attributes when mapping
pages. DMA performance will be low if specific attributes such as
DMA_ATTR_WEAK_ORDERING are not used.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 include/asm-generic/dma-mapping-common.h |   32 +++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index b1bc954..b816ed7 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -74,32 +74,50 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
-static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
-				      size_t offset, size_t size,
-				      enum dma_data_direction dir)
+static inline dma_addr_t dma_map_page_attrs(struct device *dev,
+					    struct page *page,
+					    size_t offset, size_t size,
+					    enum dma_data_direction dir,
+					    struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 	dma_addr_t addr;
 
 	kmemcheck_mark_initialized(page_address(page) + offset, size);
 	BUG_ON(!valid_dma_direction(dir));
-	addr = ops->map_page(dev, page, offset, size, dir, NULL);
+	addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 
 	return addr;
 }
 
-static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
-				  size_t size, enum dma_data_direction dir)
+static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+					size_t size,
+					enum dma_data_direction dir,
+					struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, NULL);
+		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
+static inline dma_addr_t dma_map_page(struct device *dev,
+				      struct page *page,
+				      size_t offset, size_t size,
+				      enum dma_data_direction dir)
+{
+	return dma_map_page_attrs(dev, page, offset, size, dir, NULL);
+}
+
+static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
+				  size_t size, enum dma_data_direction dir)
+{
+	return dma_unmap_page_attrs(dev, addr, size, dir, NULL);
+}
+
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 					   size_t size,
 					   enum dma_data_direction dir)
-- 
1.7.1

