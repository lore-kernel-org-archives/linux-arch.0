Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38791 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933498AbeALNZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 08:25:39 -0500
Date: Fri, 12 Jan 2018 08:25:34 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH 05/22] x86: rename swiotlb_dma_ops
Message-ID: <20180112132534.GE26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180112132534.w4UgaEi5i-HqbX38VpdQfrRO5k1MEkzhCiJ7Wkx6eEE@z>

On Wed, Jan 10, 2018 at 09:09:15AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kernel/pci-swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 9d3e35c33d94..0d77603c2f50 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -48,7 +48,7 @@ void x86_swiotlb_free_coherent(struct device *dev, size_t size,
>  		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
>  }
>  
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops x86_swiotlb_dma_ops = {
>  	.mapping_error = swiotlb_dma_mapping_error,
>  	.alloc = x86_swiotlb_alloc_coherent,
>  	.free = x86_swiotlb_free_coherent,
> @@ -112,7 +112,7 @@ void __init pci_swiotlb_init(void)
>  {
>  	if (swiotlb) {
>  		swiotlb_init(0);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &x86_swiotlb_dma_ops;
>  	}
>  }
>  
> -- 
> 2.14.2
> 
