Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeEVMFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:11 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/25] nds32: remove the broken kmap code in nds32_dma_map_sg
Date: Tue, 22 May 2018 14:04:12 +0200
Message-ID: <20180522120430.28709-8-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Message-ID: <20180522120412.shR57G8h9VDo9jQVIs7tWqEGKrwPcamNc0fQ1Fz8yB4@z>

nds32_dma_map_sg is the only of the various DMA operations that tries
to deal with highmem (the single page variants and SG sync routines are
missing, SG unmap is entirely unimplemented), and it does so without
taking into account S/G list items that are bigger than a page, which
are legal and can happen frequently.

Remove this code for now - if highmem support on nds32 becomes a real
thing it needs to be added back as a loop over pages in the newly
consolidated code that deals with all operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d291800fc621..e1bf7206e015 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -393,24 +393,9 @@ static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		void *virt;
-		unsigned long pfn;
-		struct page *page = sg_page(sg);
-
-		sg->dma_address = sg_phys(sg);
-		pfn = page_to_pfn(page) + sg->offset / PAGE_SIZE;
-		page = pfn_to_page(pfn);
-		if (PageHighMem(page)) {
-			virt = kmap_atomic(page);
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-			kunmap_atomic(virt);
-		} else {
-			if (sg->offset > PAGE_SIZE)
-				panic("sg->offset:%08x > PAGE_SIZE\n",
-				      sg->offset);
-			virt = page_address(page) + sg->offset;
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-		}
+		char *virt =
+		    page_address((struct page *)sg->page_link) + sg->offset;
+		consistent_sync(virt, sg->length, dir, FOR_CPU);
 	}
 	return nents;
 }
-- 
2.17.0
