From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arc: Implement arch-specific dma_map_ops.mmap
Date: Wed, 2 Nov 2016 11:08:06 -0600
Message-ID: <20161102170806.z3k3nlczspg2ebxb@localhost>
References: <1478089183-6458-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478089183-6458-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 02, 2016 at 03:19:43PM +0300, Alexey Brodkin wrote:
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 20afc65e22dc..034ec6a8a764 100644
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
> +	unsigned long pfn = __phys_to_pfn(dma_addr);

I don't think that's correct in all situations. Better as (for arc):

	unsigned long pfn = __phys_to_pfn(plat_dma_to_phys(dma_addr));

Other than that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
