From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 13/29] nios2: DMA mapping API
Date: Tue, 15 Jul 2014 11:38:38 +0200
Message-ID: <4843763.ps2D25LEeM@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-14-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64466 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105AbaGOJiu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:38:50 -0400
In-Reply-To: <1405413956-2772-14-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Tuesday 15 July 2014 16:45:40 Ley Foon Tan wrote:

> +static inline void __dma_sync(void *vaddr, size_t size,
> +			      enum dma_data_direction direction)
> +{
> +	switch (direction) {
> +	case DMA_FROM_DEVICE:	/* invalidate cache */
> +		invalidate_dcache_range((unsigned long)vaddr,
> +			(unsigned long)(vaddr + size));
> +		break;
> +	case DMA_TO_DEVICE:	/* flush and invalidate cache */
> +	case DMA_BIDIRECTIONAL:
> +		flush_dcache_range((unsigned long)vaddr,
> +			(unsigned long)(vaddr + size));
> +		break;
> +	default:
> +		BUG();
> +	}
> +}

This seems strange. More on that below.

> +#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
> +#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
> +
...
> +static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
> +				  enum dma_data_direction direction)
> +{
> +	__dma_sync(vaddr, size, direction);
> +}

IIRC dma_cache_sync should be empty if you define dma_alloc_noncoherent
to be the same as dma_alloc_coherent: It's already coherent, so no sync
should be needed. What does the CPU do if you try to invalidate the cache
on a coherent mapping?

> +void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +			     size_t size, enum dma_data_direction direction)
> +{
> +	BUG_ON(!valid_dma_direction(direction));
> +
> +	__dma_sync(phys_to_virt(dma_handle), size, direction);
> +}
> +EXPORT_SYMBOL(dma_sync_single_for_cpu);
> +
> +void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
> +				size_t size, enum dma_data_direction direction)
> +{
> +	BUG_ON(!valid_dma_direction(direction));
> +
> +	__dma_sync(phys_to_virt(dma_handle), size, direction);
> +}
> +EXPORT_SYMBOL(dma_sync_single_for_device);

More importantly: you do the same operation for both _for_cpu and _for_device.
I assume your CPU can never do speculative cache prefetches, so it's not
incorrect, but you do twice the number of invalidations and flushes that
you need. 

Why would you do anything for _for_cpu here?

	Arnd
