From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2] ARC: Reduce bitops lines of code using macros
Date: Fri, 12 Jun 2015 17:50:34 +0530
Message-ID: <1434111634-7854-1-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-22-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-22-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

No semantical changes !

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/bitops.h | 477 +++++++++++++-----------------------------
 1 file changed, 144 insertions(+), 333 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index dd03fd931bb7..99fe118d3730 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -18,83 +18,50 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <asm/barrier.h>
+#ifndef CONFIG_ARC_HAS_LLSC
+#include <asm/smp.h>
+#endif
 
-/*
- * Hardware assisted read-modify-write using ARC700 LLOCK/SCOND insns.
- * The Kconfig glue ensures that in SMP, this is only set if the container
- * SoC/platform has cross-core coherent LLOCK/SCOND
- */
 #if defined(CONFIG_ARC_HAS_LLSC)
 
-static inline void set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned int temp;
-
-	m += nr >> 5;
-
-	/*
-	 * ARC ISA micro-optimization:
-	 *
-	 * Instructions dealing with bitpos only consider lower 5 bits (0-31)
-	 * e.g (x << 33) is handled like (x << 1) by ASL instruction
-	 *  (mem pointer still needs adjustment to point to next word)
-	 *
-	 * Hence the masking to clamp @nr arg can be elided in general.
-	 *
-	 * However if @nr is a constant (above assumed it in a register),
-	 * and greater than 31, gcc can optimize away (x << 33) to 0,
-	 * as overflow, given the 32-bit ISA. Thus masking needs to be done
-	 * for constant @nr, but no code is generated due to const prop.
-	 */
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	__asm__ __volatile__(
-	"1:	llock   %0, [%1]	\n"
-	"	bset    %0, %0, %2	\n"
-	"	scond   %0, [%1]	\n"
-	"	bnz     1b	\n"
-	: "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
-}
-
-static inline void clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned int temp;
-
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	__asm__ __volatile__(
-	"1:	llock   %0, [%1]	\n"
-	"	bclr    %0, %0, %2	\n"
-	"	scond   %0, [%1]	\n"
-	"	bnz     1b	\n"
-	: "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
-}
-
-static inline void change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned int temp;
-
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
+/*
+ * Hardware assisted Atomic-R-M-W
+ */
 
-	__asm__ __volatile__(
-	"1:	llock   %0, [%1]	\n"
-	"	bxor    %0, %0, %2	\n"
-	"	scond   %0, [%1]	\n"
-	"	bnz     1b		\n"
-	: "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
+#define BIT_OP(op, c_op, asm_op)					\
+static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
+{									\
+	unsigned int temp;						\
+									\
+	m += nr >> 5;							\
+									\
+	/*								\
+	 * ARC ISA micro-optimization:					\
+	 *								\
+	 * Instructions dealing with bitpos only consider lower 5 bits	\
+	 * e.g (x << 33) is handled like (x << 1) by ASL instruction	\
+	 *  (mem pointer still needs adjustment to point to next word)	\
+	 *								\
+	 * Hence the masking to clamp @nr arg can be elided in general.	\
+	 *								\
+	 * However if @nr is a constant (above assumed in a register),	\
+	 * and greater than 31, gcc can optimize away (x << 33) to 0,	\
+	 * as overflow, given the 32-bit ISA. Thus masking needs to be	\
+	 * done for const @nr, but no code is generated due to gcc	\
+	 * const prop.							\
+	 */								\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock       %0, [%1]		\n"			\
+	"	" #asm_op " %0, %0, %2	\n"				\
+	"	scond       %0, [%1]		\n"			\
+	"	bnz         1b			\n"			\
+	: "=&r"(temp)	/* Early clobber, to prevent reg reuse */	\
+	: "r"(m),	/* Not "m": llock only supports reg direct addr mode */	\
+	  "ir"(nr)							\
+	: "cc");							\
 }
 
 /*
@@ -108,91 +75,38 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *m)
  * Since ARC lacks a equivalent h/w primitive, the bit is set unconditionally
  * and the old value of bit is returned
  */
-static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old, temp;
-
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	/*
-	 * Explicit full memory barrier needed before/after as
-	 * LLOCK/SCOND themselves don't provide any such semantics
-	 */
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llock   %0, [%2]	\n"
-	"	bset    %1, %0, %3	\n"
-	"	scond   %1, [%2]	\n"
-	"	bnz     1b		\n"
-	: "=&r"(old), "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
-
-	smp_mb();
-
-	return (old & (1 << nr)) != 0;
-}
-
-static inline int
-test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned int old, temp;
-
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llock   %0, [%2]	\n"
-	"	bclr    %1, %0, %3	\n"
-	"	scond   %1, [%2]	\n"
-	"	bnz     1b		\n"
-	: "=&r"(old), "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
-
-	smp_mb();
-
-	return (old & (1 << nr)) != 0;
-}
-
-static inline int
-test_and_change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned int old, temp;
-
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	smp_mb();
-
-	__asm__ __volatile__(
-	"1:	llock   %0, [%2]	\n"
-	"	bxor    %1, %0, %3	\n"
-	"	scond   %1, [%2]	\n"
-	"	bnz     1b		\n"
-	: "=&r"(old), "=&r"(temp)
-	: "r"(m), "ir"(nr)
-	: "cc");
-
-	smp_mb();
-
-	return (old & (1 << nr)) != 0;
+#define TEST_N_BIT_OP(op, c_op, asm_op)					\
+static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
+{									\
+	unsigned long old, temp;					\
+									\
+	m += nr >> 5;							\
+									\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND themselves don't provide any such smenatic	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock       %0, [%2]	\n"				\
+	"	" #asm_op " %1, %0, %3	\n"				\
+	"	scond       %1, [%2]	\n"				\
+	"	bnz         1b		\n"				\
+	: "=&r"(old), "=&r"(temp)					\
+	: "r"(m), "ir"(nr)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return (old & (1 << nr)) != 0;					\
 }
 
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
-#include <asm/smp.h>
-
 /*
  * Non hardware assisted Atomic-R-M-W
  * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
@@ -209,111 +123,43 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
  *             at compile time)
  */
 
-static inline void set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	bitops_lock(flags);
-
-	temp = *m;
-	*m = temp | (1UL << nr);
-
-	bitops_unlock(flags);
-}
-
-static inline void clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	bitops_lock(flags);
-
-	temp = *m;
-	*m = temp & ~(1UL << nr);
-
-	bitops_unlock(flags);
-}
-
-static inline void change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	bitops_lock(flags);
-
-	temp = *m;
-	*m = temp ^ (1UL << nr);
-
-	bitops_unlock(flags);
+#define BIT_OP(op, c_op, asm_op)					\
+static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
+{									\
+	unsigned long temp, flags;					\
+	m += nr >> 5;							\
+									\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	/*								\
+	 * spin lock/unlock provide the needed smp_mb() before/after	\
+	 */								\
+	bitops_lock(flags);						\
+									\
+	temp = *m;							\
+	*m = temp c_op (1UL << nr);					\
+									\
+	bitops_unlock(flags);						\
 }
 
