Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeJIUnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Oct 2018 16:43:07 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/33] powerpc/dart: remove dead cleanup code in iommu_init_early_dart
Date: Tue,  9 Oct 2018 15:24:40 +0200
Message-ID: <20181009132500.17643-14-hch@lst.de>
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181009132440.28xrbzyZO35jYc6rPCipWFxwsqn8yp4W4OtzpmGRREg@z>

If dart_init failed we didn't have a chance to setup dma or controller
ops yet, so there is no point in resetting them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 5ca3e22d0512..ce5dd2048f57 100644
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
2.19.0
