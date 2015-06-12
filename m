From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2] ARC: add smp barriers around atomics per Documentation/atomic_ops.txt
Date: Fri, 12 Jun 2015 17:45:59 +0530
Message-ID: <1434111359-6925-1-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49243 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752589AbbFLMRE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2015 08:17:04 -0400
In-Reply-To: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, stable@vger.kernel.org

 - arch_spin_lock/unlock were lacking the ACQUIRE/RELEASE barriers
   Since ARCv2 only provides load/load, store/store and all/all, we need
   the full barrier

 - LLOCK/SCOND based atomics, bitops, cmpxchg, which return modified
   values were lacking the explicit smp barriers.

 - Non LLOCK/SCOND varaints don't need the explicit barriers since that
   is implicity provided by the spin locks used to implement the
   critical section (the spin lock barriers in turn are also fixed in
   this commit as explained above

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h   | 21 +++++++++++++++++++++
 arch/arc/include/asm/bitops.h   | 19 +++++++++++++++++++
 arch/arc/include/asm/cmpxchg.h  | 17 +++++++++++++++++
 arch/arc/include/asm/spinlock.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 9917a45fc430..20b7dc17979e 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -43,6 +43,12 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned int temp;						\
 									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
 	__asm__ __volatile__(						\
 	"1:	llock   %0, [%1]	\n"				\
 	"	" #asm_op " %0, %0, %2	\n"				\
@@ -52,6 +58,8 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	: "r"(&v->counter), "ir"(i)					\
 	: "cc");							\
 									\
+	smp_mb();							\
+									\
 	return temp;							\
 }
 
@@ -105,6 +113,9 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	unsigned long flags;						\
 	unsigned long temp;						\
 									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
 	atomic_ops_lock(flags);						\
 	temp = v->counter;						\
 	temp c_op i;							\
@@ -142,9 +153,19 @@ ATOMIC_OP(and, &=, and)
 #define __atomic_add_unless(v, a, u)					\
 ({									\
 	int c, old;							\
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
 	c = atomic_read(v);						\
 	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c)\
 		c = old;						\
+									\
+	smp_mb();							\
+									\
 	c;								\
 })
 
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 829a8a2e9704..dd03fd931bb7 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -117,6 +117,12 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	/*
+	 * Explicit full memory barrier needed before/after as
+	 * LLOCK/SCOND themselves don't provide any such semantics
+	 */
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bset    %1, %0, %3	\n"
@@ -126,6 +132,8 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
@@ -139,6 +147,8 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bclr    %1, %0, %3	\n"
@@ -148,6 +158,8 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
@@ -161,6 +173,8 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bxor    %1, %0, %3	\n"
@@ -170,6 +184,8 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
@@ -249,6 +265,9 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	/*
+	 * spin lock/unlock provide the needed smp_mb() before/after
+	 */
 	bitops_lock(flags);
 
 	old = *m;
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 90de5c528da2..44fd531f4d7b 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -10,6 +10,8 @@
 #define __ASM_ARC_CMPXCHG_H
 
 #include <linux/types.h>
+
+#include <asm/barrier.h>
 #include <asm/smp.h>
 
 #ifdef CONFIG_ARC_HAS_LLSC
@@ -19,6 +21,12 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 {
 	unsigned long prev;
 
+	/*
+	 * Explicit full memory barrier needed before/after as
+	 * LLOCK/SCOND thmeselves don't provide any such semantics
+	 */
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%1]	\n"
 	"	brne    %0, %2, 2f	\n"
@@ -31,6 +39,8 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	  "r"(new)	/* can't be "ir". scond can't take LIMM for "b" */
 	: "cc", "memory"); /* so that gcc knows memory is being written here */
 
+	smp_mb();
+
 	return prev;
 }
 
@@ -43,6 +53,9 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	int prev;
 	volatile unsigned long *p = ptr;
 
+	/*
+	 * spin lock/unlock provide the needed smp_mb() before/after
+	 */
 	atomic_ops_lock(flags);
 	prev = *p;
 	if (prev == expected)
@@ -78,12 +91,16 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 	switch (size) {
 	case 4:
+		smp_mb();
+
 		__asm__ __volatile__(
 		"	ex  %0, [%1]	\n"
 		: "+r"(val)
 		: "r"(ptr)
 		: "memory");
 
+		smp_mb();
+
 		return val;
 	}
 	return __xchg_bad_pointer();
diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index b6a8c2dfbe6e..e1651df6a93d 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -22,24 +22,46 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
 
+	/*
+	 * This smp_mb() is technically superfluous, we only need the one
+	 * after the lock for providing the ACQUIRE semantics.
+	 * However doing the "right" thing was regressing hackbench
+	 * so keeping this, pending further investigation
+	 */
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	ex  %0, [%1]		\n"
 	"	breq  %0, %2, 1b	\n"
 	: "+&r" (tmp)
 	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
 	: "memory");
+
+	/*
+	 * ACQUIRE barrier to ensure load/store after taking the lock
+	 * don't "bleed-up" out of the critical section (leak-in is allowed)
+	 * http://www.spinics.net/lists/kernel/msg2010409.html
+	 *
+	 * ARCv2 only has load-load, store-store and all-all barrier
+	 * thus need the full all-all barrier
+	 */
+	smp_mb();
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	ex  %0, [%1]		\n"
 	: "+r" (tmp)
 	: "r"(&(lock->slock))
 	: "memory");
 
+	smp_mb();
+
 	return (tmp == __ARCH_SPIN_LOCK_UNLOCKED__);
 }
 
@@ -47,12 +69,22 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned int tmp = __ARCH_SPIN_LOCK_UNLOCKED__;
 
+	/*
+	 * RELEASE barrier: given the instructions avail on ARCv2, full barrier
+	 * is the only option
+	 */
+	smp_mb();
+
 	__asm__ __volatile__(
 	"	ex  %0, [%1]		\n"
 	: "+r" (tmp)
 	: "r"(&(lock->slock))
 	: "memory");
 
+	/*
+	 * superfluous, but keeping for now - see pairing version in
+	 * arch_spin_lock above
+	 */
 	smp_mb();
 }
 
-- 
1.9.1