-static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	/*
-	 * spin lock/unlock provide the needed smp_mb() before/after
-	 */
-	bitops_lock(flags);
-
-	old = *m;
-	*m = old | (1 << nr);
-
-	bitops_unlock(flags);
-
-	return (old & (1 << nr)) != 0;
-}
-
-static inline int
-test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	bitops_lock(flags);
-
-	old = *m;
-	*m = old & ~(1 << nr);
-
-	bitops_unlock(flags);
-
-	return (old & (1 << nr)) != 0;
-}
-
-static inline int
-test_and_change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old, flags;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	bitops_lock(flags);
-
-	old = *m;
-	*m = old ^ (1 << nr);
-
-	bitops_unlock(flags);
-
-	return (old & (1 << nr)) != 0;
+#define TEST_N_BIT_OP(op, c_op, asm_op)					\
+static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
+{									\
+	unsigned long old, flags;					\
+	m += nr >> 5;							\
+									\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	bitops_lock(flags);						\
+									\
+	old = *m;							\
+	*m = old c_op (1 << nr);					\
+									\
+	bitops_unlock(flags);						\
+									\
+	return (old & (1 << nr)) != 0;					\
 }
 
 #endif /* CONFIG_ARC_HAS_LLSC */
@@ -322,86 +168,51 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
  * Non atomic variants
  **************************************/
 
-static inline void __set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	temp = *m;
-	*m = temp | (1UL << nr);
-}
-
-static inline void __clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	temp = *m;
-	*m = temp & ~(1UL << nr);
-}
-
-static inline void __change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long temp;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	temp = *m;
-	*m = temp ^ (1UL << nr);
-}
-
-static inline int
-__test_and_set_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	old = *m;
-	*m = old | (1 << nr);
-
-	return (old & (1 << nr)) != 0;
+#define __BIT_OP(op, c_op, asm_op)					\
+static inline void __##op##_bit(unsigned long nr, volatile unsigned long *m)	\
+{									\
+	unsigned long temp;						\
+	m += nr >> 5;							\
+									\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	temp = *m;							\
+	*m = temp c_op (1UL << nr);					\
 }
 
-static inline int
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	old = *m;
-	*m = old & ~(1 << nr);
-
-	return (old & (1 << nr)) != 0;
+#define __TEST_N_BIT_OP(op, c_op, asm_op)				\
+static inline int __test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
+{									\
+	unsigned long old;						\
+	m += nr >> 5;							\
+									\
+	if (__builtin_constant_p(nr))					\
+		nr &= 0x1f;						\
+									\
+	old = *m;							\
+	*m = old c_op (1 << nr);					\
+									\
+	return (old & (1 << nr)) != 0;					\
 }
 
-static inline int
-__test_and_change_bit(unsigned long nr, volatile unsigned long *m)
-{
-	unsigned long old;
-	m += nr >> 5;
-
-	if (__builtin_constant_p(nr))
-		nr &= 0x1f;
-
-	old = *m;
-	*m = old ^ (1 << nr);
-
-	return (old & (1 << nr)) != 0;
-}
+#define BIT_OPS(op, c_op, asm_op)					\
+									\
+	/* set_bit(), clear_bit(), change_bit() */			\
+	BIT_OP(op, c_op, asm_op)					\
+									\
+	/* test_and_set_bit(), test_and_clear_bit(), test_and_change_bit() */\
+	TEST_N_BIT_OP(op, c_op, asm_op)					\
+									\
+	/* __set_bit(), __clear_bit(), __change_bit() */		\
+	__BIT_OP(op, c_op, asm_op)					\
+									\
+	/* __test_and_set_bit(), __test_and_clear_bit(), __test_and_change_bit() */\
+	__TEST_N_BIT_OP(op, c_op, asm_op)
+
+BIT_OPS(set, |, bset)
+BIT_OPS(clear, & ~, bclr)
+BIT_OPS(change, ^, bxor)
 
 /*
  * This routine doesn't need to be atomic.
-- 
1.9.1
