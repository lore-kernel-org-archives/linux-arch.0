From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] ARC: allow to use IOC and non-IOC DMA devices
        simultaneously
Date: Fri, 15 Jun 2018 15:17:10 +0200
Message-ID: <20180615131710.GA30776@lst.de>
References: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
List-Id: linux-arch.vger.kernel.org

> +#ifndef ASM_ARC_DMA_MAPPING_H
> +#define ASM_ARC_DMA_MAPPING_H
> +
> +#define arch_setup_dma_ops arch_setup_dma_ops
> +
> +#include <asm-generic/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent);

Can you keep the #define for arch_setup_dma_ops right next to the
prototype?

> index 000000000000..9d0d310bbf5a
> --- /dev/null
> +++ b/arch/arc/mm/dma-mapping.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// (C) 2018 Synopsys, Inc. (www.synopsys.com)
> +
> +#include <linux/dma-mapping.h>
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +			const struct iommu_ops *iommu, bool coherent)
> +{
> +	const struct dma_map_ops *dma_ops = &dma_noncoherent_ops;
> +
> +	/*
> +	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> +	 * with memory - eliding need for any explicit cache maintenance of
> +	 * DMA buffers - so we can use dma_direct cache ops.
> +	 */
> +	if (is_isa_arcv2() && ioc_enable && coherent)
> +		dma_ops = &dma_direct_ops;
> +
> +	set_dma_ops(dev, dma_ops);
> +}


Why not just write the routines as:

void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
			const struct iommu_ops *iommu, bool coherent)
{
	if (is_isa_arcv2() && ioc_enable && coherent)
		set_dma_ops(dev, &dma_direct_ops);
	else
		set_dma_ops(dev, &dma_noncoherent_ops);
}

Also a new file just for this routine seems a little wasteful.  Can't
you just squeeze it into setup.c or some other file?
