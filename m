From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 09/24] m32r: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:04 +0200
Message-ID: <20150709175308.832468809@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59664 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbbGIR4b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:31 -0400
Content-Disposition: inline; filename=peterz-m32r-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m32r/include/asm/atomic.h |   41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -93,6 +93,9 @@ static __inline__ int atomic_##op##_retu
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -240,44 +243,14 @@ static __inline__ int __atomic_add_unles
 }
 
 
-static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned long flags;
-	unsigned long tmp;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_clear_mask		\n\t"
-		DCACHE_CLEAR("%0", "r5", "%1")
-		M32R_LOCK" %0, @%1;		\n\t"
-		"and	%0, %2;			\n\t"
-		M32R_UNLOCK" %0, @%1;		\n\t"
-		: "=&r" (tmp)
-		: "r" (addr), "r" (~mask)
-		: "memory"
-		__ATOMIC_CLOBBER
-	);
-	local_irq_restore(flags);
+	atomic_and(~mask, v);
 }
 
-static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned long flags;
-	unsigned long tmp;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_set_mask		\n\t"
-		DCACHE_CLEAR("%0", "r5", "%1")
-		M32R_LOCK" %0, @%1;		\n\t"
-		"or	%0, %2;			\n\t"
-		M32R_UNLOCK" %0, @%1;		\n\t"
-		: "=&r" (tmp)
-		: "r" (addr), "r" (mask)
-		: "memory"
-		__ATOMIC_CLOBBER
-	);
-	local_irq_restore(flags);
+	atomic_or(mask, v);
 }
 
 #endif	/* _ASM_M32R_ATOMIC_H */
