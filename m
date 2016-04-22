From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 04/31] locking,arm: Implement atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Date: Fri, 22 Apr 2016 11:04:17 +0200
Message-ID: <20160422093923.293177377@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-arm.patch
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/atomic.h |  108 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 10 deletions(-)

--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -77,8 +77,36 @@ static inline int atomic_##op##_return_r
 	return result;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+{									\
+	unsigned long tmp;						\
+	int result, val;						\
+									\
+	prefetchw(&v->counter);						\
+									\
+	__asm__ __volatile__("@ atomic_fetch_" #op "\n"			\
+"1:	ldrex	%0, [%4]\n"						\
+"	" #asm_op "	%1, %0, %5\n"					\
+"	strex	%2, %1, [%4]\n"						\
+"	teq	%2, #0\n"						\
+"	bne	1b"							\
+	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Qo" (v->counter)	\
+	: "r" (&v->counter), "Ir" (i)					\
+	: "cc");							\
+									\
+	return result;							\
+}
+
 #define atomic_add_return_relaxed	atomic_add_return_relaxed
 #define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
 
 static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 {
@@ -159,6 +187,20 @@ static inline int atomic_##op##_return(i
 	return val;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+	int val;							\
+									\
+	raw_local_irq_save(flags);					\
+	val = v->counter;						\
+	v->counter c_op i;						\
+	raw_local_irq_restore(flags);					\
+									\
+	return val;							\
+}
+
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -187,19 +229,28 @@ static inline int __atomic_add_unless(at
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
 #define atomic_andnot atomic_andnot
 
-ATOMIC_OP(and, &=, and)
-ATOMIC_OP(andnot, &= ~, bic)
-ATOMIC_OP(or,  |=, orr)
-ATOMIC_OP(xor, ^=, eor)
+#define atomic_fetch_or atomic_fetch_or
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(andnot, &= ~, bic)
+ATOMIC_OPS(or,  |=, orr)
+ATOMIC_OPS(xor, ^=, eor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
@@ -317,24 +368,61 @@ atomic64_##op##_return_relaxed(long long
 	return result;							\
 }
 
+#define ATOMIC64_FETCH_OP(op, op1, op2)					\
+static inline long long							\
+atomic64_fetch_##op##_relaxed(long long i, atomic64_t *v)		\
+{									\
+	long long result, val;						\
+	unsigned long tmp;						\
+									\
+	prefetchw(&v->counter);						\
+									\
+	__asm__ __volatile__("@ atomic64_fetch_" #op "\n"		\
+"1:	ldrexd	%0, %H0, [%4]\n"					\
+"	" #op1 " %Q1, %Q0, %Q5\n"					\
+"	" #op2 " %R1, %R0, %R5\n"					\
+"	strexd	%2, %1, %H0, [%4]\n"					\
+"	teq	%2, #0\n"						\
+"	bne	1b"							\
+	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Qo" (v->counter)	\
+	: "r" (&v->counter), "r" (i)					\
+	: "cc");							\
+									\
+	return result;							\
+}
+
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
-	ATOMIC64_OP_RETURN(op, op1, op2)
+	ATOMIC64_OP_RETURN(op, op1, op2)				\
+	ATOMIC64_FETCH_OP(op, op1, op2)
 
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
 
 #define atomic64_add_return_relaxed	atomic64_add_return_relaxed
 #define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, op1, op2)					\
+	ATOMIC64_OP(op, op1, op2)					\
+	ATOMIC64_FETCH_OP(op, op1, op2)
 
 #define atomic64_andnot atomic64_andnot
 
-ATOMIC64_OP(and, and, and)
-ATOMIC64_OP(andnot, bic, bic)
-ATOMIC64_OP(or,  orr, orr)
-ATOMIC64_OP(xor, eor, eor)
+ATOMIC64_OPS(and, and, and)
+ATOMIC64_OPS(andnot, bic, bic)
+ATOMIC64_OPS(or,  orr, orr)
+ATOMIC64_OPS(xor, eor, eor)
+
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
 
 #undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
