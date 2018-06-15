From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date: Fri, 15 Jun 2018 15:58:19 +0300
Message-ID: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
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


NOTE 1:
It works perfectly fine only if we don't have ZONE_HIGHMEM used
as IOC doesn't cover all physical memory. As for today It configured
to cover 1GiB starting from 0x8z (which is ZONE_NORMAL memory for
us). Transactions outside this region are sent on the non-coherent
I/O bus interface.
We can't configure IOC to cover all physical memory as it has several
limitations relating to aperture size and start address.

And if we get DMA buffer from ZONE_HIGHMEM memory we need to
do real flush/invalidate operations on that buffer, which is obviously
not done by "dma_direct_ops".

So I am not sure about "dma_direct_ops" using - probably we need to
create our special cache ops like "arc_ioc_ops" which will handle
ZONE_HIGHMEM case.

(BTW: current ARC dma_noncoherent_ops implementation also has same
problem if IOC and HIGHMEM are enabled.)


NOTE 2:
In this RFC only hsdk.dts changes are shown to reduce patch size.
AXS103 device tree changes are not shown.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                   |  1 +
 arch/arc/boot/dts/hsdk.dts         |  4 ++++
 arch/arc/include/asm/dma-mapping.h | 14 ++++++++++++++
 arch/arc/mm/Makefile               |  2 +-
 arch/arc/mm/cache.c                | 15 +--------------
 arch/arc/mm/dma-mapping.c          | 20 ++++++++++++++++++++
 arch/arc/mm/dma.c                  | 14 +-------------
 7 files changed, 42 insertions(+), 28 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h
 create mode 100644 arch/arc/mm/dma-mapping.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e81bcd271be7..0a2fcd2a8c32 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,6 +17,7 @@ config ARC
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 006aa3de5348..ebb686c21393 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -176,6 +176,7 @@
 			phy-handle = <&phy0>;
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
+			dma-coherent;
 
 			mdio {
 				#address-cells = <1>;
@@ -194,12 +195,14 @@
 			compatible = "snps,hsdk-v1.0-ohci", "generic-ohci";
 			reg = <0x60000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		ehci@40000 {
 			compatible = "snps,hsdk-v1.0-ehci", "generic-ehci";
 			reg = <0x40000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		mmc@a000 {
@@ -212,6 +215,7 @@
 			clock-names = "biu", "ciu";
 			interrupts = <12>;
 			bus-width = <4>;
+			dma-coherent;
 		};
 	};
 
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..640a851bd331
--- /dev/null
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#ifndef ASM_ARC_DMA_MAPPING_H
+#define ASM_ARC_DMA_MAPPING_H
+
+#define arch_setup_dma_ops arch_setup_dma_ops
+
+#include <asm-generic/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent);
+
+#endif
diff --git a/arch/arc/mm/Makefile b/arch/arc/mm/Makefile
index 3703a4969349..45683897c27b 100644
--- a/arch/arc/mm/Makefile
+++ b/arch/arc/mm/Makefile
@@ -7,5 +7,5 @@
 #
 
 obj-y	:= extable.o ioremap.o dma.o fault.o init.o
-obj-y	+= tlb.o tlbex.o cache.o mmap.o
+obj-y	+= tlb.o tlbex.o cache.o mmap.o dma-mapping.o
 obj-$(CONFIG_HIGHMEM)	+= highmem.o
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 9dbe645ee127..c5d1f2a2c4da 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
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
@@ -1253,11 +1244,7 @@ void __init arc_cache_init_master(void)
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
diff --git a/arch/arc/mm/dma-mapping.c b/arch/arc/mm/dma-mapping.c
new file mode 100644
index 000000000000..9d0d310bbf5a
--- /dev/null
+++ b/arch/arc/mm/dma-mapping.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) 2018 Synopsys, Inc. (www.synopsys.com)
+
+#include <linux/dma-mapping.h>
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	const struct dma_map_ops *dma_ops = &dma_noncoherent_ops;
+
+	/*
+	 * IOC hardware snoops all DMA traffic keeping the caches consistent
+	 * with memory - eliding need for any explicit cache maintenance of
+	 * DMA buffers - so we can use dma_direct cache ops.
+	 */
+	if (is_isa_arcv2() && ioc_enable && coherent)
+		dma_ops = &dma_direct_ops;
+
+	set_dma_ops(dev, dma_ops);
+}
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 8c1071840979..4fd130e786c7 100644
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
-- 
2.14.4
