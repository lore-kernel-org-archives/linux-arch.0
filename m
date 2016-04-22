From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 27/31] locking: Remove linux/atomic.h:atomic_fetch_or
Date: Fri, 22 Apr 2016 11:04:40 +0200
Message-ID: <20160422093924.799805337@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch_or-kill.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Since all architectures have this implemented natively, remove this
now dead code.





Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/atomic.h    |    2 --
 arch/arc/include/asm/atomic.h      |    2 --
 arch/arm/include/asm/atomic.h      |    2 --
 arch/arm64/include/asm/atomic.h    |    2 --
 arch/avr32/include/asm/atomic.h    |    2 --
 arch/frv/include/asm/atomic.h      |    2 --
 arch/h8300/include/asm/atomic.h    |    2 --
 arch/hexagon/include/asm/atomic.h  |    2 --
 arch/m32r/include/asm/atomic.h     |    2 --
 arch/m68k/include/asm/atomic.h     |    2 --
 arch/metag/include/asm/atomic.h    |    2 --
 arch/mips/include/asm/atomic.h     |    2 --
 arch/mn10300/include/asm/atomic.h  |    2 --
 arch/parisc/include/asm/atomic.h   |    2 --
 arch/s390/include/asm/atomic.h     |    2 --
 arch/sh/include/asm/atomic.h       |    2 --
 arch/sparc/include/asm/atomic.h    |    1 -
 arch/sparc/include/asm/atomic_32.h |    2 --
 arch/tile/include/asm/atomic.h     |    2 --
 arch/x86/include/asm/atomic.h      |    2 --
 arch/xtensa/include/asm/atomic.h   |    2 --
 include/asm-generic/atomic.h       |    2 --
 include/linux/atomic.h             |   21 ---------------------
 23 files changed, 64 deletions(-)

--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -155,8 +155,6 @@ ATOMIC_OPS(sub)
 #define atomic_andnot atomic_andnot
 #define atomic64_andnot atomic64_andnot
 
-#define atomic_fetch_or atomic_fetch_or
-
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm)						\
 	ATOMIC_OP(op, asm)						\
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -226,8 +226,6 @@ ATOMIC_OPS(sub, -=, sub)
 
 #define atomic_andnot atomic_andnot
 
-#define atomic_fetch_or atomic_fetch_or
-
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -237,8 +237,6 @@ ATOMIC_OPS(sub, -=, sub)
 
 #define atomic_andnot atomic_andnot
 
-#define atomic_fetch_or atomic_fetch_or
-
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -128,8 +128,6 @@
 #define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
 #define atomic_andnot			atomic_andnot
 
-#define atomic_fetch_or atomic_fetch_or
-
 /*
  * 64-bit atomic operations.
  */
--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -66,8 +66,6 @@ ATOMIC_OP_RETURN(add, add, r)
 ATOMIC_FETCH_OP (sub, sub, rKs21)
 ATOMIC_FETCH_OP (add, add, r)
 
-#define atomic_fetch_or atomic_fetch_or
-
 #define ATOMIC_OPS(op, asm_op)						\
 ATOMIC_OP_RETURN(op, asm_op, r)						\
 static inline void atomic_##op(int i, atomic_t *v)			\
--- a/arch/frv/include/asm/atomic.h
+++ b/arch/frv/include/asm/atomic.h
@@ -74,8 +74,6 @@ static inline void atomic_dec(atomic_t *
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 #define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
 
-#define atomic_fetch_or atomic_fetch_or
-
 /*
  * 64-bit atomic ops
  */
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -54,8 +54,6 @@ static inline void atomic_##op(int i, at
 ATOMIC_OP_RETURN(add, +=)
 ATOMIC_OP_RETURN(sub, -=)
 
-#define atomic_fetch_or atomic_fetch_or
-
 #define ATOMIC_OPS(op, c_op)					\
 	ATOMIC_OP(op, c_op)					\
 	ATOMIC_FETCH_OP(op, c_op)
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -152,8 +152,6 @@ ATOMIC_OPS(sub)
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -121,8 +121,6 @@ ATOMIC_OPS(sub)
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -119,8 +119,6 @@ ATOMIC_OPS(sub, -=, sub)
 	ATOMIC_OP(op, c_op, asm_op)					\
 	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and, &=, and)
 ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, eor)
