From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 3/3] ARM: dma-mapping: Don't tear third-party mappings
Date: Thu, 18 May 2017 15:37:10 +0530
Message-ID: <1495102030-10548-3-git-send-email-sricharan@codeaurora.org>
References: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1495102030-10548-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

arch_setup_dma_ops() is used in device probe code paths to create an
IOMMU mapping and attach it to the device. The function assumes that the
device is attached to a device-specific IOMMU instance (or at least a
device-specific TLB in a shared IOMMU instance) and thus creates a
separate mapping for every device.

On several systems (Renesas R-Car Gen2 being one of them), that
assumption is not true, and IOMMU mappings must be shared between
multiple devices. In those cases the IOMMU driver knows better than the
generic ARM dma-mapping layer and attaches mapping to devices manually
with arm_iommu_attach_device(), which sets the DMA ops for the device.

The arch_setup_dma_ops() function takes this into account and bails out
immediately if the device already has DMA ops assigned. However, the
corresponding arch_teardown_dma_ops() function, called from driver
unbind code paths (including probe deferral), will tear the mapping down
regardless of who created it. When the device is reprobed
arch_setup_dma_ops() will be called again but won't perform any
operation as the DMA ops will still be set.

We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
However, we can't do so unconditionally, as then a new mapping would be
created by arch_setup_dma_ops() when the device is reprobed, regardless
of whether the device needs to share a mapping or not. We must thus keep
track of whether arch_setup_dma_ops() created the mapping, and only in
that case tear it down in arch_teardown_dma_ops().

Keep track of that information in the dev_archdata structure. As the
structure is embedded in all instances of struct device let's not grow
it, but turn the existing dma_coherent bool field into a bitfield that
can be used for other purposes.

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 arch/arm/include/asm/device.h | 3 ++-
 arch/arm/mm/dma-mapping.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 36ec9c8..3234fe9 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -19,7 +19,8 @@ struct dev_archdata {
 #ifdef CONFIG_XEN
 	const struct dma_map_ops *dev_dma_ops;
 #endif
-	bool dma_coherent;
+	unsigned int dma_coherent:1;
+	unsigned int dma_ops_setup:1;
 };
 
 struct omap_device;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c742dfd..b48998f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2430,9 +2430,13 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dev->dma_ops = xen_dma_ops;
 	}
 #endif
+	dev->archdata.dma_ops_setup = true;
 }
 
 void arch_teardown_dma_ops(struct device *dev)
 {
+	if (!dev->archdata.dma_ops_setup)
+		return;
+
 	arm_teardown_iommu_dma_ops(dev);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
