Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33785 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936309AbcCQQnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 12:43:25 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 1/9] iommu: Add MMIO mapping type
Date: Thu, 17 Mar 2016 13:18:36 +0200
Message-ID: <1602932.Q3715QPPaf@avalon>
In-Reply-To: <1457404974-1800-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1457404974-1800-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20160317111836.r_EK1jQt0JLBrKKCKHkLp3fXP3qBqEieAsoVHcF-vOg@z>

Hi Niklas,

Thank you for the patch.

On Tuesday 08 March 2016 03:42:46 Niklas Söderlund wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> On some platforms, MMIO regions might need slightly different treatment
> compared to mapping regular memory; add the notion of MMIO mappings to
> the IOMMU API's memory type flags, so that callers can let the IOMMU
> drivers know to do the right thing.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/io-pgtable-arm.c | 9 +++++++--
>  include/linux/iommu.h          | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 381ca5a..9c19989 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -355,7 +355,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data, if (!(prot & IOMMU_WRITE) && (prot &
> IOMMU_READ))
>  			pte |= ARM_LPAE_PTE_AP_RDONLY;
> 
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +		else if (prot & IOMMU_CACHE)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	} else {
> @@ -364,7 +367,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data, pte |= ARM_LPAE_PTE_HAP_READ;
>  		if (prot & IOMMU_WRITE)
>  			pte |= ARM_LPAE_PTE_HAP_WRITE;
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
> +		else if (prot & IOMMU_CACHE)
>  			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>  		else
>  			pte |= ARM_LPAE_PTE_MEMATTR_NC;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a5c539f..34b6432 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -30,6 +30,7 @@
>  #define IOMMU_WRITE	(1 << 1)
>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>  #define IOMMU_NOEXEC	(1 << 3)
> +#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> 
>  struct iommu_ops;
>  struct iommu_group;

-- 
Regards,

Laurent Pinchart

