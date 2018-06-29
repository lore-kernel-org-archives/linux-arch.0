Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53037 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964922AbeF2Iaq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jun 2018 04:30:46 -0400
Date: Fri, 29 Jun 2018 10:30:51 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v2] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Message-ID: <20180629083051.GA15740@lst.de>
References: <20180628141452.3585-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628141452.3585-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Message-ID: <20180629083051.uTk9hN3VMrHdK9UwnITyAVJklIH7aqrW9iMt_T-qiVY@z>

On Thu, Jun 28, 2018 at 05:14:52PM +0300, Eugeniy Paltsev wrote:
> And if we get DMA buffer from ZONE_HIGHMEM memory we need to
> do real flush/invalidate operations on that buffer, which is obviously
> not done by "dma_direct_ops".
> 
> So I am not sure about "dma_direct_ops" using - probably we need to
> create our special cache ops like "arc_ioc_ops" which will handle
> ZONE_HIGHMEM case.

FYI, I have a plan to merge dma_direct_ops and dma_noncoherent_ops
and make the decision to use cache flushing run time controllable
with a flag in struct device based on existing dynamic selection
in e.g. arm, arm64 and mips.  It will probably take a few more merge
windows to get there, but once it is done you should be able to take
easy advantage of it.

> +++ b/arch/arc/mm/dma.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-noncoherent.h>
>  #include <asm/cache.h>
>  #include <asm/cacheflush.h>
> +#include <linux/dma-mapping.h>

dma-noncoherent.h already includes dma-mapping.h, so this is not
required.

> -	if ((is_isa_arcv2() && ioc_enable) ||
> -	    (attrs & DMA_ATTR_NON_CONSISTENT))
> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>  		need_coh = 0;

need_coh is only used twice, it might be cleaner to remove the
variable and just open code the DMA_ATTR_NON_CONSISTENT check.
And for extra points remove the need_kvaddr variable as well.

Also you probably want to do the equivalent change in arch_dma_free
as well.

> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent)
> +{
> +	/*
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> +	 * with memory - eliding need for any explicit cache maintenance of
> +	 * DMA buffers - so we can use dma_direct cache ops.
> +	 */
> +	if (is_isa_arcv2() && ioc_enable && coherent) {
> +		set_dma_ops(dev, &dma_direct_ops);
> +		dev_info(dev, "use dma_direct_ops cache ops\n");
> +	} else {
> +		set_dma_ops(dev, &dma_noncoherent_ops);
> +		dev_info(dev, "use dma_noncoherent_ops cache ops\n");
> +	}
> +}

Note that due to your use of asm-generic/dma-mapping.h we already
default to dma_noncoherent_ops if no per-device ops is set.  So we
could skip the else branch here I think.
