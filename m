From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 05/10] mips: use for_each_sg()
Date: Fri,  1 May 2015 22:56:38 +0900
Message-ID: <1430488603-11055-5-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since mips doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org
---
* Changes from v1
- Update commit log

 arch/mips/mm/dma-default.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 609d124..eeaf024 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -262,12 +262,13 @@ static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	plat_unmap_dma_mem(dev, dma_addr, size, direction);
 }
 
-static int mips_dma_map_sg(struct device *dev, struct scatterlist *sg,
+static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; i++, sg++) {
+	for_each_sg(sglist, sg, nents, i) {
 		if (!plat_device_is_coherent(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
@@ -291,13 +292,14 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	return plat_map_dma_mem_page(dev, page) + offset;
 }
 
-static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	int nhwentries, enum dma_data_direction direction,
 	struct dma_attrs *attrs)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nhwentries; i++, sg++) {
+	for_each_sg(sglist, sg, nhwentries, i) {
 		if (!plat_device_is_coherent(dev) &&
 		    direction != DMA_TO_DEVICE)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
@@ -324,26 +326,34 @@ static void mips_dma_sync_single_for_device(struct device *dev,
 }
 
 static void mips_dma_sync_sg_for_cpu(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
+	struct scatterlist *sglist, int nelems,
+	enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	if (cpu_needs_post_dma_flush(dev))
-		for (i = 0; i < nelems; i++, sg++)
+	if (cpu_needs_post_dma_flush(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
+		}
+	}
 	plat_post_dma_flush(dev);
 }
 
 static void mips_dma_sync_sg_for_device(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
+	struct scatterlist *sglist, int nelems,
+	enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	if (!plat_device_is_coherent(dev))
-		for (i = 0; i < nelems; i++, sg++)
+	if (!plat_device_is_coherent(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
+		}
+	}
 }
 
 int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-- 
1.9.1
