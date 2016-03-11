From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Fri, 11 Mar 2016 03:15:22 -0800
Message-ID: <20160311111522.GA3450@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52768 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbcCKLPX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 06:15:23 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Vinod Koul <vinod.koul@intel.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, iommu@lists.linux-foundation.org, robin.murphy@arm.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Thu, Mar 10, 2016 at 10:47:10PM -0800, Dan Williams wrote:
> I think it is confusing to use the dma_ prefix for this peer-to-peer
> mmio functionality.  dma_addr_t is a device's view of host memory.
> Something like bus_addr_t bus_map_resource().  Doesn't this routine
> also need the source device in addition to the target device?  The
> resource address is from the perspective of the host cpu, it may be a
> different address space in the view of two devices relative to each
> other.

Is it supposed to be per-mmio?  It's in dma-mapping ops, and has dma
in the name, so I suspected it's for some form of peer dma.  But given
that our dma APIs reuqire a struct page backing I have no idea how this
even supposed to work, and this little documentation blurb still doesn't
clear that up.

So for now I'd like to NAK this patch until the use case can be
explained clearly, and actually works.
