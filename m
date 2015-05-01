From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/5] arc: use for_each_sg()
Date: Fri,  1 May 2015 15:47:23 +0900
Message-ID: <1430462846-12022-2-git-send-email-akinobu.mita@gmail.com>
References: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since arc doesn't select ARCH_HAS_SG_CHAIN, it is not necessary to
use for_each_sg() in order to loop over each sg element.  But this can
help find problems with drivers that do not properly initialize their
sg tables when CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-arch@vger.kernel.org
---
 arch/arc/include/asm/dma-mapping.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
index 45b8e0c..f787894 100644
--- a/arch/arc/include/asm/dma-mapping.h
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -178,22 +178,24 @@ dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
 }
 
 static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 		    enum dma_data_direction dir)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nelems; i++, sg++)
+	for_each_sg(sglist, sg, nelems, i)
 		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
 }
 
 static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction dir)
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+		       int nelems, enum dma_data_direction dir)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nelems; i++, sg++)
+	for_each_sg(sglist, sg, nelems, i)
 		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
 }
 
-- 
1.9.1
