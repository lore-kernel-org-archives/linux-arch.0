Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbeHARtm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 13:49:42 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/9] ia64: remove the unused iommu_dma_init function
Date: Wed,  1 Aug 2018 18:02:49 +0200
Message-ID: <20180801160252.25629-7-hch@lst.de>
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Message-ID: <20180801160249.a4hvIVehJzpw-KUtvKKdhJ6AqslrVw06PUHArIjdcPw@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/iommu.h | 1 -
 arch/ia64/kernel/pci-dma.c    | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
index 5397e5aa3704..7429a72f3f92 100644
--- a/arch/ia64/include/asm/iommu.h
+++ b/arch/ia64/include/asm/iommu.h
@@ -15,7 +15,6 @@ extern int iommu_detected;
 #define no_iommu		(1)
 #define iommu_detected		(0)
 #endif
-extern void iommu_dma_init(void);
 extern void machvec_init(const char *name);
 
 #endif
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 936af0ec7f8f..afb43677f9ca 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -37,12 +37,6 @@ static int __init pci_iommu_init(void)
 /* Must execute after PCI subsystem */
 fs_initcall(pci_iommu_init);
 
-void __init
-iommu_dma_init(void)
-{
-	return;
-}
-
 void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
-- 
2.18.0
