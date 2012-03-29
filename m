Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:1152 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933615Ab2C2HTe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 03:19:34 -0400
Date: Thu, 29 Mar 2012 10:19:27 +0300
From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <20120329101927.8ab6b1993475b7e16ae2258f@nvidia.com>
In-Reply-To: <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
	<1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Krishna Reddy <vdumpa@nvidia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, KyongHo Cho <pullip.cho@samsung.com>, Chunsang Jeong <chunsang.jeong@linaro.org>
Message-ID: <20120329071927.6zzeKrXMSCFCYTc6uzNsR4fvZuNB7hKbBX0-_0uiBP4@z>

Hi Marek,

On Wed, 29 Feb 2012 16:04:22 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch add a complete implementation of DMA-mapping API for
> devices that have IOMMU support. All DMA-mapping calls are supported.
> 
> This patch contains some of the code kindly provided by Krishna Reddy
> <vdumpa@nvidia.com> and Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/arm/Kconfig                 |    8 +
>  arch/arm/include/asm/device.h    |    3 +
>  arch/arm/include/asm/dma-iommu.h |   34 ++
>  arch/arm/mm/dma-mapping.c        |  726 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/mm/vmregion.h           |    2 +-
>  5 files changed, 758 insertions(+), 15 deletions(-)
>  create mode 100644 arch/arm/include/asm/dma-iommu.h
> 

<snip>

> +/*
> + * Map a part of the scatter-gather list into contiguous io address space
> + */
> +static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
> +                         size_t size, dma_addr_t *handle,
> +                         enum dma_data_direction dir)
> +{
> +       struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> +       dma_addr_t iova, iova_base;
> +       int ret = 0;
> +       unsigned int count;
> +       struct scatterlist *s;
> +
> +       size = PAGE_ALIGN(size);
> +       *handle = ARM_DMA_ERROR;
> +
> +       iova_base = iova = __alloc_iova(mapping, size);
> +       if (iova == ARM_DMA_ERROR)
> +               return -ENOMEM;
> +
> +       for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s))
> +       {
> +               phys_addr_t phys = page_to_phys(sg_page(s));
> +               unsigned int len = PAGE_ALIGN(s->offset + s->length);
> +
> +               if (!arch_is_coherent())
> +                       __dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
> +
> +               ret = iommu_map(mapping->domain, iova, phys, len, 0);
> +               if (ret < 0)
> +                       goto fail;
> +               count += len >> PAGE_SHIFT;
> +               iova += len;
> +       }
> +       *handle = iova_base;
> +
> +       return 0;
> +fail:
> +       iommu_unmap(mapping->domain, iova_base, count * PAGE_SIZE);
> +       __free_iova(mapping, iova_base, size);
> +       return ret;
> +}

Do we need to set dma_address as below?

From e8bcc3cdac5375b5d7f5ac5b3f716a11c1008f38 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu@nvidia.com>
Date: Thu, 29 Mar 2012 09:59:04 +0300
Subject: [PATCH 1/1] ARM: dma-mapping: Fix dma_address in sglist

s->dma_address wasn't set at mapping.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3347c37..11a9d65 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1111,6 +1111,8 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		ret = iommu_map(mapping->domain, iova, phys, len, 0);
 		if (ret < 0)
 			goto fail;
+		s->dma_address = iova;
+
 		count += len >> PAGE_SHIFT;
 		iova += len;
 	}
-- 
1.7.5.4
