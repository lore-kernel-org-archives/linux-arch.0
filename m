From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
 to more generic alloc/free_attrs
Date: Tue, 21 Jun 2011 13:23:35 +0200
Message-ID: <002401cc3005$a941c010$fbc54030$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
 <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36219 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1FULXp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2011 07:23:45 -0400
Received: from spt2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LN500LLR0ZKHV@mailout2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 21 Jun 2011 12:23:44 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LN500F7P0ZI4V@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 21 Jun 2011 12:23:43 +0100 (BST)
In-reply-to: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'KyongHo Cho' <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>

Hello,

On Monday, June 20, 2011 4:46 PM KyongHo Cho wrote:

> On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>=20
> > =A0struct dma_map_ops {
> > - =A0 =A0 =A0 void* (*alloc_coherent)(struct device *dev, size_t si=
ze,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_a=
ddr_t *dma_handle, gfp_t gfp);
> > - =A0 =A0 =A0 void (*free_coherent)(struct device *dev, size_t size=
,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *vad=
dr, dma_addr_t dma_handle);
> > + =A0 =A0 =A0 void* (*alloc)(struct device *dev, size_t size,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_a=
ddr_t *dma_handle, gfp_t gfp,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t dma_attrs *attrs);
> > + =A0 =A0 =A0 void (*free)(struct device *dev, size_t size,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *vad=
dr, dma_addr_t dma_handle,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dm=
a_attrs *attrs);
> > + =A0 =A0 =A0 int (*mmap)(struct device *, struct vm_area_struct *,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *, dma_addr_=
t, size_t, struct dma_attrs
> *attrs);
> > +
> > =A0 =A0 =A0 =A0dma_addr_t (*map_page)(struct device *dev, struct pa=
ge *page,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long offset, size_t size,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dm=
a_data_direction dir,
>=20
> I still don't agree with your idea that change alloc_coherent() with
> alloc().

> As I said before, we actually do not need dma_alloc_writecombine() an=
ymore
> because it is not different from dma_alloc_coherent() in ARM.

You already got a reply that dropping dma_alloc_writecombine() is no
go on ARM.

> Most of other architectures do not have dma_alloc_writecombine().

That's not a problem. Once we agree on dma_alloc_attrs(), the drivers
can be changed to use DMA_ATTR_WRITE_COMBINE attribute. If the platform
doesn't support the attribute, it is just ignored. That's the whole
point of the attributes extension. Once a driver is converted to=20
dma_alloc_attrs(), it can be used without any changes either on platfor=
ms
that supports some specific attributes or the one that doesn't implemen=
t
support for any of them.

> If you want dma_alloc_coherent() to allocate user virtual address,
> I believe that it is also available with mmap() you introduced.

Allocation is a separate operation from mapping to userspace. Mmap
operation should just map the buffer (represented by a cookie of type
dma_addr_t) to user address space.

Note that some drivers (like framebuffer drivers for example) also
needs to have both types of mapping - one for user space and one for
kernel virtual space.

Best regards
--=20
Marek Szyprowski
Samsung Poland R&D Center
