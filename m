From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 20/31] locking,sh: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:33 +0200
Message-ID: <20160422093924.347316540@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-sh.patch
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
 arch/sh/include/asm/atomic-grb.h  |   34 ++++++++++++++++++++++++++++++----
 arch/sh/include/asm/atomic-irq.h  |   31 +++++++++++++++++++++++++++----
 arch/sh/include/asm/atomic-llsc.h |   32 ++++++++++++++++++++++++++++----
 arch/sh/include/asm/atomic.h      |    2 ++
 4 files changed, 87 insertions(+), 12 deletions(-)

--- a/arch/sh/include/asm/atomic-grb.h
+++ b/arch/sh/include/asm/atomic-grb.h
@@ -43,16 +43,42 @@ static inline int atomic_##op##_return(i
 	return tmp;							\
 }
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int res, tmp;							\
+									\
+	__asm__ __volatile__ (						\
+		"   .align 2              \n\t"				\
+		"   mova    1f,   r0      \n\t" /* r0 = end point */	\
+		"   mov    r15,   r1      \n\t" /* r1 = saved sp */	\
+		"   mov    #-6,   r15     \n\t" /* LOGIN: r15 = size */	\
+		"   mov.l  @%2,   %0      \n\t" /* load old value */	\
+		"   mov     %0,   %1      \n\t" /* save old value */	\
+		" " #op "   %3,   %0      \n\t" /* $op */		\
+		"   mov.l   %0,   @%2     \n\t" /* store new value */	\
+		"1: mov     r1,   r15     \n\t" /* LOGOUT */		\
+		: "=&r" (tmp), "=&r" (res), "+r"  (v)			\
+		: "r"   (i)						\
+		: "memory" , "r0", "r1");				\
+									\
+	return res;							\
+}
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
--- a/arch/sh/include/asm/atomic-irq.h
+++ b/arch/sh/include/asm/atomic-irq.h
@@ -33,15 +33,38 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
-#define ATOMIC_OPS(op, c_op) ATOMIC_OP(op, c_op) ATOMIC_OP_RETURN(op, c_op)
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long temp, flags;					\
+									\
+	raw_local_irq_save(flags);					\
+	temp = v->counter;						\
+	v->counter c_op i;						\
+	raw_local_irq_restore(flags);					\
+									\
+	return temp;							\
+}
+
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op, c_op)						\
+	ATOMIC_OP_RETURN(op, c_op)					\
+	ATOMIC_FETCH_OP(op, c_op)
 
 ATOMIC_OPS(add, +=)
 ATOMIC_OPS(sub, -=)
-ATOMIC_OP(and, &=)
-ATOMIC_OP(or, |=)
-ATOMIC_OP(xor, ^=)
 
 #undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op)						\
+	ATOMIC_OP(op, c_op)						\
+	ATOMIC_FETCH_OP(op, c_op)
+
+ATOMIC_OPS(and, &=)
+ATOMIC_OPS(or, |=)
+ATOMIC_OPS(xor, ^=)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -48,15 +48,39 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long res, temp;					\
+									\
+	__asm__ __volatile__ (						\
+"1:	movli.l @%3, %0		! atomic_fetch_" #op "	\n"		\
+"	mov %0, %1					\n"		\
+"	" #op "	%2, %0					\n"		\
+"	movco.l	%0, @%3					\n"		\
+"	bf	1b					\n"		\
+"	synco						\n"		\
+	: "=&z" (temp), "=&z" (res)					\
+	: "r" (i), "r" (&v->counter)					\
+	: "t");								\
+									\
+	return res;							\
+}
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -25,6 +25,8 @@
 #include <asm/atomic-irq.h>
 #endif
 
+#define atomic_fetch_or atomic_fetch_or
+
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
