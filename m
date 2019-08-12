Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfHLL5b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 07:57:31 -0400
Date: Mon, 12 Aug 2019 13:57:26 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] usb: add a HCD_DMA flag instead of guestimating
 DMA capabilities
Message-ID: <20190812115726.GA9180@lst.de>
References: <20190811080520.21712-1-hch@lst.de> <20190811080520.21712-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811080520.21712-4-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>, Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org, Mathias Nyman <mathias.nyman@intel.com>, Geoff Levand <geoff@infradead.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Minas Harutyunyan <hminas@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <20190812115726.axOrBl6GYClFpBxyIcVp20lp5ZCpqsvNeeRYroaDxuw@z>

> diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
> index 576f7d79ad4e..9d17e0695e35 100644
> --- a/drivers/usb/host/ehci-ppc-of.c
> +++ b/drivers/usb/host/ehci-ppc-of.c
> @@ -31,7 +31,7 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
>  	 * generic hardware linkage
>  	 */
>  	.irq			= ehci_irq,
> -	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
> +	.flags			= HCD_MEMORY | HC_DMA | HCD_USB2 | HCD_BH,

FYI, the kbuild bot found a little typo here, so even for the unlikely
case that the series is otherwise perfect I'll have to resend it at
least once.
