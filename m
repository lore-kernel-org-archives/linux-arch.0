From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V11 11/11] ACPI/IORT: Remove linker section for IORT entries
	probing
Date: Mon, 10 Apr 2017 16:51:06 +0530
Message-ID: <1491823266-1209-12-git-send-email-sricharan@codeaurora.org>
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

From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

The IORT linker section introduced by commit 34ceea275f62
("ACPI/IORT: Introduce linker section for IORT entries probing")
was needed to make sure SMMU drivers are registered (and therefore
probed) in the kernel before devices using the SMMU have a chance
to probe in turn.

Through the introduction of deferred IOMMU configuration the linker
section based IORT probing infrastructure is not needed any longer, in
that device/SMMU probe dependencies are managed through the probe
deferral mechanism, making the IORT linker section infrastructure
unused, so that it can be removed.

Remove the unused IORT linker section probing infrastructure
from the kernel to complete the ACPI IORT IOMMU configure probe
deferral mechanism implementation.

Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/acpi/arm64/iort.c         | 2 --
 include/asm-generic/vmlinux.lds.h | 1 -
 include/linux/acpi_iort.h         | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e323ece..e7b1940 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1000,6 +1000,4 @@ void __init acpi_iort_init(void)
 	}
 
 	iort_init_platform_devices();
-
-	acpi_probe_device_table(iort);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0968d13..9faa26c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -566,7 +566,6 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
-	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 77e0809..f167e1d04 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -52,7 +52,4 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
 #endif
 
-#define IORT_ACPI_DECLARE(name, table_id, fn)		\
-	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
-
 #endif /* __ACPI_IORT_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
