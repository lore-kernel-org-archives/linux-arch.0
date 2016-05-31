From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 01/33] locking,alpha: Implement atomic{,64}_fetch_{add,sub,and,andnot,or,xor}()
Date: Tue, 31 May 2016 12:19:26 +0200
Message-ID: <20160531102641.509066876@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-alpha.patch
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
 arch/alpha/include/asm/atomic.h |   65 ++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -65,6 +65,25 @@ static inline int atomic_##op##_return(i
 	return result;							\
 }
 
+#define ATOMIC_FETCH_OP(op, asm_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	long temp, result;						\
+	smp_mb();							\
+	__asm__ __volatile__(						\
+	"1:	ldl_l %2,%1\n"						\
+	"	" #asm_op " %2,%3,%0\n"					\
+	"	stl_c %0,%1\n"						\
+	"	beq %0,2f\n"						\
+	".subsection 2\n"						\
+	"2:	br 1b\n"						\
+	".previous"							\
+	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
+	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_mb();							\
+	return result;							\
+}
+
 #define ATOMIC64_OP(op, asm_op)						\
 static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
 {									\
@@ -101,11 +120,32 @@ static __inline__ long atomic64_##op##_r
 	return result;							\
 }
 
+#define ATOMIC64_FETCH_OP(op, asm_op)					\
+static __inline__ long atomic64_fetch_##op(long i, atomic64_t * v)	\
+{									\
+	long temp, result;						\
+	smp_mb();							\
+	__asm__ __volatile__(						\
+	"1:	ldq_l %2,%1\n"						\
+	"	" #asm_op " %2,%3,%0\n"					\
+	"	stq_c %0,%1\n"						\
+	"	beq %0,2f\n"						\
+	".subsection 2\n"						\
+	"2:	br 1b\n"						\
+	".previous"							\
+	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
+	:"Ir" (i), "m" (v->counter) : "memory");			\
+	smp_mb();							\
+	return result;							\
+}
+
 #define ATOMIC_OPS(op)							\
 	ATOMIC_OP(op, op##l)						\
 	ATOMIC_OP_RETURN(op, op##l)					\
+	ATOMIC_FETCH_OP(op, op##l)					\
 	ATOMIC64_OP(op, op##q)						\
-	ATOMIC64_OP_RETURN(op, op##q)
+	ATOMIC64_OP_RETURN(op, op##q)					\
+	ATOMIC64_FETCH_OP(op, op##q)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
@@ -113,18 +153,25 @@ ATOMIC_OPS(sub)
 #define atomic_andnot atomic_andnot
 #define atomic64_andnot atomic64_andnot
 
-ATOMIC_OP(and, and)
-ATOMIC_OP(andnot, bic)
-ATOMIC_OP(or, bis)
-ATOMIC_OP(xor, xor)
-ATOMIC64_OP(and, and)
-ATOMIC64_OP(andnot, bic)
-ATOMIC64_OP(or, bis)
-ATOMIC64_OP(xor, xor)
+#define atomic_fetch_or atomic_fetch_or
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, asm)						\
+	ATOMIC_OP(op, asm)						\
+	ATOMIC_FETCH_OP(op, asm)					\
+	ATOMIC64_OP(op, asm)						\
+	ATOMIC64_FETCH_OP(op, asm)
+
+ATOMIC_OPS(and, and)
+ATOMIC_OPS(andnot, bic)
+ATOMIC_OPS(or, bis)
+ATOMIC_OPS(xor, xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
