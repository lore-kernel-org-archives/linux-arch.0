From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] dma-direct: remove the cached_kernel_address hook
Date: Mon, 24 Feb 2020 11:44:41 -0800
Message-ID: <20200224194446.690816-2-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

dma-direct now finds the kernel address for coherent allocations based
on the dma address, so the cached_kernel_address hooks is unused and
can be removed entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                    |  2 +-
 arch/microblaze/mm/consistent.c |  7 -------
 arch/mips/mm/dma-noncoherent.c  |  5 -----
 arch/nios2/mm/dma-mapping.c     | 10 ----------
 arch/xtensa/kernel/pci-dma.c    | 10 ++--------
 include/linux/dma-noncoherent.h |  1 -
 6 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 98de654b79b3..7994b239f155 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -249,7 +249,7 @@ config ARCH_HAS_SET_DIRECT_MAP
 
 #
 # Select if arch has an uncached kernel segment and provides the
-# uncached_kernel_address / cached_kernel_address symbols to use it
+# uncached_kernel_address symbol to use it
 #
 config ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index 8c5f0c332d8b..cede7c5e8135 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -49,11 +49,4 @@ void *uncached_kernel_address(void *ptr)
 		pr_warn("ERROR: Your cache coherent area is CACHED!!!\n");
 	return (void *)addr;
 }
-
-void *cached_kernel_address(void *ptr)
-{
-	unsigned long addr = (unsigned long)ptr;
-
-	return (void *)(addr & ~UNCACHED_SHADOW_MASK);
-}
 #endif /* CONFIG_MMU */
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index dc42ffc83825..77dce28ad0a0 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -54,11 +54,6 @@ void *uncached_kernel_address(void *addr)
 	return (void *)(__pa(addr) + UNCAC_BASE);
 }
 
-void *cached_kernel_address(void *addr)
-{
-	return __va(addr) - UNCAC_BASE;
-}
-
 static inline void dma_sync_virt(void *addr, size_t size,
 		enum dma_data_direction dir)
 {
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 0ed711e37902..f30f2749257c 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -75,13 +75,3 @@ void *uncached_kernel_address(void *ptr)
 
 	return (void *)ptr;
 }
-
-void *cached_kernel_address(void *ptr)
-{
-	unsigned long addr = (unsigned long)ptr;
-
-	addr &= ~CONFIG_NIOS2_IO_REGION_BASE;
-	addr |= CONFIG_NIOS2_KERNEL_REGION_BASE;
-
-	return (void *)ptr;
-}
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 72b6222daa0b..6a685545d5c9 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -88,18 +88,12 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 
 /*
  * Memory caching is platform-dependent in noMMU xtensa configurations.
- * The following two functions should be implemented in platform code
- * in order to enable coherent DMA memory operations when CONFIG_MMU is not
- * enabled.
+ * This function should be implemented in platform code in order to enable
+ * coherent DMA memory operations when CONFIG_MMU is not enabled.
  */
 #ifdef CONFIG_MMU
 void *uncached_kernel_address(void *p)
 {
 	return p + XCHAL_KSEG_BYPASS_VADDR - XCHAL_KSEG_CACHED_VADDR;
 }
-
-void *cached_kernel_address(void *p)
-{
-	return p + XCHAL_KSEG_CACHED_VADDR - XCHAL_KSEG_BYPASS_VADDR;
-}
 #endif /* CONFIG_MMU */
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index ca9b5770caee..b6b72e19b0cd 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -109,6 +109,5 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
 void *uncached_kernel_address(void *addr);
-void *cached_kernel_address(void *addr);
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
-- 
2.24.1
