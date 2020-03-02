Return-Path: <SRS0=wGQB=4T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:34664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCBQFS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:18 -0500
Subject: Re: provide in-place uncached remapping for dma-direct v2
References: <20200224194446.690816-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4fe14c57-78d4-6590-a4c4-14fbe061238e@arm.com>
Date: Mon, 2 Mar 2020 16:05:12 +0000
MIME-Version: 1.0
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200302160512.PsQ8vFLSPWEBz_4PCGNr5Uuz6NgV8Gk2xfaKcr-4xA0@z>

On 24/02/2020 7:44 pm, Christoph Hellwig wrote:
> Hi all,
> 
> this series provides support for remapping places uncached in-place in
> the generic dma-direct code, and moves openrisc over from its own
> in-place remapping scheme.  The arm64 folks also had interest in such
> a scheme to avoid problems with speculating into cache aliases.
> 
> Also all architectures that always use small page mappings for the
> kernel and have non-coherent DMA should look into enabling this
> scheme, as it is much more efficient than the vmap remapping.
> 
> Changes since v1:
>   - share the arch hook for inline remap and uncached segment support
> 

For the whole series:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I think we might ultimately want to fiddle around a bit more in 
dma_direct_alloc_pages() to give ARCH_HAS_DMA_SET_UNCACHED clear 
precedence over DMA_DIRECT_REMAP if they have to coexist, but let's land 
these patches first as a solid foundation.

Thanks,
Robin.
