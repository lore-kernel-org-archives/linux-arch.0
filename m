From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 4/5] xtensa: use for_each_sg()
Date: Fri,  1 May 2015 15:47:25 +0900
Message-ID: <1430462846-12022-4-git-send-email-akinobu.mita@gmail.com>
References: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since xtensa doesn't select ARCH_HAS_SG_CHAIN, it is not necessary to
use for_each_sg() in order to loop over each sg element.  But this can
help find problems with drivers that do not properly initialize their
sg tables when CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
---
 arch/xtensa/include/asm/dma-mapping.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 172a02a..54d2b22 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -52,14 +52,15 @@ dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 }
 
 static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	   enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
 	BUG_ON(direction == DMA_NONE);
 
-	for (i = 0; i < nents; i++, sg++ ) {
+	for_each_sg(sglist, sg, nents, i) {
 		BUG_ON(!sg_page(sg));
 
 		sg->dma_address = sg_phys(sg);
@@ -124,20 +125,24 @@ dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 	consistent_sync((void *)bus_to_virt(dma_handle)+offset,size,direction);
 }
 static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 		 enum dma_data_direction dir)
 {
 	int i;
-	for (i = 0; i < nelems; i++, sg++)
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
 		consistent_sync(sg_virt(sg), sg->length, dir);
 }
 
 static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		 enum dma_data_direction dir)
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+		       int nelems, enum dma_data_direction dir)
 {
 	int i;
-	for (i = 0; i < nelems; i++, sg++)
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
 		consistent_sync(sg_virt(sg), sg->length, dir);
 }
 static inline int
-- 
1.9.1
