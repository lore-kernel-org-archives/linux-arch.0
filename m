Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757155AbdE0Ns6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 May 2017 09:48:58 -0400
From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v6 5/6] ACPI/IORT: Move the check to get iommu_ops from translated fwspec
Date: Sat, 27 May 2017 19:17:44 +0530
Message-ID: <1495892865-9506-5-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net, geert@linux-m68k.org, magnus.damm@gmail.com, nwatters@codeaurora.org, linux@armlinux.org.uk
Cc: sricharan@codeaurora.org
Message-ID: <20170527134744.Hq0jukYjMPWQIW1r0VZmZP91mLMZnLTJyTW12LxJ_5Q@z>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

With IOMMU probe deferral, iort_iommu_configure can be called
multiple times for the same device. Hence we have a check
to see if the device's fwspec is already translated and return
the iommu_ops from that directly. But the check is wrongly
placed in iort_iommu_xlate, which breaks devices with multiple
sids. Move the check to iort_iommu_configure.

Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
Tested-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/iort.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 16e101f..797b28d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -666,14 +666,6 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	int ret = -ENODEV;
 	struct fwnode_handle *iort_fwnode;
 
-	/*
-	 * If we already translated the fwspec there
-	 * is nothing left to do, return the iommu_ops.
-	 */
-	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
-	if (ops)
-		return ops;
-
 	if (node) {
 		iort_fwnode = iort_get_fwnode(node);
 		if (!iort_fwnode)
@@ -735,6 +727,14 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	u32 streamid = 0;
 	int err;
 
+	/*
+	 * If we already translated the fwspec there
+	 * is nothing left to do, return the iommu_ops.
+	 */
+	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	if (ops)
+		return ops;
+
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 		u32 rid;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
