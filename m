Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58490 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbeGZOcl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2018 10:32:41 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 2/2] ARC: add SMP_CACHE_BYTES value validate
Date: Thu, 26 Jul 2018 16:15:44 +0300
Message-ID: <20180726131544.3780-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
References: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Message-ID: <20180726131544.7KyiK5wLII3mP0BjqRnGa36EmXhXWre1gPnAxTmhjLg@z>

Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
or equal to any cache line length by comparing it with values
previously read from ARC cache BCR registers.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * None.

 arch/arc/mm/cache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 9dbe645ee127..b95365e1253a 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1246,6 +1246,16 @@ void __init arc_cache_init_master(void)
 		}
 	}
 
+	/*
+	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
+	 * or equal to any cache line length.
+	 */
+	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,
+			 "SMP_CACHE_BYTES must be >= any cache line length");
+	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))
+		panic("L2 Cache line [%d] > kernel Config [%d]\n",
+		      l2_line_sz, SMP_CACHE_BYTES);
+
 	/* Note that SLC disable not formally supported till HS 3.0 */
 	if (is_isa_arcv2() && l2_line_sz && !slc_enable)
 		arc_slc_disable();
-- 
2.14.4
