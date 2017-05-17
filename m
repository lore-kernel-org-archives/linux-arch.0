Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdEQLaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2017 07:30:35 -0400
From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Wed, 17 May 2017 17:00:08 +0530
Message-ID: <1495020609-13397-2-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, j.neuschaefer@gmx.net
Cc: sricharan@codeaurora.org
Message-ID: <20170517113008.Vnk6vBJVSRNcZWaVz0BPC6ZES7mZm69k5yKEu0wKAzs@z>

While deferring the probe of iommu masters,
xlate and add_device callback can pass back error values
like -ENODEV, which means iommu cannot be connected
with that master for real reasons. So rather than
killing the master's probe for such errors, just
ignore the errors and let the master work without
an iommu.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e6e9bec..2ec2f0b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_info(dev, "Adding to iommu failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
