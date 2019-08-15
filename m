From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: next take at setting up a dma mask by default for platform
 devices
Date: Thu, 15 Aug 2019 10:39:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1908151039260.1664-100000@iolanthe.rowland.org>
References: <20190815132531.GA12036@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815132531.GA12036@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Olav Kongas <ok@artecdesign.ee>, Tony Prisk <linux@prisktech.co.nz>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.orglin
List-Id: linux-arch.vger.kernel.org

On Thu, 15 Aug 2019, Christoph Hellwig wrote:

> On Thu, Aug 15, 2019 at 03:23:18PM +0200, Greg Kroah-Hartman wrote:
> > I've taken the first 2 patches for 5.3-final.  Given that patch 3 needs
> > to be fixed, I'll wait for a respin of these before considering them.
> 
> I have a respun version ready, but I'd really like to hear some
> comments from usb developers about the approach before spamming
> everyone again..

I didn't see any problems with your approach at first glance; it looked 
like a good idea.

Alan Stern
