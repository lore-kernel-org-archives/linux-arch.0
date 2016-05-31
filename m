From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 24/33] locking,x86: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:49 +0200
Message-ID: <20160531102642.956228388@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-x86.patch
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
 arch/x86/include/asm/atomic.h      |   37 ++++++++++++++++++++++++++++++++++---
 arch/x86/include/asm/atomic64_32.h |   25 ++++++++++++++++++++++---
 arch/x86/include/asm/atomic64_64.h |   35 ++++++++++++++++++++++++++++++++---
 3 files changed, 88 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -171,6 +171,16 @@ static __always_inline int atomic_sub_re
 #define atomic_inc_return(v)  (atomic_add_return(1, v))
 #define atomic_dec_return(v)  (atomic_sub_return(1, v))
 
+static __always_inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	return xadd(&v->counter, i);
+}
+
+static __always_inline int atomic_fetch_sub(int i, atomic_t *v)
+{
+	return xadd(&v->counter, -i);
+}
+
 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return cmpxchg(&v->counter, old, new);
@@ -190,10 +200,31 @@ static inline void atomic_##op(int i, at
 			: "memory");					\
 }
 
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	int old, val = atomic_read(v);					\
+	for (;;) {							\
+		old = atomic_cmpxchg(v, val, val c_op i);		\
+		if (old == val)						\
+			break;						\
+		val = old;						\
+	}								\
+	return old;							\
+}
+
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op)							\
+	ATOMIC_FETCH_OP(op, c_op)
+
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and, &)
+ATOMIC_OPS(or , |)
+ATOMIC_OPS(xor, ^)
 
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP
 
 /**
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -320,10 +320,29 @@ static inline void atomic64_##op(long lo
 		c = old;						\
 }
 
-ATOMIC64_OP(and, &)
-ATOMIC64_OP(or, |)
-ATOMIC64_OP(xor, ^)
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline long long atomic64_fetch_##op(long long i, atomic64_t *v)	\
+{									\
+	long long old, c = 0;						\
+	while ((old = atomic64_cmpxchg(v, c, c c_op i)) != c)		\
+		c = old;						\
+	return old;							\
+}
+
+ATOMIC64_FETCH_OP(add, +)
+
+#define atomic64_fetch_sub(i, v)	atomic64_fetch_add(-(i), (v))
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &)
+ATOMIC64_OPS(or, |)
+ATOMIC64_OPS(xor, ^)
 
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP
 
 #endif /* _ASM_X86_ATOMIC64_32_H */
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -158,6 +158,16 @@ static inline long atomic64_sub_return(l
 	return atomic64_add_return(-i, v);
 }
 
+static inline long atomic64_fetch_add(long i, atomic64_t *v)
+{
+	return xadd(&v->counter, i);
+}
+
+static inline long atomic64_fetch_sub(long i, atomic64_t *v)
+{
+	return xadd(&v->counter, -i);
+}
+
 #define atomic64_inc_return(v)  (atomic64_add_return(1, (v)))
 #define atomic64_dec_return(v)  (atomic64_sub_return(1, (v)))
 
@@ -229,10 +239,29 @@ static inline void atomic64_##op(long i,
 			: "memory");					\
 }
 
-ATOMIC64_OP(and)
-ATOMIC64_OP(or)
-ATOMIC64_OP(xor)
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static inline long atomic64_fetch_##op(long i, atomic64_t *v)		\
+{									\
+	long old, val = atomic64_read(v);				\
+	for (;;) {							\
+		old = atomic64_cmpxchg(v, val, val c_op i);		\
+		if (old == val)						\
+			break;						\
+		val = old;						\
+	}								\
+	return old;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op)							\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(and, &)
+ATOMIC64_OPS(or, |)
+ATOMIC64_OPS(xor, ^)
 
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP
 
 #endif /* _ASM_X86_ATOMIC64_64_H */
