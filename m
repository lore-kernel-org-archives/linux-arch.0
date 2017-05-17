From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Wed, 17 May 2017 17:00:08 +0530
Message-ID: <1495020609-13397-2-git-send-email-sricharan@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495020609-13397-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

While deferring the probe of iommu masters,
xlate and add_device callback can pass back error values
like -ENODEV, which means iommu cannot be connected
with that master for real reasons. So rather than
killing the master's probe for such errors, just
ignore the errors and let the master work without
an iommu.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Tested-by: Magnus Damn <magnus.damn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
