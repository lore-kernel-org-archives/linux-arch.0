Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfALIQg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 12 Jan 2019 03:16:36 -0500
From: guoren@kernel.org
Subject: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Date: Sat, 12 Jan 2019 16:16:27 +0800
Message-ID: <1547280987-7630-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: palmer@sifive.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <mao_han@c-sky.com>
Message-ID: <20190112081627.sa8PLcDtkwGVv3tdZYYkSDImnSF7-go73NU8jMIvjtQ@z>

From: Guo Ren <ren_guo@c-sky.com>

max_low_pfn should be pfn_size not byte_size.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <mao_han@c-sky.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/riscv/kernel/setup.c | 2 +-
 arch/riscv/mm/init.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index fc8006a..5463e67 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -174,7 +174,7 @@ static void __init setup_bootmem(void)
 	BUG_ON(mem_size == 0);
 
 	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn = memblock_end_of_DRAM();
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1d9bfaf..658ebf6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,7 +28,8 @@ static void __init zone_sizes_init(void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
 
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G,
+			(unsigned long) PFN_PHYS(max_low_pfn)));
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
-- 
2.7.4
