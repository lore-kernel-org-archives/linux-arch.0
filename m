From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/34] powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
Date: Wed, 14 Nov 2018 09:22:56 +0100
Message-ID: <20181114082314.8965-17-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This function is completely bogus - the fact that two PCIe devices come
from the same vendor has absolutely nothing to say about the DMA
capabilities and characteristics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++---------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dd807446801e..afbb73cd3c5b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1745,31 +1745,6 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	 */
 }
 
-static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
-{
-	unsigned short vendor = 0;
-	struct pci_dev *pdev;
-
-	if (pe->device_count == 1)
-		return true;
-
-	/* pe->pdev should be set if it's a single device, pe->pbus if not */
-	if (!pe->pbus)
-		return true;
-
-	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
-		if (!vendor) {
-			vendor = pdev->vendor;
-			continue;
-		}
-
-		if (pdev->vendor != vendor)
-			return false;
-	}
-
-	return true;
-}
-
 /*
  * Reconfigure TVE#0 to be usable as 64-bit DMA space.
  *
@@ -1870,7 +1845,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		 */
 		if (dma_mask >> 32 &&
 		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
-		    pnv_pci_ioda_pe_single_vendor(pe) &&
+		    /* pe->pdev should be set if it's a single device, pe->pbus if not */
+		    (pe->device_count == 1 || !pe->pbus) &&
 		    phb->model == PNV_PHB_MODEL_PHB3) {
 			/* Configure the bypass mode */
 			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
-- 
2.19.1
