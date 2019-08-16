Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfHPG3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 02:29:09 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] usb: don't create dma pools for HCDs with a localmem_pool
Date: Fri, 16 Aug 2019 08:24:30 +0200
Message-ID: <20190816062435.881-2-hch@lst.de>
In-Reply-To: <20190816062435.881-1-hch@lst.de>
References: <20190816062435.881-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190816062430.tKebFl7W7qT9slopmPFXiTdknwowrnfbifbkG83v98g@z>

If the HCD provides a localmem pool we will never use the DMA pools, so
don't create them.

Fixes: b0310c2f09bb ("USB: use genalloc for USB HCs with local memory")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 1359b78a624e..1a5b3dcae930 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -66,9 +66,9 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int		i, size;
 
-	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    (!is_device_dma_capable(hcd->self.sysdev) &&
-	     !hcd->localmem_pool))
+	if (hcd->localmem_pool ||
+	    !IS_ENABLED(CONFIG_HAS_DMA) ||
+	    !is_device_dma_capable(hcd->self.sysdev))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-- 
2.20.1
