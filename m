From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/34] powerpc/dma: remove the unused
 ARCH_HAS_DMA_MMAP_COHERENT define
Date: Thu, 6 Dec 2018 06:09:55 -0800
Message-ID: <20181206140955.GC29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

ping?

On Wed, Nov 14, 2018 at 09:22:43AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/dma-mapping.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa394520af6..f2a4a7142b1e 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -112,7 +112,5 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
>  
>  extern u64 __dma_get_required_mask(struct device *dev);
>  
> -#define ARCH_HAS_DMA_MMAP_COHERENT
> -
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_DMA_MAPPING_H */
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
