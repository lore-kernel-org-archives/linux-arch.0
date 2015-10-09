From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 13/20] intel-iommu: switch from ioremap_cache to memremap
Date: Fri, 09 Oct 2015 18:16:46 -0400
Message-ID: <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

In preparation for deprecating ioremap_cache() convert its usage in
intel-iommu to memremap.  This also eliminates the mishandling of the
__iomem annotation in the implementation.

Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/iommu/intel-iommu.c         |   20 +++++++++++---------
 drivers/iommu/intel_irq_remapping.c |    8 ++++----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 041bc1810a86..a089177db372 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -34,6 +34,7 @@
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/timer.h>
+#include <linux/io.h>
 #include <linux/iova.h>
 #include <linux/iommu.h>
 #include <linux/intel-iommu.h>
@@ -2807,18 +2808,18 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 }
 
 static int copy_context_table(struct intel_iommu *iommu,
-			      struct root_entry __iomem *old_re,
+			      struct root_entry *old_re,
 			      struct context_entry **tbl,
 			      int bus, bool ext)
 {
 	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
-	struct context_entry __iomem *old_ce = NULL;
 	struct context_entry *new_ce = NULL, ce;
+	struct context_entry *old_ce = NULL;
 	struct root_entry re;
 	phys_addr_t old_ce_phys;
 
 	tbl_idx = ext ? bus * 2 : bus;
-	memcpy_fromio(&re, old_re, sizeof(re));
+	memcpy(&re, old_re, sizeof(re));
 
 	for (devfn = 0; devfn < 256; devfn++) {
 		/* First calculate the correct index */
@@ -2853,7 +2854,8 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			ret = -ENOMEM;
-			old_ce = ioremap_cache(old_ce_phys, PAGE_SIZE);
+			old_ce = memremap(old_ce_phys, PAGE_SIZE,
+					MEMREMAP_WB);
 			if (!old_ce)
 				goto out;
 
@@ -2865,7 +2867,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 		}
 
 		/* Now copy the context entry */
-		memcpy_fromio(&ce, old_ce + idx, sizeof(ce));
+		memcpy(&ce, old_ce + idx, sizeof(ce));
 
 		if (!__context_present(&ce))
 			continue;
@@ -2901,7 +2903,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
 
 out_unmap:
-	iounmap(old_ce);
+	memunmap(old_ce);
 
 out:
 	return ret;
@@ -2909,8 +2911,8 @@ out:
 
 static int copy_translation_tables(struct intel_iommu *iommu)
 {
-	struct root_entry __iomem *old_rt;
 	struct context_entry **ctxt_tbls;
+	struct root_entry *old_rt;
 	phys_addr_t old_rt_phys;
 	int ctxt_table_entries;
 	unsigned long flags;
@@ -2935,7 +2937,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	if (!old_rt_phys)
 		return -EINVAL;
 
-	old_rt = ioremap_cache(old_rt_phys, PAGE_SIZE);
+	old_rt = memremap(old_rt_phys, PAGE_SIZE, MEMREMAP_WB);
 	if (!old_rt)
 		return -ENOMEM;
 
@@ -2984,7 +2986,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	ret = 0;
 
 out_unmap:
-	iounmap(old_rt);
+	memunmap(old_rt);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 9ec4e0d94ffd..bdc52cc6ed23 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -384,7 +384,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 
 static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
-	struct irte __iomem *old_ir_table;
+	struct irte *old_ir_table;
 	phys_addr_t irt_phys;
 	unsigned int i;
 	size_t size;
@@ -408,12 +408,12 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	size     = INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte);
 
 	/* Map the old IR table */
-	old_ir_table = ioremap_cache(irt_phys, size);
+	old_ir_table = memremap(irt_phys, size, MEMREMAP_WB);
 	if (!old_ir_table)
 		return -ENOMEM;
 
 	/* Copy data over */
-	memcpy_fromio(iommu->ir_table->base, old_ir_table, size);
+	memcpy(iommu->ir_table->base, old_ir_table, size);
 
 	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
@@ -426,7 +426,7 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 			bitmap_set(iommu->ir_table->bitmap, i, 1);
 	}
 
-	iounmap(old_ir_table);
+	memunmap(old_ir_table);
 
 	return 0;
 }
