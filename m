From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 19/33] locking,powerpc: Implement atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Tue, 31 May 2016 12:19:44 +0200
Message-ID: <20160531102642.648971209@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-powerpc.patch
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
 arch/powerpc/include/asm/atomic.h |   83 +++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 9 deletions(-)

--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -78,21 +78,53 @@ static inline int atomic_##op##_return_r
 	return t;							\
 }
 
+#define ATOMIC_FETCH_OP_RELAXED(op, asm_op)				\
+static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
+{									\
+	int res, t;							\
+									\
+	__asm__ __volatile__(						\
+"1:	lwarx	%0,0,%4		# atomic_fetch_" #op "_relaxed\n"	\
+	#asm_op " %1,%3,%0\n"						\
+	PPC405_ERR77(0, %4)						\
+"	stwcx.	%1,0,%4\n"						\
+"	bne-	1b\n"							\
+	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
+	: "r" (a), "r" (&v->counter)					\
+	: "cc");							\
+									\
+	return res;							\
+}
+
 #define ATOMIC_OPS(op, asm_op)						\
 	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_OP_RETURN_RELAXED(op, asm_op)
+	ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
+	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
 
 ATOMIC_OPS(add, add)
 ATOMIC_OPS(sub, subf)
 
-ATOMIC_OP(and, and)
-ATOMIC_OP(or, or)
-ATOMIC_OP(xor, xor)
-
 #define atomic_add_return_relaxed atomic_add_return_relaxed
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
 
+#define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, asm_op)						\
+	ATOMIC_OP(op, asm_op)						\
+	ATOMIC_FETCH_OP_RELAXED(op, asm_op)
+
+ATOMIC_OPS(and, and)
+ATOMIC_OPS(or, or)
+ATOMIC_OPS(xor, xor)
+
+#define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
+#define atomic_fetch_or_relaxed  atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
+
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP_RELAXED
 #undef ATOMIC_OP_RETURN_RELAXED
 #undef ATOMIC_OP
 
@@ -329,20 +361,53 @@ atomic64_##op##_return_relaxed(long a, a
 	return t;							\
 }
 
+#define ATOMIC64_FETCH_OP_RELAXED(op, asm_op)				\
+static inline long							\
+atomic64_fetch_##op##_relaxed(long a, atomic64_t *v)			\
+{									\
+	long res, t;							\
+									\
+	__asm__ __volatile__(						\
+"1:	ldarx	%0,0,%4		# atomic64_fetch_" #op "_relaxed\n"	\
+	#asm_op " %1,%3,%0\n"						\
+"	stdcx.	%1,0,%4\n"						\
+"	bne-	1b\n"							\
+	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
+	: "r" (a), "r" (&v->counter)					\
+	: "cc");							\
+									\
+	return t;							\
+}
+
 #define ATOMIC64_OPS(op, asm_op)					\
 	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)
+	ATOMIC64_OP_RETURN_RELAXED(op, asm_op)				\
+	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
 
 ATOMIC64_OPS(add, add)
 ATOMIC64_OPS(sub, subf)
-ATOMIC64_OP(and, and)
-ATOMIC64_OP(or, or)
-ATOMIC64_OP(xor, xor)
 
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
 
+#define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, asm_op)					\
+	ATOMIC64_OP(op, asm_op)						\
+	ATOMIC64_FETCH_OP_RELAXED(op, asm_op)
+
+ATOMIC64_OPS(and, and)
+ATOMIC64_OPS(or, or)
+ATOMIC64_OPS(xor, xor)
+
+#define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
+#define atomic64_fetch_or_relaxed  atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
+
 #undef ATOPIC64_OPS
+#undef ATOMIC64_FETCH_OP_RELAXED
 #undef ATOMIC64_OP_RETURN_RELAXED
 #undef ATOMIC64_OP
 
