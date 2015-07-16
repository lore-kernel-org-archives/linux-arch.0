From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 25/28] atomic: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:35 +0200
Message-ID: <20150716172926.381891214@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36411 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbbGPReG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 13:34:06 -0400
Content-Disposition: inline; filename=peterz-generic-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/atomic.h        |    1 -
 arch/arc/include/asm/atomic.h          |    1 -
 arch/arm/include/asm/atomic.h          |    1 -
 arch/arm64/include/asm/atomic.h        |    1 -
 arch/avr32/include/asm/atomic.h        |    2 --
 arch/blackfin/include/asm/atomic.h     |    2 --
 arch/frv/include/asm/atomic.h          |    2 --
 arch/h8300/include/asm/atomic.h        |    2 --
 arch/hexagon/include/asm/atomic.h      |    2 --
 arch/ia64/include/asm/atomic.h         |    2 --
 arch/m32r/include/asm/atomic.h         |    2 --
 arch/m68k/include/asm/atomic.h         |    2 --
 arch/metag/include/asm/atomic_lnkget.h |    2 --
 arch/mips/include/asm/atomic.h         |    2 --
 arch/mn10300/include/asm/atomic.h      |    2 --
 arch/parisc/include/asm/atomic.h       |    2 --
 arch/powerpc/include/asm/atomic.h      |    2 --
 arch/s390/include/asm/atomic.h         |    2 --
 arch/sh/include/asm/atomic-grb.h       |    2 --
 arch/sparc/include/asm/atomic_32.h     |    2 --
 arch/sparc/include/asm/atomic_64.h     |    2 --
 arch/tile/include/asm/atomic_32.h      |    2 --
 arch/tile/include/asm/atomic_64.h      |    2 --
 arch/x86/include/asm/atomic.h          |    2 --
 arch/xtensa/include/asm/atomic.h       |    2 --
 include/asm-generic/atomic.h           |   21 ++++++++++++---------
 include/asm-generic/atomic64.h         |    4 ++++
 include/linux/atomic.h                 |   13 -------------
 lib/atomic64.c                         |    3 +++
 29 files changed, 19 insertions(+), 68 deletions(-)

--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -110,7 +110,6 @@ static __inline__ long atomic64_##op##_r
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
 #define atomic_andnot atomic_andnot
 #define atomic64_andnot atomic64_andnot
 
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -144,7 +144,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
 #define atomic_andnot atomic_andnot
 
 ATOMIC_OP(and, &=, and)
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -194,7 +194,6 @@ static inline int __atomic_add_unless(at
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
 #define atomic_andnot atomic_andnot
 
 ATOMIC_OP(and, &=, and)
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -85,7 +85,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
 #define atomic_andnot atomic_andnot
 
 ATOMIC_OP(and, and)
--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -51,8 +51,6 @@ static inline void atomic_##op(int i, at
 	(void)__atomic_##op##_return(i, v);				\
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, and)
 ATOMIC_OP(or, or)
 ATOMIC_OP(xor, eor)
--- a/arch/blackfin/include/asm/atomic.h
+++ b/arch/blackfin/include/asm/atomic.h
@@ -28,8 +28,6 @@ asmlinkage int __raw_atomic_test_asm(con
 #define atomic_add_return(i, v) __raw_atomic_add_asm(&(v)->counter, i)
 #define atomic_sub_return(i, v) __raw_atomic_add_asm(&(v)->counter, -(i))
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 #define atomic_or(i, v)  (void)__raw_atomic_or_asm(&(v)->counter, i)
 #define atomic_and(i, v) (void)__raw_atomic_and_asm(&(v)->counter, i)
 #define atomic_xor(i, v) (void)__raw_atomic_xor_asm(&(v)->counter, i)
--- a/arch/frv/include/asm/atomic.h
+++ b/arch/frv/include/asm/atomic.h
@@ -192,8 +192,6 @@ static inline void atomic64_##op(long lo
 	(void)__atomic64_fetch_##op(i, &v->counter);			\
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(or)
 ATOMIC_OP(and)
 ATOMIC_OP(xor)
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -41,8 +41,6 @@ static inline void atomic_##op(int i, at
 ATOMIC_OP_RETURN(add, +=)
 ATOMIC_OP_RETURN(sub, -=)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, &=)
 ATOMIC_OP(or,  |=)
 ATOMIC_OP(xor, ^=)
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -132,8 +132,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -69,8 +69,6 @@ ATOMIC_OP(sub, -)
 		: ia64_atomic_sub(__ia64_asr_i, v);			\
 })
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, &)
 ATOMIC_OP(or, |)
 ATOMIC_OP(xor, ^)
