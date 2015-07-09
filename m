Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35566 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbbGIR4K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:10 -0400
Message-ID: <20150709175308.450714909@infradead.org>
Date: Thu, 09 Jul 2015 19:29:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 05/24] avr32: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-avr32-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172900.bn6jVhrz7pkOlKXOMTgess4FgjPvxIMXE5qttnuSvuc@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/avr32/include/asm/atomic.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -44,6 +44,18 @@ static inline int __atomic_##op##_return
 ATOMIC_OP_RETURN(sub, sub, rKs21)
 ATOMIC_OP_RETURN(add, add, r)
 
+#define ATOMIC_OP(op, asm_op)						\
+ATOMIC_OP_RETURN(op, asm_op, r)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	(void)__atomic_##op##_return(i, v);				\
+}
+
+ATOMIC_OP(and, and)
+ATOMIC_OP(or, or)
+ATOMIC_OP(xor, eor)
+
+#undef ATOMIC_OP
 #undef ATOMIC_OP_RETURN
 
 /*


