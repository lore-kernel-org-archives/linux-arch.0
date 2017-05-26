From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] arm: dma-mapping: Reset the device's dma_ops
Date: Fri, 26 May 2017 17:14:28 +0300
Message-ID: <2754945.XA69I2mJdj@avalon>
References: <1495795417-15177-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:36530 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdEZOOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2017 10:14:09 -0400
In-Reply-To: <1495795417-15177-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux@armlinux.org.uk

Hi Sricharan,

Thank you for the patch.

On Friday 26 May 2017 16:13:37 Sricharan R wrote:
> arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
> ,dma_ops should be cleared in the teardown path. Currently, only the
> device's iommu mapping structures are cleared in arch_teardown_dma_ops,
> but not the dma_ops. So on the next reprobe, dma_ops left in place is
> stale from the first IOMMU setup, but iommu mappings has been disposed
> of. This is a problem when the probe of the device is deferred and
> recalled with the IOMMU probe deferral.
> 
> So for fixing this, slightly refactor by moving the code from
> __arm_iommu_detach_device to arm_iommu_detach_device and cleanup
> the former. This takes care of resetting the dma_ops in the teardown
> path.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for
> platform/amba/pci bus devices")

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Could you please push this upstream along with "[PATCH] ARM: dma-mapping: 
Don't tear third-party mappings" ?

(And feel free to s/tear/tear down/ in the subject of that patch, I've only 
noticed now that I forgot one word)

> ---
>  arch/arm/mm/dma-mapping.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c742dfd..6e82e87 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2311,7 +2311,14 @@ int arm_iommu_attach_device(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
> 
> -static void __arm_iommu_detach_device(struct device *dev)
> +/**
> + * arm_iommu_detach_device
> + * @dev: valid struct device pointer
> + *
> + * Detaches the provided device from a previously attached map.
> + * This voids the dma operations (dma_map_ops pointer)
> + */
> +void arm_iommu_detach_device(struct device *dev)
>  {
>  	struct dma_iommu_mapping *mapping;
> 
> @@ -2324,22 +2331,10 @@ static void __arm_iommu_detach_device(struct device
> *dev) iommu_detach_device(mapping->domain, dev);
>  	kref_put(&mapping->kref, release_iommu_mapping);
>  	to_dma_iommu_mapping(dev) = NULL;
> +	set_dma_ops(dev, NULL);
> 
>  	pr_debug("Detached IOMMU controller from %s device.\n", 
dev_name(dev));
>  }
> -
> -/**
> - * arm_iommu_detach_device
> - * @dev: valid struct device pointer
> - *
> - * Detaches the provided device from a previously attached map.
> - * This voids the dma operations (dma_map_ops pointer)
> - */
> -void arm_iommu_detach_device(struct device *dev)
> -{
> -	__arm_iommu_detach_device(dev);
> -	set_dma_ops(dev, NULL);
> -}
>  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> 
>  static const struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
> @@ -2379,7 +2374,7 @@ static void arm_teardown_iommu_dma_ops(struct device
> *dev) if (!mapping)
>  		return;
> 
> -	__arm_iommu_detach_device(dev);
> +	arm_iommu_detach_device(dev);
>  	arm_iommu_release_mapping(mapping);
>  }

-- 
Regards,

Laurent Pinchart
