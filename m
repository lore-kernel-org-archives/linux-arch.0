From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] dma-direct: provide a arch_dma_clear_uncached hook
Date: Mon, 24 Feb 2020 11:44:44 -0800
Message-ID: <20200224194446.690816-5-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgBXTpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 14:45:12 -0500
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This allows the arch code to reset the page tables to cached access when
freeing a dma coherent allocation that was set to uncached using
arch_dma_set_uncached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                    | 7 +++++++
 include/linux/dma-noncoherent.h | 1 +
 kernel/dma/direct.c             | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 090cfe0c82a7..c26302f90c96 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -255,6 +255,13 @@ config ARCH_HAS_SET_DIRECT_MAP
 config ARCH_HAS_DMA_SET_UNCACHED
 	bool
 
+#
+# Select if the architectures provides the arch_dma_clear_uncached symbol
+# to undo an in-place page table remap for uncached access.
+#
+config ARCH_HAS_DMA_CLEAR_UNCACHED
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 1a4039506673..b59f1b6be3e9 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -109,5 +109,6 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
 void *arch_dma_set_uncached(void *addr, size_t size);
+void arch_dma_clear_uncached(void *addr, size_t size);
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f01a8191fd59..a8560052a915 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -219,6 +219,8 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
 		vunmap(cpu_addr);
+	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
+		arch_dma_clear_uncached(cpu_addr, size);
 
 	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
 }
-- 
2.24.1
