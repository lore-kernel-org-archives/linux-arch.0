From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 01/10] m68k: use for_each_sg()
Date: Fri,  1 May 2015 22:56:34 +0900
Message-ID: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35288 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbEAN45 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2015 09:56:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since m68k doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org
---
* Changes from v1
- Update commit log

 arch/m68k/kernel/dma.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index e546a55..564665f 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -120,13 +120,16 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
 }
 EXPORT_SYMBOL(dma_sync_single_for_device);
 
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
-			    enum dma_data_direction dir)
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+			    int nents, enum dma_data_direction dir)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; sg++, i++)
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length, dir);
+	for_each_sg(sglist, sg, nents, i) {
+		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
+					   dir);
+	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
 
@@ -151,14 +154,16 @@ dma_addr_t dma_map_page(struct device *dev, struct page *page,
 }
 EXPORT_SYMBOL(dma_map_page);
 
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	       enum dma_data_direction dir)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; sg++, i++) {
+	for_each_sg(sglist, sg, nents, i) {
 		sg->dma_address = sg_phys(sg);
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length, dir);
+		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
+					   dir);
 	}
 	return nents;
 }
-- 
1.9.1
