From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 06/33] locking,arm64: Implement atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}() for LSE instructions
Date: Tue, 31 May 2016 12:19:31 +0200
Message-ID: <20160531102641.825770912@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=will_deacon-lockingarm64-implement_atomic64_fetch_addsubandandnotorxor_relaxed_acquire_release_for_lse_instructions.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

This patch implements the LSE variants.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1461344493-8262-2-git-send-email-will.deacon@arm.com
---
 arch/arm64/include/asm/atomic_lse.h |  172 ++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -46,6 +46,38 @@ ATOMIC_OP(add, stadd)
 
 #undef ATOMIC_OP
 
+#define ATOMIC_FETCH_OP(name, mb, op, asm_op, cl...)			\
+static inline int atomic_fetch_##op##name(int i, atomic_t *v)		\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	__LL_SC_ATOMIC(fetch_##op##name),				\
+	/* LSE atomics */						\
+"	" #asm_op #mb "	%w[i], %w[i], %[v]")				\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return w0;							\
+}
+
+#define ATOMIC_FETCH_OPS(op, asm_op)					\
+	ATOMIC_FETCH_OP(_relaxed,   , op, asm_op)			\
+	ATOMIC_FETCH_OP(_acquire,  a, op, asm_op, "memory")		\
+	ATOMIC_FETCH_OP(_release,  l, op, asm_op, "memory")		\
+	ATOMIC_FETCH_OP(        , al, op, asm_op, "memory")
+
+ATOMIC_FETCH_OPS(andnot, ldclr)
+ATOMIC_FETCH_OPS(or, ldset)
+ATOMIC_FETCH_OPS(xor, ldeor)
+ATOMIC_FETCH_OPS(add, ldadd)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_FETCH_OPS
+
 #define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
 static inline int atomic_add_return##name(int i, atomic_t *v)		\
 {									\
@@ -90,6 +122,33 @@ static inline void atomic_and(int i, ato
 	: __LL_SC_CLOBBERS);
 }
 
+#define ATOMIC_FETCH_OP_AND(name, mb, cl...)				\
+static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC(fetch_and##name),				\
+	/* LSE atomics */						\
+	"	mvn	%w[i], %w[i]\n"					\
+	"	ldclr" #mb "	%w[i], %w[i], %[v]")			\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return w0;							\
+}
+
+ATOMIC_FETCH_OP_AND(_relaxed,   )
+ATOMIC_FETCH_OP_AND(_acquire,  a, "memory")
+ATOMIC_FETCH_OP_AND(_release,  l, "memory")
+ATOMIC_FETCH_OP_AND(        , al, "memory")
+
+#undef ATOMIC_FETCH_OP_AND
+
 static inline void atomic_sub(int i, atomic_t *v)
 {
 	register int w0 asm ("w0") = i;
@@ -135,6 +194,33 @@ ATOMIC_OP_SUB_RETURN(_release,  l, "memo
 ATOMIC_OP_SUB_RETURN(        , al, "memory")
 
 #undef ATOMIC_OP_SUB_RETURN
+
+#define ATOMIC_FETCH_OP_SUB(name, mb, cl...)				\
+static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC(fetch_sub##name),				\
+	/* LSE atomics */						\
+	"	neg	%w[i], %w[i]\n"					\
+	"	ldadd" #mb "	%w[i], %w[i], %[v]")			\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return w0;							\
+}
+
+ATOMIC_FETCH_OP_SUB(_relaxed,   )
+ATOMIC_FETCH_OP_SUB(_acquire,  a, "memory")
+ATOMIC_FETCH_OP_SUB(_release,  l, "memory")
+ATOMIC_FETCH_OP_SUB(        , al, "memory")
+
+#undef ATOMIC_FETCH_OP_SUB
 #undef __LL_SC_ATOMIC
 
 #define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(atomic64_##op)
@@ -158,6 +244,38 @@ ATOMIC64_OP(add, stadd)
 
 #undef ATOMIC64_OP
 
+#define ATOMIC64_FETCH_OP(name, mb, op, asm_op, cl...)			\
+static inline long atomic64_fetch_##op##name(long i, atomic64_t *v)	\
+{									\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	__LL_SC_ATOMIC64(fetch_##op##name),				\
+	/* LSE atomics */						\
+"	" #asm_op #mb "	%[i], %[i], %[v]")				\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return x0;							\
+}
+
+#define ATOMIC64_FETCH_OPS(op, asm_op)					\
+	ATOMIC64_FETCH_OP(_relaxed,   , op, asm_op)			\
+	ATOMIC64_FETCH_OP(_acquire,  a, op, asm_op, "memory")		\
+	ATOMIC64_FETCH_OP(_release,  l, op, asm_op, "memory")		\
+	ATOMIC64_FETCH_OP(        , al, op, asm_op, "memory")
+
+ATOMIC64_FETCH_OPS(andnot, ldclr)
+ATOMIC64_FETCH_OPS(or, ldset)
+ATOMIC64_FETCH_OPS(xor, ldeor)
+ATOMIC64_FETCH_OPS(add, ldadd)
+
+#undef ATOMIC64_FETCH_OP
+#undef ATOMIC64_FETCH_OPS
+
 #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
 static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
 {									\
@@ -202,6 +320,33 @@ static inline void atomic64_and(long i,
 	: __LL_SC_CLOBBERS);
 }
 
+#define ATOMIC64_FETCH_OP_AND(name, mb, cl...)				\
+static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
+{									\
+	register long x0 asm ("w0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC64(fetch_and##name),				\
+	/* LSE atomics */						\
+	"	mvn	%[i], %[i]\n"					\
+	"	ldclr" #mb "	%[i], %[i], %[v]")			\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return x0;							\
+}
+
+ATOMIC64_FETCH_OP_AND(_relaxed,   )
+ATOMIC64_FETCH_OP_AND(_acquire,  a, "memory")
+ATOMIC64_FETCH_OP_AND(_release,  l, "memory")
+ATOMIC64_FETCH_OP_AND(        , al, "memory")
+
+#undef ATOMIC64_FETCH_OP_AND
+
 static inline void atomic64_sub(long i, atomic64_t *v)
 {
 	register long x0 asm ("x0") = i;
@@ -248,6 +393,33 @@ ATOMIC64_OP_SUB_RETURN(        , al, "me
 
 #undef ATOMIC64_OP_SUB_RETURN
 
+#define ATOMIC64_FETCH_OP_SUB(name, mb, cl...)				\
+static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
+{									\
+	register long x0 asm ("w0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC64(fetch_sub##name),				\
+	/* LSE atomics */						\
+	"	neg	%[i], %[i]\n"					\
+	"	ldadd" #mb "	%[i], %[i], %[v]")			\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS, ##cl);					\
+									\
+	return x0;							\
+}
+
+ATOMIC64_FETCH_OP_SUB(_relaxed,   )
+ATOMIC64_FETCH_OP_SUB(_acquire,  a, "memory")
+ATOMIC64_FETCH_OP_SUB(_release,  l, "memory")
+ATOMIC64_FETCH_OP_SUB(        , al, "memory")
+
+#undef ATOMIC64_FETCH_OP_SUB
+
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
 	register long x0 asm ("x0") = (long)v;
