From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v5 1/9] iommu: Add MMIO mapping type
Date: Tue,  8 Mar 2016 03:42:46 +0100
Message-ID: <1457404974-1800-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:38705 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbcCHCoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 21:44:14 -0500
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

=46rom: Robin Murphy <robin.murphy@arm.com>

On some platforms, MMIO regions might need slightly different treatment
compared to mapping regular memory; add the notion of MMIO mappings to
the IOMMU API's memory type flags, so that callers can let the IOMMU
drivers know to do the right thing.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 drivers/iommu/io-pgtable-arm.c | 9 +++++++--
 include/linux/iommu.h          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
index 381ca5a..9c19989 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -355,7 +355,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct =
arm_lpae_io_pgtable *data,
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |=3D ARM_LPAE_PTE_AP_RDONLY;
=20
-		if (prot & IOMMU_CACHE)
+		if (prot & IOMMU_MMIO)
+			pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_DEV
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_CACHE)
 			pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
@@ -364,7 +367,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct a=
rm_lpae_io_pgtable *data,
 			pte |=3D ARM_LPAE_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
 			pte |=3D ARM_LPAE_PTE_HAP_WRITE;
-		if (prot & IOMMU_CACHE)
+		if (prot & IOMMU_MMIO)
+			pte |=3D ARM_LPAE_PTE_MEMATTR_DEV;
+		else if (prot & IOMMU_CACHE)
 			pte |=3D ARM_LPAE_PTE_MEMATTR_OIWB;
 		else
 			pte |=3D ARM_LPAE_PTE_MEMATTR_NC;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..34b6432 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -30,6 +30,7 @@
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
+#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
=20
 struct iommu_ops;
 struct iommu_group;
--=20
2.7.2
