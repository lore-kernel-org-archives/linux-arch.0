From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 12/33] locking,ia64: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:37 +0200
Message-ID: <20160531102642.211598727@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-ia64.patch
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
 arch/ia64/include/asm/atomic.h |  134 +++++++++++++++++++++++++++++++++++------
 1 file changed, 116 insertions(+), 18 deletions(-)

--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -42,8 +42,27 @@ ia64_atomic_##op (int i, atomic_t *v)
 	return new;							\
 }
 
-ATOMIC_OP(add, +)
-ATOMIC_OP(sub, -)
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static __inline__ int							\
+ia64_atomic_fetch_##op (int i, atomic_t *v)				\
+{									\
+	__s32 old, new;							\
+	CMPXCHG_BUGCHECK_DECL						\
+									\
+	do {								\
+		CMPXCHG_BUGCHECK(v);					\
+		old = atomic_read(v);					\
+		new = old c_op i;					\
+	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic_t)) != old); \
+	return old;							\
+}
+
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op, c_op)						\
+	ATOMIC_FETCH_OP(op, c_op)
+
+ATOMIC_OPS(add, +)
+ATOMIC_OPS(sub, -)
 
 #define atomic_add_return(i,v)						\
 ({									\
@@ -69,14 +88,44 @@ ATOMIC_OP(sub, -)
 		: ia64_atomic_sub(__ia64_asr_i, v);			\
 })
 
-ATOMIC_OP(and, &)
-ATOMIC_OP(or, |)
-ATOMIC_OP(xor, ^)
-
-#define atomic_and(i,v)	(void)ia64_atomic_and(i,v)
-#define atomic_or(i,v)	(void)ia64_atomic_or(i,v)
-#define atomic_xor(i,v)	(void)ia64_atomic_xor(i,v)
+#define atomic_fetch_add(i,v)						\
+({									\
+	int __ia64_aar_i = (i);						\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_aar_i ==  1) || (__ia64_aar_i ==   4)		\
+	     || (__ia64_aar_i ==  8) || (__ia64_aar_i ==  16)		\
+	     || (__ia64_aar_i == -1) || (__ia64_aar_i ==  -4)		\
+	     || (__ia64_aar_i == -8) || (__ia64_aar_i == -16)))		\
+		? ia64_fetchadd(__ia64_aar_i, &(v)->counter, acq)	\
+		: ia64_atomic_fetch_add(__ia64_aar_i, v);		\
+})
+
+#define atomic_fetch_sub(i,v)						\
+({									\
+	int __ia64_asr_i = (i);						\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_asr_i ==   1) || (__ia64_asr_i ==   4)		\
+	     || (__ia64_asr_i ==   8) || (__ia64_asr_i ==  16)		\
+	     || (__ia64_asr_i ==  -1) || (__ia64_asr_i ==  -4)		\
+	     || (__ia64_asr_i ==  -8) || (__ia64_asr_i == -16)))	\
+		? ia64_fetchadd(-__ia64_asr_i, &(v)->counter, acq)	\
+		: ia64_atomic_fetch_sub(__ia64_asr_i, v);		\
+})
 
+ATOMIC_FETCH_OP(and, &)
+ATOMIC_FETCH_OP(or, |)
+ATOMIC_FETCH_OP(xor, ^)
+
+#define atomic_and(i,v)	(void)ia64_atomic_fetch_and(i,v)
+#define atomic_or(i,v)	(void)ia64_atomic_fetch_or(i,v)
+#define atomic_xor(i,v)	(void)ia64_atomic_fetch_xor(i,v)
+
+#define atomic_fetch_and(i,v)	ia64_atomic_fetch_and(i,v)
+#define atomic_fetch_or(i,v)	ia64_atomic_fetch_or(i,v)
+#define atomic_fetch_xor(i,v)	ia64_atomic_fetch_xor(i,v)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP
 
 #define ATOMIC64_OP(op, c_op)						\
