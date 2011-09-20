Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16400 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1ITULe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2011 16:11:34 -0400
From: Krishna Reddy <vdumpa@nvidia.com>
Date: Tue, 20 Sep 2011 13:11:20 -0700
Subject: Re: [PATCH 1/2] ARM: initial proof-of-concept IOMMU mapper for
 DMA-mapping
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E1229036BAC@HQMAIL04.nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux-ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig <linaro-mm-sig@lists.linaro.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
Message-ID: <20110920201120.j8sKGIZ88vuESlPhVdb0pW3DP5043_-zB7kqOFe5OYw@z>

Hi,
The following change fixes a bug, which causes releasing incorrect iova space, in the original patch of this mail thread. It fixes compilation error either.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82d5134..8c16ed7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -900,10 +900,8 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
        unsigned int count = size >> PAGE_SHIFT;
        int i;
 
-       for (i=0; i<count; i++) {
-               iommu_unmap(mapping->domain, iova, 0);
-               iova += PAGE_SIZE;
-       }
+       for (i=0; i<count; i++)
+               iommu_unmap(mapping->domain, iova + i * PAGE_SIZE, 0);
        __free_iova(mapping, iova, size);
        return 0;
 }
@@ -1073,7 +1071,7 @@ int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
                size += sg->length;
        }
        __map_sg_chunk(dev, start, size, &dma->dma_address, dir);
-       d->dma_address += offset;
+       dma->dma_address += offset;
 
        return count;


-nvpublic
