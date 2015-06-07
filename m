From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 04/19] ARC: untangle cache flush loop
Date: Sun, 7 Jun 2015 14:08:08 +0530
Message-ID: <1433666303-26112-5-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56891 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbbFGIjV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:21 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

- Remove the ifdef'ery and write distinct versions for each mmu ver even
  if there is some code duplication

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/cache.c | 80 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 7ff54d024b11..2db777a5d926 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -140,25 +140,19 @@ dc_chk:
  * "tag" bits are provided in PTAG, index bits in existing IVIL/IVDL/FLDL regs
  */
 
-static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
-				     unsigned long sz, const int op)
+static inline
+void __cache_line_loop_v2(unsigned long paddr, unsigned long vaddr,
+			  unsigned long sz, const int op)
 {
-	unsigned int aux_cmd, aux_tag;
+	unsigned int aux_cmd;
 	int num_lines;
-	const int full_page_op = __builtin_constant_p(sz) && sz == PAGE_SIZE;
+	const int full_page = __builtin_constant_p(sz) && sz == PAGE_SIZE;
 
 	if (op == OP_INV_IC) {
 		aux_cmd = ARC_REG_IC_IVIL;
-#if (CONFIG_ARC_MMU_VER > 2)
-		aux_tag = ARC_REG_IC_PTAG;
-#endif
-	}
-	else {
+	} else {
 		/* d$ cmd: INV (discard or wback-n-discard) OR FLUSH (wback) */
 		aux_cmd = op & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
-#if (CONFIG_ARC_MMU_VER > 2)
-		aux_tag = ARC_REG_DC_PTAG;
-#endif
 	}
 
 	/* Ensure we properly floor/ceil the non-line aligned/sized requests
@@ -167,7 +161,7 @@ static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
 	 *  -@paddr will be cache-line aligned already (being page aligned)
 	 *  -@sz will be integral multiple of line size (being page sized).
 	 */
-	if (!full_page_op) {
+	if (!full_page) {
 		sz += paddr & ~CACHE_LINE_MASK;
 		paddr &= CACHE_LINE_MASK;
 		vaddr &= CACHE_LINE_MASK;
@@ -175,32 +169,68 @@ static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
 
 	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
 
-#if (CONFIG_ARC_MMU_VER <= 2)
 	/* MMUv2 and before: paddr contains stuffed vaddrs bits */
 	paddr |= (vaddr >> PAGE_SHIFT) & 0x1F;
-#else
-	/* if V-P const for loop, PTAG can be written once outside loop */
-	if (full_page_op)
+
+	while (num_lines-- > 0) {
+		write_aux_reg(aux_cmd, paddr);
+		paddr += L1_CACHE_BYTES;
+	}
+}
+
+static inline
+void __cache_line_loop_v3(unsigned long paddr, unsigned long vaddr,
+			  unsigned long sz, const int op)
+{
+	unsigned int aux_cmd, aux_tag;
+	int num_lines;
+	const int full_page = __builtin_constant_p(sz) && sz == PAGE_SIZE;
+
+	if (op == OP_INV_IC) {
+		aux_cmd = ARC_REG_IC_IVIL;
+		aux_tag = ARC_REG_IC_PTAG;
+	} else {
+		aux_cmd = op & OP_INV ? ARC_REG_DC_IVDL : ARC_REG_DC_FLDL;
+		aux_tag = ARC_REG_DC_PTAG;
+	}
+
+	/* Ensure we properly floor/ceil the non-line aligned/sized requests
+	 * and have @paddr - aligned to cache line and integral @num_lines.
+	 * This however can be avoided for page sized since:
+	 *  -@paddr will be cache-line aligned already (being page aligned)
+	 *  -@sz will be integral multiple of line size (being page sized).
+	 */
+	if (!full_page) {
+		sz += paddr & ~CACHE_LINE_MASK;
+		paddr &= CACHE_LINE_MASK;
+		vaddr &= CACHE_LINE_MASK;
+	}
+	num_lines = DIV_ROUND_UP(sz, L1_CACHE_BYTES);
+
+	/*
+	 * MMUv3, cache ops require paddr seperately
+	 * if V-P const for loop, PTAG can be written once outside loop
+	 */
+	if (full_page)
 		write_aux_reg(aux_tag, paddr);
-#endif
 
 	while (num_lines-- > 0) {
-#if (CONFIG_ARC_MMU_VER > 2)
-		/* MMUv3, cache ops require paddr seperately */
-		if (!full_page_op) {
+		if (!full_page) {
 			write_aux_reg(aux_tag, paddr);
 			paddr += L1_CACHE_BYTES;
 		}
 
 		write_aux_reg(aux_cmd, vaddr);
 		vaddr += L1_CACHE_BYTES;
-#else
-		write_aux_reg(aux_cmd, paddr);
-		paddr += L1_CACHE_BYTES;
-#endif
 	}
 }
 
+#if (CONFIG_ARC_MMU_VER < 3)
+#define __cache_line_loop	__cache_line_loop_v2
+#elif (CONFIG_ARC_MMU_VER == 3)
+#define __cache_line_loop	__cache_line_loop_v3
+#endif
+
 #ifdef CONFIG_ARC_HAS_DCACHE
 
 /***************************************************************
-- 
1.9.1
