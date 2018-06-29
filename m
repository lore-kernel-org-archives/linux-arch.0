Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52501 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeF2RpZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jun 2018 13:45:25 -0400
Subject: Re: [RFC v2] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
References: <20180628141452.3585-1-Eugeniy.Paltsev@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <4010dc7c-7046-eddd-11cc-30099c29d640@synopsys.com>
Date: Fri, 29 Jun 2018 10:45:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180628141452.3585-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>
Message-ID: <20180629174513.MTNWOkYtFFTMvvekCX3E0Bs19eBo12VhHtXPa1uKkt0@z>

On 06/28/2018 07:14 AM, Eugeniy Paltsev wrote:
> The ARC HS processor provides an IOC port (I/O coherency bus
> interface) that allows external devices such as DMA devices
> to access memory through the cache hierarchy, providing
> coherency between I/O transactions and the complete memory
> hierarchy.

You mention IOC port in first line, but the change has nothing to do with it -
this is confusing.
Make this less verbose and just expand on the subject you have - global vs. per
device dma settings, without going into all the internal details.

And again going back to my original point, you are changing the semantics (ioc and
non ioc to co-exist) but everything still goes thru IOC port. That is different
that what we had before - everything goes through IOC port and ioc dma ops ONLY if
IOC existed.

I understand the need to isolate the 2 things and that is fine. But then what you
should do is
1a. introduce the per ioc dma settings in ARC - and not touch the DTBs.
1b. introduce the IO port settings in platform code
2. Now switch the DT binding to use the per device ioc

And any panic etc for IOC + highmem etc should be a separate patch - so we can
easily revert it when time is right !

>
> Some recent SoC with ARC HS (like HSDK) allow to select bus
> port (IOC or non-IOC port) for connecting DMA devices in runtime.
>
> With this patch we can use both HW-coherent and regular DMA
> peripherals simultaneously.
>
> For example we can connect USB and SDIO controllers through IOC port
> (so we don't need to need to maintain cache coherency for these
> devices manualy. All cache sync ops will be nop)
> And we can connect Ethernet directly to RAM port (so we had to
> maintain cache coherency manualy. Cache sync ops will be real
> flush/invalidate operations)

I presume this has been tested with some stress testing bonie++ etc.

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

And further to Christoph's comment, if we decide to skip the branch, please add a
comment that it is already set in generic code etc.
