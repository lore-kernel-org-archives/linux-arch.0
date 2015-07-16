From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 04/28] arm: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:14 +0200
Message-ID: <20150716172924.591719789@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44280 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbbGPRch (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:32:37 -0400
Content-Disposition: inline; filename=peterz-arm-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/atomic.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -194,6 +194,14 @@ static inline int __atomic_add_unless(at
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+#define atomic_andnot atomic_andnot
+
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(andnot, &= ~, bic)
+ATOMIC_OP(or,  |=, orr)
+ATOMIC_OP(xor, ^=, eor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -321,6 +329,13 @@ static inline long long atomic64_##op##_
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
 
+#define atomic64_andnot atomic64_andnot
+
+ATOMIC64_OP(and, and, and)
+ATOMIC64_OP(andnot, bic, bic)
+ATOMIC64_OP(or,  orr, orr)
+ATOMIC64_OP(xor, eor, eor)
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
