Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:9628 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964873AbWEUObY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 10:31:24 -0400
Subject: [PATCH] move scatterlist accessors into scatterlist.h on ia64, sh
	and sh64
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Sun, 21 May 2006 09:31:14 -0500
Message-Id: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: lethal@linux-sh.org
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---
Although this is a simple move, the sh implementation looks bogus.
dma_map_sg is this:

static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
			     int nents, enum dma_data_direction dir)
{
	int i;

	for (i = 0; i < nents; i++) {
#if !defined(CONFIG_PCI) || defined(CONFIG_SH_PCIDMA_NONCOHERENT)
		dma_cache_sync(page_address(sg[i].page) + sg[i].offset,
			       sg[i].length, dir);
#endif
		sg[i].dma_address = page_to_phys(sg[i].page) + sg[i].offset;
	}

	return nents;
}

which is about right for a simple physical==bus physical implementation.
However, your accessor is:

#define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))

so you're calling virt_to_bus() on an already physical address.

James

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
diff --git a/drivers/net/tulip/winbond-840.c b/drivers/net/tulip/winbond-840.c
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
diff --git a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
index ef616fd..279869f 100644
--- a/include/asm-ia64/pci.h
+++ b/include/asm-ia64/pci.h
@@ -79,9 +79,6 @@ #define pci_dac_dma_to_offset(dev,dma_ad
 #define pci_dac_dma_sync_single_for_cpu(dev,dma_addr,len,dir)	do { } while (0)
 #define pci_dac_dma_sync_single_for_device(dev,dma_addr,len,dir)	do { mb(); } while (0)
 
-#define sg_dma_len(sg)		((sg)->dma_length)
-#define sg_dma_address(sg)	((sg)->dma_address)
-
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
diff --git a/include/asm-ia64/scatterlist.h b/include/asm-ia64/scatterlist.h
index 834a189..9dbea88 100644
--- a/include/asm-ia64/scatterlist.h
+++ b/include/asm-ia64/scatterlist.h
@@ -25,4 +25,7 @@ struct scatterlist {
  */
 #define ISA_DMA_THRESHOLD	0xffffffff
 
+#define sg_dma_len(sg)		((sg)->dma_length)
+#define sg_dma_address(sg)	((sg)->dma_address)
+
 #endif /* _ASM_IA64_SCATTERLIST_H */
diff --git a/include/asm-sh/pci.h b/include/asm-sh/pci.h
index 0a523c8..18a109d 100644
--- a/include/asm-sh/pci.h
+++ b/include/asm-sh/pci.h
@@ -87,15 +87,6 @@ #endif
  */
 #define pci_dac_dma_supported(pci_dev, mask) (0)
 
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))
-#define sg_dma_len(sg)		((sg)->length)
-
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
diff --git a/include/asm-sh/scatterlist.h b/include/asm-sh/scatterlist.h
index 7b91df1..e113836 100644
--- a/include/asm-sh/scatterlist.h
+++ b/include/asm-sh/scatterlist.h
@@ -10,4 +10,13 @@ struct scatterlist {
 
 #define ISA_DMA_THRESHOLD (0x1fffffff)
 
+/* These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))
+#define sg_dma_len(sg)		((sg)->length)
+
 #endif /* !(__ASM_SH_SCATTERLIST_H) */
diff --git a/include/asm-sh64/pci.h b/include/asm-sh64/pci.h
index aa80430..2c9f8a5 100644
--- a/include/asm-sh64/pci.h
+++ b/include/asm-sh64/pci.h
@@ -77,15 +77,6 @@ #endif
  */
 #define pci_dac_dma_supported(pci_dev, mask) (0)
 
-/* These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->length)
-
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
diff --git a/include/asm-sh64/scatterlist.h b/include/asm-sh64/scatterlist.h
index 5d8fa32..be27c48 100644
--- a/include/asm-sh64/scatterlist.h
+++ b/include/asm-sh64/scatterlist.h
@@ -20,4 +20,13 @@ struct scatterlist {
 
 #define ISA_DMA_THRESHOLD (0xffffffff)
 
+/* These macros should be used after a pci_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)		((sg)->length)
+
 #endif /* !__ASM_SH64_SCATTERLIST_H */


