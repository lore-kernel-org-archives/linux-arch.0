From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 18/28] ARC: add smp barriers around atomics per memory-barrriers.txt
Date: Tue, 9 Jun 2015 17:18:18 +0530
Message-ID: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h   | 10 ++++++++++
 arch/arc/include/asm/bitops.h   | 12 ++++++++++++
 arch/arc/include/asm/cmpxchg.h  | 10 ++++++++++
 arch/arc/include/asm/spinlock.h | 10 ++++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 9917a45fc430..6fc968f78500 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -43,6 +43,8 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned int temp;						\
 									\
+	smp_mb();							\
+									\
 	__asm__ __volatile__(						\
 	"1:	llock   %0, [%1]	\n"				\
 	"	" #asm_op " %0, %0, %2	\n"				\
@@ -52,6 +54,8 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	: "r"(&v->counter), "ir"(i)					\
 	: "cc");							\
 									\
+	smp_mb();							\
+									\
 	return temp;							\
 }
 
@@ -142,9 +146,15 @@ ATOMIC_OP(and, &=, and)
 #define __atomic_add_unless(v, a, u)					\
 ({									\
 	int c, old;							\
+									\
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
index 829a8a2e9704..47878d85e3a3 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -117,6 +117,8 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bset    %1, %0, %3	\n"
@@ -126,6 +128,8 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
@@ -139,6 +143,8 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bclr    %1, %0, %3	\n"
@@ -148,6 +154,8 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
@@ -161,6 +169,8 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
 	if (__builtin_constant_p(nr))
 		nr &= 0x1f;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%2]	\n"
 	"	bxor    %1, %0, %3	\n"
@@ -170,6 +180,8 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *m)
 	: "r"(m), "ir"(nr)
 	: "cc");
 
+	smp_mb();
+
 	return (old & (1 << nr)) != 0;
 }
 
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 90de5c528da2..96a3dd8fe4bf 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -10,6 +10,8 @@
 #define __ASM_ARC_CMPXCHG_H
 
 #include <linux/types.h>
+
+#include <asm/barrier.h>
 #include <asm/smp.h>
 
 #ifdef CONFIG_ARC_HAS_LLSC
@@ -19,6 +21,8 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 {
 	unsigned long prev;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	llock   %0, [%1]	\n"
 	"	brne    %0, %2, 2f	\n"
@@ -31,6 +35,8 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	  "r"(new)	/* can't be "ir". scond can't take LIMM for "b" */
 	: "cc", "memory"); /* so that gcc knows memory is being written here */
 
+	smp_mb();
+
 	return prev;
 }
 
@@ -78,12 +84,16 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
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
index b6a8c2dfbe6e..8af8eaad4999 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -22,24 +22,32 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"1:	ex  %0, [%1]		\n"
 	"	breq  %0, %2, 1b	\n"
 	: "+&r" (tmp)
 	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
 	: "memory");
+
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
 
@@ -47,6 +55,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned int tmp = __ARCH_SPIN_LOCK_UNLOCKED__;
 
+	smp_mb();
+
 	__asm__ __volatile__(
 	"	ex  %0, [%1]		\n"
 	: "+r" (tmp)
-- 
1.9.1
