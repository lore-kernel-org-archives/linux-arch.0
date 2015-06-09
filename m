From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 08/28] ARCv2: MMUv4: support aliasing icache config
Date: Tue, 9 Jun 2015 17:18:08 +0530
Message-ID: <1433850508-26317-9-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33093 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753326AbbFILuQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:16 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

This is also default for AXS103 release

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/cache.h |  4 +---
 arch/arc/mm/cache.c          | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index e54977a7d006..d21c76d6b054 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -60,7 +60,7 @@ extern void read_decode_cache_bcr(void);
 #define ARC_REG_IC_IVIC		0x10
 #define ARC_REG_IC_CTRL		0x11
 #define ARC_REG_IC_IVIL		0x19
-#if defined(CONFIG_ARC_MMU_V3)
+#if defined(CONFIG_ARC_MMU_V3) || defined(CONFIG_ARC_MMU_V4)
 #define ARC_REG_IC_PTAG		0x1E
 #endif
 
@@ -74,9 +74,7 @@ extern void read_decode_cache_bcr(void);
 #define ARC_REG_DC_IVDL		0x4A
 #define ARC_REG_DC_FLSH		0x4B
 #define ARC_REG_DC_FLDL		0x4C
-#if defined(CONFIG_ARC_MMU_V3)
 #define ARC_REG_DC_PTAG		0x5C
-#endif
 
 /* Bit val in DC_CTRL */
 #define DC_CTRL_INV_MODE_FLUSH  0x40
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 7a898f57d84b..0eaaee60fd0b 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -21,6 +21,9 @@
 #include <asm/cachectl.h>
 #include <asm/setup.h>
 
+void (*_cache_line_loop_ic_fn)(unsigned long paddr, unsigned long vaddr,
+			       unsigned long sz, const int cacheop);
+
 char *arc_cache_mumbojumbo(int c, char *buf, int len)
 {
 	int n = 0;
@@ -414,7 +417,7 @@ __ic_line_inv_vaddr_local(unsigned long paddr, unsigned long vaddr,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__cache_line_loop(paddr, vaddr, sz, OP_INV_IC);
+	(*_cache_line_loop_ic_fn)(paddr, vaddr, sz, OP_INV_IC);
 	local_irq_restore(flags);
 }
 
@@ -746,6 +749,15 @@ void arc_cache_init(void)
 		if (ic->ver != CONFIG_ARC_MMU_VER)
 			panic("Cache ver [%d] doesn't match MMU ver [%d]\n",
 			      ic->ver, CONFIG_ARC_MMU_VER);
+
+		/*
+		 * In MMU v4 (HS38x) the alising icache config uses IVIL/PTAG
+		 * pair to provide vaddr/paddr respectively, just as in MMU v3
+		 */
+		if (is_isa_arcv2() && ic->alias)
+			_cache_line_loop_ic_fn = __cache_line_loop_v3;
+		else
+			_cache_line_loop_ic_fn = __cache_line_loop;
 	}
 
 	if (IS_ENABLED(CONFIG_ARC_HAS_DCACHE)) {
-- 
1.9.1
