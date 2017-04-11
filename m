From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: "Consolidate get_dma_ops" breaks Xen on ARM
Date: Tue, 11 Apr 2017 16:39:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1704111411350.2759@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260> <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com> <a758dfc6-2b00-e279-303c-ba1e27380e35@arm.com>
 <20170411133649.GB27857@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdDKXjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 19:39:14 -0400
In-Reply-To: <20170411133649.GB27857@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Julien Grall <julien.grall@arm.com>, Bart Van Assche <Bart.VanAssche@sandisk.com>, Stefano Stabellini <sstabellini@kernel.org>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, 11 Apr 2017, Catalin Marinas wrote:
> On Tue, Apr 11, 2017 at 01:43:28PM +0100, Julien Grall wrote:
> > On 11/04/17 02:14, Bart Van Assche wrote:
> > > On 04/10/17 17:31, Stefano Stabellini wrote:
> > >> I think the reason is that, as you can see, if (dev && dev->dma_ops),
> > >> dev->dma_ops is returned, while before this changes, xen_dma_ops was
> > >> returned on Xen on ARM.
> > >>
> > >> Unfortunately DMA cannot work properly without using the appropriate
> > >> xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for
> > >> more details. (The problem is easy to spot, but I wasn't CC'ed on the
> > >> patch.)
> > >>
> > >> I don't know how to solve this problem without introducing some sort of
> > >> if (xen()) in include/linux/dma-mapping.h.
> > > 
> > > Sorry but I don't have access to an ARM development system. Does your 
> > > comment apply to dev == NULL only, dev != NULL only or perhaps to both? 
> > > If your comment applies to dev != NULL only, can you check whether 
> > > adding something like set_dma_ops(dev, get_arch_dma_ops(NULL)) to the 
> > > appropriate ARM arch_setup_dma_ops() function is sufficient?
> > 
> > If I understand correctly, set_dma_ops will replace dev->dma_ops with
> > Xen DMA ops.
> > 
> > However, Xen DMA ops will need in some places to call the device 
> > specific DMA ops (see __generic_dma_ops(...)). So I think replacing
> > dev->dma_ops is not a solution here.
> > 
> > The hackish patch below is fixing the problem for both ARM64 and ARM32.
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 0977317c6835..43a73ddeec7a 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -174,6 +174,8 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
> >  #include <asm/dma-mapping.h>
> >  static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
> >  {
> > +       if (xen_initial_domain())
> > +              return xen_dma_ops;
> >         if (dev && dev->dma_ops)
> >                 return dev->dma_ops;
> >         return get_arch_dma_ops(dev ? dev->bus : NULL);
> 
> If we do this, I guess there is no need to check for
> xen_initial_domain() in the get_arch_dma_ops() function. Anyway, this
> hunk would break the other architectures since xen_dma_ops is only
> defined for arm and arm64.
> 
> > It is not nice as this is common code, but I can't find a better solution
> > so far. Any opinions?
> 
> A different hack would be to avoid the generic get_dma_ops
> implementation on arm with some #ifdef hacks above.
> 
> Yet another way would be for dom0 to always set dev->dma_ops to
> xen_dma_ops and preserve the real dma_ops somewhere under dev->archdata.
> You could intercept the arch_setup_dma_ops() function for this or use
> bus_register_notifier() (though I think the former is easier). The Xen
> code making use of the real dma_ops would have to dig them out from
> dev->archdata.

This is a good suggestion, Catalin. Thank you. See below. Is that what
you have in mind? Julien could you test it, please? If it is the right
approach, I'll submit the patch properly and rename __generic_dma_ops to
xen_generic_dma_ops or something.

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 220ba20..36ec9c8 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -16,6 +16,9 @@ struct dev_archdata {
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping	*mapping;
 #endif
+#ifdef CONFIG_XEN
+	const struct dma_map_ops *dev_dma_ops;
+#endif
 	bool dma_coherent;
 };
 
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 7166569..680d3f3 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -16,19 +16,9 @@
 extern const struct dma_map_ops arm_dma_ops;
 extern const struct dma_map_ops arm_coherent_dma_ops;
 
-static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
-{
-	if (dev && dev->dma_ops)
-		return dev->dma_ops;
-	return &arm_dma_ops;
-}
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (xen_initial_domain())
-		return xen_dma_ops;
-	else
-		return __generic_dma_ops(NULL);
+	return &arm_dma_ops;
 }
 
 #define HAVE_ARCH_DMA_SUPPORTED 1
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 63eabb0..82d61eb 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2396,6 +2396,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dma_ops = arm_get_dma_map_ops(coherent);
 
 	set_dma_ops(dev, dma_ops);
+
+	if (xen_initial_domain()) {
+		dev->archdata.dev_dma_ops = dev->dma_ops;
+		dev->dma_ops = xen_dma_ops;
+	}
 }
 
 void arch_teardown_dma_ops(struct device *dev)
diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 73d5bab..5a5fa47 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -20,6 +20,9 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
 #endif
+#ifdef CONFIG_XEN
+	const struct dma_map_ops *dev_dma_ops;
+#endif
 	bool dma_coherent;
 };
 
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 505756c..5392dbe 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -27,11 +27,8 @@
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern const struct dma_map_ops dummy_dma_ops;
 
-static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->dma_ops)
-		return dev->dma_ops;
-
 	/*
 	 * We expect no ISA devices, and all other DMA masters are expected to
 	 * have someone call arch_setup_dma_ops at device creation time.
@@ -39,14 +36,6 @@ static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
 	return &dummy_dma_ops;
 }
 
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	if (xen_initial_domain())
-		return xen_dma_ops;
-	else
-		return __generic_dma_ops(NULL);
-}
-
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 81cdb2e..e574c39 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -977,4 +977,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+
+	if (xen_initial_domain()) {
+		dev->archdata.dev_dma_ops = dev->dma_ops;
+		dev->dma_ops = xen_dma_ops;
+	}
 }
diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
index 95ce6ac..b0a2bfc 100644
--- a/include/xen/arm/page-coherent.h
+++ b/include/xen/arm/page-coherent.h
@@ -2,8 +2,16 @@
 #define _ASM_ARM_XEN_PAGE_COHERENT_H
 
 #include <asm/page.h>
+#include <asm/dma-mapping.h>
 #include <linux/dma-mapping.h>
 
+static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
+{
+	if (dev && dev->archdata.dev_dma_ops)
+		return dev->archdata.dev_dma_ops;
+	return get_arch_dma_ops(NULL);
+}
+
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs);
