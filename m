Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:12929 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2C3Ga1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2012 02:30:27 -0400
Date: Fri, 30 Mar 2012 08:30:06 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-reply-to: <401E54CE964CD94BAE1EB4A729C7087E37978A1E66@HQMAIL04.nvidia.com>
Message-ID: <000001cd0e3e$8ce21380$a6a63a80$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: pl
Content-transfer-encoding: 7BIT
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120329101927.8ab6b1993475b7e16ae2258f@nvidia.com>
 <01b301cd0d81$f935d750$eba185f0$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E37978A1E66@HQMAIL04.nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Krishna Reddy' <vdumpa@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Andrzej Pietrasiewicz' <andrzej.p@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'KyongHo Cho' <pullip.cho@samsung.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>
Message-ID: <20120330063006.4ZwfIa0QjYfrE0THAVUEpgL22ETc6Bq4e0hxV7hiGbI@z>

Hello,

On Friday, March 30, 2012 4:24 AM Krishna Reddy wrote:

> Hi,
> I have found a bug in arm_iommu_map_sg().
> 
> > +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> > +		     enum dma_data_direction dir, struct dma_attrs *attrs) {
> > +	struct scatterlist *s = sg, *dma = sg, *start = sg;
> > +	int i, count = 0;
> > +	unsigned int offset = s->offset;
> > +	unsigned int size = s->offset + s->length;
> > +	unsigned int max = dma_get_max_seg_size(dev);
> > +
> > +	for (i = 1; i < nents; i++) {
> > +		s->dma_address = ARM_DMA_ERROR;
> > +		s->dma_length = 0;
> > +
> > +		s = sg_next(s);
> 
> With above code, the last sg element's dma_length is not getting set to zero.
> This causing additional incorrect  unmapping during arm_iommu_unmap_sg call and
> leading to random crashes.
> The order of above three lines should be as follows.
> 		s = sg_next(s);
> 
> 		s->dma_address = ARM_DMA_ERROR;
> 		s->dma_length = 0;
> 

You are right, the order of those lines must be reversed. In all my test codes the 
scatter list was initially cleared, so I missed this typical off-by-one error. 
Thanks for spotting it!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


