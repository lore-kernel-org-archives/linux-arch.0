From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 14/34] powerpc/dart: remove dead cleanup code in
 iommu_init_early_dart
Date: Thu, 6 Dec 2018 06:11:35 -0800
Message-ID: <20181206141135.GA4770@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-15-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-15-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

ping?

On Wed, Nov 14, 2018 at 09:22:54AM +0100, Christoph Hellwig wrote:
> If dart_init failed we didn't have a chance to setup dma or controller
> ops yet, so there is no point in resetting them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/sysdev/dart_iommu.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
> index a5b40d1460f1..283ce04c5844 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -428,7 +428,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
>  
>  	/* Initialize the DART HW */
>  	if (dart_init(dn) != 0)
> -		goto bail;
> +		return;
>  
>  	/* Setup bypass if supported */
>  	if (dart_is_u4)
> @@ -439,15 +439,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
>  
>  	/* Setup pci_dma ops */
>  	set_pci_dma_ops(&dma_iommu_ops);
> -	return;
> -
> - bail:
> -	/* If init failed, use direct iommu and null setup functions */
> -	controller_ops->dma_dev_setup = NULL;
> -	controller_ops->dma_bus_setup = NULL;
> -
> -	/* Setup pci_dma ops */
> -	set_pci_dma_ops(&dma_nommu_ops);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
