From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 1/8] iommu: Add MMIO mapping type
Date: Wed, 10 Feb 2016 01:57:51 +0100
Message-ID: <1455065878-11906-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

On some platforms, MMIO regions might need slightly different treatment
compared to mapping regular memory; add the notion of MMIO mappings to
the IOMMU API's memory type flags, so that callers can let the IOMMU
drivers know to do the right thing.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/io-pgtable-arm.c | 4 +++-
 include/linux/iommu.h          | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 381ca5a..3ff4f87 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -364,7 +364,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 			pte |= ARM_LPAE_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
 			pte |= ARM_LPAE_PTE_HAP_WRITE;
-		if (prot & IOMMU_CACHE)
+		if (prot & IOMMU_MMIO)
+			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
+		else if (prot & IOMMU_CACHE)
 			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
 		else
 			pte |= ARM_LPAE_PTE_MEMATTR_NC;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..34b6432 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -30,6 +30,7 @@
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
+#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.7.1
