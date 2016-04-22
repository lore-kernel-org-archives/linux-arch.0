From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 26/31] locking: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Date: Fri, 22 Apr 2016 11:04:39 +0200
Message-ID: <20160422093924.738823597@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-generic.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Now that all the architectures have implemented support for these new
atomic primitives add on the generic infrastructure to expose and use
it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/atomic-long.h |   36 +++-
 include/asm-generic/atomic.h      |   49 +++++
 include/asm-generic/atomic64.h    |   15 +
 include/linux/atomic.h            |  336 ++++++++++++++++++++++++++++++++++++++
 lib/atomic64.c                    |   32 +++
 lib/atomic64_test.c               |   34 +++
 6 files changed, 493 insertions(+), 9 deletions(-)

--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -112,6 +112,40 @@ static __always_inline void atomic_long_
 	ATOMIC_LONG_PFX(_dec)(v);
 }
 
+#define ATOMIC_LONG_FETCH_OP(op, mo)					\
+static inline long							\
+atomic_long_fetch_##op##mo(long i, atomic_long_t *l)			\
+{									\
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;		\
+									\
+	return (long)ATOMIC_LONG_PFX(_fetch_##op##mo)(i, v);		\
+}
+
+ATOMIC_LONG_FETCH_OP(add, )
+ATOMIC_LONG_FETCH_OP(add, _relaxed)
+ATOMIC_LONG_FETCH_OP(add, _acquire)
+ATOMIC_LONG_FETCH_OP(add, _release)
+ATOMIC_LONG_FETCH_OP(sub, )
+ATOMIC_LONG_FETCH_OP(sub, _relaxed)
+ATOMIC_LONG_FETCH_OP(sub, _acquire)
+ATOMIC_LONG_FETCH_OP(sub, _release)
+ATOMIC_LONG_FETCH_OP(and, )
+ATOMIC_LONG_FETCH_OP(and, _relaxed)
+ATOMIC_LONG_FETCH_OP(and, _acquire)
+ATOMIC_LONG_FETCH_OP(and, _release)
+ATOMIC_LONG_FETCH_OP(andnot, )
+ATOMIC_LONG_FETCH_OP(andnot, _relaxed)
+ATOMIC_LONG_FETCH_OP(andnot, _acquire)
+ATOMIC_LONG_FETCH_OP(andnot, _release)
+ATOMIC_LONG_FETCH_OP(or, )
+ATOMIC_LONG_FETCH_OP(or, _relaxed)
+ATOMIC_LONG_FETCH_OP(or, _acquire)
+ATOMIC_LONG_FETCH_OP(or, _release)
+ATOMIC_LONG_FETCH_OP(xor, )
+ATOMIC_LONG_FETCH_OP(xor, _relaxed)
+ATOMIC_LONG_FETCH_OP(xor, _acquire)
+ATOMIC_LONG_FETCH_OP(xor, _release)
+
 #define ATOMIC_LONG_OP(op)						\
 static __always_inline void						\
 atomic_long_##op(long i, atomic_long_t *l)				\
@@ -124,9 +158,9 @@ atomic_long_##op(long i, atomic_long_t *
 ATOMIC_LONG_OP(add)
 ATOMIC_LONG_OP(sub)
 ATOMIC_LONG_OP(and)
+ATOMIC_LONG_OP(andnot)
 ATOMIC_LONG_OP(or)
 ATOMIC_LONG_OP(xor)
-ATOMIC_LONG_OP(andnot)
 
 #undef ATOMIC_LONG_OP
 
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -61,6 +61,18 @@ static inline int atomic_##op##_return(i
 	return c c_op i;						\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int c, old;							\
+									\
+	c = v->counter;							\
+	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+		c = old;						\
+									\
+	return c;							\
+}
+
 #else
 
 #include <linux/irqflags.h>
@@ -88,6 +100,20 @@ static inline int atomic_##op##_return(i
 	return ret;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+	int ret;							\
+									\
+	raw_local_irq_save(flags);					\
+	ret = v->counter;						\
+	v->counter = v->counter c_op i;					\
+	raw_local_irq_restore(flags);					\
+									\
+	return ret;							\
+}
+
 #endif /* CONFIG_SMP */
 
 #ifndef atomic_add_return
