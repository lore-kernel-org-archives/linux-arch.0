Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36397 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbGPReF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:34:05 -0400
Message-ID: <20150716172925.060019466@infradead.org>
Date: Thu, 16 Jul 2015 19:21:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/28] m32r: Provide atomic_{or,xor,and}
References: <20150716172110.587529075@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-m32r-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
Message-ID: <20150716172120.pvBoOx38dUbyCa_lBMyH-EknQA3E0ZlLQ4rbobIpw9s@z>

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m32r/include/asm/atomic.h |   44 +++++++++--------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -94,6 +94,12 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -240,44 +246,14 @@ static __inline__ int __atomic_add_unles
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


