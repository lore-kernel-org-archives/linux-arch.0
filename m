From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] openrisc: use the generic in-place uncached DMA allocator
Date: Mon, 24 Feb 2020 11:44:45 -0800
Message-ID: <20200224194446.690816-6-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Switch openrisc to use the dma-direct allocator and just provide the
hooks for setting memory uncached or cached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/Kconfig      |  2 ++
 arch/openrisc/kernel/dma.c | 55 +++++++-------------------------------
 2 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1928e061ff96..7e94fe37cb2f 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,8 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_SET_UNCACHED
+	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index adec711ad39d..c152a68811dd 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -11,8 +11,6 @@
  * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
  *
  * DMA mapping callbacks...
- * As alloc_coherent is the only DMA callback being used currently, that's
- * the only thing implemented properly.  The rest need looking into...
  */
 
 #include <linux/dma-noncoherent.h>
@@ -67,62 +65,29 @@ static const struct mm_walk_ops clear_nocache_walk_ops = {
 	.pte_entry		= page_clear_nocache,
 };
 
-/*
- * Alloc "coherent" memory, which for OpenRISC means simply uncached.
- *
- * This function effectively just calls __get_free_pages, sets the
- * cache-inhibit bit on those pages, and makes sure that the pages are
- * flushed out of the cache before they are used.
- *
- * If the NON_CONSISTENT attribute is set, then this function just
- * returns "normal", cachable memory.
- *
- * There are additional flags WEAK_ORDERING and WRITE_COMBINE to take
- * into consideration here, too.  All current known implementations of
- * the OR1K support only strongly ordered memory accesses, so that flag
- * is being ignored for now; uncached but write-combined memory is a
- * missing feature of the OR1K.
- */
-void *
-arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va;
-	void *page;
-
-	page = alloc_pages_exact(size, gfp | __GFP_ZERO);
-	if (!page)
-		return NULL;
-
-	/* This gives us the real physical address of the first page. */
-	*dma_handle = __pa(page);
-
-	va = (unsigned long)page;
+	unsigned long va = (unsigned long)cpu_addr;
+	int error;
 
 	/*
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL)) {
-		free_pages_exact(page, size);
-		return NULL;
-	}
-
-	return (void *)va;
+	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
+			NULL);
+	if (error)
+		return ERR_PTR(error);
+	return cpu_addr;
 }
 
-void
-arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va = (unsigned long)vaddr;
+	unsigned long va = (unsigned long)cpu_addr;
 
 	/* walk_page_range shouldn't be able to fail here */
 	WARN_ON(walk_page_range(&init_mm, va, va + size,
 			&clear_nocache_walk_ops, NULL));
-
-	free_pages_exact(vaddr, size);
 }
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.24.1
