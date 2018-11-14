From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/34] cxl: drop the dma_set_mask callback from vphb
Date: Wed, 14 Nov 2018 09:22:59 +0100
Message-ID: <20181114082314.8965-20-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The CXL code never even looks at the dma mask, so there is no good
reason for this sanity check.  Remove it because it gets in the way
of the dma ops refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/misc/cxl/vphb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 7908633d9204..49da2f744bbf 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -11,17 +11,6 @@
 #include <misc/cxl.h>
 #include "cxl.h"
 
-static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
-{
-	if (dma_mask < DMA_BIT_MASK(64)) {
-		pr_info("%s only 64bit DMA supported on CXL", __func__);
-		return -EIO;
-	}
-
-	*(pdev->dev.dma_mask) = dma_mask;
-	return 0;
-}
-
 static int cxl_pci_probe_mode(struct pci_bus *bus)
 {
 	return PCI_PROBE_NORMAL;
@@ -220,7 +209,6 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
 	.setup_msi_irqs = cxl_setup_msi_irqs,
 	.teardown_msi_irqs = cxl_teardown_msi_irqs,
-	.dma_set_mask = cxl_dma_set_mask,
 };
 
 int cxl_pci_vphb_add(struct cxl_afu *afu)
-- 
2.19.1
