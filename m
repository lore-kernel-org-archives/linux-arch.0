From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 14/28] mn10300: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:24 +0200
Message-ID: <20150716172925.387195160@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-mn10300-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mn10300/include/asm/atomic.h |   57 ++++++--------------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

--- a/arch/mn10300/include/asm/atomic.h
+++ b/arch/mn10300/include/asm/atomic.h
@@ -89,6 +89,12 @@ static inline int atomic_##op##_return(i
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
@@ -134,31 +140,9 @@ static inline void atomic_dec(atomic_t *
  *
  * Atomically clears the bits set in mask from the memory word specified.
  */
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-#ifdef CONFIG_SMP
-	int status;
-
-	asm volatile(
-		"1:	mov	%3,(_AAR,%2)	\n"
-		"	mov	(_ADR,%2),%0	\n"
-		"	and	%4,%0		\n"
-		"	mov	%0,(_ADR,%2)	\n"
-		"	mov	(_ADR,%2),%0	\n"	/* flush */
-		"	mov	(_ASR,%2),%0	\n"
-		"	or	%0,%0		\n"
-		"	bne	1b		\n"
-		: "=&r"(status), "=m"(*addr)
-		: "a"(ATOMIC_OPS_BASE_ADDR), "r"(addr), "r"(~mask)
-		: "memory", "cc");
-#else
-	unsigned long flags;
-
-	mask = ~mask;
-	flags = arch_local_cli_save();
-	*addr &= mask;
-	arch_local_irq_restore(flags);
-#endif
+	atomic_and(~mask, v);
 }
 
 /**
@@ -168,30 +152,9 @@ static inline void atomic_clear_mask(uns
  *
  * Atomically sets the bits set in mask from the memory word specified.
  */
-static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-#ifdef CONFIG_SMP
-	int status;
-
-	asm volatile(
-		"1:	mov	%3,(_AAR,%2)	\n"
-		"	mov	(_ADR,%2),%0	\n"
-		"	or	%4,%0		\n"
-		"	mov	%0,(_ADR,%2)	\n"
-		"	mov	(_ADR,%2),%0	\n"	/* flush */
-		"	mov	(_ASR,%2),%0	\n"
-		"	or	%0,%0		\n"
-		"	bne	1b		\n"
-		: "=&r"(status), "=m"(*addr)
-		: "a"(ATOMIC_OPS_BASE_ADDR), "r"(addr), "r"(mask)
-		: "memory", "cc");
-#else
-	unsigned long flags;
-
-	flags = arch_local_cli_save();
-	*addr |= mask;
-	arch_local_irq_restore(flags);
-#endif
+	atomic_or(mask, v);
 }
 
 #endif /* __KERNEL__ */
