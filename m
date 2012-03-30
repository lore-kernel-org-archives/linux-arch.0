Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:2743 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759929Ab2C3CYs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 22:24:48 -0400
From: Krishna Reddy <vdumpa@nvidia.com>
Date: Thu, 29 Mar 2012 19:24:21 -0700
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37978A1E66@HQMAIL04.nvidia.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120329101927.8ab6b1993475b7e16ae2258f@nvidia.com>
 <01b301cd0d81$f935d750$eba185f0$%szyprowski@samsung.com>
In-Reply-To: <01b301cd0d81$f935d750$eba185f0$%szyprowski@samsung.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'KyongHo Cho' <pullip.cho@samsung.com>, Hiroshi Doyu <hdoyu@nvidia.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>
Message-ID: <20120330022421.r8rZnVqHIBEQuL32oqlYsaJqQUKmdCQ4s-m9ZliWdYc@z>

Hi,
I have found a bug in arm_iommu_map_sg(). 

> +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, struct dma_attrs *attrs) {
> +	struct scatterlist *s = sg, *dma = sg, *start = sg;
> +	int i, count = 0;
> +	unsigned int offset = s->offset;
> +	unsigned int size = s->offset + s->length;
> +	unsigned int max = dma_get_max_seg_size(dev);
> +
> +	for (i = 1; i < nents; i++) {
> +		s->dma_address = ARM_DMA_ERROR;
> +		s->dma_length = 0;
> +
> +		s = sg_next(s);

With above code, the last sg element's dma_length is not getting set to zero.
This causing additional incorrect  unmapping during arm_iommu_unmap_sg call and 
leading to random crashes.
The order of above three lines should be as follows.
		s = sg_next(s);

		s->dma_address = ARM_DMA_ERROR;
		s->dma_length = 0;


-KR
--nvpublic
