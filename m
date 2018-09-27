From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 17/33] csky: Misc headers
Date: Thu, 27 Sep 2018 22:47:54 +0800
Message-ID: <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds csky register definition, byteorder, asm-offsets codes.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/reg_ops.h      |  27 ++++
 arch/csky/abiv1/inc/abi/regdef.h       |  26 +++
 arch/csky/abiv2/inc/abi/reg_ops.h      |  17 ++
 arch/csky/abiv2/inc/abi/regdef.h       |  26 +++
 arch/csky/include/asm/bitops.h         | 282 +++++++++++++++++++++++++++++++++
 arch/csky/include/asm/checksum.h       |  55 +++++++
 arch/csky/include/asm/compat.h         |  11 ++
 arch/csky/include/asm/reg_ops.h        |  22 +++
 arch/csky/include/uapi/asm/byteorder.h |   9 ++
 arch/csky/kernel/asm-offsets.c         |  86 ++++++++++
 10 files changed, 561 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv1/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv2/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv2/inc/abi/regdef.h
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/checksum.h
 create mode 100644 arch/csky/include/asm/compat.h
 create mode 100644 arch/csky/include/asm/reg_ops.h
 create mode 100644 arch/csky/include/uapi/asm/byteorder.h
 create mode 100644 arch/csky/kernel/asm-offsets.c

