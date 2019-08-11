Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfHKIFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:54 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: next take at setting up a dma mask by default for platform devices
Date: Sun, 11 Aug 2019 10:05:14 +0200
Message-ID: <20190811080520.21712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Olav Kongas <ok@artecdesign.ee>, Tony Prisk <linux@prisktech.co.nz>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190811080514.oTy2Gf1Rg_O1rP2-fhzb_gwSOxffjvCPNVEzV3FCZ1I@z>

Hi all,

this is another attempt to make sure the dma_mask pointer is always
initialized for platform devices.  Not doing so lead to lots of
boilerplate code, and makes platform devices different from all our
major busses like PCI where we always set up a dma_mask.  In the long
run this should also help to eventually make dma_mask a scalar value
instead of a pointer and remove even more cruft.

The bigger blocker for this last time was the fact that the usb
subsystem uses the presence or lack of a dma_mask to check if the core
should do dma mapping for the driver, which is highly unusual.  So we
fix this first.  Note that this has some overlap with the pending
desire to use the proper dma_mmap_coherent helper for mapping usb
buffers.  The first two patches from this series should probably
go into 5.3 and then uses as the basis for the decision to use
dma_mmap_coherent.
