From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V10 02/12] iommu/of: Prepare for deferred IOMMU configuration
Date: Tue,  4 Apr 2017 15:48:15 +0530
Message-ID: <1491301105-5274-3-git-send-email-sricharan@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491301105-5274-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

IOMMU configuration represents unchanging properties of the hardware,
and as such should only need happen once in a device's lifetime, but
the necessary interaction with the IOMMU device and driver complicates
exactly when that point should be.

Since the only reasonable tool available for handling the inter-device
dependency is probe deferral, we need to prepare of_iommu_configure()
to run later than it is currently called (i.e. at driver probe rather
than device creation), to handle being retried, and to tell whether a
not-yet present IOMMU should be waited for or skipped (by virtue of
having declared a built-in driver or not).

Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8f4e599..c8be889 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -96,6 +96,19 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
+static bool of_iommu_driver_present(struct device_node *np)
+{
+	/*
+	 * If the IOMMU still isn't ready by the time we reach init, assume
+	 * it never will be. We don't want to defer indefinitely, nor attempt
+	 * to dereference __iommu_of_table after it's been freed.
+	 */
+	if (system_state > SYSTEM_BOOTING)
+		return false;
+
+	return of_match_node(&__iommu_of_table, np);
+}
+
 static const struct iommu_ops
 *of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
 {
@@ -104,12 +117,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	int err;
 
 	ops = iommu_ops_from_fwnode(fwnode);
-	if (!ops || !ops->of_xlate)
+	if ((ops && !ops->of_xlate) ||
+	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
 		return NULL;
 
 	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
 	if (err)
 		return ERR_PTR(err);
+	/*
+	 * The otherwise-empty fwspec handily serves to indicate the specific
+	 * IOMMU device we're waiting for, which will be useful if we ever get
+	 * a proper probe-ordering dependency mechanism in future.
+	 */
+	if (!ops)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	err = ops->of_xlate(dev, iommu_spec);
 	if (err)
@@ -186,14 +207,34 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
 	const struct iommu_ops *ops;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 
 	if (!master_np)
 		return NULL;
 
+	if (fwspec) {
+		if (fwspec->ops)
+			return fwspec->ops;
+
+		/* In the deferred case, start again from scratch */
+		iommu_fwspec_free(dev);
+	}
+
 	if (dev_is_pci(dev))
 		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
 	else
 		ops = of_platform_iommu_init(dev, master_np);
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
+	    dev->bus && !dev->iommu_group) {
+		int err = ops->add_device(dev);
+
+		if (err)
+			ops = ERR_PTR(err);
+	}
 
 	return IS_ERR(ops) ? NULL : ops;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
