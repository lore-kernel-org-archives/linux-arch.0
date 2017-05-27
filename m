Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbdE0NtH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2017 09:49:07 -0400
From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v6 6/6] arm: dma-mapping: Reset the device's dma_ops
Date: Sat, 27 May 2017 19:17:45 +0530
Message-ID: <1495892865-9506-6-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net, geert@linux-m68k.org, magnus.damm@gmail.com, nwatters@codeaurora.org, linux@armlinux.org.uk
Cc: sricharan@codeaurora.org
Message-ID: <20170527134745.XkPwtFvMwy6iMeamS_4Po-Ri-siavuyTvPsagR4MVbI@z>

arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
,dma_ops should be cleared in the teardown path. Currently, only the
device's iommu mapping structures are cleared in arch_teardown_dma_ops,
but not the dma_ops. So on the next reprobe, dma_ops left in place is
stale from the first IOMMU setup, but iommu mappings has been disposed
of. This is a problem when the probe of the device is deferred and
recalled with the IOMMU probe deferral.

So for fixing this, slightly refactor by moving the code from
__arm_iommu_detach_device to arm_iommu_detach_device and cleanup
the former. This takes care of resetting the dma_ops in the teardown
path.

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b48998f..bd83c53 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2311,7 +2311,14 @@ int arm_iommu_attach_device(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
-static void __arm_iommu_detach_device(struct device *dev)
+/**
+ * arm_iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ * This voids the dma operations (dma_map_ops pointer)
+ */
+void arm_iommu_detach_device(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -2324,22 +2331,10 @@ static void __arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
+	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
-
-/**
- * arm_iommu_detach_device
- * @dev: valid struct device pointer
- *
- * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
- */
-void arm_iommu_detach_device(struct device *dev)
-{
-	__arm_iommu_detach_device(dev);
-	set_dma_ops(dev, NULL);
-}
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static const struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
@@ -2379,7 +2374,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	if (!mapping)
 		return;
 
-	__arm_iommu_detach_device(dev);
+	arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
