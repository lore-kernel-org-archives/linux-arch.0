From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 16/24] sh: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:11 +0200
Message-ID: <20150709175309.479414926@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-sh-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sh/include/asm/atomic-grb.h  |   42 ++------------------------------------
 arch/sh/include/asm/atomic-irq.h  |   21 ++-----------------
 arch/sh/include/asm/atomic-llsc.h |   31 ++--------------------------
 arch/sh/include/asm/atomic.h      |   10 +++++++++
 4 files changed, 19 insertions(+), 85 deletions(-)

--- a/arch/sh/include/asm/atomic-grb.h
+++ b/arch/sh/include/asm/atomic-grb.h
@@ -47,48 +47,12 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	int tmp;
-	unsigned int _mask = ~mask;
-
-	__asm__ __volatile__ (
-		"   .align 2              \n\t"
-		"   mova    1f,   r0      \n\t" /* r0 = end point */
-		"   mov    r15,   r1      \n\t" /* r1 = saved sp */
-		"   mov    #-6,   r15     \n\t" /* LOGIN: r15 = size */
-		"   mov.l  @%1,   %0      \n\t" /* load  old value */
-		"   and     %2,   %0      \n\t" /* add */
-		"   mov.l   %0,   @%1     \n\t" /* store new value */
-		"1: mov     r1,   r15     \n\t" /* LOGOUT */
-		: "=&r" (tmp),
-		  "+r"  (v)
-		: "r"   (_mask)
-		: "memory" , "r0", "r1");
-}
-
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	int tmp;
-
-	__asm__ __volatile__ (
-		"   .align 2              \n\t"
-		"   mova    1f,   r0      \n\t" /* r0 = end point */
-		"   mov    r15,   r1      \n\t" /* r1 = saved sp */
-		"   mov    #-6,   r15     \n\t" /* LOGIN: r15 = size */
-		"   mov.l  @%1,   %0      \n\t" /* load  old value */
-		"   or      %2,   %0      \n\t" /* or */
-		"   mov.l   %0,   @%1     \n\t" /* store new value */
-		"1: mov     r1,   r15     \n\t" /* LOGOUT */
-		: "=&r" (tmp),
-		  "+r"  (v)
-		: "r"   (mask)
-		: "memory" , "r0", "r1");
-}
-
 #endif /* __ASM_SH_ATOMIC_GRB_H */
--- a/arch/sh/include/asm/atomic-irq.h
+++ b/arch/sh/include/asm/atomic-irq.h
@@ -37,27 +37,12 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
+ATOMIC_OP(and, &=)
+ATOMIC_OP(or, |=)
+ATOMIC_OP(xor, ^=)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	v->counter &= ~mask;
-	raw_local_irq_restore(flags);
-}
-
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	v->counter |= mask;
-	raw_local_irq_restore(flags);
-}
-
 #endif /* __ASM_SH_ATOMIC_IRQ_H */
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -52,37 +52,12 @@ static inline int atomic_##op##_return(i
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__ (
-"1:	movli.l @%2, %0		! atomic_clear_mask	\n"
-"	and	%1, %0					\n"
-"	movco.l	%0, @%2					\n"
-"	bf	1b					\n"
-	: "=&z" (tmp)
-	: "r" (~mask), "r" (&v->counter)
-	: "t");
-}
-
-static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__ (
-"1:	movli.l @%2, %0		! atomic_set_mask	\n"
-"	or	%1, %0					\n"
-"	movco.l	%0, @%2					\n"
-"	bf	1b					\n"
-	: "=&z" (tmp)
-	: "r" (mask), "r" (&v->counter)
-	: "t");
-}
-
 #endif /* __ASM_SH_ATOMIC_LLSC_H */
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -25,6 +25,16 @@
 #include <asm/atomic-irq.h>
 #endif
 
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
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
