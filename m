From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/28] arc: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:13 +0200
Message-ID: <20150716172924.523616900@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36420 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbbGPReG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:34:06 -0400
Content-Disposition: inline; filename=peterz-arc-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/atomic.h |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -143,14 +143,29 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
-ATOMIC_OP(and, &=, and)
 
-#define atomic_clear_mask(mask, v) atomic_and(~(mask), (v))
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+#define atomic_andnot atomic_andnot
+
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(andnot, &= ~, bic)
+ATOMIC_OP(or, |=, or)
+ATOMIC_OP(xor, ^=, xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
+
 /**
  * __atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
