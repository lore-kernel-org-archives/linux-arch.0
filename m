From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 02/33] locking,arc: Implement atomic_fetch_{add,sub,and,andnot,or,xor}()
Date: Tue, 31 May 2016 12:19:27 +0200
Message-ID: <20160531102641.582308264@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-arc.patch
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

Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/atomic.h |  103 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 9 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -104,6 +104,37 @@ static inline int atomic_##op##_return(i
 	return val;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned int val, orig;						\
+	SCOND_FAIL_RETRY_VAR_DEF                                        \
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[orig], [%[ctr]]		\n"		\
+	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"						\n"		\
+	SCOND_FAIL_RETRY_ASM						\
+									\
+	: [val]	"=&r"	(val),						\
+	  [orig] "=&r" (orig)						\
+	  SCOND_FAIL_RETRY_VARS						\
+	: [ctr]	"r"	(&v->counter),					\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return orig;							\
+}
+
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
 #ifndef CONFIG_SMP
@@ -166,21 +197,46 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+	unsigned long orig;						\
+									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
+	atomic_ops_lock(flags);						\
+	orig = v->counter;						\
+	v->counter c_op i;						\
+	atomic_ops_unlock(flags);					\
+									\
+	return orig;							\
+}
+
 #endif /* !CONFIG_ARC_HAS_LLSC */
 
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
-ATOMIC_OP(or, |=, or)
-ATOMIC_OP(xor, ^=, xor)
+#define atomic_fetch_or atomic_fetch_or
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(andnot, &= ~, bic)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, xor)
 
 #undef SCOND_FAIL_RETRY_VAR_DEF
 #undef SCOND_FAIL_RETRY_ASM
@@ -245,22 +301,51 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned int temp = i;						\
+									\
+	/* Explicit full memory barrier needed before/after */		\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"	mov r2, %0\n"						\
+	"	mov r3, %1\n"						\
+	"       .word %2\n"						\
+	"	mov %0, r2"						\
+	: "+r"(temp)							\
+	: "r"(&v->counter), "i"(asm_op)					\
+	: "r2", "r3", "memory");					\
+									\
+	smp_mb();							\
+									\
+	return temp;							\
+}
+
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, CTOP_INST_AADD_DI_R2_R2_R3)
 #define atomic_sub(i, v) atomic_add(-(i), (v))
 #define atomic_sub_return(i, v) atomic_add_return(-(i), (v))
 
-ATOMIC_OP(and, &=, CTOP_INST_AAND_DI_R2_R2_R3)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, CTOP_INST_AAND_DI_R2_R2_R3)
 #define atomic_andnot(mask, v) atomic_and(~(mask), (v))
-ATOMIC_OP(or, |=, CTOP_INST_AOR_DI_R2_R2_R3)
-ATOMIC_OP(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
+ATOMIC_OPS(or, |=, CTOP_INST_AOR_DI_R2_R2_R3)
+ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
 
 #endif /* CONFIG_ARC_PLAT_EZNPS */
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
