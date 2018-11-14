From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 17/34] powerpc/powernv: remove pnv_npu_dma_set_mask
Date: Wed, 14 Nov 2018 09:22:57 +0100
Message-ID: <20181114082314.8965-18-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

These devices are not PCIe devices and do not have associated dma map
ops, so this is just dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index afbb73cd3c5b..1d9f446f3eff 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3688,14 +3688,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
-{
-	dev_err_once(&npdev->dev,
-			"%s operation unsupported for NVLink devices\n",
-			__func__);
-	return -EPERM;
-}
-
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
@@ -3705,7 +3697,6 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
-	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-- 
2.19.1
