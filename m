Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59129 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752223AbeERNWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 09:22:49 -0400
Date: Fri, 18 May 2018 15:27:31 +0200
From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
        implementation
Message-ID: <20180518132731.GA31125@lst.de>
References: <20180511075945.16548-1-hch@lst.de> <20180511075945.16548-3-hch@lst.de> <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Message-ID: <20180518132731.UE0_TnuXCV1CQqzmLftL1ipqQcSFeUutZLsf7Tk6nwM@z>

On Fri, May 18, 2018 at 01:03:46PM +0000, Alexey Brodkin wrote:
> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
> 
> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.

arc overrides the dir paramter of the dma_sync_single_for_device/
dma_sync_single_for_cpu calls.  My patches dropped that, and I have
restored that, and audit for the other architectures is pending.

That being said the existing arc code still looks rather odd as it
didn't do the same thing for the scatterlist versions of the calls.
I've thrown in a few patches into my new tree to make the sg versions
make the normal calls, and to clean up the area a bit.

> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Oops!  Thank you for all the debugging!
