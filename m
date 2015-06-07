From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 03/19] ARC: cacheflush: No need to retain DC_CTRL from __before_dc_op()
Date: Sun, 7 Jun 2015 14:08:07 +0530
Message-ID: <1433666303-26112-4-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37825 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752313AbbFGIjS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:18 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

That is because __after_dc_op() already reads it for status check, so it
is better anyways to use that "newer" value.

Also reduces the clutter in callers for passing from/to these routines.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/cache.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 1d34a6978a83..7ff54d024b11 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -207,32 +207,32 @@ static inline void __cache_line_loop(unsigned long paddr, unsigned long vaddr,
  * Machine specific helpers for Entire D-Cache or Per Line ops
  */
 
-static inline unsigned int __before_dc_op(const int op)
+static inline void __before_dc_op(const int op)
 {
-	unsigned int reg = reg;
-
 	if (op == OP_FLUSH_N_INV) {
 		/* Dcache provides 2 cmd: FLUSH or INV
 		 * INV inturn has sub-modes: DISCARD or FLUSH-BEFORE
 		 * flush-n-inv is achieved by INV cmd but with IM=1
 		 * So toggle INV sub-mode depending on op request and default
 		 */
-		reg = read_aux_reg(ARC_REG_DC_CTRL);
-		write_aux_reg(ARC_REG_DC_CTRL, reg | DC_CTRL_INV_MODE_FLUSH)
+		write_aux_reg(ARC_REG_DC_CTRL,
+			      read_aux_reg(ARC_REG_DC_CTRL) | DC_CTRL_INV_MODE_FLUSH)
 			;
 	}
-
-	return reg;
 }
 
-static inline void __after_dc_op(const int op, unsigned int reg)
+static inline void __after_dc_op(const int op)
 {
-	if (op & OP_FLUSH)	/* flush / flush-n-inv both wait */
-		while (read_aux_reg(ARC_REG_DC_CTRL) & DC_CTRL_FLUSH_STATUS);
+	if (op & OP_FLUSH) {
+		unsigned int reg;
 
-	/* Switch back to default Invalidate mode */
-	if (op == OP_FLUSH_N_INV)
-		write_aux_reg(ARC_REG_DC_CTRL, reg & ~DC_CTRL_INV_MODE_FLUSH);
+		/* flush / flush-n-inv both wait */
+		while ((reg = read_aux_reg(ARC_REG_DC_CTRL)) & DC_CTRL_FLUSH_STATUS);
+
+		/* Switch back to default Invalidate mode */
+		if (op == OP_FLUSH_N_INV)
+			write_aux_reg(ARC_REG_DC_CTRL, reg & ~DC_CTRL_INV_MODE_FLUSH);
+	}
 }
 
 /*
@@ -243,10 +243,9 @@ static inline void __after_dc_op(const int op, unsigned int reg)
  */
 static inline void __dc_entire_op(const int op)
 {
-	unsigned int ctrl_reg;
 	int aux;
 
-	ctrl_reg = __before_dc_op(op);
+	__before_dc_op(op);
 
 	if (op & OP_INV)	/* Inv or flush-n-inv use same cmd reg */
 		aux = ARC_REG_DC_IVDC;
@@ -255,7 +254,7 @@ static inline void __dc_entire_op(const int op)
 
 	write_aux_reg(aux, 0x1);
 
-	__after_dc_op(op, ctrl_reg);
+	__after_dc_op(op);
 }
 
 /* For kernel mappings cache operation: index is same as paddr */
@@ -268,15 +267,14 @@ static inline void __dc_line_op(unsigned long paddr, unsigned long vaddr,
 				unsigned long sz, const int op)
 {
 	unsigned long flags;
-	unsigned int ctrl_reg;
 
 	local_irq_save(flags);
 
-	ctrl_reg = __before_dc_op(op);
+	__before_dc_op(op);
 
 	__cache_line_loop(paddr, vaddr, sz, op);
 
-	__after_dc_op(op, ctrl_reg);
+	__after_dc_op(op);
 
 	local_irq_restore(flags);
 }
-- 
1.9.1
