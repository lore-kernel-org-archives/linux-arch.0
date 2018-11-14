From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/34] powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
Date: Wed, 14 Nov 2018 09:23:07 +0100
Message-ID: <20181114082314.8965-28-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

swiotlb will only bounce buffer the effectice dma address for the device
is smaller than the actual DMA range.  Instead of flipping between the
swiotlb and nommu ops for FSL SOCs that have the second outbound window
just don't set the bus dma_mask in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/fsl_pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f136567a5ed5..296ffabc9386 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -143,7 +143,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 * mapping that allows addressing any RAM address from across PCI.
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
-		set_dma_ops(dev, &dma_nommu_ops);
+		dev->bus_dma_mask = 0;
 		set_dma_offset(dev, pci64_dma_offset);
 	}
 
@@ -403,10 +403,6 @@ static void setup_pci_atmu(struct pci_controller *hose)
 				out_be32(&pci->piw[win_idx].piwar,  piwar);
 			}
 
-			/*
-			 * install our own dma_set_mask handler to fixup dma_ops
-			 * and dma_offset
-			 */
 			ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
 
 			pr_info("%pOF: Setup 64-bit PCI DMA window\n", hose->dn);
-- 
2.19.1
