From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Tue, 15 Mar 2016 01:22:54 -0700
Message-ID: <20160315082254.GE9136@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
 <20160311111522.GA3450@infradead.org>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from [198.137.202.9] ([198.137.202.9]:33439 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933849AbcCOIXn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Mar 2016 04:23:43 -0400
Content-Disposition: inline
In-Reply-To: <20160311125846.GF1111@bigcity.dyn.berto.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Fri, Mar 11, 2016 at 01:58:46PM +0100, Niklas S?derlund wrote:
> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are 
> the same and no special care is needed. However if you have a IOMMU you 
> need to map the DMA slave phys_addr_t to a dma_addr_t using something 
> like this. Is it not very similar to dma_map_single() where one maps 
> processor virtual memory (instead if MMIO) so that it can be used with 
> DMA slaves?

It's similar, but I don't think this actually works as a general case
as there are quite a few places that expect to be able to have a
struct page for a physical address.  We'd at least need a very careful
audit for that case.
