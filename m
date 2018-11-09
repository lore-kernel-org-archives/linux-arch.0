Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJAWP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Nov 2018 19:22:15 -0500
Subject: Re: [PATCH 1/2] dma-mapping: remove ->mapping_error
References: <20181109084632.22848-1-hch@lst.de>
 <20181109084632.22848-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <75c72464-1ff6-7c53-2cdb-0c5882c190aa@arm.com>
Date: Fri, 9 Nov 2018 14:41:18 +0000
MIME-Version: 1.0
In-Reply-To: <20181109084632.22848-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Message-ID: <20181109144118.U2zpjHYh0P6bwPn-UB2lcaxIpp2By7O7xjqfLrzVv08@z>

On 09/11/2018 08:46, Christoph Hellwig wrote:
[...]
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1167ff0416cf..cfb422e17049 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -55,8 +55,6 @@
>   #include "amd_iommu_types.h"
>   #include "irq_remapping.h"
>   
> -#define AMD_IOMMU_MAPPING_ERROR	0
> -
>   #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>   
>   #define LOOP_TIMEOUT	100000
> @@ -2339,7 +2337,7 @@ static dma_addr_t __map_single(struct device *dev,
>   	paddr &= PAGE_MASK;
>   
>   	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
> -	if (address == AMD_IOMMU_MAPPING_ERROR)
> +	if (address == DMA_MAPPING_ERROR)

This for one is clearly broken, because the IOVA allocator still returns 
0 on failure here...

>   		goto out;
>   
>   	prot = dir2prot(direction);
> @@ -2376,7 +2374,7 @@ static dma_addr_t __map_single(struct device *dev,
>   
>   	dma_ops_free_iova(dma_dom, address, pages);
>   
> -	return AMD_IOMMU_MAPPING_ERROR;
> +	return DMA_MAPPING_ERROR;
>   }
>   
>   /*
> @@ -2427,7 +2425,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
>   	if (PTR_ERR(domain) == -EINVAL)
>   		return (dma_addr_t)paddr;
>   	else if (IS_ERR(domain))
> -		return AMD_IOMMU_MAPPING_ERROR;
> +		return DMA_MAPPING_ERROR;
>   
>   	dma_mask = *dev->dma_mask;
>   	dma_dom = to_dma_ops_domain(domain);
> @@ -2504,7 +2502,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
>   	npages = sg_num_pages(dev, sglist, nelems);
>   
>   	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
> -	if (address == AMD_IOMMU_MAPPING_ERROR)
> +	if (address == DMA_MAPPING_ERROR)

..and here.

I very much agree with the concept, but I think the way to go about it 
is to convert the implementations which need it to the standardised 
*_MAPPING_ERROR value one-by-one, and only then then do the big sweep to 
remove them all. That has more of a chance of getting worthwhile review 
and testing from the respective relevant parties (I'll confess I came 
looking for this bug specifically, since I happened to recall amd_iommu 
having a tricky implicit reliance on the old DMA_ERROR_CODE being 0 on x86).

In terms of really minimising the error-checking overhead it's a bit of 
a shame that DMA_MAPPING_ERROR = 0 doesn't seem viable as the thing to 
standardise on, since that has advantages at the micro-optimisation 
level for many ISAs - fixing up the legacy IOMMU code doesn't seem 
insurmountable, but I suspect there may well be non-IOMMU platforms 
where DMA to physical address 0 is a thing :(

(yeah, I know saving a couple of instructions and potential register 
allocations is down in the noise when we're already going from an 
indirect call to an inline comparison; I'm mostly just thinking out loud 
there)

Robin.

>   		goto out_err;
>   
>   	prot = dir2prot(direction);
> @@ -2627,7 +2625,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
>   	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
>   				 size, DMA_BIDIRECTIONAL, dma_mask);
>   
> -	if (*dma_addr == AMD_IOMMU_MAPPING_ERROR)
> +	if (*dma_addr == DMA_MAPPING_ERROR)
>   		goto out_free;
>   
>   	return page_address(page);
> @@ -2678,11 +2676,6 @@ static int amd_iommu_dma_supported(struct device *dev, u64 mask)
>   	return check_device(dev);
>   }
>   
> -static int amd_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr)
> -{
> -	return dma_addr == AMD_IOMMU_MAPPING_ERROR;
> -}
> -
>   static const struct dma_map_ops amd_iommu_dma_ops = {
>   	.alloc		= alloc_coherent,
>   	.free		= free_coherent,
> @@ -2691,7 +2684,6 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
>   	.map_sg		= map_sg,
>   	.unmap_sg	= unmap_sg,
>   	.dma_supported	= amd_iommu_dma_supported,
> -	.mapping_error	= amd_iommu_mapping_error,
>   };
>   
>   static int init_reserved_iova_ranges(void)
