Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59575 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeAJIKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 03:10:04 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
Date: Wed, 10 Jan 2018 09:09:18 +0100
Message-ID: <20180110080932.14157-9-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180110080918.83MwarJ_Eii_EpXqrOoBeYZYhap1ofJKwsD5g44eleQ@z>

To properly reject too small DMA masks based on the addressability of the
bounce buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 0fae2f45c3c0..539fd1099ba9 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1128,5 +1128,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
+	.dma_supported		= swiotlb_dma_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.14.2
