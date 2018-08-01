Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbeHARtb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 13:49:31 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/9] ia64: remove the unused pci_iommu_shutdown function
Date: Wed,  1 Aug 2018 18:02:48 +0200
Message-ID: <20180801160252.25629-6-hch@lst.de>
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Message-ID: <20180801160248.D7x4XMnwa3jvsRLPD57M3pf28yulgGdVEV1oqnEvMt4@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/iommu.h | 1 -
 arch/ia64/kernel/pci-dma.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
index 156b9d8e1932..5397e5aa3704 100644
--- a/arch/ia64/include/asm/iommu.h
+++ b/arch/ia64/include/asm/iommu.h
@@ -5,7 +5,6 @@
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT (((cycles_t) local_cpu_data->itc_freq)*10)
 
-extern void pci_iommu_shutdown(void);
 extern void no_iommu_init(void);
 #ifdef	CONFIG_INTEL_IOMMU
 extern int force_iommu, no_iommu;
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 924966e5aa25..936af0ec7f8f 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -37,11 +37,6 @@ static int __init pci_iommu_init(void)
 /* Must execute after PCI subsystem */
 fs_initcall(pci_iommu_init);
 
-void pci_iommu_shutdown(void)
-{
-	return;
-}
-
 void __init
 iommu_dma_init(void)
 {
-- 
2.18.0
