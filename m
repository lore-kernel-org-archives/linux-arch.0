Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbdL2IW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Dec 2017 03:22:56 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 47/67] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date: Fri, 29 Dec 2017 09:18:51 +0100
Message-ID: <20171229081911.2802-48-hch@lst.de>
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20171229081851.knHgkuw3Y3D_WWlcFVpuadEVVkExNDCWNPamJVjCjn0@z>

To properly reject too small DMA masks based on the addressability of the
bounce buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 9c100f0173bf..e0b8980334c3 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1125,5 +1125,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
+	.dma_supported		= swiotlb_dma_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2
