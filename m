Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59760 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbbGIR4l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:41 -0400
Message-ID: <20150709175309.098420045@infradead.org>
Date: Thu, 09 Jul 2015 19:29:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 12/24] mips: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-mips-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172907.siKJpzmEuGqGmV19nNzALn9mLdEP9Iu8sBlTg9sZMrE@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -136,6 +136,9 @@ static __inline__ int atomic_##op##_retu
 
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
+ATOMIC_OP(and, &=, and)
+ATOMIC_OP(or, |=, or)
+ATOMIC_OP(xor, ^=, xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -416,6 +419,9 @@ static __inline__ long atomic64_##op##_r
 
 ATOMIC64_OPS(add, +=, daddu)
 ATOMIC64_OPS(sub, -=, dsubu)
+ATOMIC64_OP(and, &=, and)
+ATOMIC64_OP(or, |=, or)
+ATOMIC64_OP(xor, ^=, xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN


