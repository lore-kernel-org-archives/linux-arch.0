From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/33] dma-mapping: take dma_pfn_offset into account in
 dma_max_pfn
Date: Wed, 10 Jan 2018 11:07:55 +0000
Message-ID: <6e4732eb-9eaf-7e5b-863c-d3faa47bb513@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-10-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20180110080027.13879-10-hch@lst.de>
Content-Language: en-GB
Sender: linux-m68k-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 10/01/18 08:00, Christoph Hellwig wrote:
> This makes sure the generic version can be used with architectures /
> devices that have a DMA offset in the direct mapping.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 81ed9b2d84dc..d84951865be7 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   #ifndef dma_max_pfn
>   static inline unsigned long dma_max_pfn(struct device *dev)
>   {
> -	return *dev->dma_mask >> PAGE_SHIFT;
> +	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
>   }
>   #endif
>   
> 
