From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 11/19] csky: Atomic operations
Date: Mon,  2 Jul 2018 01:30:14 +0800
Message-ID: <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/cmpxchg.h        |  68 +++++++++++++
 arch/csky/include/asm/spinlock.h       | 174 +++++++++++++++++++++++++++++++++
 arch/csky/include/asm/spinlock_types.h |  20 ++++
 arch/csky/kernel/atomic.S              |  87 +++++++++++++++++
 4 files changed, 349 insertions(+)
 create mode 100644 arch/csky/include/asm/cmpxchg.h
 create mode 100644 arch/csky/include/asm/spinlock.h
 create mode 100644 arch/csky/include/asm/spinlock_types.h
 create mode 100644 arch/csky/kernel/atomic.S

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
new file mode 100644
index 0000000..1c30a28
--- /dev/null
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -0,0 +1,68 @@
+#ifndef __ASM_CSKY_CMPXCHG_H
+#define __ASM_CSKY_CMPXCHG_H
+
+#ifdef CONFIG_CPU_HAS_LDSTEX
+#include <linux/bug.h>
+#include <asm/barrier.h>
+
+#define __xchg(new, ptr, size)					\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	unsigned long tmp;					\
+	switch (size) {						\
+	case 4:							\
+		asm volatile (					\
+		"1:	ldex.w		%0, (%3) \n"		\
+		"	mov		%1, %2   \n"		\
+		"	stex.w		%1, (%3) \n"		\
+		"	bez		%1, 1b   \n"		\
+			: "=&r" (__ret), "=&r" (tmp)		\
+			: "r" (__new), "r"(__ptr)		\
+			: "memory");				\
+		smp_mb();					\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
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
+			: "memory");				\
+		smp_mb();					\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
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
index 0000000..ca10d0e
--- /dev/null
+++ b/arch/csky/include/asm/spinlock.h
@@ -0,0 +1,174 @@
+#ifndef __ASM_CSKY_SPINLOCK_H
+#define __ASM_CSKY_SPINLOCK_H
+
+#include <linux/spinlock_types.h>
+#include <asm/barrier.h>
+
+#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
+
+/****** spin lock/unlock/trylock ******/
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 1b   \n"
+		"	movi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	movi		%0, 0    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
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
+		: "memory");
+	smp_mb();
+
+	return !tmp;
+}
+
+/****** read lock/unlock/trylock ******/
+static inline void arch_read_lock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	blz		%0, 1b   \n"
+		"	addi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	subi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
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
+		: "memory");
+	smp_mb();
+
+	return !tmp;
+}
+
+/****** write lock/unlock/trylock ******/
+static inline void arch_write_lock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	bnez		%0, 1b   \n"
+		"	subi		%0, 1    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
+
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%1) \n"
+		"	movi		%0, 0    \n"
+		"	stex.w		%0, (%1) \n"
+		"	bez		%0, 1b   \n"
+		: "=&r" (tmp)
+		: "r"(p)
+		: "memory");
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *lock)
+{
+	unsigned int *p = &lock->lock;
+	unsigned int tmp;
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
+		: "memory");
+	smp_mb();
+
+	return !tmp;
+}
+
+#endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
new file mode 100644
index 0000000..ea890ef
--- /dev/null
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
+#define __ASM_CSKY_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	unsigned int lock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	unsigned int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
new file mode 100644
index 0000000..95ae696
--- /dev/null
+++ b/arch/csky/kernel/atomic.S
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
+
-- 
2.7.4
