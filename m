Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJIUnK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Oct 2018 16:43:10 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/33] powerpc/pci: remove the dma_set_mask pci_controller ops methods
Date: Tue,  9 Oct 2018 15:24:46 +0200
Message-ID: <20181009132500.17643-20-hch@lst.de>
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181009132446.CwrkIIHLuDNQtQRIEKp4VMVzXiM-tkUuf1EyUEicRkY@z>

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 --
 arch/powerpc/kernel/dma.c             | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index aace7033fa02..a50703af7db3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -45,8 +45,6 @@ struct pci_controller_ops {
 	void		(*teardown_msi_irqs)(struct pci_dev *pdev);
 #endif
 
-	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-
 	void		(*shutdown)(struct pci_controller *hose);
 };
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 9ca9d2cec4ed..78ef4076e15c 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -267,13 +267,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 	if (ppc_md.dma_set_mask)
 		return ppc_md.dma_set_mask(dev, dma_mask);
 
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
-		if (phb->controller_ops.dma_set_mask)
-			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
-	}
-
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
-- 
2.19.0
