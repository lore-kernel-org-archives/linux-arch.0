From: Stefano Stabellini <sstabellini@kernel.org>
Subject: "Consolidate get_dma_ops" breaks Xen on ARM
Date: Mon, 10 Apr 2017 17:31:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751695AbdDKAbz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Apr 2017 20:31:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bart.vanassche@sandisk.com
Cc: sstabellini@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, benh@kernel.crashing.org, dwmw2@infradead.org, hpa@zytor.com, mingo@redhat.com, linux@armlinux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, julien.grall@arm.com

Hi all,

Julien Grall (CC'ed) discovered that the following commit breaks Xen on ARM:


  commit 815dd18788fe0d41899f51b91d0560279cf16b0d
  Author: Bart Van Assche <bart.vanassche@sandisk.com>
  Date:   Fri Jan 20 13:04:04 2017 -0800
  
      treewide: Consolidate get_dma_ops() implementations
   

The relevant changes are:

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c7432d6..7166569 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -23,12 +23,12 @@ static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
 	return &arm_dma_ops;
 }
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	if (xen_initial_domain())
 		return xen_dma_ops;
 	else
-		return __generic_dma_ops(dev);
+		return __generic_dma_ops(NULL);
 }
 
 #define HAVE_ARCH_DMA_SUPPORTED 1
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e97f23e..ab87108 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -164,6 +164,13 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
+static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (dev && dev->dma_ops)
+		return dev->dma_ops;
+	return get_arch_dma_ops(dev ? dev->bus : NULL);
+}
+
 static inline void set_dma_ops(struct device *dev,
 			       const struct dma_map_ops *dma_ops)
 {


I think the reason is that, as you can see, if (dev && dev->dma_ops),
dev->dma_ops is returned, while before this changes, xen_dma_ops was
returned on Xen on ARM.

Unfortunately DMA cannot work properly without using the appropriate
xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for
more details. (The problem is easy to spot, but I wasn't CC'ed on the
patch.)

I don't know how to solve this problem without introducing some sort of
if (xen()) in include/linux/dma-mapping.h.