@@ -98,6 +124,28 @@ ATOMIC_OP_RETURN(add, +)
 ATOMIC_OP_RETURN(sub, -)
 #endif
 
+#ifndef atomic_fetch_add
+ATOMIC_FETCH_OP(add, +)
+#endif
+
+#ifndef atomic_fetch_sub
+ATOMIC_FETCH_OP(sub, -)
+#endif
+
+#ifndef atomic_fetch_and
+ATOMIC_FETCH_OP(and, &)
+#endif
+
+#ifndef atomic_fetch_or
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_FETCH_OP(or, |)
+#endif
+
+#ifndef atomic_fetch_xor
+ATOMIC_FETCH_OP(xor, ^)
+#endif
+
 #ifndef atomic_and
 ATOMIC_OP(and, &)
 #endif
@@ -110,6 +158,7 @@ ATOMIC_OP(or, |)
 ATOMIC_OP(xor, ^)
 #endif
 
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -27,16 +27,23 @@ extern void	 atomic64_##op(long long a,
 #define ATOMIC64_OP_RETURN(op)						\
 extern long long atomic64_##op##_return(long long a, atomic64_t *v);
 
-#define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op)
+#define ATOMIC64_FETCH_OP(op)						\
+extern long long atomic64_fetch_##op(long long a, atomic64_t *v);
+
+#define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
 
-ATOMIC64_OP(and)
-ATOMIC64_OP(or)
-ATOMIC64_OP(xor)
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_FETCH_OP(op)
+
+ATOMIC64_OPS(and)
+ATOMIC64_OPS(or)
+ATOMIC64_OPS(xor)
 
 #undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -163,6 +163,154 @@
 #endif
 #endif /* atomic_dec_return_relaxed */
 
