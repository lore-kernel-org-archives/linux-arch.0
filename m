From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V11 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Mon, 10 Apr 2017 16:51:03 +0530
Message-ID: <1491823266-1209-9-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

This is an equivalent to the DT's handling of the iommu master's probe
with deferred probing when the corrsponding iommu is not probed yet.
The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the firmware describes the bus master and
IOMMU topology correctly but no device driver exists for the IOMMU yet
or the device driver has not been compiled in. Return NULL, the caller
will configure the device without an IOMMU.

The second and third cases are handled by deferring the probe of the bus
master device which will eventually get reprobed after the IOMMU.

The last case is currently handled by deferring the probe of the bus
master device as well. A mechanism to either configure the bus master
device without an IOMMU or to fail the bus master device probe depending
on whether the IOMMU is optional or mandatory would be a good
enhancement.

Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
[Lorenzo: Added fixes for dma_coherent_mask overflow, acpi_dma_configure
          called multiple times for same device]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/acpi/arm64/iort.c  | 33 ++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c        | 11 ++++++++---
 drivers/base/dma-mapping.c |  2 +-
 include/acpi/acpi_bus.h    |  2 +-
 include/linux/acpi.h       |  7 +++++--
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3dd9ec3..e323ece 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -543,6 +543,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	const struct iommu_ops *ops = NULL;
 	int ret = -ENODEV;
 	struct fwnode_handle *iort_fwnode;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+
+	/*
+	 * If we already translated the fwspec there
+	 * is nothing left to do, return the iommu_ops.
+	 */
+	if (fwspec && fwspec->ops)
+		return fwspec->ops;
 
 	if (node) {
 		iort_fwnode = iort_get_fwnode(node);
@@ -550,8 +558,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 			return NULL;
 
 		ops = iommu_ops_from_fwnode(iort_fwnode);
+		/*
+		 * If the ops look-up fails, this means that either
+		 * the SMMU drivers have not been probed yet or that
+		 * the SMMU drivers are not built in the kernel;
+		 * Depending on whether the SMMU drivers are built-in
+		 * in the kernel or not, defer the IOMMU configuration
+		 * or just abort it.
+		 */
 		if (!ops)
-			return NULL;
+			return iort_iommu_driver_enabled(node->type) ?
+			       ERR_PTR(-EPROBE_DEFER) : NULL;
 
 		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
 	}
@@ -625,12 +642,26 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 
 		while (parent) {
 			ops = iort_iommu_xlate(dev, parent, streamid);
+			if (IS_ERR_OR_NULL(ops))
+				return ops;
 
 			parent = iort_node_get_id(node, &streamid,
 						  IORT_IOMMU_TYPE, i++);
 		}
 	}
 
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
+
 	return ops;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..2a513cc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1373,20 +1373,25 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  * @dev: The pointer to the device
  * @attr: device dma attributes
  */
-void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
+int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
 	const struct iommu_ops *iommu;
+	u64 size;
 
 	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
 
+	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	/*
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
-			   attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, 0, size, iommu, attr == DEV_DMA_COHERENT);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_dma_configure);
 
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 82bd45c..755a2b5 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -368,7 +368,7 @@ int dma_configure(struct device *dev)
 	} else if (has_acpi_companion(dma_dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
-			acpi_dma_configure(dev, attr);
+			ret = acpi_dma_configure(dev, attr);
 	}
 
 	if (bridge)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ef0ae8a..2a9a5de 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -575,7 +575,7 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
-void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
+int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
 void acpi_dma_deconfigure(struct device *dev);
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9b05886..79d06ef6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -762,8 +762,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
-static inline void acpi_dma_configure(struct device *dev,
-				      enum dev_dma_attr attr) { }
+static inline int acpi_dma_configure(struct device *dev,
+				     enum dev_dma_attr attr)
+{
+	return 0;
+}
 
 static inline void acpi_dma_deconfigure(struct device *dev) { }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
