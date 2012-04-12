From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping
	interface
Date: Thu, 12 Apr 2012 14:13:37 +0200
Message-ID: <028f01cd18a5$b0721770$11564650$%szyprowski@samsung.com>
References: <1334155004-5700-1-git-send-email-m.szyprowski@samsung.com>
	<4F869AF4.3080402@gmail.com>
	<026301cd188d$32613860$9723a920$%szyprowski@samsung.com>
	<201204121109.28753.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <201204121109.28753.arnd-r2nGTMty4D4@public.gmane.org>
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
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, 'Benjamin Herrenschmidt' <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, 'Subash Patel' <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Krishna Reddy' <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Chunsang Jeong' <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org





> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: Thursday, April 12, 2012 1:09 PM
> To: Marek Szyprowski
> Cc: 'Subash Patel'; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org;
> linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org; linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; 'Kyungmin
> Park'; 'Joerg Roedel'; 'Russell King - ARM Linux'; 'Chunsang Jeong'; 'Krishna Reddy'; 'KyongHo
> Cho'; Andrzej Pietrasiewicz; 'Benjamin Herrenschmidt'; 'Konrad Rzeszutek Wilk'; 'Hiroshi Doyu'
> Subject: Re: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping interface
> 
> On Thursday 12 April 2012, Marek Szyprowski wrote:
> > +
> > > > +/*
> > > > + * s5p_sysmmu_late_init
> > > > + * Create DMA-mapping IOMMU context for specified devices. This function must
> > > > + * be called later, once SYSMMU driver gets registered and probed.
> > > > + */
> > > > +static int __init s5p_sysmmu_late_init(void)
> > > > +{
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc0).dev,&s5p_device_fimc0.dev);
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc1).dev,&s5p_device_fimc1.dev);
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc2).dev,&s5p_device_fimc2.dev);
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc3).dev,&s5p_device_fimc3.dev);
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_l).dev,&s5p_device_mfc_l.dev);
> > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_r).dev,&s5p_device_mfc_r.dev);
> > > > +
> > > > +   s5p_create_iommu_mapping(&s5p_device_fimc0.dev, 0x20000000, SZ_128M, 4);
> > > > +   s5p_create_iommu_mapping(&s5p_device_fimc1.dev, 0x20000000, SZ_128M, 4);
> > > > +   s5p_create_iommu_mapping(&s5p_device_fimc2.dev, 0x20000000, SZ_128M, 4);
> > > > +   s5p_create_iommu_mapping(&s5p_device_fimc3.dev, 0x20000000, SZ_128M, 4);
> > > > +   s5p_create_iommu_mapping(&s5p_device_mfc_l.dev, 0x20000000, SZ_128M, 4);
> > > > +   s5p_create_iommu_mapping(&s5p_device_mfc_r.dev, 0x40000000, SZ_128M, 4);
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +device_initcall(s5p_sysmmu_late_init);
> > >
> > > Shouldn't these things be specific to a SoC? With this RFC, it happens
> > > that you will predefine the IOMMU attachment and mapping information for
> > > devices in common location (dev-sysmmu.c)? This may lead to problems
> > > because there are some IP's with SYSMMU support in exynos5, but not
> > > available in exynos4 (eg: GSC, FIMC-LITE, FIMC-ISP) Previously we used
> > > to do above declaration in individual machine file, which I think was
> > > more meaningful.
> >
> > Right, I simplified the code too much. Keeping these definitions inside machine
> > files was a better idea. I completely forgot that Exynos sub-platform now covers
> > both Exynos4 and Exynos5 SoC families.
> 
> Ideally the information about iommu attachment should come from the
> device tree. We have the "dma-ranges" properties that define how a dma
> address space is mapped. I am not entirely sure how that works when you
> have multiple IOMMUs and if that requires defining addititional properties,
> but I think we should make it so that we don't have to hardcode specific
> devices in the source.

Right, until that time machine/board files are imho ok.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