+
+/* atomic_fetch_add_relaxed */
+#ifndef atomic_fetch_add_relaxed
+#define atomic_fetch_add_relaxed	atomic_fetch_add
+#define atomic_fetch_add_acquire	atomic_fetch_add
+#define atomic_fetch_add_release	atomic_fetch_add
+
+#else /* atomic_fetch_add_relaxed */
+
+#ifndef atomic_fetch_add_acquire
+#define atomic_fetch_add_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_add, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_add_release
+#define atomic_fetch_add_release(...)					\
+	__atomic_op_release(atomic_fetch_add, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_add
+#define atomic_fetch_add(...)						\
+	__atomic_op_fence(atomic_fetch_add, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_add_relaxed */
+
+/* atomic_fetch_sub_relaxed */
+#ifndef atomic_fetch_sub_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub
+#define atomic_fetch_sub_acquire	atomic_fetch_sub
+#define atomic_fetch_sub_release	atomic_fetch_sub
+
+#else /* atomic_fetch_sub_relaxed */
+
+#ifndef atomic_fetch_sub_acquire
+#define atomic_fetch_sub_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_sub, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_sub_release
+#define atomic_fetch_sub_release(...)					\
+	__atomic_op_release(atomic_fetch_sub, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_sub
+#define atomic_fetch_sub(...)						\
+	__atomic_op_fence(atomic_fetch_sub, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_sub_relaxed */
+
+/* atomic_fetch_or_relaxed */
+#ifndef atomic_fetch_or_relaxed
+#define atomic_fetch_or_relaxed	atomic_fetch_or
+#define atomic_fetch_or_acquire	atomic_fetch_or
+#define atomic_fetch_or_release	atomic_fetch_or
+
+#else /* atomic_fetch_or_relaxed */
+
+#ifndef atomic_fetch_or_acquire
+#define atomic_fetch_or_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_or, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_or_release
+#define atomic_fetch_or_release(...)					\
+	__atomic_op_release(atomic_fetch_or, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_or
+#define atomic_fetch_or(...)						\
+	__atomic_op_fence(atomic_fetch_or, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_or_relaxed */
+
+/* atomic_fetch_and_relaxed */
+#ifndef atomic_fetch_and_relaxed
+#define atomic_fetch_and_relaxed	atomic_fetch_and
+#define atomic_fetch_and_acquire	atomic_fetch_and
+#define atomic_fetch_and_release	atomic_fetch_and
+
+#else /* atomic_fetch_and_relaxed */
+
+#ifndef atomic_fetch_and_acquire
+#define atomic_fetch_and_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_and, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_and_release
+#define atomic_fetch_and_release(...)					\
+	__atomic_op_release(atomic_fetch_and, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_and
+#define atomic_fetch_and(...)						\
+	__atomic_op_fence(atomic_fetch_and, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_and_relaxed */
+
+#ifdef atomic_andnot
+/* atomic_fetch_andnot_relaxed */
+#ifndef atomic_fetch_andnot_relaxed
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot
+#define atomic_fetch_andnot_acquire	atomic_fetch_andnot
+#define atomic_fetch_andnot_release	atomic_fetch_andnot
+
+#else /* atomic_fetch_andnot_relaxed */
+
+#ifndef atomic_fetch_andnot_acquire
+#define atomic_fetch_andnot_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_andnot, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_andnot_release
+#define atomic_fetch_andnot_release(...)					\
+	__atomic_op_release(atomic_fetch_andnot, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_andnot
+#define atomic_fetch_andnot(...)						\
+	__atomic_op_fence(atomic_fetch_andnot, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_andnot_relaxed */
+#endif /* atomic_andnot */
+
+/* atomic_fetch_xor_relaxed */
+#ifndef atomic_fetch_xor_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor
+#define atomic_fetch_xor_acquire	atomic_fetch_xor
+#define atomic_fetch_xor_release	atomic_fetch_xor
+
+#else /* atomic_fetch_xor_relaxed */
+
+#ifndef atomic_fetch_xor_acquire
+#define atomic_fetch_xor_acquire(...)					\
+	__atomic_op_acquire(atomic_fetch_xor, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_xor_release
+#define atomic_fetch_xor_release(...)					\
+	__atomic_op_release(atomic_fetch_xor, __VA_ARGS__)
+#endif
+
+#ifndef atomic_fetch_xor
+#define atomic_fetch_xor(...)						\
+	__atomic_op_fence(atomic_fetch_xor, __VA_ARGS__)
+#endif
+#endif /* atomic_fetch_xor_relaxed */
+
+
 /* atomic_xchg_relaxed */
 #ifndef atomic_xchg_relaxed
 #define  atomic_xchg_relaxed		atomic_xchg
@@ -310,6 +458,26 @@ static inline void atomic_andnot(int i,
 {
 	atomic_and(~i, v);
 }
+
+static inline int atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return atomic_fetch_and(~i, v);
+}
+
+static inline int atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_and_relaxed(~i, v);
+}
+
+static inline int atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_and_acquire(~i, v);
+}
+
+static inline int atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return atomic_fetch_and_release(~i, v);
+}
 #endif
 
 static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
@@ -535,6 +703,154 @@ static inline int atomic_fetch_or(atomic
 #endif
 #endif /* atomic64_dec_return_relaxed */
 
+
+/* atomic64_fetch_add_relaxed */
+#ifndef atomic64_fetch_add_relaxed
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add
+#define atomic64_fetch_add_acquire	atomic64_fetch_add
+#define atomic64_fetch_add_release	atomic64_fetch_add
+
+#else /* atomic64_fetch_add_relaxed */
+
+#ifndef atomic64_fetch_add_acquire
+#define atomic64_fetch_add_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_add, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_add_release
+#define atomic64_fetch_add_release(...)					\
+	__atomic_op_release(atomic64_fetch_add, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_add
+#define atomic64_fetch_add(...)						\
+	__atomic_op_fence(atomic64_fetch_add, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_add_relaxed */
+
+/* atomic64_fetch_sub_relaxed */
+#ifndef atomic64_fetch_sub_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub
+#define atomic64_fetch_sub_acquire	atomic64_fetch_sub
+#define atomic64_fetch_sub_release	atomic64_fetch_sub
+
+#else /* atomic64_fetch_sub_relaxed */
+
+#ifndef atomic64_fetch_sub_acquire
+#define atomic64_fetch_sub_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_sub, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_sub_release
+#define atomic64_fetch_sub_release(...)					\
+	__atomic_op_release(atomic64_fetch_sub, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_sub
+#define atomic64_fetch_sub(...)						\
+	__atomic_op_fence(atomic64_fetch_sub, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_sub_relaxed */
+
+/* atomic64_fetch_or_relaxed */
+#ifndef atomic64_fetch_or_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or
+#define atomic64_fetch_or_acquire	atomic64_fetch_or
+#define atomic64_fetch_or_release	atomic64_fetch_or
+
+#else /* atomic64_fetch_or_relaxed */
+
+#ifndef atomic64_fetch_or_acquire
+#define atomic64_fetch_or_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_or, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_or_release
+#define atomic64_fetch_or_release(...)					\
+	__atomic_op_release(atomic64_fetch_or, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_or
+#define atomic64_fetch_or(...)						\
+	__atomic_op_fence(atomic64_fetch_or, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_or_relaxed */
+
+/* atomic64_fetch_and_relaxed */
+#ifndef atomic64_fetch_and_relaxed
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and
+#define atomic64_fetch_and_acquire	atomic64_fetch_and
+#define atomic64_fetch_and_release	atomic64_fetch_and
+
+#else /* atomic64_fetch_and_relaxed */
+
+#ifndef atomic64_fetch_and_acquire
+#define atomic64_fetch_and_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_and, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_and_release
+#define atomic64_fetch_and_release(...)					\
+	__atomic_op_release(atomic64_fetch_and, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_and
+#define atomic64_fetch_and(...)						\
+	__atomic_op_fence(atomic64_fetch_and, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_and_relaxed */
+
+#ifdef atomic64_andnot
+/* atomic64_fetch_andnot_relaxed */
+#ifndef atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot
+#define atomic64_fetch_andnot_acquire	atomic64_fetch_andnot
+#define atomic64_fetch_andnot_release	atomic64_fetch_andnot
+
+#else /* atomic64_fetch_andnot_relaxed */
+
+#ifndef atomic64_fetch_andnot_acquire
+#define atomic64_fetch_andnot_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_andnot, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_andnot_release
+#define atomic64_fetch_andnot_release(...)					\
+	__atomic_op_release(atomic64_fetch_andnot, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_andnot
+#define atomic64_fetch_andnot(...)						\
+	__atomic_op_fence(atomic64_fetch_andnot, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_andnot_relaxed */
+#endif /* atomic64_andnot */
+
+/* atomic64_fetch_xor_relaxed */
+#ifndef atomic64_fetch_xor_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor
+#define atomic64_fetch_xor_acquire	atomic64_fetch_xor
+#define atomic64_fetch_xor_release	atomic64_fetch_xor
+
+#else /* atomic64_fetch_xor_relaxed */
+
+#ifndef atomic64_fetch_xor_acquire
+#define atomic64_fetch_xor_acquire(...)					\
+	__atomic_op_acquire(atomic64_fetch_xor, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_xor_release
+#define atomic64_fetch_xor_release(...)					\
+	__atomic_op_release(atomic64_fetch_xor, __VA_ARGS__)
+#endif
+
+#ifndef atomic64_fetch_xor
+#define atomic64_fetch_xor(...)						\
+	__atomic_op_fence(atomic64_fetch_xor, __VA_ARGS__)
+#endif
+#endif /* atomic64_fetch_xor_relaxed */
+
+
 /* atomic64_xchg_relaxed */
 #ifndef atomic64_xchg_relaxed
 #define  atomic64_xchg_relaxed		atomic64_xchg
@@ -588,6 +904,26 @@ static inline void atomic64_andnot(long
 {
 	atomic64_and(~i, v);
 }
+
+static inline long long atomic64_fetch_andnot(long long i, atomic64_t *v)
+{
+	return atomic64_fetch_and(~i, v);
+}
+
+static inline long long atomic64_fetch_andnot_relaxed(long long i, atomic64_t *v)
+{
+	return atomic64_fetch_and_relaxed(~i, v);
+}
+
+static inline long long atomic64_fetch_andnot_acquire(long long i, atomic64_t *v)
+{
+	return atomic64_fetch_and_acquire(~i, v);
+}
+
+static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v)
+{
+	return atomic64_fetch_and_release(~i, v);
+}
 #endif
 
 #include <asm-generic/atomic-long.h>
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -96,17 +96,41 @@ long long atomic64_##op##_return(long lo
 }									\
 EXPORT_SYMBOL(atomic64_##op##_return);
 
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+long long atomic64_fetch_##op(long long a, atomic64_t *v)		\
+{									\
+	unsigned long flags;						\
+	raw_spinlock_t *lock = lock_addr(v);				\
+	long long val;							\
+									\
+	raw_spin_lock_irqsave(lock, flags);				\
+	val = v->counter;						\
+	v->counter c_op a;						\
+	raw_spin_unlock_irqrestore(lock, flags);			\
+	return val;							\
+}									\
+EXPORT_SYMBOL(atomic64_fetch_##op);
+
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
-	ATOMIC64_OP_RETURN(op, c_op)
+	ATOMIC64_OP_RETURN(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
 
 ATOMIC64_OPS(add, +=)
 ATOMIC64_OPS(sub, -=)
-ATOMIC64_OP(and, &=)
-ATOMIC64_OP(or, |=)
-ATOMIC64_OP(xor, ^=)
 
 #undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_OP_RETURN(op, c_op)					\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &=)
+ATOMIC64_OPS(or, |=)
+ATOMIC64_OPS(xor, ^=)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -53,11 +53,25 @@ do {								\
 	BUG_ON(atomic##bit##_read(&v) != r);			\
 } while (0)
 
+#define TEST_FETCH(bit, op, c_op, val)				\
+do {								\
+	atomic##bit##_set(&v, v0);				\
+	r = v0;							\
+	r c_op val;						\
+	BUG_ON(atomic##bit##_##op(val, &v) != v0);		\
+	BUG_ON(atomic##bit##_read(&v) != r);			\
+} while (0)
+
 #define RETURN_FAMILY_TEST(bit, op, c_op, val)			\
 do {								\
 	FAMILY_TEST(TEST_RETURN, bit, op, c_op, val);		\
 } while (0)
 
+#define FETCH_FAMILY_TEST(bit, op, c_op, val)			\
+do {								\
+	FAMILY_TEST(TEST_FETCH, bit, op, c_op, val);		\
+} while (0)
+
 #define TEST_ARGS(bit, op, init, ret, expect, args...)		\
 do {								\
 	atomic##bit##_set(&v, init);				\
@@ -114,6 +128,16 @@ static __init void test_atomic(void)
 	RETURN_FAMILY_TEST(, sub_return, -=, onestwos);
 	RETURN_FAMILY_TEST(, sub_return, -=, -one);
 
+	FETCH_FAMILY_TEST(, fetch_add, +=, onestwos);
+	FETCH_FAMILY_TEST(, fetch_add, +=, -one);
+	FETCH_FAMILY_TEST(, fetch_sub, -=, onestwos);
+	FETCH_FAMILY_TEST(, fetch_sub, -=, -one);
+
+	FETCH_FAMILY_TEST(, fetch_or,  |=, v1);
+	FETCH_FAMILY_TEST(, fetch_and, &=, v1);
+	FETCH_FAMILY_TEST(, fetch_andnot, &= ~, v1);
+	FETCH_FAMILY_TEST(, fetch_xor, ^=, v1);
+
 	INC_RETURN_FAMILY_TEST(, v0);
 	DEC_RETURN_FAMILY_TEST(, v0);
 
@@ -154,6 +178,16 @@ static __init void test_atomic64(void)
 	RETURN_FAMILY_TEST(64, sub_return, -=, onestwos);
 	RETURN_FAMILY_TEST(64, sub_return, -=, -one);
 
+	FETCH_FAMILY_TEST(64, fetch_add, +=, onestwos);
+	FETCH_FAMILY_TEST(64, fetch_add, +=, -one);
+	FETCH_FAMILY_TEST(64, fetch_sub, -=, onestwos);
+	FETCH_FAMILY_TEST(64, fetch_sub, -=, -one);
+
+	FETCH_FAMILY_TEST(64, fetch_or,  |=, v1);
+	FETCH_FAMILY_TEST(64, fetch_and, &=, v1);
+	FETCH_FAMILY_TEST(64, fetch_andnot, &= ~, v1);
+	FETCH_FAMILY_TEST(64, fetch_xor, ^=, v1);
+
 	INIT(v0);
 	atomic64_inc(&v);
 	r += one;