--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -94,8 +94,6 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -77,8 +77,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, &=, and)
 ATOMIC_OP(or, |=, or)
 ATOMIC_OP(xor, ^=, eor)
--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -74,8 +74,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -137,8 +137,6 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, &=, and)
 ATOMIC_OP(or, |=, or)
 ATOMIC_OP(xor, ^=, xor)
--- a/arch/mn10300/include/asm/atomic.h
+++ b/arch/mn10300/include/asm/atomic.h
@@ -89,8 +89,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -126,8 +126,6 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, &=)
 ATOMIC_OP(or, |=)
 ATOMIC_OP(xor, ^=)
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -67,8 +67,6 @@ static __inline__ int atomic_##op##_retu
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, subf)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and, and)
 ATOMIC_OP(or, or)
 ATOMIC_OP(xor, xor)
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -282,8 +282,6 @@ static inline void atomic64_##op(long i,
 	__ATOMIC64_LOOP(v, i, __ATOMIC64_##OP, __ATOMIC64_NO_BARRIER);	\
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC64_OP(and, AND)
 ATOMIC64_OP(or, OR)
 ATOMIC64_OP(xor, XOR)
--- a/arch/sh/include/asm/atomic-grb.h
+++ b/arch/sh/include/asm/atomic-grb.h
@@ -48,8 +48,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -17,8 +17,6 @@
 #include <asm/barrier.h>
 #include <asm-generic/atomic64.h>
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 #define ATOMIC_INIT(i)  { (i) }
 
 int atomic_add_return(int, atomic_t *);
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -33,8 +33,6 @@ long atomic64_##op##_return(long, atomic
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/tile/include/asm/atomic_32.h
+++ b/arch/tile/include/asm/atomic_32.h
@@ -41,8 +41,6 @@ static inline void atomic_##op(int i, at
 	_atomic_##op((unsigned long *)&v->counter, i);			\
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/tile/include/asm/atomic_64.h
+++ b/arch/tile/include/asm/atomic_64.h
@@ -58,8 +58,6 @@ static inline int __atomic_add_unless(at
 	return oldval;
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 static inline void atomic_and(int i, atomic_t *v)
 {
 	__insn_fetchand4((void *)&v->counter, i);
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -191,8 +191,6 @@ static inline void atomic_##op(int i, at
 			: "memory");					\
 }
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -145,8 +145,6 @@ static inline int atomic_##op##_return(i
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -102,24 +102,27 @@ ATOMIC_OP_RETURN(sub, -)
 ATOMIC_OP(and, &)
 #endif
 
-#ifndef atomic_clear_mask
-#define atomic_clear_mask(i, v) atomic_and(~(i), (v))
-#endif
-
 #ifndef atomic_or
-#ifndef CONFIG_ARCH_HAS_ATOMIC_OR
-#define CONFIG_ARCH_HAS_ATOMIC_OR
-#endif
 ATOMIC_OP(or, |)
 #endif
 
-#ifndef atomic_set_mask
-#define atomic_set_mask(i, v)	atomic_or((i), (v))
+#ifndef atomic_xor
+ATOMIC_OP(xor, ^)
 #endif
 
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
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -32,6 +32,10 @@ extern long long atomic64_##op##_return(
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
 
+ATOMIC64_OP(and)
+ATOMIC64_OP(or)
+ATOMIC64_OP(xor)
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -111,19 +111,6 @@ static inline int atomic_dec_if_positive
 }
 #endif
 
-#ifndef CONFIG_ARCH_HAS_ATOMIC_OR
-static inline void atomic_or(int i, atomic_t *v)
-{
-	int old;
-	int new;
-
-	do {
-		old = atomic_read(v);
-		new = old | i;
-	} while (atomic_cmpxchg(v, old, new) != old);
-}
-#endif /* #ifndef CONFIG_ARCH_HAS_ATOMIC_OR */
-
 #include <asm-generic/atomic-long.h>
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -102,6 +102,9 @@ EXPORT_SYMBOL(atomic64_##op##_return);
 
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
+ATOMIC64_OP(and, &=)
+ATOMIC64_OP(or, |=)
+ATOMIC64_OP(xor, ^=)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
