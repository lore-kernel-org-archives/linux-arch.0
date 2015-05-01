From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 10/10] parisc: use for_each_sg()
Date: Fri,  1 May 2015 22:56:43 +0900
Message-ID: <1430488603-11055-10-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35828 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbEAN5a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2015 09:57:30 -0400
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since parisc doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
* New patch from v2

 arch/parisc/kernel/pci-dma.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ff834fd..b9402c9 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -478,14 +478,16 @@ static void pa11_dma_unmap_single(struct device *dev, dma_addr_t dma_handle, siz
 static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
 	BUG_ON(direction == DMA_NONE);
 
-	for (i = 0; i < nents; i++, sglist++ ) {
-		unsigned long vaddr = (unsigned long)sg_virt(sglist);
-		sg_dma_address(sglist) = (dma_addr_t) virt_to_phys(vaddr);
-		sg_dma_len(sglist) = sglist->length;
-		flush_kernel_dcache_range(vaddr, sglist->length);
+	for_each_sg(sglist, sg, nents, i) {
+		unsigned long vaddr = (unsigned long)sg_virt(sg);
+
+		sg_dma_address(sg) = (dma_addr_t) virt_to_phys(vaddr);
+		sg_dma_len(sg) = sg->length;
+		flush_kernel_dcache_range(vaddr, sg->length);
 	}
 	return nents;
 }
@@ -493,6 +495,7 @@ static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist, int n
 static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
 	BUG_ON(direction == DMA_NONE);
 
@@ -501,8 +504,8 @@ static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist, in
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for (i = 0; i < nents; i++, sglist++ )
-		flush_kernel_vmap_range(sg_virt(sglist), sglist->length);
+	for_each_sg(sglist, sg, nents, i)
+		flush_kernel_vmap_range(sg_virt(sg), sg->length);
 	return;
 }
 
@@ -523,21 +526,23 @@ static void pa11_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_h
 static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for (i = 0; i < nents; i++, sglist++ )
-		flush_kernel_vmap_range(sg_virt(sglist), sglist->length);
+	for_each_sg(sglist, sg, nents, i)
+		flush_kernel_vmap_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
-	for (i = 0; i < nents; i++, sglist++ )
-		flush_kernel_vmap_range(sg_virt(sglist), sglist->length);
+	for_each_sg(sglist, sg, nents, i)
+		flush_kernel_vmap_range(sg_virt(sg), sg->length);
 }
 
 struct hppa_dma_ops pcxl_dma_ops = {
-- 
1.9.1
