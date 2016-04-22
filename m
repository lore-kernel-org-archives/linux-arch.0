From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 03/31] locking,arc: Implement atomic_fetch_{add,sub,and,andnot,or,xor}()
Date: Fri, 22 Apr 2016 11:04:16 +0200
Message-ID: <20160422093923.218866387@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35044 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbcDVJm7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 05:42:59 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-arc.patch
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
 arch/arc/include/asm/atomic.h |   69 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -102,6 +102,38 @@ static inline int atomic_##op##_return(i
 	return val;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned int val, result;			                \
+	SCOND_FAIL_RETRY_VAR_DEF                                        \
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[val], [%[ctr]]		\n"		\
+	"	mov %[result], %[val]			\n"		\
+	"	" #asm_op " %[val], %[val], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"						\n"		\
+	SCOND_FAIL_RETRY_ASM						\
+									\
+	: [val]	"=&r"	(val),						\
+	  [result] "=&r" (result)					\
+	  SCOND_FAIL_RETRY_VARS						\
+	: [ctr]	"r"	(&v->counter),					\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return result;							\
+}
+
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
 #ifndef CONFIG_SMP
@@ -164,23 +196,50 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+	unsigned long temp, result;					\
+									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
+	atomic_ops_lock(flags);						\
+	result = temp = v->counter;					\
+	temp c_op i;							\
+	v->counter = temp;						\
+	atomic_ops_unlock(flags);					\
+									\
+	return result;							\
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
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 #undef SCOND_FAIL_RETRY_VAR_DEF
