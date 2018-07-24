Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42396 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jul 2018 07:16:27 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4/4] ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
Date: Tue, 24 Jul 2018 13:10:01 +0300
Message-ID: <20180724101001.31965-5-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Message-ID: <20180724101001.mzR4CJ1FVGiyq4Fk5U0XbOPbcst05mOD8RQqtkT-JhE@z>

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/cache.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 34935ce38631..e0b3484641c3 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1143,6 +1143,19 @@ noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
+	/*
+	 * As for today we don't support both IOC and ZONE_HIGHMEM enabled
+	 * simultaneously. This happens because as of today IOC aperture covers
+	 * only ZONE_NORMAL (low mem) and any dma transactions outside this
+	 * region won't be HW coherent.
+	 * If we want to use both IOC and ZONE_HIGHMEM we can use
+	 * bounce_buffer to handle dma transactions to HIGHMEM.
+	 * Also it is possible to modify dma_direct cache ops or increase IOC
+	 * aperture size if we are planning to use HIGHMEM without PAE.
+	 */
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		panic("IOC and HIGHMEM can't be used simultaneously");
+
 	/* Flush + invalidate + disable L1 dcache */
 	__dc_disable();
 
-- 
2.14.4
