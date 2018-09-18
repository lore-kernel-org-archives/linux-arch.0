From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
Date: Tue, 18 Sep 2018 21:48:13 +0800
Message-ID: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
