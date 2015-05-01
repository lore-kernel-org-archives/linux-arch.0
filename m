From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 03/10] metag: use for_each_sg()
Date: Fri,  1 May 2015 22:56:36 +0900
Message-ID: <1430488603-11055-3-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, James Hogan <james.hogan@imgtec.com>, linux-metag@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since metag doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-metag@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
* Changes from v1
- Update commit log

 arch/metag/include/asm/dma-mapping.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
index 14b23ef..eb5cdec 100644
--- a/arch/metag/include/asm/dma-mapping.h
+++ b/arch/metag/include/asm/dma-mapping.h
@@ -134,20 +134,24 @@ dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 }
 
 static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 		    enum dma_data_direction direction)
 {
 	int i;
-	for (i = 0; i < nelems; i++, sg++)
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
 		dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
 }
 
 static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction direction)
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+		       int nelems, enum dma_data_direction direction)
 {
 	int i;
-	for (i = 0; i < nelems; i++, sg++)
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
 		dma_sync_for_device(sg_virt(sg), sg->length, direction);
 }
 
-- 
1.9.1
