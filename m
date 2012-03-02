Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37166 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758348Ab2CBIFc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 2 Mar 2012 03:05:32 -0500
MIME-Version: 1.0
In-Reply-To: <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
	<1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
Date: Fri, 2 Mar 2012 17:05:30 +0900
Message-ID: <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
From: KyongHo Cho <pullip.cho@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Krishna Reddy <vdumpa@nvidia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
Message-ID: <20120302080530.V9PSvY7AmQSXgZ86gfsQSznWrSmaNytk67zP9B7kuZc@z>

On Thu, Mar 1, 2012 at 12:04 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> +/**
> + * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
> + * @dev: valid struct device pointer
> + * @sg: list of buffers
> + * @nents: number of buffers to map
> + * @dir: DMA transfer direction
> + *
> + * Map a set of buffers described by scatterlist in streaming mode for DMA.
> + * The scatter gather list elements are merged together (if possible) and
> + * tagged with the appropriate dma address and length. They are obtained via
> + * sg_dma_{address,length}.
> + */
> +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +                    enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +       struct scatterlist *s = sg, *dma = sg, *start = sg;
> +       int i, count = 0;
> +       unsigned int offset = s->offset;
> +       unsigned int size = s->offset + s->length;
> +       unsigned int max = dma_get_max_seg_size(dev);
> +
> +       for (i = 1; i < nents; i++) {
> +               s->dma_address = ARM_DMA_ERROR;
> +               s->dma_length = 0;
> +
> +               s = sg_next(s);
> +
> +               if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
> +                       if (__map_sg_chunk(dev, start, size, &dma->dma_address,
> +                           dir) < 0)
> +                               goto bad_mapping;
> +
> +                       dma->dma_address += offset;
> +                       dma->dma_length = size - offset;
> +
> +                       size = offset = s->offset;
> +                       start = s;
> +                       dma = sg_next(dma);
> +                       count += 1;
> +               }
> +               size += s->length;
> +       }
> +       if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir) < 0)
> +               goto bad_mapping;
> +
> +       dma->dma_address += offset;
> +       dma->dma_length = size - offset;
> +
> +       return count+1;
> +
> +bad_mapping:
> +       for_each_sg(sg, s, count, i)
> +               __iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
> +       return 0;
> +}
> +
This looks that the given sg list specifies the list of physical
memory chunks and
the list of IO virtual memory chunks at the same time after calling
arm_dma_map_sg().
It can happen that dma_address and dma_length of a sg entry does not
correspond to
physical memory information of the sg entry.

I think it is beneficial for handling IO virtual memory.

However, I worry about any other problems caused by a single sg entry contains
information from 2 different context.

Regards,

Cho KyongHo.