@@ -94,8 +143,27 @@ ia64_atomic64_##op (__s64 i, atomic64_t
 	return new;							\
 }
 
-ATOMIC64_OP(add, +)
-ATOMIC64_OP(sub, -)
+#define ATOMIC64_FETCH_OP(op, c_op)					\
+static __inline__ long							\
+ia64_atomic64_fetch_##op (__s64 i, atomic64_t *v)			\
+{									\
+	__s64 old, new;							\
+	CMPXCHG_BUGCHECK_DECL						\
+									\
+	do {								\
+		CMPXCHG_BUGCHECK(v);					\
+		old = atomic64_read(v);					\
+		new = old c_op i;					\
+	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic64_t)) != old); \
+	return old;							\
+}
+
+#define ATOMIC64_OPS(op, c_op)						\
+	ATOMIC64_OP(op, c_op)						\
+	ATOMIC64_FETCH_OP(op, c_op)
+
+ATOMIC64_OPS(add, +)
+ATOMIC64_OPS(sub, -)
 
 #define atomic64_add_return(i,v)					\
 ({									\
@@ -121,14 +189,44 @@ ATOMIC64_OP(sub, -)
 		: ia64_atomic64_sub(__ia64_asr_i, v);			\
 })
 
-ATOMIC64_OP(and, &)
-ATOMIC64_OP(or, |)
-ATOMIC64_OP(xor, ^)
-
-#define atomic64_and(i,v)	(void)ia64_atomic64_and(i,v)
-#define atomic64_or(i,v)	(void)ia64_atomic64_or(i,v)
-#define atomic64_xor(i,v)	(void)ia64_atomic64_xor(i,v)
+#define atomic64_fetch_add(i,v)						\
+({									\
+	long __ia64_aar_i = (i);					\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_aar_i ==  1) || (__ia64_aar_i ==   4)		\
+	     || (__ia64_aar_i ==  8) || (__ia64_aar_i ==  16)		\
+	     || (__ia64_aar_i == -1) || (__ia64_aar_i ==  -4)		\
+	     || (__ia64_aar_i == -8) || (__ia64_aar_i == -16)))		\
+		? ia64_fetchadd(__ia64_aar_i, &(v)->counter, acq)	\
+		: ia64_atomic64_fetch_add(__ia64_aar_i, v);		\
+})
+
+#define atomic64_fetch_sub(i,v)						\
+({									\
+	long __ia64_asr_i = (i);					\
+	(__builtin_constant_p(i)					\
+	 && (   (__ia64_asr_i ==   1) || (__ia64_asr_i ==   4)		\
+	     || (__ia64_asr_i ==   8) || (__ia64_asr_i ==  16)		\
+	     || (__ia64_asr_i ==  -1) || (__ia64_asr_i ==  -4)		\
+	     || (__ia64_asr_i ==  -8) || (__ia64_asr_i == -16)))	\
+		? ia64_fetchadd(-__ia64_asr_i, &(v)->counter, acq)	\
+		: ia64_atomic64_fetch_sub(__ia64_asr_i, v);		\
+})
+
+ATOMIC64_FETCH_OP(and, &)
+ATOMIC64_FETCH_OP(or, |)
+ATOMIC64_FETCH_OP(xor, ^)
+
+#define atomic64_and(i,v)	(void)ia64_atomic64_fetch_and(i,v)
+#define atomic64_or(i,v)	(void)ia64_atomic64_fetch_or(i,v)
+#define atomic64_xor(i,v)	(void)ia64_atomic64_fetch_xor(i,v)
+
+#define atomic64_fetch_and(i,v)	ia64_atomic64_fetch_and(i,v)
+#define atomic64_fetch_or(i,v)	ia64_atomic64_fetch_or(i,v)
+#define atomic64_fetch_xor(i,v)	ia64_atomic64_fetch_xor(i,v)
 
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP
 
 #define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
