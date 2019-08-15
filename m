Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732211AbfHOOFe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 10:05:34 -0400
Date: Thu, 15 Aug 2019 16:05:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: next take at setting up a dma mask by default for platform
 devices
Message-ID: <20190815140531.GC7174@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
 <20190815132318.GA27208@kroah.com>
 <20190815132531.GA12036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815132531.GA12036@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Gavin Li <git@thegavinli.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Minas Harutyunyan <hminas@synopsys.com>, Alan Stern <stern@rowland.harvard.edu>, Geoff Levand <geoff@infradead.org>, Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Olav Kongas <ok@artecdesign.ee>, Tony Prisk <linux@prisktech.co.nz>, Mathias Nyman <mathias.nyman@intel.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190815140531.eN_V6Wd8FepqXupG5HsQq7Sw3e7B3vOKN-TPw1TlHDY@z>

On Thu, Aug 15, 2019 at 03:25:31PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 03:23:18PM +0200, Greg Kroah-Hartman wrote:
> > I've taken the first 2 patches for 5.3-final.  Given that patch 3 needs
> > to be fixed, I'll wait for a respin of these before considering them.
> 
> I have a respun version ready, but I'd really like to hear some
> comments from usb developers about the approach before spamming
> everyone again..

Spam away, we can take it :)
