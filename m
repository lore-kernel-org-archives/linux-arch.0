From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping
	interface
Date: Thu, 12 Apr 2012 14:38:40 +0200
Message-ID: <20120412.153840.505876550992316983.hdoyu@nvidia.com>
References: <026301cd188d$32613860$9723a920$%szyprowski@samsung.com><201204121109.28753.arnd@arndb.de><028f01cd18a5$b0721770$11564650$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <028f01cd18a5$b0721770$11564650$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping interface
Date: Thu, 12 Apr 2012 14:13:37 +0200
Message-ID: <028f01cd18a5$b0721770$11564650$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

>
>
>
>
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > Sent: Thursday, April 12, 2012 1:09 PM
> > To: Marek Szyprowski
> > Cc: 'Subash Patel'; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org;
> > linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org; linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; 'Kyungmin
> > Park'; 'Joerg Roedel'; 'Russell King - ARM Linux'; 'Chunsang Jeong'; 'Krishna Reddy'; 'KyongHo
> > Cho'; Andrzej Pietrasiewicz; 'Benjamin Herrenschmidt'; 'Konrad Rzeszutek Wilk'; 'Hiroshi Doyu'
> > Subject: Re: [PATCH] ARM: Exynos4: integrate SYSMMU driver with DMA-mapping interface
> >
> > On Thursday 12 April 2012, Marek Szyprowski wrote:
> > > +
> > > > > +/*
> > > > > + * s5p_sysmmu_late_init
> > > > > + * Create DMA-mapping IOMMU context for specified devices. This function must
> > > > > + * be called later, once SYSMMU driver gets registered and probed.
> > > > > + */
> > > > > +static int __init s5p_sysmmu_late_init(void)
> > > > > +{
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc0).dev,&s5p_device_fimc0.dev);
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc1).dev,&s5p_device_fimc1.dev);
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc2).dev,&s5p_device_fimc2.dev);
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(fimc3).dev,&s5p_device_fimc3.dev);
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_l).dev,&s5p_device_mfc_l.dev);
> > > > > +   platform_set_sysmmu(&SYSMMU_PLATDEV(mfc_r).dev,&s5p_device_mfc_r.dev);
> > > > > +
> > > > > +   s5p_create_iommu_mapping(&s5p_device_fimc0.dev, 0x20000000, SZ_128M, 4);
> > > > > +   s5p_create_iommu_mapping(&s5p_device_fimc1.dev, 0x20000000, SZ_128M, 4);
> > > > > +   s5p_create_iommu_mapping(&s5p_device_fimc2.dev, 0x20000000, SZ_128M, 4);
> > > > > +   s5p_create_iommu_mapping(&s5p_device_fimc3.dev, 0x20000000, SZ_128M, 4);
> > > > > +   s5p_create_iommu_mapping(&s5p_device_mfc_l.dev, 0x20000000, SZ_128M, 4);
> > > > > +   s5p_create_iommu_mapping(&s5p_device_mfc_r.dev, 0x40000000, SZ_128M, 4);
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +device_initcall(s5p_sysmmu_late_init);
> > > >
> > > > Shouldn't these things be specific to a SoC? With this RFC, it happens
> > > > that you will predefine the IOMMU attachment and mapping information for
> > > > devices in common location (dev-sysmmu.c)? This may lead to problems
> > > > because there are some IP's with SYSMMU support in exynos5, but not
> > > > available in exynos4 (eg: GSC, FIMC-LITE, FIMC-ISP) Previously we used
> > > > to do above declaration in individual machine file, which I think was
> > > > more meaningful.
> > >
> > > Right, I simplified the code too much. Keeping these definitions inside machine
> > > files was a better idea. I completely forgot that Exynos sub-platform now covers
> > > both Exynos4 and Exynos5 SoC families.
> >
> > Ideally the information about iommu attachment should come from the
> > device tree. We have the "dma-ranges" properties that define how a dma
> > address space is mapped. I am not entirely sure how that works when you
> > have multiple IOMMUs and if that requires defining addititional properties,
> > but I think we should make it so that we don't have to hardcode specific
> > devices in the source.
>
> Right, until that time machine/board files are imho ok.

In Tegra30, there are quite many IOMMU attachable (platform)devices,
and it's quite nice for us to configure them (un)attached with address
range and IOMMU device ID(ASID) in DT in advance rather than inserting
the code to attach those devices here and there.

Experimentally I added some hook in platform_device_add() as below,
but apparently this won't be accepted.

From cb34373ebbf025e42ec6d8fea2e19e74ba41231e Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Thu, 22 Mar 2012 16:06:27 +0200
Subject: [PATCH 1/1] ARM: dma-mapping: All platform_device DMA API'able

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-tegra/board-cardhu.c |    7 ++++++-
 arch/arm/mm/dma-mapping.c          |    5 ++++-
 drivers/base/platform.c            |   11 +++++++++--
 include/linux/device.h             |    2 ++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/board-cardhu.c b/arch/arm/mach-tegra/board-cardhu.c
index 339011e..38f5292 100644
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ca5544e..5e6dbe0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -758,6 +758,9 @@ size_t arm_iommu_iova_avail(struct device *dev)
 	size_t size = 0;
 	unsigned long start = 0;

+	BUG_ON(!dev);
+	BUG_ON(!mapping);
+
 	spin_lock_irqsave(&mapping->lock, flags);
 	while (1) {
 		unsigned long end;
@@ -1513,7 +1516,7 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 	mapping->domain = iommu_domain_alloc(bus);
 	if (!mapping->domain)
 		goto err3;
-
+	bus->map = mapping;
 	kref_init(&mapping->kref);
 	return mapping;
 err3:
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 99a5272..4af431c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -21,6 +21,8 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>

+#include <asm/dma-iommu.h>
+
 #include "base.h"

 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
@@ -305,8 +307,13 @@ int platform_device_add(struct platform_device *pdev)
 		 dev_name(&pdev->dev), dev_name(pdev->dev.parent));

 	ret = device_add(&pdev->dev);
-	if (ret == 0)
-		return ret;
+	if (ret)
+		goto failed;
+
+	if (platform_bus_type.map)
+		arm_iommu_attach_device(&pdev->dev, platform_bus_type.map);
+
+	return 0;

  failed:
 	while (--i >= 0) {
diff --git a/include/linux/device.h b/include/linux/device.h
index 28c35f8..732611f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -34,6 +34,7 @@ struct subsys_private;
 struct bus_type;
 struct device_node;
 struct iommu_ops;
+struct dma_iommu_mapping;

 struct bus_attribute {
 	struct attribute	attr;
@@ -101,6 +102,7 @@ struct bus_type {
 	const struct dev_pm_ops *pm;

 	struct iommu_ops *iommu_ops;
+	struct dma_iommu_mapping *map;

 	struct subsys_private *p;
 };
--
1.7.5.4
