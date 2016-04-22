From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 05/31] locking,arm64: Implement atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Date: Fri, 22 Apr 2016 11:04:18 +0200
Message-ID: <20160422093923.366551860@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-arm64.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

XXX lacking LSE bits


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/atomic.h       |   32 ++++++++++
 arch/arm64/include/asm/atomic_ll_sc.h |  108 ++++++++++++++++++++++++++--------
 2 files changed, 116 insertions(+), 24 deletions(-)

--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -76,6 +76,36 @@
 #define atomic_dec_return_release(v)	atomic_sub_return_release(1, (v))
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_add_acquire	atomic_fetch_add_acquire
+#define atomic_fetch_add_release	atomic_fetch_add_release
+#define atomic_fetch_add		atomic_fetch_add
+
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define atomic_fetch_sub_acquire	atomic_fetch_sub_acquire
+#define atomic_fetch_sub_release	atomic_fetch_sub_release
+#define atomic_fetch_sub		atomic_fetch_sub
+
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_and_acquire	atomic_fetch_and_acquire
+#define atomic_fetch_and_release	atomic_fetch_and_release
+#define atomic_fetch_and		atomic_fetch_and
+
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
+#define atomic_fetch_andnot_acquire	atomic_fetch_andnot_acquire
+#define atomic_fetch_andnot_release	atomic_fetch_andnot_release
+#define atomic_fetch_andnot		atomic_fetch_andnot
+
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_or_acquire		atomic_fetch_or_acquire
+#define atomic_fetch_or_release		atomic_fetch_or_release
+#define atomic_fetch_or			atomic_fetch_or
+
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define atomic_fetch_xor_acquire	atomic_fetch_xor_acquire
+#define atomic_fetch_xor_release	atomic_fetch_xor_release
+#define atomic_fetch_xor		atomic_fetch_xor
+
 #define atomic_xchg_relaxed(v, new)	xchg_relaxed(&((v)->counter), (new))
 #define atomic_xchg_acquire(v, new)	xchg_acquire(&((v)->counter), (new))
 #define atomic_xchg_release(v, new)	xchg_release(&((v)->counter), (new))
@@ -98,6 +128,8 @@
 #define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
 #define atomic_andnot			atomic_andnot
 
