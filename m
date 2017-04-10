From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V11 07/11] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Mon, 10 Apr 2017 16:51:02 +0530
Message-ID: <1491823266-1209-8-git-send-email-sricharan@codeaurora.org>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Failures to look up an IOMMU when parsing the DT iommus property need to
be handled separately from the .of_xlate() failures to support deferred
probing.

The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the device tree describes the bus master and
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

Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Laurent Pichart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

 [V11] Small change to return non-void value in one of returns
       in of_dma_configure, as a result of dropping patch #3 from
       previous V10. No functional impact.

 drivers/base/dma-mapping.c | 5 +++--
 drivers/iommu/of_iommu.c   | 4 ++--
 drivers/of/device.c        | 9 +++++++--
 include/linux/of_device.h  | 9 ++++++---
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 449b948..82bd45c 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -353,6 +353,7 @@ int dma_configure(struct device *dev)
 {
 	struct device *bridge = NULL, *dma_dev = dev;
 	enum dev_dma_attr attr;
+	int ret = 0;
 
 	if (dev_is_pci(dev)) {
 		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
@@ -363,7 +364,7 @@ int dma_configure(struct device *dev)
 	}
 
 	if (dma_dev->of_node) {
-		of_dma_configure(dev, dma_dev->of_node);
+		ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -373,7 +374,7 @@ int dma_configure(struct device *dev)
 	if (bridge)
 		pci_put_host_bridge_device(bridge);
 
-	return 0;
+	return ret;
 }
 
 void dma_deconfigure(struct device *dev)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c8be889..9f44ee8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -236,7 +236,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
-	return IS_ERR(ops) ? NULL : ops;
+	return ops;
 }
 
 static int __init of_iommu_init(void)
@@ -247,7 +247,7 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index e1ae9e7..8bd3d8c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -82,7 +82,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-void of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
@@ -123,7 +123,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 
 		if (!size) {
 			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
-			return;
+			return -EINVAL;
 		}
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
@@ -144,10 +144,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index af98455..2cacdd8 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev, struct device_node *np);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
@@ -104,8 +104,11 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
-static inline void of_dma_configure(struct device *dev, struct device_node *np)
-{}
+
+static inline int of_dma_configure(struct device *dev, struct device_node *np)
+{
+	return 0;
+}
 static inline void of_dma_deconfigure(struct device *dev)
 {}
 #endif /* CONFIG_OF */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
