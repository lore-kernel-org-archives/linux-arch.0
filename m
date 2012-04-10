Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:16358 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab2DJM5x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 08:57:53 -0400
Received: from euspt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M29008ARLCCGK@mailout2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 10 Apr 2012 13:57:48 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M2900C5SLCF19@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 10 Apr 2012 13:57:52 +0100 (BST)
Date: Tue, 10 Apr 2012 14:57:48 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv8 10/10] ARM: dma-mapping: add support for IOMMU mapper
In-reply-to: <201204101158.29590.arnd@arndb.de>
Message-ID: <002d01cd1719$87ac7520$97055f60$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-2
Content-language: pl
Content-transfer-encoding: 8BIT
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-11-git-send-email-m.szyprowski@samsung.com>
 <201204101158.29590.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Subash Patel' <subashrp@gmail.com>
Message-ID: <20120410125748.12KscKqwkz1bUp1VgZ4dw8a500VXdRROr3weev8NDOU@z>

Hi Arnd,

On Tuesday, April 10, 2012 1:58 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > +/**
> > + * arm_iommu_create_mapping
> > + * @bus: pointer to the bus holding the client device (for IOMMU calls)
> > + * @base: start address of the valid IO address space
> > + * @size: size of the valid IO address space
> > + * @order: accuracy of the IO addresses allocations
> > + *
> > + * Creates a mapping structure which holds information about used/unused
> > + * IO address ranges, which is required to perform memory allocation and
> > + * mapping with IOMMU aware functions.
> > + *
> > + * The client device need to be attached to the mapping with
> > + * arm_iommu_attach_device function.
> > + */
> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > +                        int order)
> > +{
> > +       unsigned int count = size >> (PAGE_SHIFT + order);
> > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > +       struct dma_iommu_mapping *mapping;
> > +       int err = -ENOMEM;
> > +
> > +       if (!count)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> > +       if (!mapping)
> > +               goto err;
> > +
> > +       mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +       if (!mapping->bitmap)
> > +               goto err2;
> > +
> > +       mapping->base = base;
> > +       mapping->bits = BITS_PER_BYTE * bitmap_size;
> > +       mapping->order = order;
> > +       spin_lock_init(&mapping->lock);
> > +
> > +       mapping->domain = iommu_domain_alloc(bus);
> > +       if (!mapping->domain)
> > +               goto err3;
> > +
> > +       kref_init(&mapping->kref);
> > +       return mapping;
> > +err3:
> > +       kfree(mapping->bitmap);
> > +err2:
> > +       kfree(mapping);
> > +err:
> > +       return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL(arm_iommu_create_mapping);
> 
> I don't understand this function, mostly I guess because you have not
> provided any users. A few questions here:
> 
> * What is ARM specific about it that it is named arm_iommu_create_mapping?
>   Isn't this completely generic, at least on the interface side?
> 
> * Why is this exported to modules? Which device drivers do you expect
>   to call it?
> 
> * Why do you pass the bus_type in here? That seems like the completely
>   wrong thing to do when all devices are on the same bus type (e.g.
>   amba or platform) but are connected to different instances that each
>   have their own iommu. I guess this is a question for Jörg, because the
>   base iommu interface provides iommu_domain_alloc().

I will soon post a patch which shows how my IOMMU aware dma-mapping 
integrates with Samsung Exynos4 SYSMMU driver, so I will be able to answer
all your questions by pointing to the respective lines in either IOMMU
framework or my integration code.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


