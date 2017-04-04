From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V10 01/12] iommu/of: Refactor of_iommu_configure() for error
	handling
Date: Tue,  4 Apr 2017 15:48:14 +0530
Message-ID: <1491301105-5274-2-git-send-email-sricharan@codeaurora.org>
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

In preparation for some upcoming cleverness, rework the control flow in
of_iommu_configure() to minimise duplication and improve the propogation
of errors. It's also as good a time as any to switch over from the
now-just-a-compatibility-wrapper of_iommu_get_ops() to using the generic
IOMMU instance interface directly.

Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 83 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 2683e9f..8f4e599 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -96,6 +96,28 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
+static const struct iommu_ops
+*of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
+{
+	const struct iommu_ops *ops;
+	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
+	int err;
+
+	ops = iommu_ops_from_fwnode(fwnode);
+	if (!ops || !ops->of_xlate)
+		return NULL;
+
+	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	if (err)
+		return ERR_PTR(err);
+
+	err = ops->of_xlate(dev, iommu_spec);
+	if (err)
+		return ERR_PTR(err);
+
+	return ops;
+}
+
 static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct of_phandle_args *iommu_spec = data;
@@ -105,10 +127,11 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 }
 
 static const struct iommu_ops
-*of_pci_iommu_configure(struct pci_dev *pdev, struct device_node *bridge_np)
+*of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
 {
 	const struct iommu_ops *ops;
 	struct of_phandle_args iommu_spec;
+	int err;
 
 	/*
 	 * Start by tracing the RID alias down the PCI topology as
@@ -123,56 +146,56 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 	 * bus into the system beyond, and which IOMMU it ends up at.
 	 */
 	iommu_spec.np = NULL;
-	if (of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
-			   "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
-		return NULL;
+	err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
+			     "iommu-map-mask", &iommu_spec.np,
+			     iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NULL : ERR_PTR(err);
 
-	ops = iommu_ops_from_fwnode(&iommu_spec.np->fwnode);
-	if (!ops || !ops->of_xlate ||
-	    iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
-	    ops->of_xlate(&pdev->dev, &iommu_spec))
-		ops = NULL;
+	ops = of_iommu_xlate(&pdev->dev, &iommu_spec);
 
 	of_node_put(iommu_spec.np);
 	return ops;
 }
 
-const struct iommu_ops *of_iommu_configure(struct device *dev,
-					   struct device_node *master_np)
+static const struct iommu_ops
+*of_platform_iommu_init(struct device *dev, struct device_node *np)
 {
 	struct of_phandle_args iommu_spec;
-	struct device_node *np;
 	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
-	if (dev_is_pci(dev))
-		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
-
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
 	 * See the `Notes:' section of
 	 * Documentation/devicetree/bindings/iommu/iommu.txt
 	 */
-	while (!of_parse_phandle_with_args(master_np, "iommus",
-					   "#iommu-cells", idx,
-					   &iommu_spec)) {
-		np = iommu_spec.np;
-		ops = iommu_ops_from_fwnode(&np->fwnode);
-
-		if (!ops || !ops->of_xlate ||
-		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
-		    ops->of_xlate(dev, &iommu_spec))
-			goto err_put_node;
-
-		of_node_put(np);
+	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+					   idx, &iommu_spec)) {
+		ops = of_iommu_xlate(dev, &iommu_spec);
+		of_node_put(iommu_spec.np);
 		idx++;
+		if (IS_ERR_OR_NULL(ops))
+			break;
 	}
 
 	return ops;
+}
+
+const struct iommu_ops *of_iommu_configure(struct device *dev,
+					   struct device_node *master_np)
+{
+	const struct iommu_ops *ops;
+
+	if (!master_np)
+		return NULL;
+
+	if (dev_is_pci(dev))
+		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
+	else
+		ops = of_platform_iommu_init(dev, master_np);
 
-err_put_node:
-	of_node_put(np);
-	return NULL;
+	return IS_ERR(ops) ? NULL : ops;
 }
 
 static int __init of_iommu_init(void)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
