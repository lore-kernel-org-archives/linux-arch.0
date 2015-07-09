Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60143 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbbGIR50 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:57:26 -0400
Message-ID: <20150709175308.296642297@infradead.org>
Date: Thu, 09 Jul 2015 19:28:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 03/24] arm: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-arm-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172858.NP6IRGVGJO73zhXeUmRq1Ynlm1jvh8SAqivHda4El_U@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -193,6 +193,9 @@ static inline int __atomic_add_unless(at
 
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(or, |=, orr)
+ATOMIC_OP(xor, ^=, eor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -320,6 +323,9 @@ static inline long long atomic64_##op##_
 
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
+ATOMIC64_OP(and, and, and)
+ATOMIC64_OP(or, or, or)
+ATOMIC64_OP(xor, eor, eor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN


