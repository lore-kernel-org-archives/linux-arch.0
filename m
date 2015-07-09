Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60502 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbGIR6U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:58:20 -0400
Message-ID: <20150709175309.375034448@infradead.org>
Date: Thu, 09 Jul 2015 19:29:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 15/24] powerpc: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-powerpc-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172910.yXfNBv08Gwvj_8VZdVgHN7p0ps__OI9DzIsPyulv-bs@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -66,6 +66,9 @@ static __inline__ int atomic_##op##_retu
 
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, subf)
+ATOMIC_OP(and, and)
+ATOMIC_OP(or, or)
+ATOMIC_OP(xor, xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -304,6 +307,9 @@ static __inline__ long atomic64_##op##_r
 
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, subf)
+ATOMIC64_OP(and, and)
+ATOMIC64_OP(or, or)
+ATOMIC64_OP(xor, xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN


