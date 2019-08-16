Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHPG3Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 02:29:24 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/6] dma-mapping: remove is_device_dma_capable
Date: Fri, 16 Aug 2019 08:24:34 +0200
Message-ID: <20190816062435.881-6-hch@lst.de>
In-Reply-To: <20190816062435.881-1-hch@lst.de>
References: <20190816062435.881-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190816062434.m8lqqy_RTnDf2mFS9_Y8ZemUXxUqNPNFeFUGjf-KJgE@z>

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..14702e2d6fa8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -149,11 +149,6 @@ static inline int valid_dma_direction(int dma_direction)
 		(dma_direction == DMA_FROM_DEVICE));
 }
 
-static inline int is_device_dma_capable(struct device *dev)
-{
-	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
-}
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
2.20.1
