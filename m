From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 11/21] csky: Atomic operations
Date: Fri, 12 Oct 2018 12:42:46 +0800
Message-ID: <ed0799f993de7e213624b99a318a3e7dac7a9bd1.1539315391.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

This patch adds atomic, cmpxchg, spinlock files.

Changlog:
 - SMP supported
 - ticklock supported
 - queue-rwlock supported

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 arch/csky/include/asm/atomic.h         | 212 +++++++++++++++++++++++++
 arch/csky/include/asm/cmpxchg.h        |  73 +++++++++
 arch/csky/include/asm/spinlock.h       | 274 +++++++++++++++++++++++++++++++++
 arch/csky/include/asm/spinlock_types.h |  37 +++++
 arch/csky/kernel/atomic.S              |  87 +++++++++++
 5 files changed, 683 insertions(+)
 create mode 100644 arch/csky/include/asm/atomic.h
 create mode 100644 arch/csky/include/asm/cmpxchg.h
 create mode 100644 arch/csky/include/asm/spinlock.h
 create mode 100644 arch/csky/include/asm/spinlock_types.h
 create mode 100644 arch/csky/kernel/atomic.S

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
new file mode 100644
index 0000000..e369d73
--- /dev/null
+++ b/arch/csky/include/asm/atomic.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_ATOMIC_H
+#define __ASM_CSKY_ATOMIC_H
+
+#include <linux/version.h>
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#ifdef CONFIG_CPU_HAS_LDSTEX
+
+#define __atomic_add_unless __atomic_add_unless
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	unsigned long tmp, ret;
+
+	smp_mb();
+
+	asm volatile (
+	"1:	ldex.w		%0, (%3) \n"
+	"	mov		%1, %0   \n"
+	"	cmpne		%0, %4   \n"
+	"	bf		2f	 \n"
+	"	add		%0, %2   \n"
+	"	stex.w		%0, (%3) \n"
+	"	bez		%0, 1b   \n"
+	"2:				 \n"
+		: "=&r" (tmp), "=&r" (ret)
+		: "r" (a), "r"(&v->counter), "r"(u)
+		: "memory");
+
+	if (ret != u)
+		smp_mb();
+
+	return ret;
+}
+
+#define ATOMIC_OP(op, c_op)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long tmp;						\
+									\
+	asm volatile (							\
+	"1:	ldex.w		%0, (%2) \n"				\
+	"	" #op "		%0, %1   \n"				\
+	"	stex.w		%0, (%2) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp)						\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+}
+
+#define ATOMIC_OP_RETURN(op, c_op)					\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	unsigned long tmp, ret;						\
+									\
+	smp_mb();							\
+	asm volatile (							\
+	"1:	ldex.w		%0, (%3) \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	mov		%1, %0   \n"				\
+	"	stex.w		%0, (%3) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+	smp_mb();							\
+									\
+	return ret;							\
+}
+
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long tmp, ret;						\
+									\
+	smp_mb();							\
+	asm volatile (							\
+	"1:	ldex.w		%0, (%3) \n"				\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	stex.w		%0, (%3) \n"				\
+	"	bez		%0, 1b   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+	smp_mb();							\
+									\
+	return ret;							\
+}
+
+#else /* CONFIG_CPU_HAS_LDSTEX */
+
+#include <linux/irqflags.h>
+
+#define __atomic_add_unless __atomic_add_unless
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	unsigned long tmp, ret, flags;
+
+	raw_local_irq_save(flags);
+
+	asm volatile (
+	"	ldw		%0, (%3) \n"
+	"	mov		%1, %0   \n"
+	"	cmpne		%0, %4   \n"
+	"	bf		2f	 \n"
+	"	add		%0, %2   \n"
+	"	stw		%0, (%3) \n"
+	"2:				 \n"
+		: "=&r" (tmp), "=&r" (ret)
+		: "r" (a), "r"(&v->counter), "r"(u)
+		: "memory");
+
+	raw_local_irq_restore(flags);
+
+	return ret;
+}
+
+#define ATOMIC_OP(op, c_op)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long tmp, flags;					\
+									\
+	raw_local_irq_save(flags);					\
+									\
+	asm volatile (							\
+	"	ldw		%0, (%2) \n"				\
+	"	" #op "		%0, %1   \n"				\
+	"	stw		%0, (%2) \n"				\
+		: "=&r" (tmp)						\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+									\
+	raw_local_irq_restore(flags);					\
+}
+
+#define ATOMIC_OP_RETURN(op, c_op)					\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	unsigned long tmp, ret, flags;					\
+									\
+	raw_local_irq_save(flags);					\
+									\
+	asm volatile (							\
+	"	ldw		%0, (%3) \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	stw		%0, (%3) \n"				\
+	"	mov		%1, %0   \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+									\
+	raw_local_irq_restore(flags);					\
+									\
+	return ret;							\
+}
+
+#define ATOMIC_FETCH_OP(op, c_op)					\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long tmp, ret, flags;					\
+									\
+	raw_local_irq_save(flags);					\
+									\
+	asm volatile (							\
+	"	ldw		%0, (%3) \n"				\
+	"	mov		%1, %0   \n"				\
+	"	" #op "		%0, %2   \n"				\
+	"	stw		%0, (%3) \n"				\
+		: "=&r" (tmp), "=&r" (ret)				\
+		: "r" (i), "r"(&v->counter)				\
+		: "memory");						\
+									\
+	raw_local_irq_restore(flags);					\
+									\
+	return ret;							\
+}
+
+#endif /* CONFIG_CPU_HAS_LDSTEX */
+
+#define atomic_add_return atomic_add_return
+ATOMIC_OP_RETURN(add, +)
+#define atomic_sub_return atomic_sub_return
+ATOMIC_OP_RETURN(sub, -)
+
+#define atomic_fetch_add atomic_fetch_add
+ATOMIC_FETCH_OP(add, +)
+#define atomic_fetch_sub atomic_fetch_sub
+ATOMIC_FETCH_OP(sub, -)
+#define atomic_fetch_and atomic_fetch_and
+ATOMIC_FETCH_OP(and, &)
+#define atomic_fetch_or atomic_fetch_or
+ATOMIC_FETCH_OP(or, |)
+#define atomic_fetch_xor atomic_fetch_xor
+ATOMIC_FETCH_OP(xor, ^)
+
+#define atomic_and atomic_and
+ATOMIC_OP(and, &)
+#define atomic_or atomic_or
+ATOMIC_OP(or, |)
+#define atomic_xor atomic_xor
+ATOMIC_OP(xor, ^)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#include <asm-generic/atomic.h>
+
+#endif /* __ASM_CSKY_ATOMIC_H */
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
new file mode 100644
index 0000000..8922453
--- /dev/null
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_CMPXCHG_H
+#define __ASM_CSKY_CMPXCHG_H
+
+#ifdef CONFIG_CPU_HAS_LDSTEX
+#include <asm/barrier.h>
+
+extern void __bad_xchg(void);
+
+#define __xchg(new, ptr, size)					\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	unsigned long tmp;					\
+	switch (size) {						\
+	case 4:							\
+		smp_mb();					\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(__ptr)		\
+			:);					\
+		smp_mb();					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+
+#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
+
+#define __cmpxchg(ptr, old, new, size)				\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(new) __tmp;					\
+	__typeof__(old) __old = (old);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		smp_mb();					\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	cmpne		%0, %4   \n"		\
+		"	bt		2f       \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+		"2:				 \n"		\
+			: "=&r" (__ret), "=&r" (__tmp)		\
+			: "r" (__new), "r"(__ptr), "r"(__old)	\
+			:);					\
+		smp_mb();					\
+		break;						\
+	default:						\
+		__bad_xchg();					\
+	}							\
+	__ret;							\
+})
+
+#define cmpxchg(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+#else
+#include <asm-generic/cmpxchg.h>
+#endif
+
+#endif /* __ASM_CSKY_CMPXCHG_H */
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
new file mode 100644
index 0000000..0474603
--- /dev/null
+++ b/arch/csky/include/asm/spinlock.h
@@ -0,0 +1,274 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_SPINLOCK_H
+#define __ASM_CSKY_SPINLOCK_H
+
+#include <linux/spinlock_types.h>
+#include <asm/barrier.h>
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+
+/*
+ * Ticket-based spin-locking.
+ */
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval;
+	u32 ticket_next = 1 << TICKET_NEXT;
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%2) \n"
+		"	mov		%1, %0	 \n"
+		"	add		%0, %3	 \n"
+		"	stex.w		%0, (%2) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp), "=&r" (lockval)
+		: "r"(p), "r"(ticket_next)
+		: "cc");
+
+	while (lockval.tickets.next != lockval.tickets.owner)
+		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
+
+	smp_mb();
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 tmp, contended, res;
+	u32 ticket_next = 1 << TICKET_NEXT;
+	u32 *p = &lock->lock;
+
+	do {
+		asm volatile (
+		"	ldex.w		%0, (%3)   \n"
+		"	movi		%2, 1	   \n"
+		"	rotli		%1, %0, 16 \n"
+		"	cmpne		%1, %0     \n"
+		"	bt		1f         \n"
+		"	movi		%2, 0	   \n"
+		"	add		%0, %0, %4 \n"
+		"	stex.w		%0, (%3)   \n"
+		"1:				   \n"
+		: "=&r" (res), "=&r" (tmp), "=&r" (contended)
+		: "r"(p), "r"(ticket_next)
+		: "cc");
+	} while (!res);
+
+	if (!contended)
+		smp_mb();
+
+	return !contended;
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	smp_mb();
+	lock->tickets.owner++;
+}
+
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.tickets.owner == lock.tickets.next;
+}
+
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	return !arch_spin_value_unlocked(READ_ONCE(*lock));
+}
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
+
+	return (tickets.next - tickets.owner) > 1;
+}
+#define arch_spin_is_contended	arch_spin_is_contended
+
+#include <asm/qrwlock.h>
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
+#else /* CONFIG_QUEUED_RWLOCKS */
+
+/*
+ * Test-and-set spin-locking.
+ */
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 1b   \n"
+		"	movi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+	smp_mb();
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	smp_mb();
+	asm volatile (
+		"	movi		%0, 0    \n"
+		"	stw		%0, (%1) \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 2f   \n"
+		"	movi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		"	movi		%0, 0    \n"
+		"2:				 \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+
+	if (!tmp)
+		smp_mb();
+
+	return !tmp;
+}
+
+#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
+
+/*
+ * read lock/unlock/trylock
+ */
+static inline void arch_read_lock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	blz		%0, 1b   \n"
+		"	addi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+	smp_mb();
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	subi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	blz		%0, 2f   \n"
+		"	addi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		"	movi		%0, 0    \n"
+		"2:				 \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+
+	if (!tmp)
+		smp_mb();
+
+	return !tmp;
+}
+
+/*
+ * write lock/unlock/trylock
+ */
+static inline void arch_write_lock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 1b   \n"
+		"	subi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+	smp_mb();
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	movi		%0, 0    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *lock)
+{
+	u32 *p = &lock->lock;
+	u32 tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 2f   \n"
+		"	subi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		"	movi		%0, 0    \n"
+		"2:				 \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "cc");
+
+	if (!tmp)
+		smp_mb();
+
+	return !tmp;
+}
+
+#endif /* CONFIG_QUEUED_RWLOCKS */
+#endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
new file mode 100644
index 0000000..88b8243
--- /dev/null
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
+#define __ASM_CSKY_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+#define TICKET_NEXT	16
+
+typedef struct {
+	union {
+		u32 lock;
+		struct __raw_tickets {
+			/* little endian */
+			u16 owner;
+			u16 next;
+		} tickets;
+	};
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm-generic/qrwlock_types.h>
+
+#else /* CONFIG_NR_CPUS > 2 */
+
+typedef struct {
+	u32 lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif /* CONFIG_QUEUED_RWLOCKS */
+#endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
new file mode 100644
index 0000000..d2357c8
--- /dev/null
+++ b/arch/csky/kernel/atomic.S
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/linkage.h>
+#include <abi/entry.h>
+
+.text
+
+/*
+ * int csky_cmpxchg(int oldval, int newval, int *ptr)
+ *
+ * If *ptr != oldval && return 1,
+ * else *ptr = newval return 0.
+ */
+#ifdef CONFIG_CPU_HAS_LDSTEX
+ENTRY(csky_cmpxchg)
+	USPTOKSP
+	mfcr	a3, epc
+	INCTRAP	a3
+
+	subi    sp, 8
+	stw     a3, (sp, 0)
+	mfcr    a3, epsr
+	stw     a3, (sp, 4)
+
+	psrset	ee
+1:
+	ldex	a3, (a2)
+	cmpne	a0, a3
+	bt16	2f
+	mov	a3, a1
+	stex	a3, (a2)
+	bez	a3, 1b
+2:
+	sync.is
+	mvc	a0
+	ldw	a3, (sp, 0)
+	mtcr	a3, epc
+	ldw     a3, (sp, 4)
+	mtcr	a3, epsr
+	addi	sp, 8
+	KSPTOUSP
+	rte
+END(csky_cmpxchg)
+#else
+ENTRY(csky_cmpxchg)
+	USPTOKSP
+	mfcr	a3, epc
+	INCTRAP	a3
+
+	subi    sp, 8
+	stw     a3, (sp, 0)
+	mfcr    a3, epsr
+	stw     a3, (sp, 4)
+
+	psrset	ee
+1:
+	ldw	a3, (a2)
+	cmpne	a0, a3
+	bt16	3f
+2:
+	stw	a1, (a2)
+3:
+	mvc	a0
+	ldw	a3, (sp, 0)
+	mtcr	a3, epc
+	ldw     a3, (sp, 4)
+	mtcr	a3, epsr
+	addi	sp, 8
+	KSPTOUSP
+	rte
+END(csky_cmpxchg)
+
+/*
+ * Called from tlbmodified exception
+ */
+ENTRY(csky_cmpxchg_fixup)
+	mfcr	a0, epc
+	lrw	a1, 2b
+	cmpne	a1, a0
+	bt	1f
+	subi	a1, (2b - 1b)
+	stw	a1, (sp, LSAVE_PC)
+1:
+	rts
+END(csky_cmpxchg_fixup)
+#endif
-- 
2.7.4
