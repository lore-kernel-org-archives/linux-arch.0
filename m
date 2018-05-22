Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeEVMFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:16 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/25] nds32: implement the unmap_sg DMA operation
Date: Tue, 22 May 2018 14:04:14 +0200
Message-ID: <20180522120430.28709-10-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Message-ID: <20180522120414.f-Q3MlVtHCdMz1GJQVhSDGQ05cc0gVvJp6CjrQFUR5I@z>

This matches the implementation of the more commonly used unmap_single
routines and the sync_sg_for_cpu method which should provide equivalent
cache maintainance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 4e6fb4ffd3f7..43d7fd432bb6 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -426,6 +426,12 @@ static void nds32_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nhwentries, enum dma_data_direction dir,
 			       unsigned long attrs)
 {
+	int i;
+
+	for (i = 0; i < nhwentries; i++, sg++) {
+		nds32_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+				sg->length, dir);
+	}
 }
 
 struct dma_map_ops nds32_dma_ops = {
-- 
2.17.0
