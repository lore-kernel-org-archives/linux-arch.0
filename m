From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] arc: Implement arch-specific dma_map_ops.mmap
Date: Thu, 3 Nov 2016 10:03:37 -0700
Message-ID: <5fcface9-1402-85b7-2caa-624d650d311e@synopsys.com>
References: <1478185573-12871-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34598 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbcKCREb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2016 13:04:31 -0400
In-Reply-To: <1478185573-12871-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org

On 11/03/2016 08:06 AM, Alexey Brodkin wrote:
> We used to use generic implementation of dma_map_ops.mmap which is
> dma_common_mmap() but that only worked for simpler cached mappings when
> vaddr = paddr.
> 
> If a driver requests uncached DMA buffer kernel maps it to virtual
> address so that MMU gets involved and page uncached status takes into
> account. In that case usage of dma_common_mmap() lead to mapping of
> vaddr to vaddr for user-space which is obviously wrong. For more detals
> please refer to verbose explanation here [1].
> 
> So here we implement our own version of mmap() which always deals
> with dma_addr and maps underlying memory to user-space properly
> (note that DMA buffer mapped to user-space is always uncached
> because there's no way to properly manage cache from user-space).
> 
> [1] https://lkml.org/lkml/2016/10/26/973
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: <stable@vger.kernel.org>

I've added a stable 4.5+, since ARC didn't use dma ops until 4.5-rc1.
Pushed to for-curr !

Thx,
-Vineet

> ---
> 
> Changes v1 -> v2:
>  * Added plat_dma_to_phys wrapper around dma_addr
> 
>  arch/arc/mm/dma.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 20afc65e22dc..9288851d43a0 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -105,6 +105,31 @@ static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
>  	__free_pages(page, get_order(size));
>  }
>  
> +static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +			void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			unsigned long attrs)
> +{
> +	unsigned long user_count = vma_pages(vma);
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long pfn = __phys_to_pfn(plat_dma_to_phys(dev, dma_addr));
> +	unsigned long off = vma->vm_pgoff;
> +	int ret = -ENXIO;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;
> +
> +	if (off < count && user_count <= (count - off)) {
> +		ret = remap_pfn_range(vma, vma->vm_start,
> +				      pfn + off,
> +				      user_count << PAGE_SHIFT,
> +				      vma->vm_page_prot);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * streaming DMA Mapping API...
>   * CPU accesses page via normal paddr, thus needs to explicitly made
> @@ -193,6 +218,7 @@ static int arc_dma_supported(struct device *dev, u64 dma_mask)
>  struct dma_map_ops arc_dma_ops = {
>  	.alloc			= arc_dma_alloc,
>  	.free			= arc_dma_free,
> +	.mmap			= arc_dma_mmap,
>  	.map_page		= arc_dma_map_page,
>  	.map_sg			= arc_dma_map_sg,
>  	.sync_single_for_device	= arc_dma_sync_single_for_device,
> 
