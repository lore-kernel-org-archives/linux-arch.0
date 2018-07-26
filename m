Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53537 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbeGZMZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jul 2018 08:25:07 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: setup SMP_CACHE_BYTES and cache_line_size
Date: Thu, 26 Jul 2018 14:08:38 +0300
Message-ID: <20180726110839.1915-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Message-ID: <20180726110838.xMmI7V_o2GfUb4GFi9sS65J8bWGFWgrx2M5o50SKIKQ@z>

As for today we don't setup SMP_CACHE_BYTESi and cache_line_size for
ARC, so they are set to L1_CACHE_BYTES by default. L1 line length
(L1_CACHE_BYTES) might be easily smaller than L2 line (which is
usually the case BTW). This breaks code.

For example this breaks ethernet infrastructure on HSDK/AXS103 boards
with IOC disabled:
Functions which alloc and manage sk_buff packet data area rely on
SMP_CACHE_BYTES define. In the result we can share last L2 cache
line in sk_buff linear packet data area between DMA buffer and
some useful data in other structure. So we can lose this data when
we invalidate DMA buffer.

   sk_buff linear packet data area
                |
                |
                |         skb->end        skb->tail
                V            |                |
                             V                V
----------------------------------------------.
      packet data            | <tail padding> |  <useful data in other struct>
----------------------------------------------.

---------------------.--------------------------------------------------.
     SLC line        |             SLC (L2 cache) line (128B)           |
---------------------.--------------------------------------------------.
        ^                                     ^
        |                                     |
     These cache lines will be invalidated when we invalidate skb
     linear packet data area before DMA transaction starting.

This leads to issues painful to debug as it reproduces only if
(sk_buff->end - sk_buff->tail) < SLC_LINE_SIZE and
if we have some useful data right after sk_buff->end.

Fix that by hardcode SMP_CACHE_BYTES to max line length we may have.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig             | 1 +
 arch/arc/include/asm/cache.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9cf59fc60eab..ee1a38c99197 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,6 +9,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SG_CHAIN
diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index 8486f328cc5d..ff7d3232764a 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -48,7 +48,9 @@
 })
 
 /* Largest line length for either L1 or L2 is 128 bytes */
-#define ARCH_DMA_MINALIGN      128
+#define SMP_CACHE_BYTES		128
+#define cache_line_size()	SMP_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
 
 extern void arc_cache_init(void);
 extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
-- 
2.14.4
