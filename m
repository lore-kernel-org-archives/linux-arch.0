Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46431 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcESOYP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 10:24:15 -0400
Date: Thu, 19 May 2016 10:22:48 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCHv6 3/8] dma-mapping: add dma_{map,unmap}_resource
Message-ID: <20160519142248.GB21691@localhost.localdomain>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160517145445.GE4074@char.us.oracle.com>
 <20160519112926.GO29375@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160519112926.GO29375@bigcity.dyn.berto.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, linux-arch@vger.kernel.org, geert+renesas@glider.be, arnd@arndb.de, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com
Message-ID: <20160519142248.c1ovmV_ekovaZx3K30w6bCBxnivVeILhDU3SGPKFWoA@z>

On Thu, May 19, 2016 at 01:29:26PM +0200, Niklas Söderlund wrote:
> Hi Konrad,
> 
> Thanks for your feedback.
> 
> On 2016-05-17 10:54:45 -0400, Konrad Rzeszutek Wilk wrote:
> > >  
> > > -In some circumstances dma_map_single() and dma_map_page() will fail to create
> > > -a mapping. A driver can check for these errors by testing the returned
> > > -DMA address with dma_mapping_error(). A non-zero return value means the mapping
> > > -could not be created and the driver should take appropriate action (e.g.
> > > -reduce current DMA mapping usage or delay and try again later).
> > > +In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
> > > +will fail to create a mapping. A driver can check for these errors by testing
> > > +the returned DMA address with dma_mapping_error(). A non-zero return value
> > > +means the mapping could not be created and the driver should take appropriate
> > > +action (e.g. reduce current DMA mapping usage or delay and try again later).
> > 
> > This looks like it belongs to another patch?
> 
> No it is correct (at least intended to be in this patch). All it really 
> do is inject dma_map_resource() (which is added in this patch) as one of 
> the calls which return dma_addr_t should be checked for error using 
> dma_mapping_error().  But yes the change effect all lines in the 
> paragraph due to line wrapping.
> 
> Hum or maybe I'm misunderstanding your question.

I totally missed the 'dma_map_resource' in there and just read
'dma_mapping_error'!

<sigh> Thanks.
> 
> -- 
> Regards,
> Niklas Söderlund
