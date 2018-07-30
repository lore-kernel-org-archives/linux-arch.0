From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 4/4] ARC: don't check for HIGHMEM pages in arch_dma_alloc
Date: Mon, 30 Jul 2018 19:26:36 +0300
Message-ID: <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

__GFP_HIGHMEM flag is cleared by upper layer functions
(in include/linux/dma-mapping.h) so we'll never get a
__GFP_HIGHMEM flag in arch_dma_alloc gfp argument.
That's why alloc_pages will never return highmem page
here.

Get rid of highmem pages handling and cleanup arch_dma_alloc
and arch_dma_free functions.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2 (Thanks to Christoph):
 * Remove check for HIGHMEM pages from arch_dma_{alloc, free}

 arch/arc/mm/dma.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 4d1466905e48..46129d7a298d 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -27,30 +27,29 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page;
 	phys_addr_t paddr;
 	void *kvaddr;
-	int need_coh = 1, need_kvaddr = 0;
+	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
+
+	/*
+	 * __GFP_HIGHMEM flag is cleared by upper layer functions
+	 * (in include/linux/dma-mapping.h) so we should never get a
+	 * __GFP_HIGHMEM here.
+	 */
+	BUG_ON(gfp & __GFP_HIGHMEM);
 
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		need_coh = 0;
-
-	/*
-	 * - A coherent buffer needs MMU mapping to enforce non-cachability
-	 * - A highmem page needs a virtual handle (hence MMU mapping)
-	 *   independent of cachability
-	 */
-	if (PageHighMem(page) || need_coh)
-		need_kvaddr = 1;
-
 	/* This is linear addr (0x8000_0000 based) */
 	paddr = page_to_phys(page);
 
 	*dma_handle = paddr;
 
-	/* This is kernel Virtual address (0x7000_0000 based) */
-	if (need_kvaddr) {
+	/*
+	 * A coherent buffer needs MMU mapping to enforce non-cachability.
+	 * kvaddr is kernel Virtual address (0x7000_0000 based).
+	 */
+	if (need_coh) {
 		kvaddr = ioremap_nocache(paddr, size);
 		if (kvaddr == NULL) {
 			__free_pages(page, order);
@@ -81,11 +80,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 {
 	phys_addr_t paddr = dma_handle;
 	struct page *page = virt_to_page(paddr);
-	int is_non_coh = 1;
-
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
 
-	if (PageHighMem(page) || !is_non_coh)
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
 		iounmap((void __force __iomem *)vaddr);
 
 	__free_pages(page, get_order(size));
-- 
2.14.4
