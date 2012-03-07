From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Wed, 7 Mar 2012 08:16:01 +0100
Message-ID: <20120307.091601.458605132780655792.hdoyu@nvidia.com>
References: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com><20120307.080952.2152478004740487196.hdoyu@nvidia.com><20120307.083706.2087121294965856946.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
Sender: owner-linux-mm@kvack.org
To: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Krishna Reddy <vdumpa@nvidia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shariq.hasnain@linaro.org" <shariq.hasnain@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, "chunsang.jeong@linaro.org" <chunsang.jeong@linaro.org>
List-Id: linux-arch.vger.kernel.org

From: Hiroshi DOYU <hdoyu@nvidia.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Wed, 07 Mar 2012 08:37:06 +0200 (EET)
Message-ID: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>

> From: Hiroshi DOYU <hdoyu@nvidia.com>
> Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
> Date: Wed, 07 Mar 2012 08:09:52 +0200 (EET)
> Message-ID: <20120307.080952.2152478004740487196.hdoyu@nvidia.com>
>=20
> > From: Krishna Reddy <vdumpa@nvidia.com>
> > Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapp=
er
> > Date: Tue, 6 Mar 2012 23:48:42 +0100
> > Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia=
.com>
> >=20
> > > > > +struct dma_iommu_mapping *
> > > > > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, =
size_t size,
> > > > > +                        int order)
> > > > > +{
> > > > > +       unsigned int count =3D (size >> PAGE_SHIFT) - order;
> > > > > +       unsigned int bitmap_size =3D BITS_TO_LONGS(count) * sizeo=
f(long);
> > >=20
> > > The count calculation doesn't seem correct. "order" is log2 number an=
d
> > >  size >> PAGE_SHIFT is number of pages.=20
> > >=20
> > > If size is passed as 64*4096(256KB) and order is 6(allocation granula=
rity is 2^6 pages=3D256KB),
> > >  just 1 bit is enough to manage allocations.  So it should be 4 bytes=
 or one long.
> >=20
> > Good catch!
> >=20
> > > But the calculation gives count =3D 64 - 6 =3D 58 and=20
> > > Bitmap_size gets set to (58/(4*8)) * 4 =3D 8 bytes, which is incorrec=
t.
> >=20
> > "order" isn't the order of size passed, which is minimal *page*
> > allocation order which client decides whatever, just in case.
> >=20
> > > It should be as follows.
> > > unsigned int count =3D 1 << get_order(size) - order;
>=20
> To be precise, as below?
>=20
>  unsigned int count =3D 1 << (get_order(size) - order);

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
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t siz=
e,
 			 int order)
 {
-	unsigned int count =3D (size >> PAGE_SHIFT) - order;
-	unsigned int bitmap_size =3D BITS_TO_LONGS(count) * sizeof(long);
+	unsigned int n, count;
+	unsigned int bitmap_size;
 	struct dma_iommu_mapping *mapping;
 	int err =3D -ENOMEM;
=20
+	n =3D get_order(size);
+	if (n < order)
+		return ERR_PTR(-EINVAL);
+
+	count =3D 1 << (n - order);
+	bitmap_size =3D BITS_TO_LONGS(count) * sizeof(long);
+
 	mapping =3D kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
 	if (!mapping)
 		goto err;
--=20
1.7.5.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
