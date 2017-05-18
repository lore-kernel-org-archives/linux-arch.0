From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Thu, 18 May 2017 15:37:09 +0530
Message-ID: <1495102030-10548-2-git-send-email-sricharan@codeaurora.org>
References: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdERKHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2017 06:07:40 -0400
In-Reply-To: <1495102030-10548-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, j.neuschaefer@gmx.net, laurent.pinchart+renesas@ideasonboard.com
Cc: sricharan@codeaurora.org

While deferring the probe of IOMMU masters,
xlate and add_device callback can pass back error values
like -ENODEV, which means IOMMU cannot be connected
with that master for real reasons. So rather than
killing the master's probe for such errors, just
ignore the errors and let the master work without
an IOMMU.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[V2] Corrected spelling/case in commit log

 drivers/iommu/of_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e6e9bec..f0d22c0 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_info(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
