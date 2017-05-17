From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 1/3] iommu: of: Fix check for returning EPROBE_DEFER
Date: Wed, 17 May 2017 17:00:07 +0530
Message-ID: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbdEQLa1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2017 07:30:27 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, j.neuschaefer@gmx.net
Cc: sricharan@codeaurora.org

Now with iommu probe deferral, we return -EPROBE_DEFER
for master's that are connected to an iommu which is not
probed yet, but going to get probed, so that we can attach
the correct dma_ops. So while trying to defer the probe of
the master, check if the of_iommu node that it is connected
to is marked in DT as 'status=disabled', then the iommu is never
is going to get probed. So simply return NULL and let the master
work without an iommu.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9f44ee8..e6e9bec 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
+	    !of_device_is_available(iommu_spec->np) ||
 	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
 		return NULL;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
