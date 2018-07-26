From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] ARC: add SMP_CACHE_BYTES value validate
Date: Thu, 26 Jul 2018 14:08:39 +0300
Message-ID: <20180726110839.1915-2-Eugeniy.Paltsev@synopsys.com>
References: <20180726110839.1915-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726110839.1915-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
or equal to any cache line length by comparing it with values
previously read from ARC cache BCR registers.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
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