+#define atomic_fetch_or atomic_fetch_or
+
 /*
  * 64-bit atomic operations.
  */
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -77,25 +77,55 @@ __LL_SC_PREFIX(atomic_##op##_return##nam
 }									\
 __LL_SC_EXPORT(atomic_##op##_return##name);
 
+#define ATOMIC_FETCH_OP(name, mb, acq, rel, cl, op, asm_op)		\
+__LL_SC_INLINE int							\
+__LL_SC_PREFIX(atomic_fetch_##op##name(int i, atomic_t *v))		\
+{									\
+	unsigned long tmp;						\
+	int val, result;						\
+									\
+	asm volatile("// atomic_fetch_" #op #name "\n"			\
+"	prfm	pstl1strm, %3\n"					\
+"1:	ld" #acq "xr	%w0, %3\n"					\
+"	" #asm_op "	%w1, %w0, %w4\n"				\
+"	st" #rel "xr	%w2, %w1, %3\n"					\
+"	cbnz	%w2, 1b\n"						\
+"	" #mb								\
+	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Q" (v->counter)	\
+	: "Ir" (i)							\
+	: cl);								\
+									\
+	return result;							\
+}									\
+__LL_SC_EXPORT(atomic_fetch_##op##name);
+
 #define ATOMIC_OPS(...)							\
 	ATOMIC_OP(__VA_ARGS__)						\
-	ATOMIC_OP_RETURN(        , dmb ish,  , l, "memory", __VA_ARGS__)
-
-#define ATOMIC_OPS_RLX(...)						\
-	ATOMIC_OPS(__VA_ARGS__)						\
+	ATOMIC_OP_RETURN(        , dmb ish,  , l, "memory", __VA_ARGS__)\
 	ATOMIC_OP_RETURN(_relaxed,        ,  ,  ,         , __VA_ARGS__)\
 	ATOMIC_OP_RETURN(_acquire,        , a,  , "memory", __VA_ARGS__)\
-	ATOMIC_OP_RETURN(_release,        ,  , l, "memory", __VA_ARGS__)
+	ATOMIC_OP_RETURN(_release,        ,  , l, "memory", __VA_ARGS__)\
+	ATOMIC_FETCH_OP (        , dmb ish,  , l, "memory", __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_relaxed,        ,  ,  ,         , __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_acquire,        , a,  , "memory", __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_release,        ,  , l, "memory", __VA_ARGS__)
 
-ATOMIC_OPS_RLX(add, add)
-ATOMIC_OPS_RLX(sub, sub)
+ATOMIC_OPS(add, add)
+ATOMIC_OPS(sub, sub)
 
-ATOMIC_OP(and, and)
-ATOMIC_OP(andnot, bic)
-ATOMIC_OP(or, orr)
-ATOMIC_OP(xor, eor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(...)							\
+	ATOMIC_OP(__VA_ARGS__)						\
+	ATOMIC_FETCH_OP (        , dmb ish,  , l, "memory", __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_relaxed,        ,  ,  ,         , __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_acquire,        , a,  , "memory", __VA_ARGS__)\
+	ATOMIC_FETCH_OP (_release,        ,  , l, "memory", __VA_ARGS__)
+
+ATOMIC_OPS(and, and)
+ATOMIC_OPS(andnot, bic)
+ATOMIC_OPS(or, orr)
+ATOMIC_OPS(xor, eor)
 
-#undef ATOMIC_OPS_RLX
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -140,25 +170,55 @@ __LL_SC_PREFIX(atomic64_##op##_return##n
 }									\
 __LL_SC_EXPORT(atomic64_##op##_return##name);
 
+#define ATOMIC64_FETCH_OP(name, mb, acq, rel, cl, op, asm_op)		\
+__LL_SC_INLINE long							\
+__LL_SC_PREFIX(atomic64_fetch_##op##name(long i, atomic64_t *v))	\
+{									\
+	long result, val;						\
+	unsigned long tmp;						\
+									\
+	asm volatile("// atomic64_fetch_" #op #name "\n"		\
+"	prfm	pstl1strm, %3\n"					\
+"1:	ld" #acq "xr	%0, %3\n"					\
+"	" #asm_op "	%1, %0, %4\n"					\
+"	st" #rel "xr	%w2, %1, %3\n"					\
+"	cbnz	%w2, 1b\n"						\
+"	" #mb								\
+	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Q" (v->counter)	\
+	: "Ir" (i)							\
+	: cl);								\
+									\
+	return result;							\
+}									\
+__LL_SC_EXPORT(atomic64_##op##_return##name);
+
 #define ATOMIC64_OPS(...)						\
 	ATOMIC64_OP(__VA_ARGS__)					\
-	ATOMIC64_OP_RETURN(, dmb ish,  , l, "memory", __VA_ARGS__)
-
-#define ATOMIC64_OPS_RLX(...)						\
-	ATOMIC64_OPS(__VA_ARGS__)					\
+	ATOMIC64_OP_RETURN(, dmb ish,  , l, "memory", __VA_ARGS__)	\
 	ATOMIC64_OP_RETURN(_relaxed,,  ,  ,         , __VA_ARGS__)	\
 	ATOMIC64_OP_RETURN(_acquire,, a,  , "memory", __VA_ARGS__)	\
-	ATOMIC64_OP_RETURN(_release,,  , l, "memory", __VA_ARGS__)
+	ATOMIC64_OP_RETURN(_release,,  , l, "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (, dmb ish,  , l, "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_relaxed,,  ,  ,         , __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_acquire,, a,  , "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_release,,  , l, "memory", __VA_ARGS__)
 
-ATOMIC64_OPS_RLX(add, add)
-ATOMIC64_OPS_RLX(sub, sub)
+ATOMIC64_OPS(add, add)
+ATOMIC64_OPS(sub, sub)
 
-ATOMIC64_OP(and, and)
-ATOMIC64_OP(andnot, bic)
-ATOMIC64_OP(or, orr)
-ATOMIC64_OP(xor, eor)
+#undef ATOMIC_OPS
+#define ATOMIC64_OPS(...)						\
+	ATOMIC64_OP(__VA_ARGS__)					\
+	ATOMIC64_FETCH_OP (, dmb ish,  , l, "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_relaxed,,  ,  ,         , __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_acquire,, a,  , "memory", __VA_ARGS__)	\
+	ATOMIC64_FETCH_OP (_release,,  , l, "memory", __VA_ARGS__)
+
+ATOMIC64_OPS(and, and)
+ATOMIC64_OPS(andnot, bic)
+ATOMIC64_OPS(or, orr)
+ATOMIC64_OPS(xor, eor)
 
-#undef ATOMIC64_OPS_RLX
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
