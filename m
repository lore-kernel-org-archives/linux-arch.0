Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:12723 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2CGHQb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 02:16:31 -0500
From: Hiroshi Doyu <hdoyu@nvidia.com>
Date: Wed, 7 Mar 2012 08:16:01 +0100
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <20120307.091601.458605132780655792.hdoyu@nvidia.com>
References: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com><20120307.080952.2152478004740487196.hdoyu@nvidia.com><20120307.083706.2087121294965856946.hdoyu@nvidia.com>
In-Reply-To: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Krishna Reddy <vdumpa@nvidia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shariq.hasnain@linaro.org" <shariq.hasnain@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, "chunsang.jeong@linaro.org" <chunsang.jeong@linaro.org>
Message-ID: <20120307071601.rNhpZaX3cd_Opn6ZqLOIE6B2gjTORiywtJpUshqSyyw@z>

From: Hiroshi DOYU <hdoyu@nvidia.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Wed, 07 Mar 2012 08:37:06 +0200 (EET)
Message-ID: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>

> From: Hiroshi DOYU <hdoyu@nvidia.com>
> Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> Date: Wed, 07 Mar 2012 08:09:52 +0200 (EET)
> Message-ID: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
> 
> > From: Krishna Reddy <vdumpa@nvidia.com>
> > Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> > Date: Tue, 6 Mar 2012 23:48:42 +0100
> > Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com>
> > 
> > > > > +struct dma_iommu_mapping *
> > > > > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
> > > > > +                        int order)
> > > > > +{
> > > > > +       unsigned int count = (size >> PAGE_SHIFT) - order;
> > > > > +       unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > > 
> > > The count calculation doesn't seem correct. "order" is log2 number and
> > >  size >> PAGE_SHIFT is number of pages. 
> > > 
> > > If size is passed as 64*4096(256KB) and order is 6(allocation granularity is 2^6 pages=256KB),
> > >  just 1 bit is enough to manage allocations.  So it should be 4 bytes or one long.
> > 
> > Good catch!
> > 
> > > But the calculation gives count = 64 - 6 = 58 and 
> > > Bitmap_size gets set to (58/(4*8)) * 4 = 8 bytes, which is incorrect.
> > 
> > "order" isn't the order of size passed, which is minimal *page*
> > allocation order which client decides whatever, just in case.
> > 
> > > It should be as follows.
> > > unsigned int count = 1 << get_order(size) - order;
> 
> To be precise, as below?
> 
>  unsigned int count = 1 << (get_order(size) - order);

This could be:

From fd40740ef4bc4a3924fe1188ea6dd785be0fe859 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu@nvidia.com>
Date: Wed, 7 Mar 2012 08:14:38 +0200
Subject: [PATCH 1/1] dma-mapping: Fix count calculation of iova space

Fix count calculation of iova space.
Pointed by Krishna Reddy <vdumpa@nvidia.com>

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6c2f104..56f0af5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1483,11 +1483,18 @@ struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 			 int order)
 {
-	unsigned int count = (size >> PAGE_SHIFT) - order;
-	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
+	unsigned int n, count;
+	unsigned int bitmap_size;
 	struct dma_iommu_mapping *mapping;
 	int err = -ENOMEM;
 
+	n = get_order(size);
+	if (n < order)
+		return ERR_PTR(-EINVAL);
+
+	count = 1 << (n - order);
+	bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
+
 	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
 	if (!mapping)
 		goto err;
-- 
1.7.5.4
