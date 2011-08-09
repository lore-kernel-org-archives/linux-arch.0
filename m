From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/24] C6X: memory management
Date: Tue, 9 Aug 2011 18:27:39 +0200
Message-ID: <201108091827.40045.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-8-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63428 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1HIQ1p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:27:45 -0400
In-Reply-To: <1312839879-13592-8-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> +#define dma_supported(d, m)	    (1)
> +
> +#define __pfn_to_bus(pfn)	   ((pfn) << PAGE_SHIFT)
> +#define __bus_to_pfn(paddr)	   ((paddr) >> PAGE_SHIFT)
> +#define __bus_to_phys(x)	   (x)
> +#define __phys_to_bus(x)	   (x)
> +#define __bus_to_virt(b)	   phys_to_virt(__bus_to_phys(b))
> +#define __virt_to_bus(v)	   __phys_to_bus(virt_to_phys(v))
> +
> +/*
> + * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
> + * used internally by the DMA-mapping API to provide DMA addresses. They
> + * must not be used by drivers.
> + */
> +static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
> +{
> +	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
> +}
> +
> +static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
> +{
> +	return pfn_to_page(__bus_to_pfn(addr));
> +}
> +
> +static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
> +{
> +	return (void *)__bus_to_virt(addr);
> +}
> +
> +static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> +{
> +	return (dma_addr_t)__virt_to_bus(addr);
> +}

It would be better not to provide these functions. Drivers are supposed
to use the proper dma mapping API functions that you also provide.
Using those ensures that drives can still work when you add an IOMMU.

> +extern int __dma_is_coherent(struct device *dev, dma_addr_t handle);
> +
> +static inline int dma_is_consistent(struct device *dev, dma_addr_t handle)
> +{
> +	if (arch_is_coherent() || __dma_is_coherent(dev, handle))
> +		return 1;
> +	else
> +		return 0;
> +}

Does this need to be both a runtime decision and set per device?
Most architectures are just always consistent or never, so you could
turn this into an #ifdef block to define the two versions, or even
just provide one version.

> +extern void dma_free_coherent(struct device *, size_t, void *, dma_addr_t);
> +
> +#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent((d), (s), (h), (f))
> +#define dma_free_noncoherent(d, s, v, h)  dma_free_coherent((d), (s), (v), (h))
> +
> +extern void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
> +				    enum dma_data_direction dir);
> +
> +extern void __dma_single_dev_to_cpu(const void *kaddr, size_t size,
> +				    enum dma_data_direction dir);
> +
> +extern void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
> +				  size_t size, enum dma_data_direction dir);
> +
> +extern void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
> +				  size_t size, enum dma_data_direction dir);
> +
> +/**
> + * dma_map_single - map a single buffer for streaming DMA
> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> + * @cpu_addr: CPU direct mapped address of buffer
> + * @size: size of buffer to map
> + * @dir: DMA transfer direction
> + *
> + * Ensure that any data held in the cache is appropriately discarded
> + * or written back.
> + *
> + * The device owns this memory once this call has completed.  The CPU
> + * can regain ownership by calling dma_unmap_single() or
> + * dma_sync_single_for_cpu().
> + */
> +static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	__dma_single_cpu_to_dev(cpu_addr, size, dir);
> +
> +	return virt_to_dma(dev, cpu_addr);
> +}

The naming is a little confusing. Why not call the standard dma_sync_* functions
and make them extern instead of having multiple layers of wrappers.

> diff --git a/arch/c6x/include/asm/dma.h b/arch/c6x/include/asm/dma.h
> new file mode 100644
> index 0000000..2ac46c3
> --- /dev/null
> +++ b/arch/c6x/include/asm/dma.h
> @@ -0,0 +1,23 @@
> +/*
> + *  Port on Texas Instruments TMS320C6x architecture
> + *
> + *  Copyright (C) 2004, 2009 Texas Instruments Incorporated
> + *  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +#ifndef _ASM_C6X_DMA_H
> +#define _ASM_C6X_DMA_H
> +
> +#define MAX_DMA_ADDRESS  0xFFFFFFFF
> +#define MAX_DMA_CHANNELS 64
> +
> +/* Reserve a DMA channel */
> +extern int request_dma(unsigned int dmanr, const char *device_id);
> +
> +/* Release it again */
> +extern void free_dma(unsigned int dmanr);
> +
> +#endif /* _ASM_C6X_DMA_H */

These should not be there. The dma.h header is only for ISA-style DMA,
which I'm sure you don't have.

> +void *dma_alloc_coherent(struct device *dev, size_t size,
> +			 dma_addr_t *handle, gfp_t gfp)
> +{
> +	u32 paddr;
> +	void __iomem *virt;
> +
> +	if (in_interrupt())
> +		BUG();
> +
> +	/* Round up to a page */
> +	size = PAGE_ALIGN(size);
> +
> +	spin_lock_irq(&dma_mem_lock);
> +
> +	/* Check if we have a DMA memory */
> +	if (dma_page_heap)
> +		paddr = __dma_alloc_coherent(size, gfp);
> +	else
> +		/* Otherwise do an allocation using standard allocator */
> +		paddr = __dma_alloc_coherent_stdmem(size, gfp);
> +
> +	spin_unlock_irq(&dma_mem_lock);
> +
> +	if (paddr == -1)
> +		return NULL;
> +
> +	if (handle)
> +		*handle = __phys_to_bus(paddr);
> +
> +	/*
> +	 * In a near future we can expect having a partial MMU with
> +	 * chaching attributes
> +	 */
> +	virt = ioremap_nocache(paddr, size);
> +	if (!virt)
> +		return NULL;
> +
> +	/*
> +	 * We need to ensure that there are no cachelines in use, or
> +	 * worse dirty in this area.
> +	 */
> +	L2_cache_block_invalidate(paddr, paddr + size);
> +
> +	return (void *) virt;
> +}
> +EXPORT_SYMBOL(dma_alloc_coherent);

The pointer should not be __iomem, because it is definitely not an
MMIO register. You might want to add another low-level memory remapping
function when you add MMU support that uses the same low-level code as
ioremap, but does not change the address space annotations.

	Arnd
