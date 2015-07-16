Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44446 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbbGPRcj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:32:39 -0400
Message-ID: <20150716172925.306114742@infradead.org>
Date: Thu, 16 Jul 2015 19:21:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/28] mips: Provide atomic_{or,xor,and}
References: <20150716172110.587529075@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-mips-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150716172123.5ZxBME6ve91x3IoRLIjdjq2hmhYeEULWqj6r6tjpcsw@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Acked-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -137,6 +137,12 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(or, |=, or)
+ATOMIC_OP(xor, ^=, xor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -416,6 +422,9 @@ static __inline__ long atomic64_##op##_r
 
 ATOMIC64_OPS(add, +=, daddu)
 ATOMIC64_OPS(sub, -=, dsubu)
+ATOMIC64_OP(and, &=, and)
+ATOMIC64_OP(or, |=, or)
+ATOMIC64_OP(xor, ^=, xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN


