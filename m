From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date: Mon, 30 Jul 2018 19:26:34 +0300
Message-ID: <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

The ARC HS processor provides an IOC port (I/O coherency bus
interface) that allows external devices such as DMA devices
to access memory through the cache hierarchy, providing
coherency between I/O transactions and the complete memory
hierarchy.

Some recent SoC with ARC HS (like HSDK) allow to select bus
port (IOC or non-IOC port) for connecting DMA devices in runtime.

With this patch we can use both HW-coherent and regular DMA
peripherals simultaneously.

For example we can connect USB and SDIO controllers through IOC port
(so we don't need to need to maintain cache coherency for these
devices manualy. All cache sync ops will be nop)
And we can connect Ethernet directly to RAM port (so we had to
maintain cache coherency manualy. Cache sync ops will be real
flush/invalidate operations)

Cache ops are set per-device and depends on "dma-coherent" device
tree property:
"dma_noncoherent_ops" are used if no "dma-coherent" property is
present (or IOC is disabled)
"dma_direct_ops" are used if "dma-coherent" property is present.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2 (Thanks to Christoph):
 * Don't select DMA_DIRECT_OPS explicitly as it is already selected by
   DMA_NONCOHERENT_OPS

 arch/arc/include/asm/dma-mapping.h | 13 +++++++++++++
 arch/arc/mm/cache.c                | 17 ++---------------
 arch/arc/mm/dma.c                  | 34 +++++++++++++++++++---------------
 3 files changed, 34 insertions(+), 30 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h

diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..c946c0a83e76
--- /dev/null
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier:  GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#ifndef ASM_ARC_DMA_MAPPING_H
+#define ASM_ARC_DMA_MAPPING_H
+
+#include <asm-generic/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent);
+#define arch_setup_dma_ops arch_setup_dma_ops
+
+#endif
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index b95365e1253a..dac12afbb93a 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -65,7 +65,7 @@ char *arc_cache_mumbojumbo(int c, char *buf, int len)
 
 	n += scnprintf(buf + n, len - n, "Peripherals\t: %#lx%s%s\n",
 		       perip_base,
-		       IS_AVAIL3(ioc_exists, ioc_enable, ", IO-Coherency "));
+		       IS_AVAIL3(ioc_exists, ioc_enable, ", per device IO-Coherency "));
 
 	return buf;
 }
@@ -896,15 +896,6 @@ static void __dma_cache_wback_slc(phys_addr_t start, unsigned long sz)
 	slc_op(start, sz, OP_FLUSH);
 }
 
-/*
- * DMA ops for systems with IOC
- * IOC hardware snoops all DMA traffic keeping the caches consistent with
- * memory - eliding need for any explicit cache maintenance of DMA buffers
- */
-static void __dma_cache_wback_inv_ioc(phys_addr_t start, unsigned long sz) {}
-static void __dma_cache_inv_ioc(phys_addr_t start, unsigned long sz) {}
-static void __dma_cache_wback_ioc(phys_addr_t start, unsigned long sz) {}
-
 /*
  * Exported DMA API
  */
@@ -1263,11 +1254,7 @@ void __init arc_cache_init_master(void)
 	if (is_isa_arcv2() && ioc_enable)
 		arc_ioc_setup();
 
-	if (is_isa_arcv2() && ioc_enable) {
-		__dma_cache_wback_inv = __dma_cache_wback_inv_ioc;
-		__dma_cache_inv = __dma_cache_inv_ioc;
-		__dma_cache_wback = __dma_cache_wback_ioc;
-	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {
+	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
 		__dma_cache_wback_inv = __dma_cache_wback_inv_slc;
 		__dma_cache_inv = __dma_cache_inv_slc;
 		__dma_cache_wback = __dma_cache_wback_slc;
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index cefb776a99ff..4d1466905e48 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (!page)
 		return NULL;
 
-	/*
-	 * IOC relies on all data (even coherent DMA data) being in cache
-	 * Thus allocate normal cached memory
-	 *
-	 * The gains with IOC are two pronged:
-	 *   -For streaming data, elides need for cache maintenance, saving
-	 *    cycles in flush code, and bus bandwidth as all the lines of a
-	 *    buffer need to be flushed out to memory
-	 *   -For coherent data, Read/Write to buffers terminate early in cache
-	 *   (vs. always going to memory - thus are faster)
-	 */
-	if ((is_isa_arcv2() && ioc_enable) ||
-	    (attrs & DMA_ATTR_NON_CONSISTENT))
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
 		need_coh = 0;
 
 	/*
@@ -95,8 +83,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	struct page *page = virt_to_page(paddr);
 	int is_non_coh = 1;
 
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT) ||
-			(is_isa_arcv2() && ioc_enable);
+	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
 
 	if (PageHighMem(page) || !is_non_coh)
 		iounmap((void __force __iomem *)vaddr);
@@ -182,3 +169,20 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		break;
 	}
 }
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	/*
+	 * IOC hardware snoops all DMA traffic keeping the caches consistent
+	 * with memory - eliding need for any explicit cache maintenance of
+	 * DMA buffers - so we can use dma_direct cache ops.
+	 */
+	if (is_isa_arcv2() && ioc_enable && coherent) {
+		set_dma_ops(dev, &dma_direct_ops);
+		dev_info(dev, "use dma_direct_ops cache ops\n");
+	} else {
+		set_dma_ops(dev, &dma_noncoherent_ops);
+		dev_info(dev, "use dma_noncoherent_ops cache ops\n");
+	}
+}
-- 
2.14.4