diff --git a/arch/csky/abiv1/inc/abi/reg_ops.h b/arch/csky/abiv1/inc/abi/reg_ops.h
new file mode 100644
index 0000000..6091788
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/reg_ops.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_REG_OPS_H
+#define __ABI_REG_OPS_H
+#include <asm/reg_ops.h>
+
+#define cprcr(reg)					\
+({							\
+	unsigned int tmp;				\
+	asm volatile("cprcr %0, "reg"\n":"=b"(tmp));	\
+	tmp;						\
+})
+
+#define cpwcr(reg, val)					\
+({							\
+	asm volatile("cpwcr %0, "reg"\n"::"b"(val));	\
+})
+
+static inline unsigned int mfcr_hint(void)
+{
+	return mfcr("cr30");
+}
+
+static inline unsigned int mfcr_ccr2(void){return 0;}
+
+#endif /* __ABI_REG_OPS_H */
diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
new file mode 100644
index 0000000..68cf10f
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r1
+#define r11_sig		r11
+
+#define regs_syscallid(regs) regs->regs[9]
+
+/*
+ * PSR format:
+ * | 31 | 30-24 | 23-16 | 15 14 | 13-0 |
+ *   S     CPID     VEC     TM
+ *
+ *    S: Super Mode
+ * CPID: Coprocessor id, only 15 for MMU
+ *  VEC: Exception Number
+ *   TM: Trace Mode
+ */
+#define DEFAULT_PSR_VALUE	0x8f000000
+
+#define SYSTRACE_SAVENUM	2
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/abiv2/inc/abi/reg_ops.h b/arch/csky/abiv2/inc/abi/reg_ops.h
new file mode 100644
index 0000000..ffe4fc9
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/reg_ops.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_REG_OPS_H
+#define __ABI_REG_OPS_H
+#include <asm/reg_ops.h>
+
+static inline unsigned int mfcr_hint(void)
+{
+	return mfcr("cr31");
+}
+
+static inline unsigned int mfcr_ccr2(void)
+{
+	return mfcr("cr23");
+}
+#endif /* __ABI_REG_OPS_H */
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
new file mode 100644
index 0000000..676e74a
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r7
+#define r11_sig		r11
+
+#define regs_syscallid(regs) regs->regs[3]
+
+/*
+ * PSR format:
+ * | 31 | 30-24 | 23-16 | 15 14 | 13-10 | 9 | 8-0 |
+ *   S              VEC     TM            MM
+ *
+ *   S: Super Mode
+ * VEC: Exception Number
+ *  TM: Trace Mode
+ *  MM: Memory unaligned addr access
+ */
+#define DEFAULT_PSR_VALUE	0x80000200
+
+#define SYSTRACE_SAVENUM	5
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
new file mode 100644
index 0000000..c9834f1
--- /dev/null
+++ b/arch/csky/include/asm/bitops.h
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_BITOPS_H
+#define __ASM_CSKY_BITOPS_H
+
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+
+/*
+ * asm-generic/bitops/ffs.h
+ */
+static inline int ffs(int x)
+{
+	if(!x) return 0;
+
+	asm volatile (
+		"brev %0\n"
+		"ff1  %0\n"
+		"addi %0, 1\n"
+		:"=&r"(x)
+		:"0"(x));
+	return x;
+}
+
+/*
+ * asm-generic/bitops/__ffs.h
+ */
+static __always_inline unsigned long __ffs(unsigned long x)
+{
+	asm volatile (
+		"brev %0\n"
+		"ff1  %0\n"
+		:"=&r"(x)
+		:"0"(x));
+	return x;
+}
+
+/*
+ * asm-generic/bitops/fls.h
+ */
+static __always_inline int fls(int x)
+{
+	asm volatile(
+		"ff1 %0\n"
+		:"=&r"(x)
+		:"0"(x));
+
+	return (32 - x);
+}
+
+/*
+ * asm-generic/bitops/__fls.h
+ */
+static __always_inline unsigned long __fls(unsigned long x)
+{
+	return fls(x) - 1;
+}
+
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
+
+#ifdef CONFIG_CPU_HAS_LDSTEX
+
+/*
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This function is atomic and may not be reordered.  See __set_bit()
+ * if you do not require the atomic guarantees.
+ *
+ * Note: there are no guarantees that this function will not be reordered
+ * on non x86 architectures, so if you are writing portable code,
+ * make sure not to rely on its reordering guarantees.
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	/* *p  |= mask; */
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%2)	\n"
+		"	or32		%0, %0, %1	\n"
+		"	stex.w		%0, (%2)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp)
+		: "r"(mask), "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
+ * in order to ensure changes are visible on other processors.
+ */
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	/* *p &= ~mask; */
+	mask = ~mask;
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%2)	\n"
+		"	and32		%0, %0, %1	\n"
+		"	stex.w		%0, (%2)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp)
+		: "r"(mask), "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	/* *p ^= mask; */
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%0, (%2)	\n"
+		"	xor32		%0, %0, %1	\n"
+		"	stex.w		%0, (%2)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp)
+		: "r"(mask), "r"(p)
+		: "memory");
+	smp_mb();
+}
+
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old, tmp;
+
+	/*
+	 * old = *p;
+	 * *p = old | mask;
+	 */
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%1, (%3)	\n"
+		"	mov		%0, %1		\n"
+		"	or32		%0, %0, %2	\n"
+		"	stex.w		%0, (%3)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp), "=&r"(old)
+		: "r"(mask), "r"(p)
+		: "memory");
+	smp_mb();
+
+	return (old & mask) != 0;
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reorderdered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old, tmp, mask_not;
+
+	/*
+	 * old = *p;
+	 * *p = old & ~mask;
+	 */
+	smp_mb();
+	mask_not = ~mask;
+	asm volatile (
+		"1:	ldex.w		%1, (%3)	\n"
+		"	mov		%0, %1		\n"
+		"	and32		%0, %0, %2	\n"
+		"	stex.w		%0, (%3)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp), "=&r"(old)
+		: "r"(mask_not), "r"(p)
+		: "memory");
+
+	smp_mb();
+
+	return (old & mask) != 0;
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old, tmp;
+
+	/*
+	 * old = *p;
+	 * *p = old ^ mask;
+	 */
+	smp_mb();
+	asm volatile (
+		"1:	ldex.w		%1, (%3)	\n"
+		"	mov		%0, %1		\n"
+		"	xor32		%0, %0, %2	\n"
+		"	stex.w		%0, (%3)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp), "=&r"(old)
+		: "r"(mask), "r"(p)
+		: "memory");
+	smp_mb();
+
+	return (old & mask) != 0;
+}
+
+#else
+#include <asm-generic/bitops/atomic.h>
+#endif
+
+/*
+ * bug fix, why only could use atomic!!!!
+ */
+#include <asm-generic/bitops/non-atomic.h>
+#define __clear_bit(nr,vaddr) clear_bit(nr,vaddr)
+
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#endif /* __ASM_CSKY_BITOPS_H */
diff --git a/arch/csky/include/asm/checksum.h b/arch/csky/include/asm/checksum.h
new file mode 100644
index 0000000..df73c5c
--- /dev/null
+++ b/arch/csky/include/asm/checksum.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_CHECKSUM_H
+#define __ASM_CSKY_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <asm/byteorder.h>
+
+static inline __sum16 csum_fold(__wsum csum)
+{
+	u32 tmp;
+	asm volatile(
+		"mov	%1, %0\n"
+		"rori	%0, 16\n"
+		"addu	%0, %1\n"
+		"lsri	%0, 16\n"
+		:"=r"(csum), "=r"(tmp)
+		:"0"(csum));
+	return (__force __sum16)~csum;
+}
+#define csum_fold csum_fold
+
+static inline __wsum
+csum_tcpudp_nofold(
+	__be32 saddr,
+	__be32 daddr,
+	unsigned short len,
+	unsigned short proto,
+	__wsum sum
+	)
+{
+	asm volatile(
+		"clrc\n"
+		"addc    %0, %1\n"
+		"addc    %0, %2\n"
+		"addc    %0, %3\n"
+		"inct    %0\n"
+		:"=r"(sum)
+		:"r"((__force u32)saddr),
+		"r"((__force u32)daddr),
+#ifdef __BIG_ENDIAN
+		"r"(proto + len),
+#else
+		"r"((proto + len) << 8),
+#endif
+		"0" ((__force unsigned long)sum)
+		:"cc");
+	return sum;
+}
+#define csum_tcpudp_nofold csum_tcpudp_nofold
+
+#include <asm-generic/checksum.h>
+
+#endif /* __ASM_CSKY_CHECKSUM_H */
diff --git a/arch/csky/include/asm/compat.h b/arch/csky/include/asm/compat.h
new file mode 100644
index 0000000..59f9297
--- /dev/null
+++ b/arch/csky/include/asm/compat.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_COMPAT_H
+#define __ASM_CSKY_COMPAT_H
+
+#ifdef CONFIG_COMPAT
+#define COMPAT_UTS_MACHINE "csky\0\0"
+#endif
+
+#endif /* __ASM_CSKY_COMPAT_H */
diff --git a/arch/csky/include/asm/reg_ops.h b/arch/csky/include/asm/reg_ops.h
new file mode 100644
index 0000000..ed7bbde
--- /dev/null
+++ b/arch/csky/include/asm/reg_ops.h
@@ -0,0 +1,22 @@
+#ifndef __ASM_REGS_OPS_H
+#define __ASM_REGS_OPS_H
+
+#define mfcr(reg)				\
+({						\
+	unsigned int tmp;			\
+	asm volatile("mfcr %0, "reg"\n"		\
+		     :"=r"(tmp)			\
+		     :				\
+		     :"memory");		\
+	tmp;					\
+})
+
+#define mtcr(reg, val)				\
+({						\
+	asm volatile("mtcr %0, "reg"\n"		\
+		     :				\
+		     :"r"(val)			\
+		     :"memory");		\
+})
+
+#endif /* __ASM_REGS_OPS_H */
diff --git a/arch/csky/include/uapi/asm/byteorder.h b/arch/csky/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..c758563
--- /dev/null
+++ b/arch/csky/include/uapi/asm/byteorder.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_BYTEORDER_H
+#define __ASM_CSKY_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif /* __ASM_CSKY_BYTEORDER_H */
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
new file mode 100644
index 0000000..4ca6614
--- /dev/null
+++ b/arch/csky/kernel/asm-offsets.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/kbuild.h>
+#include <abi/regdef.h>
+
+int main(void)
+{
+	/* offsets into the task struct */
+	DEFINE(TASK_STATE,        offsetof(struct task_struct, state));
+	DEFINE(TASK_THREAD_INFO,  offsetof(struct task_struct, stack));
+	DEFINE(TASK_FLAGS,        offsetof(struct task_struct, flags));
+	DEFINE(TASK_PTRACE,       offsetof(struct task_struct, ptrace));
+	DEFINE(TASK_THREAD,       offsetof(struct task_struct, thread));
+	DEFINE(TASK_MM,           offsetof(struct task_struct, mm));
+	DEFINE(TASK_ACTIVE_MM,    offsetof(struct task_struct, active_mm));
+
+	/* offsets into the thread struct */
+	DEFINE(THREAD_KSP,        offsetof(struct thread_struct, ksp));
+	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
+	DEFINE(THREAD_ESP0,       offsetof(struct thread_struct, esp0));
+	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
+	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
+	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
+	DEFINE(THREAD_DSPHI,      offsetof(struct thread_struct, hi));
+	DEFINE(THREAD_DSPLO,      offsetof(struct thread_struct, lo));
+
+	/* offsets into the thread_info struct */
+	DEFINE(TINFO_FLAGS,       offsetof(struct thread_info, flags));
+	DEFINE(TINFO_PREEMPT,     offsetof(struct thread_info, preempt_count));
+	DEFINE(TINFO_ADDR_LIMIT,  offsetof(struct thread_info, addr_limit));
+	DEFINE(TINFO_TP_VALUE,   offsetof(struct thread_info, tp_value));
+	DEFINE(TINFO_TASK,        offsetof(struct thread_info, task));
+
+	/* offsets into the pt_regs */
+	DEFINE(PT_PC,             offsetof(struct pt_regs, pc));
+	DEFINE(PT_ORIG_AO,        offsetof(struct pt_regs, orig_a0));
+	DEFINE(PT_SR,             offsetof(struct pt_regs, sr));
+
+	DEFINE(PT_A0,             offsetof(struct pt_regs, a0));
+	DEFINE(PT_A1,             offsetof(struct pt_regs, a1));
+	DEFINE(PT_A2,             offsetof(struct pt_regs, a2));
+	DEFINE(PT_A3,             offsetof(struct pt_regs, a3));
+	DEFINE(PT_REGS0,          offsetof(struct pt_regs, regs[0]));
+	DEFINE(PT_REGS1,          offsetof(struct pt_regs, regs[1]));
+	DEFINE(PT_REGS2,          offsetof(struct pt_regs, regs[2]));
+	DEFINE(PT_REGS3,          offsetof(struct pt_regs, regs[3]));
+	DEFINE(PT_REGS4,          offsetof(struct pt_regs, regs[4]));
+	DEFINE(PT_REGS5,          offsetof(struct pt_regs, regs[5]));
+	DEFINE(PT_REGS6,          offsetof(struct pt_regs, regs[6]));
+	DEFINE(PT_REGS7,          offsetof(struct pt_regs, regs[7]));
+	DEFINE(PT_REGS8,          offsetof(struct pt_regs, regs[8]));
+	DEFINE(PT_REGS9,          offsetof(struct pt_regs, regs[9]));
+	DEFINE(PT_R15,            offsetof(struct pt_regs, lr));
+#if defined(__CSKYABIV2__)
+	DEFINE(PT_R16,            offsetof(struct pt_regs, exregs[0]));
+	DEFINE(PT_R17,            offsetof(struct pt_regs, exregs[1]));
+	DEFINE(PT_R18,            offsetof(struct pt_regs, exregs[2]));
+	DEFINE(PT_R19,            offsetof(struct pt_regs, exregs[3]));
+	DEFINE(PT_R20,            offsetof(struct pt_regs, exregs[4]));
+	DEFINE(PT_R21,            offsetof(struct pt_regs, exregs[5]));
+	DEFINE(PT_R22,            offsetof(struct pt_regs, exregs[6]));
+	DEFINE(PT_R23,            offsetof(struct pt_regs, exregs[7]));
+	DEFINE(PT_R24,            offsetof(struct pt_regs, exregs[8]));
+	DEFINE(PT_R25,            offsetof(struct pt_regs, exregs[9]));
+	DEFINE(PT_R26,            offsetof(struct pt_regs, exregs[10]));
+	DEFINE(PT_R27,            offsetof(struct pt_regs, exregs[11]));
+	DEFINE(PT_R28,            offsetof(struct pt_regs, exregs[12]));
+	DEFINE(PT_R29,            offsetof(struct pt_regs, exregs[13]));
+	DEFINE(PT_R30,            offsetof(struct pt_regs, exregs[14]));
+	DEFINE(PT_R31,            offsetof(struct pt_regs, exregs[15]));
+	DEFINE(PT_RHI,            offsetof(struct pt_regs, rhi));
+	DEFINE(PT_RLO,            offsetof(struct pt_regs, rlo));
+#endif
+	DEFINE(PT_USP,            offsetof(struct pt_regs, usp));
+	/* offsets into the irq_cpustat_t struct */
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
+
+	/* signal defines */
+	DEFINE(SIGSEGV, SIGSEGV);
+	DEFINE(SIGTRAP, SIGTRAP);
+
+	return 0;
+}
-- 
2.7.4
