From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Date: Tue, 24 Jul 2018 13:10:00 +0300
Message-ID: <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Refactoring, no functional change intended.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/dma.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index b693818cd8e5..46584c7c2858 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -27,30 +27,24 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page;
 	phys_addr_t paddr;
 	void *kvaddr;
-	int need_coh = 1, need_kvaddr = 0;
+	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
 
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
+	 * - A coherent buffer needs MMU mapping to enforce non-cachability
+	 * - A highmem page needs a virtual handle (hence MMU mapping)
+	 *   independent of cachability.
+	 * kvaddr is kernel Virtual address (0x7000_0000 based)
+	 */
+	if (PageHighMem(page) || need_coh) {
 		kvaddr = ioremap_nocache(paddr, size);
 		if (kvaddr == NULL) {
 			__free_pages(page, order);
@@ -81,11 +75,9 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 {
 	phys_addr_t paddr = dma_handle;
 	struct page *page = virt_to_page(paddr);
-	int is_non_coh = 1;
-
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
+	bool is_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
 
-	if (PageHighMem(page) || !is_non_coh)
+	if (PageHighMem(page) || is_coh)
 		iounmap((void __force __iomem *)vaddr);
 
 	__free_pages(page, get_order(size));
-- 
2.14.4
