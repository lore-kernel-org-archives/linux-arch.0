Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:37055 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338Ab0D0M0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Apr 2010 08:26:15 -0400
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 2/6] ia64: remove unnecessary sync_single_range_* in swiotlb_dma_ops
Date: Tue, 27 Apr 2010 21:25:36 +0900
Message-ID: <1272371140-6085-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Message-ID: <20100427122536.yjS9FwrsR1NjSJO_yRd5QMJ0iK5yqd8btCwnbbdwtAc@z>

sync_single_range_for_cpu and sync_single_range_for_device hooks in
swiotlb_dma_ops are unnecessary because sync_single_for_cpu and
sync_single_for_device are used there.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/kernel/pci-swiotlb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 3095654..d9485d9 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -31,8 +31,6 @@ struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg = swiotlb_unmap_sg_attrs,
 	.sync_single_for_cpu = swiotlb_sync_single_for_cpu,
 	.sync_single_for_device = swiotlb_sync_single_for_device,
-	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
-	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.dma_supported = swiotlb_dma_supported,
-- 
1.6.5

