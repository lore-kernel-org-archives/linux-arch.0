Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:51434 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcBKALv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2016 19:11:51 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 4/8] arm: dma-mapping: add {map,unmap}_resource for iommu ops
Date: Thu, 11 Feb 2016 02:12:13 +0200
Message-ID: <3988595.8dtuaVHoSu@avalon>
In-Reply-To: <1455065878-11906-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1455065878-11906-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, vinod.koul@intel.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160211001213.XV0AWaBpiwekXpBxueGD-N3ky5YYPU_q1MYgoLkSCgA@z>

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:54 Niklas Söderlund wrote:
> Add methods to map/unmap device resources addresses for dma_map_ops that
> are IOMMU aware. This is needed to map a device MMIO register from a
> physical address.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mm/dma-mapping.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 0eca381..ae2b175 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1814,6 +1814,63 @@ static void arm_iommu_unmap_page(struct device *dev,
> dma_addr_t handle, __free_iova(mapping, iova, len);
>  }
> 
> +/**
> + * arm_iommu_map_resource - map a device resource for DMA
> + * @dev: valid struct device pointer
> + * @phys_addr: physical address of resource
> + * @size: size of resource to map
> + * @dir: DMA transfer direction
> + */
> +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> +		phys_addr_t phys_addr, size_t size,
> +		enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +	dma_addr_t dma_addr;
> +	int ret, prot;
> +	phys_addr_t addr = phys_addr & PAGE_MASK;
> +	int offset = phys_addr & ~PAGE_MASK;
> +	int len = PAGE_ALIGN(size + offset);
> +
> +	dma_addr = __alloc_iova(mapping, size);
> +	if (dma_addr == DMA_ERROR_CODE)
> +		return dma_addr;
> +
> +	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
> +
> +	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
> +	if (ret < 0)
> +		goto fail;
> +
> +	return dma_addr + offset;
> +fail:
> +	__free_iova(mapping, dma_addr, size);
> +	return DMA_ERROR_CODE;
> +}
> +
> +/**
> + * arm_iommu_unmap_resource - unmap a device DMA resource
> + * @dev: valid struct device pointer
> + * @dma_handle: DMA address to resource
> + * @size: size of resource to map
> + * @dir: DMA transfer direction
> + */
> +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t
> dma_handle, +		size_t size, enum dma_data_direction dir,
> +		struct dma_attrs *attrs)
> +{
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +	dma_addr_t iova = dma_handle & PAGE_MASK;
> +	int offset = dma_handle & ~PAGE_MASK;
> +	int len = PAGE_ALIGN(size + offset);
> +
> +	if (!iova)
> +		return;
> +
> +	iommu_unmap(mapping->domain, iova, len);
> +	__free_iova(mapping, iova, len);
> +}
> +
>  static void arm_iommu_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> @@ -1858,6 +1915,9 @@ struct dma_map_ops iommu_ops = {
>  	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
>  	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
> 
> +	.map_resource		= arm_iommu_map_resource,
> +	.unmap_resource		= arm_iommu_unmap_resource,
> +
>  	.set_dma_mask		= arm_dma_set_mask,
>  };
> 
> @@ -1873,6 +1933,9 @@ struct dma_map_ops iommu_coherent_ops = {
>  	.map_sg		= arm_coherent_iommu_map_sg,
>  	.unmap_sg	= arm_coherent_iommu_unmap_sg,
> 
> +	.map_resource	= arm_iommu_map_resource,
> +	.unmap_resource	= arm_iommu_unmap_resource,
> +
>  	.set_dma_mask	= arm_dma_set_mask,
>  };

-- 
Regards,

Laurent Pinchart

