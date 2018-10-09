From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 18/33] powerpc/dma: stop overriding dma_get_required_mask
Date: Tue,  9 Oct 2018 15:24:45 +0200
Message-ID: <20181009132500.17643-19-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181009132500.17643-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

The ppc_md and pci_controller_ops methods are unused now and can be
removed.  The dma_nommu implementation is generic to the generic one
except for using max_pfn instead of calling into the memblock API,
and all other dma_map_ops instances implement a method of their own.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/powerpc/include/asm/device.h      |  2 --
 arch/powerpc/include/asm/dma-mapping.h |  2 --
 arch/powerpc/include/asm/machdep.h     |  2 --
 arch/powerpc/include/asm/pci-bridge.h  |  1 -
 arch/powerpc/kernel/dma.c              | 42 --------------------------
 drivers/base/platform.c                |  2 --
 6 files changed, 51 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 1aa53318b4bc..3814e1c2d4bc 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -59,6 +59,4 @@ struct pdev_archdata {
 	u64 dma_mask;
 };
 
-#define ARCH_HAS_DMA_GET_REQUIRED_MASK
-
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 59c090b7eaac..b1999880fc61 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,5 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
-extern u64 __dma_get_required_mask(struct device *dev);
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a47de82fb8e2..99f06102474e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -47,9 +47,7 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	/* Platform set_dma_mask and dma_get_required_mask overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct device *dev);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 5c7a1e7ffc8a..aace7033fa02 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -46,7 +46,6 @@ struct pci_controller_ops {
 #endif
 
 	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct pci_dev *pdev);
 
 	void		(*shutdown)(struct pci_controller *hose);
 };
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 716b7eab3ee7..9ca9d2cec4ed 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -197,18 +197,6 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static u64 dma_nommu_get_required_mask(struct device *dev)
-{
-	u64 end, mask;
-
-	end = memblock_end_of_DRAM() + get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -246,7 +234,6 @@ const struct dma_map_ops dma_nommu_ops = {
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
-	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
 	.sync_single_for_device 	= dma_nommu_sync_single,
@@ -294,35 +281,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-u64 __dma_get_required_mask(struct device *dev)
-{
-	const struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if (unlikely(dma_ops == NULL))
-		return 0;
-
-	if (dma_ops->get_required_mask)
-		return dma_ops->get_required_mask(dev);
-
-	return DMA_BIT_MASK(8 * sizeof(dma_addr_t));
-}
-
-u64 dma_get_required_mask(struct device *dev)
-{
-	if (ppc_md.dma_get_required_mask)
-		return ppc_md.dma_get_required_mask(dev);
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
-		if (phb->controller_ops.dma_get_required_mask)
-			return phb->controller_ops.dma_get_required_mask(pdev);
-	}
-
-	return __dma_get_required_mask(dev);
-}
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
-
 static int __init dma_init(void)
 {
 #ifdef CONFIG_IBMVIO
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 23cf4427f425..057357521561 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1179,7 +1179,6 @@ int __init platform_bus_init(void)
 	return error;
 }
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
 static u64 dma_default_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
@@ -1208,7 +1207,6 @@ u64 dma_get_required_mask(struct device *dev)
 	return dma_default_get_required_mask(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
-#endif
 
 static __initdata LIST_HEAD(early_platform_driver_list);
 static __initdata LIST_HEAD(early_platform_device_list);
-- 
2.19.0
