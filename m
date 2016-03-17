Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33778 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936159AbcCQQnS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 12:43:18 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Thu, 17 Mar 2016 13:33:51 +0200
Message-ID: <3286525.zPAGiD4Xk2@avalon>
In-Reply-To: <20160315082254.GE9136@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <20160311125846.GF1111@bigcity.dyn.berto.se> <20160315082254.GE9136@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20160317113351.Uwt_1gDT_7Evh7deC_xsncwfa5a7cjSq4N4CYkUe7pg@z>

Hello,

On Tuesday 15 March 2016 01:22:54 Christoph Hellwig wrote:
> On Fri, Mar 11, 2016 at 01:58:46PM +0100, Niklas S?derlund wrote:
> > Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> > the same and no special care is needed. However if you have a IOMMU you
> > need to map the DMA slave phys_addr_t to a dma_addr_t using something
> > like this. Is it not very similar to dma_map_single() where one maps
> > processor virtual memory (instead if MMIO) so that it can be used with
> > DMA slaves?
> 
> It's similar, but I don't think this actually works as a general case
> as there are quite a few places that expect to be able to have a
> struct page for a physical address.  We'd at least need a very careful
> audit for that case.

The good news is that, given that no code uses this new API at the moment, 
there isn't much to audit. The patch series implements the resource mapping 
for arch/arm only, and makes use of it in the rcar-dmac driver only. Would you 
like anything audited else than the arch/arm dma mapping implementation, the 
rcar-dmac driver and the code that then deals with the dma addresses (I'm 
thinking about the IOMMU subsystem and the ipmmu-vmsa driver in particular) ?

-- 
Regards,

Laurent Pinchart

