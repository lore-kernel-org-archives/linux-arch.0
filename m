Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeERUG0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 16:06:26 -0400
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
Date: Fri, 18 May 2018 22:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
Cc: "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>
Message-ID: <20180518200551.aByBFr8EeeSLuz_l22mTlru09Y5aj-xfbeuhDhjkPdc@z>

On 18.05.2018 15:03, Alexey Brodkin wrote:
> But the real fix of my problem is:
> ---------------------------------------->8------------------------------------
> --- a/lib/dma-noncoherent.c
> +++ b/lib/dma-noncoherent.c
> @@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
>  
>         addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>         if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
>         return addr;
>  }
> ---------------------------------------->8------------------------------------
> 
> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Good.
This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.

So it leaves only one open issue on parisc:
Now every 32 bit parisc system is unnecessarily non-coherent.

Helge
