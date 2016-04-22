From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 14/31] locking,metag: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:27 +0200
Message-ID: <20160422093923.941873289@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-metag.patch
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
 arch/metag/include/asm/atomic.h        |    2 +
 arch/metag/include/asm/atomic_lnkget.h |   36 +++++++++++++++++++++++++++++----
 arch/metag/include/asm/atomic_lock1.h  |   33 ++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 8 deletions(-)

--- a/arch/metag/include/asm/atomic.h
+++ b/arch/metag/include/asm/atomic.h
@@ -17,6 +17,8 @@
 #include <asm/atomic_lnkget.h>
 #endif
 
+#define atomic_fetch_or atomic_fetch_or
+
 #define atomic_add_negative(a, v)       (atomic_add_return((a), (v)) < 0)
 
 #define atomic_dec_return(v) atomic_sub_return(1, (v))
--- a/arch/metag/include/asm/atomic_lnkget.h
+++ b/arch/metag/include/asm/atomic_lnkget.h
@@ -69,16 +69,44 @@ static inline int atomic_##op##_return(i
 	return result;							\
 }
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int result, temp;						\
+									\
+	smp_mb();							\
+									\
+	asm volatile (							\
+		"1:	LNKGETD %1, [%2]\n"				\
+		"	" #op "	%0, %1, %3\n"				\
+		"	LNKSETD [%2], %0\n"				\
+		"	DEFR	%0, TXSTAT\n"				\
+		"	ANDT	%0, %0, #HI(0x3f000000)\n"		\
+		"	CMPT	%0, #HI(0x02000000)\n"			\
+		"	BNZ 1b\n"					\
+		: "=&d" (temp), "=&da" (result)				\
+		: "da" (&v->counter), "bd" (i)				\
+		: "cc");						\
+									\
+	smp_mb();							\
+									\
+	return result;							\
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
 
--- a/arch/metag/include/asm/atomic_lock1.h
+++ b/arch/metag/include/asm/atomic_lock1.h
@@ -64,15 +64,40 @@ static inline int atomic_##op##_return(i
 	return result;							\
 }
 
-#define ATOMIC_OPS(op, c_op) ATOMIC_OP(op, c_op) ATOMIC_OP_RETURN(op, c_op)
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long result;						\
+	unsigned long flags;						\
+									\
+	__global_lock1(flags);						\
+	result = v->counter;						\
+	fence();							\
+	v->counter c_op i;						\
+	__global_unlock1(flags);					\
+									\
+	return result;							\
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
 
