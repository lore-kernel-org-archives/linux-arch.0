From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
 method to more generic alloc/free_attrs
Date: Fri, 24 Jun 2011 11:15:47 -0500
Message-ID: <1308932147.5929.0.camel@mulgrave>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	 <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	 <201106241751.35655.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53814 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759725Ab1FXQQI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2011 12:16:08 -0400
In-Reply-To: <201106241751.35655.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Fri, 2011-06-24 at 17:51 +0200, Arnd Bergmann wrote:
> On Monday 20 June 2011, Marek Szyprowski wrote:
> > Introduce new alloc/free/mmap methods that take attributes argument.
> > alloc/free_coherent can be implemented on top of the new alloc/free
> > calls with NULL attributes. dma_alloc_non_coherent can be implemented
> > using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
> > use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
> > get more generic, platform independent way of allocating dma memory
> > buffers with specific parameters.
> > 
> > One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
> > such attribute will not have valid kernel virtual address. They might be
> > usefull for drivers that only exports the DMA buffers to userspace (like
> > for example V4L2 or ALSA).
> > 
> > mmap method is introduced to let the drivers create a user space mapping
> > for a DMA buffer in generic, architecture independent way.
> > 
> > TODO: update all dma_map_ops clients for all architectures
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Yes, I think that is good, but the change needs to be done atomically
> across all architectures. This should be easy enough as I believe
> all other architectures that use dma_map_ops don't even require
> dma_alloc_noncoherent

This statement is definitely not true of parisc, and also, I believe,
not true of sh, so that would have to figure in the conversion work too.

James


>  but just define it to dma_alloc_coherent
> because they have only coherent memory in regular device drivers.
> 
> On a related note, do you plan to make the CMA work use this
> transparently, or do you want to have a DMA_ATTR_LARGE or
> DMA_ATTR_CONTIGUOUS for CMA?
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
