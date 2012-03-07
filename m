Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:29122 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab2CGQ6M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 11:58:12 -0500
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2012 17:58:07 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-reply-to: <20120307.091601.458605132780655792.hdoyu@nvidia.com>
Message-ID: <011701ccfc83$78030180$68090480$%szyprowski@samsung.com>
Content-language: pl
References: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
 <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
 <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
 <20120307.091601.458605132780655792.hdoyu@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Krishna Reddy' <vdumpa@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, shariq.hasnain@linaro.org, arnd@arndb.de, benh@kernel.crashing.org, kyungmin.park@samsung.com, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, linux@arm.linux.org.uk, pullip.cho@samsung.com, chunsang.jeong@linaro.org
Message-ID: <20120307165807.tYHqH40sa3J1_5t-tuUstxTiGw2hHuxzOMfmUYBmTgY@z>

Hello,

On Wednesday, March 07, 2012 8:16 AM Hiroshi Doyu wrote:

> From: Hiroshi DOYU <hdoyu@nvidia.com>
> Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> Date: Wed, 07 Mar 2012 08:37:06 +0200 (EET)
> Message-ID: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
> 
> > From: Hiroshi DOYU <hdoyu@nvidia.com>
> > Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> > Date: Wed, 07 Mar 2012 08:09:52 +0200 (EET)
> > Message-ID: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
> >
> > > From: Krishna Reddy <vdumpa@nvidia.com>
> > > Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> > > Date: Tue, 6 Mar 2012 23:48:42 +0100
> > > Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
> > >
> > > > > > +struct dma_iommu_mapping *
> > > > > > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > > > > > +                        int order)
> > > > > > +{
> > > > > > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > > > > > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > > >
> > > > The count calculation doesn't seem correct. "order" is log2 number and
> > > >  size >> PAGE_SHIFT is number of pages.
> > > >
> > > > If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6
> pages=256KB),
> > > >  just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.
> > >
> > > Good catch!
> > >
> > > > But the calculation gives count = 64 - 6 = 58 and
> > > > Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.
> > >
> > > "order" isn't the order of size passed, which is minimal *page*
> > > allocation order which client decides whatever, just in case.
> > >
> > > > It should be as follows.
> > > > unsigned int count = 1 << get_order(size) - order;
> >
> > To be precise, as below?
> >
> >  unsigned int count = 1 << (get_order(size) - order);
> 
> This could be:
> 
> From fd40740ef4bc4a3924fe1188ea6dd785be0fe859 Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <hdoyu@nvidia.com>
> Date: Wed, 7 Mar 2012 08:14:38 +0200
> Subject: [PATCH 1/1] dma-mapping: Fix count calculation of iova space
> 
> Fix count calculation of iova space.
> Pointed by Krishna Reddy <vdumpa@nvidia.com>
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> ---
>  arch/arm/mm/dma-mapping.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6c2f104..56f0af5 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1483,11 +1483,18 @@ struct dma_iommu_mapping *
>  arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
>  			 int order)
>  {
> -	unsigned int count = (size >> PAGE_SHIFT) - order;
> -	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> +	unsigned int n, count;
> +	unsigned int bitmap_size;
>  	struct dma_iommu_mapping *mapping;
>  	int err = -ENOMEM;
> 
> +	n = get_order(size);
> +	if (n < order)
> +		return ERR_PTR(-EINVAL);
> +
> +	count = 1 << (n - order);
> +	bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> +
>  	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
>  	if (!mapping)
>  		goto err;

Thanks again for finding another bug. I thought that I've checked that code more
than twice, but it looks that I've missed something again.

IMHO the size of virtual memory area doesn't need to be aligned to the power of
two, so I will simplify it to the following code:

unsigned int count = size >> (PAGE_SHIFT + order);
unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);

if (!count)
	return ERR_PTR(-EINVAL);

...

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