--- a/arch/metag/include/asm/atomic.h
+++ b/arch/metag/include/asm/atomic.h
@@ -17,8 +17,6 @@
 #include <asm/atomic_lnkget.h>
 #endif
 
-#define atomic_fetch_or atomic_fetch_or
-
 #define atomic_add_negative(a, v)       (atomic_add_return((a), (v)) < 0)
 
 #define atomic_dec_return(v) atomic_sub_return(1, (v))
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -194,8 +194,6 @@ ATOMIC_OPS(sub, -=, subu)
 	ATOMIC_OP(op, c_op, asm_op)					      \
 	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and, &=, and)
 ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
--- a/arch/mn10300/include/asm/atomic.h
+++ b/arch/mn10300/include/asm/atomic.h
@@ -113,8 +113,6 @@ ATOMIC_OPS(sub)
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -148,8 +148,6 @@ ATOMIC_OPS(sub, -=)
 	ATOMIC_OP(op, c_op)						\
 	ATOMIC_FETCH_OP(op, c_op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and, &=)
 ATOMIC_OPS(or, |=)
 ATOMIC_OPS(xor, ^=)
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -135,8 +135,6 @@ static inline int atomic_fetch_##op(int
 	return __ATOMIC_LOOP(v, i, __ATOMIC_##OP, __ATOMIC_BARRIER);	\
 }
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and, AND)
 ATOMIC_OPS(or, OR)
 ATOMIC_OPS(xor, XOR)
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -25,8 +25,6 @@
 #include <asm/atomic-irq.h>
 #endif
 
-#define atomic_fetch_or atomic_fetch_or
-
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
--- a/arch/sparc/include/asm/atomic.h
+++ b/arch/sparc/include/asm/atomic.h
@@ -5,5 +5,4 @@
 #else
 #include <asm/atomic_32.h>
 #endif
-#define atomic_fetch_or atomic_fetch_or
 #endif
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -36,8 +36,6 @@ void atomic_set(atomic_t *, int);
 #define atomic_inc(v)		((void)atomic_add_return(        1, (v)))
 #define atomic_dec(v)		((void)atomic_add_return(       -1, (v)))
 
-#define atomic_fetch_or	atomic_fetch_or
-
 #define atomic_and(i, v)	((void)atomic_fetch_and((i), (v)))
 #define atomic_or(i, v)		((void)atomic_fetch_or((i), (v)))
 #define atomic_xor(i, v)	((void)atomic_fetch_xor((i), (v)))
--- a/arch/tile/include/asm/atomic.h
+++ b/arch/tile/include/asm/atomic.h
@@ -48,8 +48,6 @@ static inline int atomic_read(const atom
 
 #define atomic_fetch_sub(i, v)		atomic_fetch_add(-(int)(i), (v))
 
-#define atomic_fetch_or atomic_fetch_or
-
 /**
  * atomic_sub - subtract integer from atomic variable
  * @i: integer value to subtract
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -217,8 +217,6 @@ static inline int atomic_fetch_##op(int
 	ATOMIC_OP(op)							\
 	ATOMIC_FETCH_OP(op, c_op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and, &)
 ATOMIC_OPS(or , |)
 ATOMIC_OPS(xor, ^)
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -188,8 +188,6 @@ ATOMIC_OPS(sub)
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
 
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_OPS(and)
 ATOMIC_OPS(or)
 ATOMIC_OPS(xor)
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -137,8 +137,6 @@ ATOMIC_FETCH_OP(and, &)
 #endif
 
 #ifndef atomic_fetch_or
-#define atomic_fetch_or atomic_fetch_or
-
 ATOMIC_FETCH_OP(or, |)
 #endif
 
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -573,27 +573,6 @@ static inline int atomic_dec_if_positive
 }
 #endif
 
-/**
- * atomic_fetch_or - perform *p |= mask and return old value of *p
- * @mask: mask to OR on the atomic_t
- * @p: pointer to atomic_t
- */
-#ifndef atomic_fetch_or
-static inline int atomic_fetch_or(int mask, atomic_t *p)
-{
-	int old, val = atomic_read(p);
-
-	for (;;) {
-		old = atomic_cmpxchg(p, val, val | mask);
-		if (old == val)
-			break;
-		val = old;
-	}
-
-	return old;
-}
-#endif
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
