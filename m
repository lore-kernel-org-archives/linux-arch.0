Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16470 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031516Ab2CFWsy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2012 17:48:54 -0500
From: Krishna Reddy <vdumpa@nvidia.com>
Date: Tue, 6 Mar 2012 14:48:42 -0800
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120305134721.0ab0d0e6de56fa30250059b1@nvidia.com>
 <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com>
In-Reply-To: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Hiroshi Doyu <hdoyu@nvidia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'KyongHo Cho' <pullip.cho@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>
Message-ID: <20120306224842.p_nI-q8202FWrrYyDnIsEXjHsYq2V6lSlK8uEn8brH8@z>

> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +                        int order)
> > +{
> > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);

The count calculation doesn't seem correct. "order" is log2 number and
 size >> PAGE_SHIFT is number of pages. 

If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6 pages=256KB),
 just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.

But the calculation gives count = 64 - 6 = 58 and 
Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.

It should be as follows.
unsigned int count = 1 << get_order(size) - order;
unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long) * BITS_PER_BYTE;

-KR

--nvpublic


