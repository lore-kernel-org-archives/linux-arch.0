From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCHv8 10/10] ARM: dma-mapping: add support for IOMMU mapper
Date: Tue, 10 Apr 2012 14:57:48 +0200
Message-ID: <002d01cd1719$87ac7520$97055f60$%szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
	<1334055852-19500-11-git-send-email-m.szyprowski@samsung.com>
	<201204101158.29590.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <201204101158.29590.arnd-r2nGTMty4D4@public.gmane.org>
Content-language: pl
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, 'Benjamin Herrenschmidt' <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Krishna Reddy' <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Chunsang Jeong' <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

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
> > + * Creates a mapping structure which holds information about used/unus=
ed
> > + * IO address ranges, which is required to perform memory allocation a=
nd
> > + * mapping with IOMMU aware functions.
> > + *
> > + * The client device need to be attached to the mapping with
> > + * arm_iommu_attach_device function.
> > + */
> > +struct dma_iommu_mapping *
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t=
 size,
> > +                        int order)
> > +{
> > +       unsigned int count =3D size >> (PAGE_SHIFT + order);
> > +       unsigned int bitmap_size =3D BITS_TO_LONGS(count) * sizeof(long=
);
> > +       struct dma_iommu_mapping *mapping;
> > +       int err =3D -ENOMEM;
> > +
> > +       if (!count)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       mapping =3D kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNE=
L);
> > +       if (!mapping)
> > +               goto err;
> > +
> > +       mapping->bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> > +       if (!mapping->bitmap)
> > +               goto err2;
> > +
> > +       mapping->base =3D base;
> > +       mapping->bits =3D BITS_PER_BYTE * bitmap_size;
> > +       mapping->order =3D order;
> > +       spin_lock_init(&mapping->lock);
> > +
> > +       mapping->domain =3D iommu_domain_alloc(bus);
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
> =

> I don't understand this function, mostly I guess because you have not
> provided any users. A few questions here:
> =

> * What is ARM specific about it that it is named arm_iommu_create_mapping?
>   Isn't this completely generic, at least on the interface side?
> =

> * Why is this exported to modules? Which device drivers do you expect
>   to call it?
> =

> * Why do you pass the bus_type in here? That seems like the completely
>   wrong thing to do when all devices are on the same bus type (e.g.
>   amba or platform) but are connected to different instances that each
>   have their own iommu. I guess this is a question for J=F6rg, because the
>   base iommu interface provides iommu_domain_alloc().

I will soon post a patch which shows how my IOMMU aware dma-mapping =

integrates with Samsung Exynos4 SYSMMU driver, so I will be able to answer
all your questions by pointing to the respective lines in either IOMMU
framework or my integration code.

Best regards
-- =

Marek Szyprowski
Samsung Poland R&D Center
