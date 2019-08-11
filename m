Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKIFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:54 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] usb/max3421: remove the dummy {un,}map_urb_for_dma methods
Date: Sun, 11 Aug 2019 10:05:18 +0200
Message-ID: <20190811080520.21712-5-hch@lst.de>
In-Reply-To: <20190811080520.21712-1-hch@lst.de>
References: <20190811080520.21712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Olav Kongas <ok@artecdesign.ee>, Tony Prisk <linux@prisktech.co.nz>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190811080518.i5Pwd5ojg8qdYT62w7aq7y-X_aTuHNRcFqxHkV-f1Pk@z>

Now that we have an explicit HCD_DMA flag, there is not need to override
these methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/host/max3421-hcd.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index afa321ab55fc..8819f502b6a6 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1800,21 +1800,6 @@ max3421_bus_resume(struct usb_hcd *hcd)
 	return -1;
 }
 
-/*
- * The SPI driver already takes care of DMA-mapping/unmapping, so no
- * reason to do it twice.
- */
-static int
-max3421_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
-{
-	return 0;
-}
-
-static void
-max3421_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
-{
-}
-
 static const struct hc_driver max3421_hcd_desc = {
 	.description =		"max3421",
 	.product_desc =		DRIVER_DESC,
@@ -1826,8 +1811,6 @@ static const struct hc_driver max3421_hcd_desc = {
 	.get_frame_number =	max3421_get_frame_number,
 	.urb_enqueue =		max3421_urb_enqueue,
 	.urb_dequeue =		max3421_urb_dequeue,
-	.map_urb_for_dma =	max3421_map_urb_for_dma,
-	.unmap_urb_for_dma =	max3421_unmap_urb_for_dma,
 	.endpoint_disable =	max3421_endpoint_disable,
 	.hub_status_data =	max3421_hub_status_data,
 	.hub_control =		max3421_hub_control,
-- 
2.20.1
