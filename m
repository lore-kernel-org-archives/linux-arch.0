From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: fix broken noncoherent cache ops
Date: Tue, 24 Jul 2018 17:13:02 +0300
Message-ID: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

All DMA devices on ARC haven't worked with SW cache control
since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
This happens because we don't check direction argument at all in
new implementation. Fix that.

Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
NOTE:
 * This patch was stress tested on HSDK with bonie++ (usb and sdio)
   with IOC disabled. The ethernet wasn't tested because it doesn't
   work with SW cache control as for today (see STAR 9001336019)

 arch/arc/mm/dma.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 8c1071840979..cefb776a99ff 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -129,14 +129,56 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
+/*
+ * Cache operations depending on function and direction argument, inspired by
+ * https://lkml.org/lkml/2018/5/18/979
+ * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
+ * dma-mapping: provide a generic dma-noncoherent implementation)"
+ *
+ *          |   map          ==  for_device     |   unmap     ==  for_cpu
+ *          |----------------------------------------------------------------
+ * TO_DEV   |   writeback        writeback      |   none          none
+ * FROM_DEV |   invalidate       invalidate     |   invalidate    invalidate
+ * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invalidate
+ *
+ * NOTE: we don't check the validity of direction argument as it is done in
+ * upper layer functions (in include/linux/dma-mapping.h)
+ */
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_wback(paddr, size);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		dma_cache_wback(paddr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		dma_cache_inv(paddr, size);
+		break;
+
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_inv(paddr, size);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		dma_cache_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
 }
-- 
2.14.4
