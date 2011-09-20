From: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH 1/2] ARM: initial proof-of-concept IOMMU mapper for
 DMA-mapping
Date: Tue, 20 Sep 2011 13:11:20 -0700
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E1229036BAC@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Linux-ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig <linaro-mm-sig@lists.linaro.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi,
The following change fixes a bug, which causes releasing incorrect iova spa=
ce, in the original patch of this mail thread. It fixes compilation error e=
ither.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82d5134..8c16ed7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -900,10 +900,8 @@ static int __iommu_remove_mapping(struct device *dev, =
dma_addr_t iova, size_t si
        unsigned int count =3D size >> PAGE_SHIFT;
        int i;
=20
-       for (i=3D0; i<count; i++) {
-               iommu_unmap(mapping->domain, iova, 0);
-               iova +=3D PAGE_SIZE;
-       }
+       for (i=3D0; i<count; i++)
+               iommu_unmap(mapping->domain, iova + i * PAGE_SIZE, 0);
        __free_iova(mapping, iova, size);
        return 0;
 }
@@ -1073,7 +1071,7 @@ int arm_iommu_map_sg(struct device *dev, struct scatt=
erlist *sg, int nents,
                size +=3D sg->length;
        }
        __map_sg_chunk(dev, start, size, &dma->dma_address, dir);
-       d->dma_address +=3D offset;
+       dma->dma_address +=3D offset;
=20
        return count;


-nvpublic

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
