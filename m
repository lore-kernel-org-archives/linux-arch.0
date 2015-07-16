From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 23/28] h8300: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:33 +0200
Message-ID: <20150716172926.168831201@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-h8300-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Also rework the atomic implementation in terms of CPP macros to avoid
the typical repetition -- I seem to have missed this arch the last
time around when I did that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/h8300/include/asm/atomic.h |  147 ++++++++++++----------------------------
 1 file changed, 46 insertions(+), 101 deletions(-)

--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -16,83 +16,54 @@
 
 #include <linux/kernel.h>
 
-static inline int atomic_add_return(int i, atomic_t *v)
-{
-	h8300flags flags;
-	int ret;
+#define ATOMIC_OP_RETURN(op, c_op)				\
+static inline int atomic_##op##_return(int i, atomic_t *v)	\
+{								\
+	h8300flags flags;					\
+	int ret;						\
+								\
+	flags = arch_local_irq_save();				\
+	ret = v->counter c_op i;				\
+	arch_local_irq_restore(flags);				\
+	return ret;						\
+}
+
+#define ATOMIC_OP(op, c_op)					\
+static inline void atomic_##op(int i, atomic_t *v)		\
+{								\
+	h8300flags flags;					\
+								\
+	flags = arch_local_irq_save();				\
+	v->counter c_op i;					\
+	arch_local_irq_restore(flags);				\
+}
+
+ATOMIC_OP_RETURN(add, +=)
+ATOMIC_OP_RETURN(sub, -=)
+
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+
+ATOMIC_OP(and, &=)
+ATOMIC_OP(or,  |=)
+ATOMIC_OP(xor, ^=)
 
-	flags = arch_local_irq_save();
-	ret = v->counter += i;
-	arch_local_irq_restore(flags);
-	return ret;
-}
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
 
-#define atomic_add(i, v) atomic_add_return(i, v)
+#define atomic_add(i, v)		(void)atomic_add_return(i, v)
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 
-static inline int atomic_sub_return(int i, atomic_t *v)
-{
-	h8300flags flags;
-	int ret;
-
-	flags = arch_local_irq_save();
-	ret = v->counter -= i;
-	arch_local_irq_restore(flags);
-	return ret;
-}
-
-#define atomic_sub(i, v) atomic_sub_return(i, v)
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
-
-static inline int atomic_inc_return(atomic_t *v)
-{
-	h8300flags flags;
-	int ret;
-
-	flags = arch_local_irq_save();
-	v->counter++;
-	ret = v->counter;
-	arch_local_irq_restore(flags);
-	return ret;
-}
-
-#define atomic_inc(v) atomic_inc_return(v)
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-static inline int atomic_dec_return(atomic_t *v)
-{
-	h8300flags flags;
-	int ret;
-
-	flags = arch_local_irq_save();
-	--v->counter;
-	ret = v->counter;
-	arch_local_irq_restore(flags);
-	return ret;
-}
+#define atomic_sub(i, v)		(void)atomic_sub_return(i, v)
+#define atomic_sub_and_test(i, v)	(atomic_sub_return(i, v) == 0)
 
-#define atomic_dec(v) atomic_dec_return(v)
+#define atomic_inc_return(v)		atomic_add_return(1, v)
+#define atomic_dec_return(v)		atomic_sub_return(1, v)
 
-static inline int atomic_dec_and_test(atomic_t *v)
-{
-	h8300flags flags;
-	int ret;
+#define atomic_inc(v)			(void)atomic_inc_return(v)
+#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
 
-	flags = arch_local_irq_save();
-	--v->counter;
-	ret = v->counter;
-	arch_local_irq_restore(flags);
-	return ret == 0;
-}
+#define atomic_dec(v)			(void)atomic_dec_return(v)
+#define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
@@ -120,40 +91,14 @@ static inline int __atomic_add_unless(at
 	return ret;
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *v)
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned char ccr;
-	unsigned long tmp;
-
-	__asm__ __volatile__("stc ccr,%w3\n\t"
-			     "orc #0x80,ccr\n\t"
-			     "mov.l %0,%1\n\t"
-			     "and.l %2,%1\n\t"
-			     "mov.l %1,%0\n\t"
-			     "ldc %w3,ccr"
-			     : "=m"(*v), "=r"(tmp)
-			     : "g"(~(mask)), "r"(ccr));
+	atomic_and(~mask, v);
 }
 
-static inline void atomic_set_mask(unsigned long mask, unsigned long *v)
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
-	unsigned char ccr;
-	unsigned long tmp;
-
-	__asm__ __volatile__("stc ccr,%w3\n\t"
-			     "orc #0x80,ccr\n\t"
-			     "mov.l %0,%1\n\t"
-			     "or.l %2,%1\n\t"
-			     "mov.l %1,%0\n\t"
-			     "ldc %w3,ccr"
-			     : "=m"(*v), "=r"(tmp)
-			     : "g"(~(mask)), "r"(ccr));
-}
-
-/* Atomic operations are already serializing */
-#define smp_mb__before_atomic_dec()    barrier()
-#define smp_mb__after_atomic_dec() barrier()
-#define smp_mb__before_atomic_inc()    barrier()
-#define smp_mb__after_atomic_inc() barrier()
+	atomic_or(mask, v);
+}
 
 #endif /* __ARCH_H8300_ATOMIC __ */
