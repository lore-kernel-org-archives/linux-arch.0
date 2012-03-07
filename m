Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:7034 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab2CGGK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 01:10:29 -0500
From: Hiroshi Doyu <hdoyu@nvidia.com>
Date: Wed, 7 Mar 2012 07:09:52 +0100
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
References: <20120305134721.0ab0d0e6de56fa30250059b1@nvidia.com><000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com><401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Cc: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shariq.hasnain@linaro.org" <shariq.hasnain@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, "chunsang.jeong@linaro.org" <chunsang.jeong@linaro.org>
Message-ID: <20120307060952.0FaV-Bh8_T95MGNwUn6iQSQgSBeVPtAfETWFgaI-lVk@z>

From: Krishna Reddy <vdumpa@nvidia.com>
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Tue, 6 Mar 2012 23:48:42 +0100
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>

> > > +struct dma_iommu_mapping *
> > > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > > +                        int order)
> > > +{
> > > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> 
> The count calculation doesn't seem correct. "order" is log2 number and
>  size >> PAGE_SHIFT is number of pages. 
> 
> If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6 pages=256KB),
>  just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.

Good catch!

> But the calculation gives count = 64 - 6 = 58 and 
> Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.

"order" isn't the order of size passed, which is minimal *page*
allocation order which client decides whatever, just in case.

> It should be as follows.
> unsigned int count = 1 << get_order(size) - order;
> unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long) * BITS_PER_BYTE;
> 
> -KR
> 
> --nvpublic
> 
> 
