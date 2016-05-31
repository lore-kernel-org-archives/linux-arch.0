From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 05/33] arm64: atomic: generate LSE non-return cases using common macros
Date: Tue, 31 May 2016 12:19:30 +0200
Message-ID: <20160531102641.765871260@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=will_deacon-arm64-atomic__generate_lse_non-return_cases_using_common_macros.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

atomic[64]_{add,and,andnot,or,xor} all follow the same patterns, so
generate them using macros, like we do for the LL/SC case already.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1461344493-8262-1-git-send-email-will.deacon@arm.com
---
 arch/arm64/include/asm/atomic_lse.h |  122 +++++++++---------------------------
 1 file changed, 32 insertions(+), 90 deletions(-)

--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -26,54 +26,25 @@
 #endif
 
 #define __LL_SC_ATOMIC(op)	__LL_SC_CALL(atomic_##op)
-
-static inline void atomic_andnot(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(andnot),
-	"	stclr	%w[i], %[v]\n")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
-
-static inline void atomic_or(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(or),
-	"	stset	%w[i], %[v]\n")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+#define ATOMIC_OP(op, asm_op)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(op),		\
+"	" #asm_op "	%w[i], %[v]\n")					\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS);						\
 }
 
-static inline void atomic_xor(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
+ATOMIC_OP(andnot, stclr)
+ATOMIC_OP(or, stset)
+ATOMIC_OP(xor, steor)
+ATOMIC_OP(add, stadd)
 
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(xor),
-	"	steor	%w[i], %[v]\n")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
-
-static inline void atomic_add(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(add),
-	"	stadd	%w[i], %[v]\n")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
+#undef ATOMIC_OP
 
 #define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
 static inline int atomic_add_return##name(int i, atomic_t *v)		\
@@ -167,54 +138,25 @@ ATOMIC_OP_SUB_RETURN(        , al, "memo
 #undef __LL_SC_ATOMIC
 
 #define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(atomic64_##op)
-
-static inline void atomic64_andnot(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(andnot),
-	"	stclr	%[i], %[v]\n")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
-
-static inline void atomic64_or(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(or),
-	"	stset	%[i], %[v]\n")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
-
-static inline void atomic64_xor(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(xor),
-	"	steor	%[i], %[v]\n")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+#define ATOMIC64_OP(op, asm_op)						\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
+{									\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(op),	\
+"	" #asm_op "	%[i], %[v]\n")					\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: __LL_SC_CLOBBERS);						\
 }
 
-static inline void atomic64_add(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
+ATOMIC64_OP(andnot, stclr)
+ATOMIC64_OP(or, stset)
+ATOMIC64_OP(xor, steor)
+ATOMIC64_OP(add, stadd)
 
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(add),
-	"	stadd	%[i], %[v]\n")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
-}
+#undef ATOMIC64_OP
 
 #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
 static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
