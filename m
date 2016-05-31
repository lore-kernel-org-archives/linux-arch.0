From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 16/33] locking,mips: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:41 +0200
Message-ID: <20160531102642.455488921@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48585 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbcEaK3w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:29:52 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-mips.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h |  138 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 9 deletions(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -66,7 +66,7 @@ static __inline__ void atomic_##op(int i
 			"	" #asm_op " %0, %2			\n"   \
 			"	sc	%0, %1				\n"   \
 			"	.set	mips0				\n"   \
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  \
 			: "Ir" (i));					      \
 		} while (unlikely(!temp));				      \
 	} else {							      \
@@ -130,18 +130,78 @@ static __inline__ int atomic_##op##_retu
 	return result;							      \
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				      \
+static __inline__ int atomic_fetch_##op(int i, atomic_t * v)		      \
+{									      \
+	int result;							      \
+									      \
+	smp_mb__before_llsc();						      \
+									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		int temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	ll	%1, %2		# atomic_fetch_" #op "	\n"   \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	sc	%0, %2					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	move	%0, %1					\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (result), "=&r" (temp),				      \
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		int temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			"	ll	%1, %2	# atomic_fetch_" #op "	\n"   \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	sc	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
+			: "Ir" (i));					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp;						      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		result = v->counter;					      \
+		v->counter c_op i;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+									      \
+	smp_llsc_mb();							      \
+									      \
+	return result;							      \
+}
+
 #define ATOMIC_OPS(op, c_op, asm_op)					      \
 	ATOMIC_OP(op, c_op, asm_op)					      \
-	ATOMIC_OP_RETURN(op, c_op, asm_op)
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				      \
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
 
-ATOMIC_OP(and, &=, and)
-ATOMIC_OP(or, |=, or)
-ATOMIC_OP(xor, ^=, xor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					      \
+	ATOMIC_OP(op, c_op, asm_op)					      \
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
@@ -414,17 +474,77 @@ static __inline__ long atomic64_##op##_r
 	return result;							      \
 }
 
+#define ATOMIC64_FETCH_OP(op, c_op, asm_op)				      \
+static __inline__ long atomic64_fetch_##op(long i, atomic64_t * v)	      \
+{									      \
+	long result;							      \
+									      \
+	smp_mb__before_llsc();						      \
+									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		long temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	lld	%1, %2		# atomic64_fetch_" #op "\n"   \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	scd	%0, %2					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	move	%0, %1					\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (result), "=&r" (temp),				      \
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		long temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			"	lld	%1, %2	# atomic64_fetch_" #op "\n"   \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	scd	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "=" GCC_OFF_SMALL_ASM() (v->counter)		      \
+			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
+			: "memory");					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp;						      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		result = v->counter;					      \
+		v->counter c_op i;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+									      \
+	smp_llsc_mb();							      \
+									      \
+	return result;							      \
+}
+
 #define ATOMIC64_OPS(op, c_op, asm_op)					      \
 	ATOMIC64_OP(op, c_op, asm_op)					      \
-	ATOMIC64_OP_RETURN(op, c_op, asm_op)
+	ATOMIC64_OP_RETURN(op, c_op, asm_op)				      \
+	ATOMIC64_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC64_OPS(add, +=, daddu)
 ATOMIC64_OPS(sub, -=, dsubu)
-ATOMIC64_OP(and, &=, and)
-ATOMIC64_OP(or, |=, or)
-ATOMIC64_OP(xor, ^=, xor)
 
 #undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, c_op, asm_op)					      \
+	ATOMIC64_OP(op, c_op, asm_op)					      \
+	ATOMIC64_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC64_OPS(and, &=, and)
+ATOMIC64_OPS(or, |=, or)
+ATOMIC64_OPS(xor, ^=, xor)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
