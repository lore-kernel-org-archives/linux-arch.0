From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V11 10/11] iommu/arm-smmu: Clean up early-probing workarounds
Date: Mon, 10 Apr 2017 16:51:05 +0530
Message-ID: <1491823266-1209-11-git-send-email-sricharan@codeaurora.org>
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

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Now that the appropriate ordering is enforced via probe-deferral of
masters in core code, rip it all out and bask in the simplicity.

Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
[Sricharan: Rebased on top of ACPI IORT SMMU series]
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c |  46 +-----------------
 drivers/iommu/arm-smmu.c    | 110 +++++++++++++++++++-------------------------
 2 files changed, 49 insertions(+), 107 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5806a6a..9497800 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2761,51 +2761,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
+module_platform_driver(arm_smmu_driver);
 
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU_V3))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu_v3, ACPI_SIG_IORT, acpi_smmu_v3_init);
-#endif
+IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index abf6496..be53b02 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2075,6 +2075,23 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static void arm_smmu_bus_init(void)
+{
+	/* Oh, for a proper bus abstraction */
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		pci_request_acs();
+		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+	}
+#endif
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2180,21 +2197,30 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
 
-	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
-#ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
-#endif
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		pci_request_acs();
-		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-	}
-#endif
+	/*
+	 * For ACPI and generic DT bindings, an SMMU will be probed before
+	 * any device which might need it, so we want the bus ops in place
+	 * ready to handle default domain setup as soon as any SMMU exists.
+	 */
+	if (!using_legacy_binding)
+		arm_smmu_bus_init();
+
+	return 0;
+}
+
+/*
+ * With the legacy DT binding in play, though, we have no guarantees about
+ * probe order, but then we're also not doing default domains, so we can
+ * delay setting bus ops until we're sure every possible SMMU is ready,
+ * and that way ensure that no add_device() calls get missed.
+ */
+static int arm_smmu_legacy_bus_init(void)
+{
+	if (using_legacy_binding)
+		arm_smmu_bus_init();
 	return 0;
 }
+device_initcall_sync(arm_smmu_legacy_bus_init);
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
@@ -2219,56 +2245,14 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
-
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", arm_smmu_of_init);
-IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init arm_smmu_acpi_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu, ACPI_SIG_IORT, arm_smmu_acpi_init);
-#endif
+module_platform_driver(arm_smmu_driver);
+
+IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
+IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
+IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", NULL);
+IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", NULL);
+IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", NULL);
+IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
