From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 08/24] C6X: memory management and DMA support
Date: Wed, 28 Sep 2011 15:46:32 +0200
Message-ID: <201109281546.32909.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-9-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52753 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1I1Nqh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:46:37 -0400
In-Reply-To: <1317155405-26235-9-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:

> +dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
> +			  enum dma_data_direction dir)
> +{
> +	dma_addr_t addr = virt_to_phys(ptr);
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		L2_cache_block_invalidate(addr, addr + size);
> +		break;
> +	case DMA_TO_DEVICE:
> +		L2_cache_block_writeback(addr, addr + size);
> +		break;
> +	case DMA_BIDIRECTIONAL:
> +		/*
> +		 * If area will be used bidirectionally, syncing will
> +		 * take place manually in the driver.
> +		 */

I think this comment is not strictly correct and you have to do a
writeback+invalidate here. When you map an area, it initially
belongs to the device, until you either do an unmap or sync_*_for_cpu.

> +void dma_unmap_single(struct device *dev, dma_addr_t handle,
> +		      size_t size, enum dma_data_direction dir)
> +{
> +	/* nothing to do here */
> +	debug_dma_unmap_page(dev, handle, size, dir, true);
> +}
> +EXPORT_SYMBOL(dma_unmap_single);

> +void dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
> +			     size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long paddr = handle;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		L2_cache_block_invalidate(paddr, paddr + size);
> +		break;
> +	case DMA_TO_DEVICE:
> +		L2_cache_block_writeback(paddr, paddr + size);
> +		break;
> +	case DMA_BIDIRECTIONAL:
> +		L2_cache_block_writeback_invalidate(paddr, paddr + size);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
> +}
> +EXPORT_SYMBOL(dma_sync_single_for_cpu);

Normally, sync_*_for_cpu is the same as unmap regarding the cache.

> +void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
> +				size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long paddr = handle;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	/* don't bother invalidating if DMA to device */
> +	if (dir != DMA_TO_DEVICE)
> +		L2_cache_block_invalidate(paddr, paddr + size);
> +
> +	debug_dma_sync_single_for_device(dev, handle, size, dir);
> +}
> +EXPORT_SYMBOL(dma_sync_single_for_device);

And this should do the same as map(). In particular it needs
to writeback the cache when direction is TO_DEVICE or BIDIRECTIONAL.

	Arnd
