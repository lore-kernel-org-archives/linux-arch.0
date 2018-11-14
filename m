From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 32/34] powerpc/dma: remove get_dma_offset
Date: Wed, 14 Nov 2018 09:23:12 +0100
Message-ID: <20181114082314.8965-33-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Just fold the calculation into __phys_to_dma/__dma_to_phys as those are
the only places that should know about it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-direct.h  |  8 ++++++--
 arch/powerpc/include/asm/dma-mapping.h | 16 ----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index 92d8aed86422..a2912b47102c 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -13,11 +13,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return paddr + get_dma_offset(dev);
+	if (!dev)
+		return paddr + PCI_DRAM_OFFSET;
+	return paddr + dev->archdata.dma_offset;
 }
 
 static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	return daddr - get_dma_offset(dev);
+	if (!dev)
+		return daddr - PCI_DRAM_OFFSET;
+	return daddr - dev->archdata.dma_offset;
 }
 #endif /* ASM_POWERPC_DMA_DIRECT_H */
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 93e57e28be28..c70f55d2f5e0 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -43,22 +43,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/*
- * get_dma_offset()
- *
- * Get the dma offset on configurations where the dma address can be determined
- * from the physical address by looking at a simple offset.  Direct dma and
- * swiotlb use this function, but it is typically not used by implementations
- * with an iommu.
- */
-static inline dma_addr_t get_dma_offset(struct device *dev)
-{
-	if (dev)
-		return dev->archdata.dma_offset;
-
-	return PCI_DRAM_OFFSET;
-}
-
 static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 {
 	if (dev)
-- 
2.19.1
