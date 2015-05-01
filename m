Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35533 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbEAN5P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2015 09:57:15 -0400
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 06/10] frv: use for_each_sg()
Date: Fri,  1 May 2015 22:56:39 +0900
Message-ID: <1430488603-11055-6-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20150501135639.mDoavHAHPEcoOLEYj3AHp6cHHI3S-9E3U4EuHub92Ug@z>

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since frv doesn't
select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
order to loop over each sg element.  But this can help find problems
with drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
---
* New patch from v2

 arch/frv/mb93090-mb00/pci-dma-nommu.c | 10 ++++++----
 arch/frv/mb93090-mb00/pci-dma.c       |  7 ++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-dma-nommu.c b/arch/frv/mb93090-mb00/pci-dma-nommu.c
index b99c2a7..8eeea0d 100644
--- a/arch/frv/mb93090-mb00/pci-dma-nommu.c
+++ b/arch/frv/mb93090-mb00/pci-dma-nommu.c
@@ -119,14 +119,16 @@ dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 
 EXPORT_SYMBOL(dma_map_single);
 
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	       enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i=0; i<nents; i++)
-		frv_cache_wback_inv(sg_dma_address(&sg[i]),
-				    sg_dma_address(&sg[i]) + sg_dma_len(&sg[i]));
+	for_each_sg(sglist, sg, nents, i) {
+		frv_cache_wback_inv(sg_dma_address(sg),
+				    sg_dma_address(sg) + sg_dma_len(sg));
+	}
 
 	BUG_ON(direction == DMA_NONE);
 
diff --git a/arch/frv/mb93090-mb00/pci-dma.c b/arch/frv/mb93090-mb00/pci-dma.c
index 8247897..4d1f01d 100644
--- a/arch/frv/mb93090-mb00/pci-dma.c
+++ b/arch/frv/mb93090-mb00/pci-dma.c
@@ -50,19 +50,20 @@ dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 
 EXPORT_SYMBOL(dma_map_single);
 
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	       enum dma_data_direction direction)
 {
 	unsigned long dampr2;
 	void *vaddr;
 	int i;
+	struct scatterlist *sg;
 
 	BUG_ON(direction == DMA_NONE);
 
 	dampr2 = __get_DAMPR(2);
 
-	for (i = 0; i < nents; i++) {
-		vaddr = kmap_atomic_primary(sg_page(&sg[i]));
+	for_each_sg(sglist, sg, nents, i) {
+		vaddr = kmap_atomic_primary(sg_page(sg));
 
 		frv_dcache_writeback((unsigned long) vaddr,
 				     (unsigned long) vaddr + PAGE_SIZE);
-- 
1.9.1

