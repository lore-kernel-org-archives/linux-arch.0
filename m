From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 14/33] locking,m68k: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:39 +0200
Message-ID: <20160531102642.333689893@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-m68k.patch
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
 arch/m68k/include/asm/atomic.h |   53 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -38,6 +38,13 @@ static inline void atomic_##op(int i, at
 
 #ifdef CONFIG_RMW_INSNS
 
+/*
+ * Am I reading these CAS loops right in that %2 is the old value and the first
+ * iteration uses an uninitialized value?
+ *
+ * Would it not make sense to add: tmp = atomic_read(v); to avoid this?
+ */
+
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
 static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
@@ -53,6 +60,21 @@ static inline int atomic_##op##_return(i
 	return t;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int t, tmp;							\
+									\
+	__asm__ __volatile__(						\
+			"1:	movel %2,%1\n"				\
+			"	" #asm_op "l %3,%1\n"			\
+			"	casl %2,%1,%0\n"			\
+			"	jne 1b"					\
+			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
+			: "g" (i), "2" (atomic_read(v)));		\
+	return tmp;							\
+}
+
 #else
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
@@ -68,20 +90,43 @@ static inline int atomic_##op##_return(i
 	return t;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+{									\
+	unsigned long flags;						\
+	int t;								\
+									\
+	local_irq_save(flags);						\
+	t = v->counter;							\
+	v->counter c_op i;						\
+	local_irq_restore(flags);					\
+									\
+	return t;							\
+}
+
 #endif /* CONFIG_RMW_INSNS */
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-ATOMIC_OP(and, &=, and)
-ATOMIC_OP(or, |=, or)
-ATOMIC_OP(xor, ^=, eor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+#define atomic_fetch_or atomic_fetch_or
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, eor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
