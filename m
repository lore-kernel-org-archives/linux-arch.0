Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46797 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbfHONiR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:38:17 -0400
Date: Thu, 15 Aug 2019 15:38:12 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
Message-ID: <20190815133812.GF12036@lst.de>
References: <20190811080520.21712-1-hch@lst.de> <20190811080520.21712-7-hch@lst.de> <20190815130325.GB17065@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815130325.GB17065@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Olav Kongas <ok@artecdesign.ee>, Tony Prisk <linux@prisktech.co.nz>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190815133812.3Mba2F9oiOSAYDnNivqIEgrK56PV4eF63TqtIYVXUno@z>

On Thu, Aug 15, 2019 at 03:03:25PM +0200, Greg Kroah-Hartman wrote:
> > --- a/include/linux/platform_device.h
> > +++ b/include/linux/platform_device.h
> > @@ -24,6 +24,7 @@ struct platform_device {
> >  	int		id;
> >  	bool		id_auto;
> >  	struct device	dev;
> > +	u64		dma_mask;
> 
> Why is the dma_mask in 'struct device' which is part of this structure,
> not sufficient here?  Shouldn't the "platform" be setting that up
> correctly already in the "archdata" type callback?

Becaus the dma_mask in struct device is a pointer that needs to point
to something, and this is the best space we can allocate for 'something'.
m68k and powerpc currently do something roughly equivalent at the moment,
while everyone else just has horrible, horrible hacks.  As mentioned in
the changelog the intent of this patch is that we treat platform devices
like any other bus, where the bus allocates the space for the dma_mask.
The long term plan is to eventually kill that weird pointer indirection
that doesn't help anyone, but for that we need to sort out the basics
first.
