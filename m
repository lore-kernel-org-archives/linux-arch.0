From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 3/6] x86: remove unnecessary sync_single_range_* in swiotlb_dma_ops
Date: Tue, 27 Apr 2010 21:25:37 +0900
Message-ID: <1272371140-6085-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

sync_single_range_for_cpu and sync_single_range_for_device hooks in
swiotlb_dma_ops are unnecessary because sync_single_for_cpu and
sync_single_for_device are used there.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: x86@kernel.org
---
 arch/x86/kernel/pci-swiotlb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 7d2829d..a5bc528 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -31,8 +31,6 @@ static struct dma_map_ops swiotlb_dma_ops = {
 	.free_coherent = swiotlb_free_coherent,
 	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
 	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
-	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.map_sg = swiotlb_map_sg_attrs,
-- 
1.6.5
