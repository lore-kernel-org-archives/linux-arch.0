Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbeBFMsB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Feb 2018 07:48:01 -0500
Subject: Re: [PATCH/RFC 4/6] mm: Add NO_DMA dummies for DMA pool API
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
 <1517912092-15470-5-git-send-email-geert@linux-m68k.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <61f0970a-c0aa-9b6f-74c7-d63be1e477ac@arm.com>
Date: Tue, 6 Feb 2018 12:47:56 +0000
MIME-Version: 1.0
In-Reply-To: <1517912092-15470-5-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180206124756.AmvGiUzorVge5dY8meMrcIIRq_j-QJ53h4jw529x-CQ@z>

Hi Geert,

On 06/02/18 10:14, Geert Uytterhoeven wrote:
> Add dummies for dma{,m}_pool_{create,destroy,alloc,free}(), to allow
> compile-testing if NO_DMA=y.
> 
> This prevents the following from showing up later:
> 
>      ERROR: "dma_pool_destroy" [drivers/usb/mtu3/mtu3.ko] undefined!
>      ERROR: "dma_pool_free" [drivers/usb/mtu3/mtu3.ko] undefined!
>      ERROR: "dma_pool_alloc" [drivers/usb/mtu3/mtu3.ko] undefined!
>      ERROR: "dma_pool_create" [drivers/usb/mtu3/mtu3.ko] undefined!
>      ERROR: "dma_pool_destroy" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
>      ERROR: "dma_pool_free" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
>      ERROR: "dma_pool_alloc" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
>      ERROR: "dma_pool_create" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
>      ERROR: "dma_pool_alloc" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
>      ERROR: "dma_pool_free" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
>      ERROR: "dma_pool_create" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
>      ERROR: "dma_pool_destroy" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   include/linux/dmapool.h | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
> index 53ba737505df31c7..adeb5e56c3ad73a8 100644
> --- a/include/linux/dmapool.h
> +++ b/include/linux/dmapool.h
> @@ -16,6 +16,7 @@
>   
>   struct device;
>   
> +#ifdef CONFIG_HAS_DMA
>   struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>   			size_t size, size_t align, size_t allocation);
>   
> @@ -23,6 +24,17 @@ void dma_pool_destroy(struct dma_pool *pool);
>   
>   void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>   		     dma_addr_t *handle);
> +void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
> +#else /* !CONFIG_HAS_DMA */
> +static inline struct dma_pool *dma_pool_create(const char *name,
> +	struct device *dev, size_t size, size_t align, size_t allocation)
> +{ return NULL; }
> +static inline void dma_pool_destroy(struct dma_pool *pool) { }
> +static inline void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
> +				   dma_addr_t *handle) { return NULL; }
> +static inline void dma_pool_free(struct dma_pool *pool, void *vaddr,
> +				 dma_addr_t addr) { }
> +#endif /* !CONFIG_HAS_DMA */
>   
>   static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
>   				    dma_addr_t *handle)
> @@ -30,14 +42,19 @@ static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
>   	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
>   }
>   
> -void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
> -
>   /*
>    * Managed DMA pool
>    */
> +#ifdef CONFIG_HAS_DMA
>   struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
>   				  size_t size, size_t align, size_t allocation);
>   void dmam_pool_destroy(struct dma_pool *pool);
> +#else /* !CONFIG_HAS_DMA */
> +static inline struct dma_pool *dmam_pool_create(const char *name,
> +	struct device *dev, size_t size, size_t align, size_t allocation)
> +{ return NULL; }
> +static inline void dmam_pool_destroy(struct dma_pool *pool) { }
> +#endif /* !CONFIG_HAS_DMA */

Nit: It might be tidier to add *all* the stubs down here so that there 
only need be a single #ifdef, then move the dma_pool_zalloc definition 
outside at the end (where we might eventually get rid of it anyway).

Other than that, though, I think I agree with the series in general - 
more COMPILE_TEST is always good from the point of view of weeding out 
drivers using architecture-specific DMA API internals which aren't part 
of the proper generic interface.

Robin.

>   
>   #endif
>   
> 
