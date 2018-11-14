From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/34] powerpc/dart: remove dead cleanup code in iommu_init_early_dart
Date: Wed, 14 Nov 2018 09:22:54 +0100
Message-ID: <20181114082314.8965-15-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

If dart_init failed we didn't have a chance to setup dma or controller
ops yet, so there is no point in resetting them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a5b40d1460f1..283ce04c5844 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -428,7 +428,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Initialize the DART HW */
 	if (dart_init(dn) != 0)
-		goto bail;
+		return;
 
 	/* Setup bypass if supported */
 	if (dart_is_u4)
@@ -439,15 +439,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
-	return;
-
- bail:
-	/* If init failed, use direct iommu and null setup functions */
-	controller_ops->dma_dev_setup = NULL;
-	controller_ops->dma_bus_setup = NULL;
-
-	/* Setup pci_dma ops */
-	set_pci_dma_ops(&dma_nommu_ops);
 }
 
 #ifdef CONFIG_PM
-- 
2.19.1
