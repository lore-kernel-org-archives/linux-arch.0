Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40916 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeAJMG2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jan 2018 07:06:28 -0500
Subject: Re: [PATCH 27/33] dma-direct: use node local allocations for coherent
 memory
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-28-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
Date: Wed, 10 Jan 2018 12:06:22 +0000
MIME-Version: 1.0
In-Reply-To: <20180110080027.13879-28-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180110120622.mKrUGr8sCeNtwUvhcI1IYXVYHA54I1b_waaTNs-JfR0@z>

On 10/01/18 08:00, Christoph Hellwig wrote:
> To preserve the x86 behavior.

And combined with patch 10/22 of the SWIOTLB refactoring, this means 
SWIOTLB allocations will also end up NUMA-aware, right? Great, that's 
what we want on arm64 too :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-direct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index a9ae98be7af3..f04a424f91fa 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (gfpflags_allow_blocking(gfp))
>   		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>   	if (!page)
> -		page = alloc_pages(gfp, page_order);
> +		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>   	if (!page)
>   		return NULL;
>   
> 
