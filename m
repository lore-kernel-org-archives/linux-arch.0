Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeDPIut (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Apr 2018 04:50:49 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/12] mtip32xx: don't use block layer bounce buffers
Date: Mon, 16 Apr 2018 10:50:23 +0200
Message-ID: <20180416085032.7367-4-hch@lst.de>
In-Reply-To: <20180416085032.7367-1-hch@lst.de>
References: <20180416085032.7367-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20180416085023.XeBAF74NBcGRMxeH9NJKMQFZlOHsr2SZxsXUAZSbYK8@z>

mtip32xx just sets the block bounce limit to the dma mask, which means
that the iommu or swiotlb already take care of the bounce buffering,
and the block bouncing can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 769c551e3d71..b03bb27dcc58 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3862,7 +3862,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	blk_queue_max_hw_sectors(dd->queue, 0xffff);
 	blk_queue_max_segment_size(dd->queue, 0x400000);
 	blk_queue_io_min(dd->queue, 4096);
-	blk_queue_bounce_limit(dd->queue, dd->pdev->dma_mask);
 
 	/* Signal trim support */
 	if (dd->trim_supp == true) {
-- 
2.17.0
