From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Mon, 13 Aug 2018 16:24:02 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:=0A=
> @@ -1263,11 +1254,7 @@ void __init arc_cache_init_master(void)=0A=
>  	if (is_isa_arcv2() && ioc_enable)=0A=
>  		arc_ioc_setup();=0A=
>  =0A=
> -	if (is_isa_arcv2() && ioc_enable) {=0A=
> -		__dma_cache_wback_inv =3D __dma_cache_wback_inv_ioc;=0A=
> -		__dma_cache_inv =3D __dma_cache_inv_ioc;=0A=
> -		__dma_cache_wback =3D __dma_cache_wback_ioc;=0A=
> -	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {=0A=
> +	if (is_isa_arcv2() && l2_line_sz && slc_enable) {=0A=
>  		__dma_cache_wback_inv =3D __dma_cache_wback_inv_slc;=0A=
>  		__dma_cache_inv =3D __dma_cache_inv_slc;=0A=
>  		__dma_cache_wback =3D __dma_cache_wback_slc;=0A=
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c=0A=
> index cefb776a99ff..4d1466905e48 100644=0A=
> --- a/arch/arc/mm/dma.c=0A=
> +++ b/arch/arc/mm/dma.c=0A=
> @@ -33,19 +33,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, =
dma_addr_t *dma_handle,=0A=
>  	if (!page)=0A=
>  		return NULL;=0A=
>  =0A=
> -	/*=0A=
> -	 * IOC relies on all data (even coherent DMA data) being in cache=0A=
> -	 * Thus allocate normal cached memory=0A=
> -	 *=0A=
> -	 * The gains with IOC are two pronged:=0A=
> -	 *   -For streaming data, elides need for cache maintenance, saving=0A=
> -	 *    cycles in flush code, and bus bandwidth as all the lines of a=0A=
> -	 *    buffer need to be flushed out to memory=0A=
> -	 *   -For coherent data, Read/Write to buffers terminate early in cache=
=0A=
> -	 *   (vs. always going to memory - thus are faster)=0A=
> -	 */=0A=
> -	if ((is_isa_arcv2() && ioc_enable) ||=0A=
> -	    (attrs & DMA_ATTR_NON_CONSISTENT))=0A=
> +	if (attrs & DMA_ATTR_NON_CONSISTENT)=0A=
>  		need_coh =3D 0;=0A=
>  =0A=
>  	/*=0A=
> @@ -95,8 +83,7 @@ void arch_dma_free(struct device *dev, size_t size, voi=
d *vaddr,=0A=
>  	struct page *page =3D virt_to_page(paddr);=0A=
>  	int is_non_coh =3D 1;=0A=
>  =0A=
> -	is_non_coh =3D (attrs & DMA_ATTR_NON_CONSISTENT) ||=0A=
> -			(is_isa_arcv2() && ioc_enable);=0A=
> +	is_non_coh =3D (attrs & DMA_ATTR_NON_CONSISTENT);=0A=
>  =0A=
>  	if (PageHighMem(page) || !is_non_coh)=0A=
>  		iounmap((void __force __iomem *)vaddr);=0A=
> @@ -182,3 +169,20 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_=
addr_t paddr,=0A=
>  		break;=0A=
>  	}=0A=
>  }=0A=
=0A=
I think we have some shenanigans with @ioc_enable now.=0A=
Do note that it was more of a debug hack using when the hw feature was intr=
oduced=0A=
to be able to run same kernel on various FPGA bitfiles but just flicking a =
global=0A=
variable via the debugger.=0A=
=0A=
So per code below, if @ioc_enable is NOT set, we still use software assiste=
d cache=0A=
maintenance, but dma_{alloc,free} don't do use that variable. Have you trie=
d=0A=
testing the combination when @ioc_enable is set to 0 before boot ? And is t=
hat works ?=0A=
=0A=
> +=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +			const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +	/*=0A=
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent=0A=
> +	 * with memory - eliding need for any explicit cache maintenance of=0A=
> +	 * DMA buffers - so we can use dma_direct cache ops.=0A=
> +	 */=0A=
> +	if (is_isa_arcv2() && ioc_enable && coherent) {=0A=
> +		set_dma_ops(dev, &dma_direct_ops);=0A=
> +		dev_info(dev, "use dma_direct_ops cache ops\n");=0A=
> +	} else {=0A=
> +		set_dma_ops(dev, &dma_noncoherent_ops);=0A=
> +		dev_info(dev, "use dma_noncoherent_ops cache ops\n");=0A=
> +	}=0A=
> +}=0A=
=0A=
