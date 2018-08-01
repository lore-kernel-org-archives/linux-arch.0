From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/9] ia64: remove the unused bad_dma_address symbol
Date: Wed,  1 Aug 2018 18:02:47 +0200
Message-ID: <20180801160252.25629-5-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 3c2884bef3d4..924966e5aa25 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -15,9 +15,6 @@
 #include <linux/kernel.h>
 #include <asm/page.h>
 
-dma_addr_t bad_dma_address __read_mostly;
-EXPORT_SYMBOL(bad_dma_address);
-
 int no_iommu __read_mostly;
 #ifdef CONFIG_IOMMU_DEBUG
 int force_iommu __read_mostly = 1;
-- 
2.18.0
