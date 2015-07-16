Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35412 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbbGPRdO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:33:14 -0400
Message-ID: <20150716172924.724993968@infradead.org>
Date: Thu, 16 Jul 2015 19:21:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/28] avr32: Provide atomic_{or,xor,and}
References: <20150716172110.587529075@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-avr32-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150716172116.Yrr5EZCINobOggqpjt8Y2lHMVIkCcQ0ITlik7UITuL8@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/avr32/include/asm/atomic.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -44,6 +44,20 @@ static inline int __atomic_##op##_return
 ATOMIC_OP_RETURN(sub, sub, rKs21)
 ATOMIC_OP_RETURN(add, add, r)
 
+#define ATOMIC_OP(op, asm_op)						\
+ATOMIC_OP_RETURN(op, asm_op, r)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	(void)__atomic_##op##_return(i, v);				\
+}
+
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and, and)
+ATOMIC_OP(or, or)
+ATOMIC_OP(xor, eor)
+
+#undef ATOMIC_OP
 #undef ATOMIC_OP_RETURN
 
 /*


