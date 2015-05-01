From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 07/10] avr32: use for_each_sg()
Date: Fri,  1 May 2015 22:56:40 +0900
Message-ID: <1430488603-11055-7-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since avr32 doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-arch@vger.kernel.org
---
* New patch from v2

 arch/avr32/include/asm/dma-mapping.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/asm/dma-mapping.h
index b3d18f9..ae7ac92 100644
--- a/arch/avr32/include/asm/dma-mapping.h
+++ b/arch/avr32/include/asm/dma-mapping.h
@@ -209,17 +209,18 @@ dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
  * the same here.
  */
 static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	   enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; i++) {
+	for_each_sg(sglist, sg, nents, i) {
 		char *virt;
 
-		sg[i].dma_address = page_to_bus(sg_page(&sg[i])) + sg[i].offset;
-		virt = sg_virt(&sg[i]);
-		dma_cache_sync(dev, virt, sg[i].length, direction);
+		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
+		virt = sg_virt(sg);
+		dma_cache_sync(dev, virt, sg->length, direction);
 	}
 
 	return nents;
@@ -321,14 +322,14 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 }
 
 static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 		       int nents, enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; i++) {
-		dma_cache_sync(dev, sg_virt(&sg[i]), sg[i].length, direction);
-	}
+	for_each_sg(sglist, sg, nents, i)
+		dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
 }
 
 /* Now for the API extensions over the pci_ one */
-- 
1.9.1
