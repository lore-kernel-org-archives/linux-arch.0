From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 07/33] locking,avr32: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:32 +0200
Message-ID: <20160531102641.887302747@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48591 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbcEaK3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:29:54 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-avr32.patch
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

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/avr32/include/asm/atomic.h |   56 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

--- a/arch/avr32/include/asm/atomic.h
+++ b/arch/avr32/include/asm/atomic.h
@@ -41,21 +41,51 @@ static inline int __atomic_##op##_return
 	return result;							\
 }
 
+#define ATOMIC_FETCH_OP(op, asm_op, asm_con)				\
+static inline int __atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	int result, val;						\
+									\
+	asm volatile(							\
+		"/* atomic_fetch_" #op " */\n"				\
+		"1:	ssrf	5\n"					\
+		"	ld.w	%0, %3\n"				\
+		"	mov	%1, %0\n"				\
+		"	" #asm_op "	%1, %4\n"			\
+		"	stcond	%2, %1\n"				\
+		"	brne	1b"					\
+		: "=&r" (result), "=&r" (val), "=o" (v->counter)	\
+		: "m" (v->counter), #asm_con (i)			\
+		: "cc");						\
+									\
+	return result;							\
+}
+
 ATOMIC_OP_RETURN(sub, sub, rKs21)
 ATOMIC_OP_RETURN(add, add, r)
+ATOMIC_FETCH_OP (sub, sub, rKs21)
+ATOMIC_FETCH_OP (add, add, r)
 
-#define ATOMIC_OP(op, asm_op)						\
+#define atomic_fetch_or atomic_fetch_or
+
+#define ATOMIC_OPS(op, asm_op)						\
 ATOMIC_OP_RETURN(op, asm_op, r)						\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
 	(void)__atomic_##op##_return(i, v);				\
+}									\
+ATOMIC_FETCH_OP(op, asm_op, r)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)		\
+{									\
+	return __atomic_fetch_##op(i, v);				\
 }
 
-ATOMIC_OP(and, and)
-ATOMIC_OP(or, or)
-ATOMIC_OP(xor, eor)
+ATOMIC_OPS(and, and)
+ATOMIC_OPS(or, or)
+ATOMIC_OPS(xor, eor)
 
-#undef ATOMIC_OP
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
 /*
@@ -87,6 +117,14 @@ static inline int atomic_add_return(int
 	return __atomic_add_return(i, v);
 }
 
+static inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	if (IS_21BIT_CONST(i))
+		return __atomic_fetch_sub(-i, v);
+
+	return __atomic_fetch_add(i, v);
+}
+
 /*
  * atomic_sub_return - subtract the atomic variable
  * @i: integer value to subtract
@@ -102,6 +140,14 @@ static inline int atomic_sub_return(int
 	return __atomic_add_return(-i, v);
 }
 
+static inline int atomic_fetch_sub(int i, atomic_t *v)
+{
+	if (IS_21BIT_CONST(i))
+		return __atomic_fetch_sub(i, v);
+
+	return __atomic_fetch_add(-i, v);
+}
+
 /*
  * __atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
