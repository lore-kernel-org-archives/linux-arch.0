Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730443AbfHTO6o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:44 -0400
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune dma-direct min mask
Date: Tue, 20 Aug 2019 16:58:18 +0200
Message-ID: <20190820145821.27214-11-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org, nsaenzjulienne@suse.de, eric@anholt.net, mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org, frowand.list@gmail.com, m.szyprowski@samsung.com
Message-ID: <20190820145818.wURex2bpS747G5wTF70nWcm1_Bsp7zkTjyWT2X7JdnU@z>

With the introduction of ZONE_DMA in arm64 devices are not forced to
support 32 bit DMA masks. We have to inform dma-direct of this
limitation whenever it happens.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2:
- Make sure to filter the higher part of arm64_dma_phys_limit
- Rename variable to zone_dma_bits

 arch/arm64/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c51ce79b692b..c5e619f21ad8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/of_fdt.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-direct.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
@@ -437,8 +438,10 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
+	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
 		arm64_dma_phys_limit = max_zone_dma_phys();
+		zone_dma_bits = ilog2((arm64_dma_phys_limit - 1) & GENMASK_ULL(31, 0)) + 1;
+	}
 
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
 		arm64_dma32_phys_limit = max_zone_dma32_phys();
-- 
2.22.0
