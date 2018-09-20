Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34451 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:28 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 1/6] csky/dma: bugfix dma_sync_for_cpu/device
Date: Thu, 20 Sep 2018 13:39:27 +0800
Message-ID: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180920053927.AqAEfXD1WYteinGVOKegvMs0WdoCRiMowci6NKuY_Qw@z>

ref: https://lkml.org/lkml/2018/5/18/1068

        map             for_cpu         for_device      unmap
TO_DEV  writeback       none            writeback       none
TO_CPU  invalidate      invalidate*     invalidate      invalidate*
BIDIR   writeback       invalidate      writeback       invalidate

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/mm/dma-mapping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 16c2087..30a2041 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -217,7 +217,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		BUG();
+		dma_wbinv_range(vaddr + offset, vaddr + offset + size);
+		break;
 	default:
 		BUG();
 	}
@@ -240,7 +241,7 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		BUG();
+		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
 		dma_wbinv_range(vaddr + offset, vaddr + offset + size);
-- 
2.7.4
