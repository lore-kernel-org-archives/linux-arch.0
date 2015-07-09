Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59717 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbGIR4h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:37 -0400
Message-ID: <20150709175308.217482496@infradead.org>
Date: Thu, 09 Jul 2015 19:28:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 02/24] arc: Provide atomic_{or,xor,and}
References: <20150709172855.564686637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-arc-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150709172857.LRDkLe_yXc4Pepr_sI1pV7bU9its_MZEIRThV8v9f_g@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/atomic.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -125,13 +125,23 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 ATOMIC_OP(and, &=, and)
-
-#define atomic_clear_mask(mask, v) atomic_and(~(mask), (v))
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


