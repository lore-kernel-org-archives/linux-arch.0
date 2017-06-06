From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Tue,  6 Jun 2017 16:00:03 -0700
Message-ID: <20170606230007.19101-14-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

This patch adds the include files for the RISC-V port.  These are mostly
based on the score port, but there are a lot of arm64-based files as
well.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/Kbuild             |  61 +++++
 arch/riscv/include/asm/asm-offsets.h      |   1 +
 arch/riscv/include/asm/asm.h              |  76 ++++++
 arch/riscv/include/asm/atomic.h           | 349 ++++++++++++++++++++++++
 arch/riscv/include/asm/atomic64.h         | 355 ++++++++++++++++++++++++
 arch/riscv/include/asm/barrier.h          |  41 +++
 arch/riscv/include/asm/bitops.h           | 228 ++++++++++++++++
 arch/riscv/include/asm/bug.h              |  88 ++++++
 arch/riscv/include/asm/cache.h            |  22 ++
 arch/riscv/include/asm/cacheflush.h       |  39 +++
 arch/riscv/include/asm/cmpxchg.h          | 124 +++++++++
 arch/riscv/include/asm/compat.h           |  31 +++
 arch/riscv/include/asm/csr.h              | 125 +++++++++
 arch/riscv/include/asm/current.h          |  42 +++
 arch/riscv/include/asm/delay.h            |  28 ++
 arch/riscv/include/asm/device.h           |  27 ++
 arch/riscv/include/asm/dma-mapping.h      |  41 +++
 arch/riscv/include/asm/elf.h              |  85 ++++++
 arch/riscv/include/asm/io.h               | 152 +++++++++++
 arch/riscv/include/asm/irq.h              |  31 +++
 arch/riscv/include/asm/irqflags.h         |  63 +++++
 arch/riscv/include/asm/kprobes.h          |  22 ++
 arch/riscv/include/asm/linkage.h          |  20 ++
 arch/riscv/include/asm/mmu.h              |  26 ++
 arch/riscv/include/asm/mmu_context.h      |  69 +++++
 arch/riscv/include/asm/page.h             | 138 ++++++++++
 arch/riscv/include/asm/pci.h              |  50 ++++
 arch/riscv/include/asm/pgalloc.h          | 124 +++++++++
 arch/riscv/include/asm/pgtable-32.h       |  25 ++
 arch/riscv/include/asm/pgtable-64.h       |  84 ++++++
 arch/riscv/include/asm/pgtable-bits.h     |  48 ++++
 arch/riscv/include/asm/pgtable.h          | 427 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/processor.h        | 102 +++++++
 arch/riscv/include/asm/ptrace.h           | 116 ++++++++
 arch/riscv/include/asm/sbi.h              | 100 +++++++
 arch/riscv/include/asm/smp.h              |  41 +++
 arch/riscv/include/asm/spinlock.h         | 155 +++++++++++
 arch/riscv/include/asm/spinlock_types.h   |  33 +++
 arch/riscv/include/asm/string.h           |  30 ++
 arch/riscv/include/asm/switch_to.h        |  69 +++++
 arch/riscv/include/asm/syscall.h          |  90 ++++++
 arch/riscv/include/asm/syscalls.h         |  25 ++
 arch/riscv/include/asm/thread_info.h      |  96 +++++++
 arch/riscv/include/asm/timex.h            |  43 +++
 arch/riscv/include/asm/tlb.h              |  24 ++
 arch/riscv/include/asm/tlbflush.h         |  64 +++++
 arch/riscv/include/asm/uaccess.h          | 440 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/unistd.h           |  16 ++
 arch/riscv/include/asm/vdso.h             |  32 +++
 arch/riscv/include/asm/word-at-a-time.h   |  55 ++++
 arch/riscv/include/uapi/asm/Kbuild        |   2 +
 arch/riscv/include/uapi/asm/auxvec.h      |  24 ++
 arch/riscv/include/uapi/asm/bitsperlong.h |  25 ++
 arch/riscv/include/uapi/asm/byteorder.h   |  23 ++
 arch/riscv/include/uapi/asm/elf.h         |  83 ++++++
 arch/riscv/include/uapi/asm/ptrace.h      |  68 +++++
 arch/riscv/include/uapi/asm/sigcontext.h  |  29 ++
 arch/riscv/include/uapi/asm/siginfo.h     |  24 ++
 arch/riscv/include/uapi/asm/unistd.h      |  22 ++
 59 files changed, 4873 insertions(+)
 create mode 100644 arch/riscv/include/asm/Kbuild
 create mode 100644 arch/riscv/include/asm/asm-offsets.h
 create mode 100644 arch/riscv/include/asm/asm.h
 create mode 100644 arch/riscv/include/asm/atomic.h
 create mode 100644 arch/riscv/include/asm/atomic64.h
 create mode 100644 arch/riscv/include/asm/barrier.h
 create mode 100644 arch/riscv/include/asm/bitops.h
 create mode 100644 arch/riscv/include/asm/bug.h
 create mode 100644 arch/riscv/include/asm/cache.h
 create mode 100644 arch/riscv/include/asm/cacheflush.h
 create mode 100644 arch/riscv/include/asm/cmpxchg.h
 create mode 100644 arch/riscv/include/asm/compat.h
 create mode 100644 arch/riscv/include/asm/csr.h
 create mode 100644 arch/riscv/include/asm/current.h
 create mode 100644 arch/riscv/include/asm/delay.h
 create mode 100644 arch/riscv/include/asm/device.h
 create mode 100644 arch/riscv/include/asm/dma-mapping.h
 create mode 100644 arch/riscv/include/asm/elf.h
 create mode 100644 arch/riscv/include/asm/io.h
 create mode 100644 arch/riscv/include/asm/irq.h
 create mode 100644 arch/riscv/include/asm/irqflags.h
 create mode 100644 arch/riscv/include/asm/kprobes.h
 create mode 100644 arch/riscv/include/asm/linkage.h
 create mode 100644 arch/riscv/include/asm/mmu.h
 create mode 100644 arch/riscv/include/asm/mmu_context.h
 create mode 100644 arch/riscv/include/asm/page.h
 create mode 100644 arch/riscv/include/asm/pci.h
 create mode 100644 arch/riscv/include/asm/pgalloc.h
 create mode 100644 arch/riscv/include/asm/pgtable-32.h
 create mode 100644 arch/riscv/include/asm/pgtable-64.h
 create mode 100644 arch/riscv/include/asm/pgtable-bits.h
 create mode 100644 arch/riscv/include/asm/pgtable.h
 create mode 100644 arch/riscv/include/asm/processor.h
 create mode 100644 arch/riscv/include/asm/ptrace.h
 create mode 100644 arch/riscv/include/asm/sbi.h
 create mode 100644 arch/riscv/include/asm/smp.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 arch/riscv/include/asm/spinlock_types.h
 create mode 100644 arch/riscv/include/asm/string.h
 create mode 100644 arch/riscv/include/asm/switch_to.h
 create mode 100644 arch/riscv/include/asm/syscall.h
 create mode 100644 arch/riscv/include/asm/syscalls.h
 create mode 100644 arch/riscv/include/asm/thread_info.h
 create mode 100644 arch/riscv/include/asm/timex.h
 create mode 100644 arch/riscv/include/asm/tlb.h
 create mode 100644 arch/riscv/include/asm/tlbflush.h
 create mode 100644 arch/riscv/include/asm/uaccess.h
 create mode 100644 arch/riscv/include/asm/unistd.h
 create mode 100644 arch/riscv/include/asm/vdso.h
 create mode 100644 arch/riscv/include/asm/word-at-a-time.h
 create mode 100644 arch/riscv/include/uapi/asm/Kbuild
 create mode 100644 arch/riscv/include/uapi/asm/auxvec.h
 create mode 100644 arch/riscv/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/riscv/include/uapi/asm/byteorder.h
 create mode 100644 arch/riscv/include/uapi/asm/elf.h
 create mode 100644 arch/riscv/include/uapi/asm/ptrace.h
 create mode 100644 arch/riscv/include/uapi/asm/sigcontext.h
 create mode 100644 arch/riscv/include/uapi/asm/siginfo.h
 create mode 100644 arch/riscv/include/uapi/asm/unistd.h

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
new file mode 100644
index 000000000000..710397395981
--- /dev/null
+++ b/arch/riscv/include/asm/Kbuild
@@ -0,0 +1,61 @@
+generic-y += bugs.h
+generic-y += cacheflush.h
+generic-y += checksum.h
+generic-y += clkdev.h
+generic-y += cputime.h
+generic-y += div64.h
+generic-y += dma.h
+generic-y += dma-contiguous.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += exec.h
+generic-y += fb.h
+generic-y += fcntl.h
+generic-y += ftrace.h
+generic-y += futex.h
+generic-y += hardirq.h
+generic-y += hash.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += irq_regs.h
+generic-y += irq_work.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += kvm_para.h
+generic-y += local.h
+generic-y += mm-arch-hooks.h
+generic-y += mman.h
+generic-y += module.h
+generic-y += msgbuf.h
+generic-y += mutex.h
+generic-y += param.h
+generic-y += percpu.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += preempt.h
+generic-y += resource.h
+generic-y += scatterlist.h
+generic-y += sections.h
+generic-y += sembuf.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += topology.h
+generic-y += trace_clock.h
+generic-y += types.h
+generic-y += ucontext.h
+generic-y += unaligned.h
+generic-y += user.h
+generic-y += vga.h
+generic-y += vmlinux.lds.h
+generic-y += xor.h
diff --git a/arch/riscv/include/asm/asm-offsets.h b/arch/riscv/include/asm/asm-offsets.h
new file mode 100644
index 000000000000..d370ee36a182
--- /dev/null
+++ b/arch/riscv/include/asm/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
new file mode 100644
index 000000000000..6cbbb6a68d76
--- /dev/null
+++ b/arch/riscv/include/asm/asm.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_ASM_H
+#define _ASM_RISCV_ASM_H
+
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)	x
+#else
+#define __ASM_STR(x)	#x
+#endif
+
+#if __riscv_xlen == 64
+#define __REG_SEL(a, b)	__ASM_STR(a)
+#elif __riscv_xlen == 32
+#define __REG_SEL(a, b)	__ASM_STR(b)
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define REG_L		__REG_SEL(ld, lw)
+#define REG_S		__REG_SEL(sd, sw)
+#define SZREG		__REG_SEL(8, 4)
+#define LGREG		__REG_SEL(3, 2)
+
+#if __SIZEOF_POINTER__ == 8
+#ifdef __ASSEMBLY__
+#define RISCV_PTR		.dword
+#define RISCV_SZPTR		8
+#define RISCV_LGPTR		3
+#else
+#define RISCV_PTR		".dword"
+#define RISCV_SZPTR		"8"
+#define RISCV_LGPTR		"3"
+#endif
+#elif __SIZEOF_POINTER__ == 4
+#ifdef __ASSEMBLY__
+#define RISCV_PTR		.word
+#define RISCV_SZPTR		4
+#define RISCV_LGPTR		2
+#else
+#define RISCV_PTR		".word"
+#define RISCV_SZPTR		"4"
+#define RISCV_LGPTR		"2"
+#endif
+#else
+#error "Unexpected __SIZEOF_POINTER__"
+#endif
+
+#if (__SIZEOF_INT__ == 4)
+#define INT		__ASM_STR(.word)
+#define SZINT		__ASM_STR(4)
+#define LGINT		__ASM_STR(2)
+#else
+#error "Unexpected __SIZEOF_INT__"
+#endif
+
+#if (__SIZEOF_SHORT__ == 2)
+#define SHORT		__ASM_STR(.half)
+#define SZSHORT		__ASM_STR(2)
+#define LGSHORT		__ASM_STR(1)
+#else
+#error "Unexpected __SIZEOF_SHORT__"
+#endif
+
+#endif /* _ASM_RISCV_ASM_H */
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
new file mode 100644
index 000000000000..17ab22036e1a
--- /dev/null
+++ b/arch/riscv/include/asm/atomic.h
@@ -0,0 +1,349 @@
+/*
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_RISCV_ATOMIC_H
+#define _ASM_RISCV_ATOMIC_H
+
+#ifdef CONFIG_ISA_A
+
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#define ATOMIC_INIT(i)	{ (i) }
+
+/**
+ * atomic_read - read atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically reads the value of @v.
+ */
+static inline int atomic_read(const atomic_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+
+/**
+ * atomic_set - set atomic variable
+ * @v: pointer of type atomic_t
+ * @i: required value
+ *
+ * Atomically sets the value of @v to @i.
+ */
+static inline void atomic_set(atomic_t *v, int i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+/**
+ * atomic_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v.
+ */
+static inline void atomic_add(int i, atomic_t *v)
+{
+	__asm__ __volatile__ (
+		"amoadd.w zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (i));
+}
+
+#define atomic_fetch_add atomic_fetch_add
+static inline int atomic_fetch_add(unsigned int mask, atomic_t *v)
+{
+	int out;
+
+	__asm__ __volatile__ (
+		"amoadd.w %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic_sub - subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v.
+ */
+static inline void atomic_sub(int i, atomic_t *v)
+{
+	atomic_add(-i, v);
+}
+
+#define atomic_fetch_sub atomic_fetch_sub
+static inline int atomic_fetch_sub(unsigned int mask, atomic_t *v)
+{
+	int out;
+
+	__asm__ __volatile__ (
+		"amosub.w %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic_add_return - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns the result
+ */
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	register int c;
+
+	__asm__ __volatile__ (
+		"amoadd.w %0, %2, %1"
+		: "=r" (c), "+A" (v->counter)
+		: "r" (i));
+	return (c + i);
+}
+
+/**
+ * atomic_sub_return - subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns the result
+ */
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_add_return(-i, v);
+}
+
+/**
+ * atomic_inc - increment atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1.
+ */
+static inline void atomic_inc(atomic_t *v)
+{
+	atomic_add(1, v);
+}
+
+/**
+ * atomic_dec - decrement atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1.
+ */
+static inline void atomic_dec(atomic_t *v)
+{
+	atomic_add(-1, v);
+}
+
+static inline int atomic_inc_return(atomic_t *v)
+{
+	return atomic_add_return(1, v);
+}
+
+static inline int atomic_dec_return(atomic_t *v)
+{
+	return atomic_sub_return(1, v);
+}
+
+/**
+ * atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic_sub_and_test(int i, atomic_t *v)
+{
+	return (atomic_sub_return(i, v) == 0);
+}
+
+/**
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic_inc_and_test(atomic_t *v)
+{
+	return (atomic_inc_return(v) == 0);
+}
+
+/**
+ * atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static inline int atomic_dec_and_test(atomic_t *v)
+{
+	return (atomic_dec_return(v) == 0);
+}
+
+/**
+ * atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static inline int atomic_add_negative(int i, atomic_t *v)
+{
+	return (atomic_add_return(i, v) < 0);
+}
+
+
+static inline int atomic_xchg(atomic_t *v, int n)
+{
+	register int c;
+
+	__asm__ __volatile__ (
+		"amoswap.w %0, %2, %1"
+		: "=r" (c), "+A" (v->counter)
+		: "r" (n));
+	return c;
+}
+
+static inline int atomic_cmpxchg(atomic_t *v, int o, int n)
+{
+	return cmpxchg(&(v->counter), o, n);
+}
+
+/**
+ * __atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns the old value of @v.
+ */
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	register int prev, rc;
+
+	__asm__ __volatile__ (
+	"0:\n"
+		"lr.w %0, %2\n"
+		"beq  %0, %4, 1f\n"
+		"add  %1, %0, %3\n"
+		"sc.w %1, %1, %2\n"
+		"bnez %1, 0b\n"
+	"1:"
+		: "=&r" (prev), "=&r" (rc), "+A" (v->counter)
+		: "r" (a), "r" (u));
+	return prev;
+}
+
+/**
+ * atomic_and - Atomically clear bits in atomic variable
+ * @mask: Mask of the bits to be retained
+ * @v: pointer of type atomic_t
+ *
+ * Atomically retains the bits set in @mask from @v
+ */
+static inline void atomic_and(unsigned int mask, atomic_t *v)
+{
+	__asm__ __volatile__ (
+		"amoand.w zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+#define atomic_fetch_and atomic_fetch_and
+static inline int atomic_fetch_and(unsigned int mask, atomic_t *v)
+{
+	int out;
+
+	__asm__ __volatile__ (
+		"amoand.w %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic_or - Atomically set bits in atomic variable
+ * @mask: Mask of the bits to be set
+ * @v: pointer of type atomic_t
+ *
+ * Atomically sets the bits set in @mask in @v
+ */
+static inline void atomic_or(unsigned int mask, atomic_t *v)
+{
+	__asm__ __volatile__ (
+		"amoor.w zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+#define atomic_fetch_or atomic_fetch_or
+static inline int atomic_fetch_or(unsigned int mask, atomic_t *v)
+{
+	int out;
+
+	__asm__ __volatile__ (
+		"amoor.w %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic_xor - Atomically flips bits in atomic variable
+ * @mask: Mask of the bits to be flipped
+ * @v: pointer of type atomic_t
+ *
+ * Atomically flips the bits set in @mask in @v
+ */
+static inline void atomic_xor(unsigned int mask, atomic_t *v)
+{
+	__asm__ __volatile__ (
+		"amoxor.w zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+#define atomic_fetch_xor atomic_fetch_xor
+static inline int atomic_fetch_xor(unsigned int mask, atomic_t *v)
+{
+	int out;
+
+	__asm__ __volatile__ (
+		"amoxor.w %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/* Assume that atomic operations are already serializing */
+#define smp_mb__before_atomic_dec()	barrier()
+#define smp_mb__after_atomic_dec()	barrier()
+#define smp_mb__before_atomic_inc()	barrier()
+#define smp_mb__after_atomic_inc()	barrier()
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/atomic.h>
+
+#endif /* CONFIG_ISA_A */
+
+#include <asm/atomic64.h>
+
+#endif /* _ASM_RISCV_ATOMIC_H */
diff --git a/arch/riscv/include/asm/atomic64.h b/arch/riscv/include/asm/atomic64.h
new file mode 100644
index 000000000000..5822c4755f06
--- /dev/null
+++ b/arch/riscv/include/asm/atomic64.h
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_RISCV_ATOMIC64_H
+#define _ASM_RISCV_ATOMIC64_H
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#else /* !CONFIG_GENERIC_ATOMIC64 */
+
+#include <linux/types.h>
+
+#define ATOMIC64_INIT(i)	{ (i) }
+
+/**
+ * atomic64_read - read atomic64 variable
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically reads the value of @v.
+ */
+static inline s64 atomic64_read(const atomic64_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+
+/**
+ * atomic64_set - set atomic64 variable
+ * @v: pointer to type atomic64_t
+ * @i: required value
+ *
+ * Atomically sets the value of @v to @i.
+ */
+static inline void atomic64_set(atomic64_t *v, s64 i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+/**
+ * atomic64_add - add integer to atomic64 variable
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @i to @v.
+ */
+static inline void atomic64_add(s64 a, atomic64_t *v)
+{
+	__asm__ __volatile__ (
+		"amoadd.d zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (a));
+}
+
+static inline long atomic64_fetch_add(unsigned long mask, atomic64_t *v)
+{
+	long out;
+
+	 __asm__ __volatile__ (
+		"amoadd.d %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic64_sub - subtract the atomic64 variable
+ * @i: integer value to subtract
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically subtracts @i from @v.
+ */
+static inline void atomic64_sub(s64 a, atomic64_t *v)
+{
+	atomic64_add(-a, v);
+}
+
+static inline long atomic64_fetch_sub(unsigned long mask, atomic64_t *v)
+{
+	long out;
+
+	__asm__ __volatile__ (
+		"amosub.d %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic64_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static inline s64 atomic64_add_return(s64 a, atomic64_t *v)
+{
+	register s64 c;
+
+	__asm__ __volatile__ (
+		"amoadd.d %0, %2, %1"
+		: "=r" (c), "+A" (v->counter)
+		: "r" (a));
+	return (c + a);
+}
+
+static inline s64 atomic64_sub_return(s64 a, atomic64_t *v)
+{
+	return atomic64_add_return(-a, v);
+}
+
+/**
+ * atomic64_inc - increment atomic64 variable
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically increments @v by 1.
+ */
+static inline void atomic64_inc(atomic64_t *v)
+{
+	atomic64_add(1L, v);
+}
+
+/**
+ * atomic64_dec - decrement atomic64 variable
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically decrements @v by 1.
+ */
+static inline void atomic64_dec(atomic64_t *v)
+{
+	atomic64_add(-1L, v);
+}
+
+static inline s64 atomic64_inc_return(atomic64_t *v)
+{
+	return atomic64_add_return(1L, v);
+}
+
+static inline s64 atomic64_dec_return(atomic64_t *v)
+{
+	return atomic64_add_return(-1L, v);
+}
+
+/**
+ * atomic64_inc_and_test - increment and test
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic64_inc_and_test(atomic64_t *v)
+{
+	return (atomic64_inc_return(v) == 0);
+}
+
+/**
+ * atomic64_dec_and_test - decrement and test
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static inline int atomic64_dec_and_test(atomic64_t *v)
+{
+	return (atomic64_dec_return(v) == 0);
+}
+
+/**
+ * atomic64_sub_and_test - subtract value from variable and test result
+ * @a: integer value to subtract
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically subtracts @a from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic64_sub_and_test(s64 a, atomic64_t *v)
+{
+	return (atomic64_sub_return(a, v) == 0);
+}
+
+/**
+ * atomic64_add_negative - add and test if negative
+ * @a: integer value to add
+ * @v: pointer to type atomic64_t
+ *
+ * Atomically adds @a to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static inline int atomic64_add_negative(s64 a, atomic64_t *v)
+{
+	return (atomic64_add_return(a, v) < 0);
+}
+
+
+static inline s64 atomic64_xchg(atomic64_t *v, s64 n)
+{
+	register s64 c;
+
+	__asm__ __volatile__ (
+		"amoswap.d %0, %2, %1"
+		: "=r" (c), "+A" (v->counter)
+		: "r" (n));
+	return c;
+}
+
+static inline s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+{
+	return cmpxchg(&(v->counter), o, n);
+}
+
+/*
+ * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic_t
+ *
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
+ */
+static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+{
+	register s64 prev, rc;
+
+	__asm__ __volatile__ (
+	"0:\n"
+		"lr.d %0, %2\n"
+		"add  %0, %0, -1\n"
+		"bltz %0, 1f\n"
+		"sc.w %1, %0, %2\n"
+		"bnez %1, 0b\n"
+	"1:\n"
+		: "=&r" (prev), "=r" (rc), "+A" (v->counter));
+	return prev;
+}
+
+/**
+ * atomic64_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns true if the addition occurred and false otherwise.
+ */
+static inline int atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	register s64 tmp;
+	register int rc = 1;
+
+	__asm__ __volatile__ (
+	"0:\n"
+		"lr.d %0, %2\n"
+		"beq  %0, %z4, 1f\n"
+		"add  %0, %0, %3\n"
+		"sc.d %1, %0, %2\n"
+		"bnez %1, 0b\n"
+	"1:"
+		: "=&r" (tmp), "=&r" (rc), "+A" (v->counter)
+		: "rI" (a), "rJ" (u));
+	return !rc;
+}
+
+static inline int atomic64_inc_not_zero(atomic64_t *v)
+{
+	return atomic64_add_unless(v, 1, 0);
+}
+
+/**
+ * atomic64_and - Atomically clear bits in atomic variable
+ * @mask: Mask of the bits to be retained
+ * @v: pointer of type atomic_t
+ *
+ * Atomically retains the bits set in @mask from @v
+ */
+static inline void atomic64_and(s64 mask, atomic64_t *v)
+{
+	__asm__ __volatile__ (
+		"amoand.d zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+static inline long atomic64_fetch_and(unsigned long mask, atomic64_t *v)
+{
+	long out;
+
+	__asm__ __volatile__ (
+		"amoand.d %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic64_or - Atomically set bits in atomic variable
+ * @mask: Mask of the bits to be set
+ * @v: pointer of type atomic_t
+ *
+ * Atomically sets the bits set in @mask in @v
+ */
+static inline void atomic64_or(s64 mask, atomic64_t *v)
+{
+	__asm__ __volatile__ (
+		"amoor.d zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+static inline long atomic64_fetch_or(unsigned long mask, atomic64_t *v)
+{
+	long out;
+
+	__asm__ __volatile__ (
+		"amoor.d %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+/**
+ * atomic64_xor - Atomically flips bits in atomic variable
+ * @mask: Mask of the bits to be flipped
+ * @v: pointer of type atomic_t
+ *
+ * Atomically flips the bits set in @mask in @v
+ */
+static inline void atomic64_xor(s64 mask, atomic64_t *v)
+{
+	__asm__ __volatile__ (
+		"amoxor.d zero, %1, %0"
+		: "+A" (v->counter)
+		: "r" (mask));
+}
+
+static inline long atomic64_fetch_xor(unsigned long mask, atomic64_t *v)
+{
+	long out;
+
+	__asm__ __volatile__ (
+		"amoxor.d %2, %1, %0"
+		: "+A" (v->counter), "=r" (out)
+		: "r" (mask));
+	return out;
+}
+
+#endif /* CONFIG_GENERIC_ATOMIC64 */
+
+#endif /* _ASM_RISCV_ATOMIC64_H */
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
new file mode 100644
index 000000000000..5eb0e501e618
--- /dev/null
+++ b/arch/riscv/include/asm/barrier.h
@@ -0,0 +1,41 @@
+/*
+ * Based on arch/arm/include/asm/barrier.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2013 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_RISCV_BARRIER_H
+#define _ASM_RISCV_BARRIER_H
+
+#ifndef __ASSEMBLY__
+
+#define nop()		__asm__ __volatile__ ("nop")
+
+/* These barries need to enforce ordering on both devices or memory. */
+#define mb()		__asm__ __volatile__ ("fence iorw,iorw" : : : "memory")
+#define rmb()		__asm__ __volatile__ ("fence ir,ir"     : : : "memory")
+#define wmb()		__asm__ __volatile__ ("fence ow,ow"     : : : "memory")
+
+/* These barries do not need to enforce ordering on devices, just memory. */
+#define smp_mb()	__asm__ __volatile__ ("fence rw,rw" : : : "memory")
+#define smp_rmb()	__asm__ __volatile__ ("fence r,r"   : : : "memory")
+#define smp_wmb()	__asm__ __volatile__ ("fence w,w"   : : : "memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_BARRIER_H */
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
new file mode 100644
index 000000000000..27e47858c6b1
--- /dev/null
+++ b/arch/riscv/include/asm/bitops.h
@@ -0,0 +1,228 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_BITOPS_H
+#define _ASM_RISCV_BITOPS_H
+
+#ifndef _LINUX_BITOPS_H
+#error "Only <linux/bitops.h> can be included directly"
+#endif /* _LINUX_BITOPS_H */
+
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <asm/barrier.h>
+#include <asm/bitsperlong.h>
+
+#ifdef CONFIG_ISA_A
+
+#ifndef smp_mb__before_clear_bit
+#define smp_mb__before_clear_bit()  smp_mb()
+#define smp_mb__after_clear_bit()   smp_mb()
+#endif /* smp_mb__before_clear_bit */
+
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffs.h>
+
+#include <asm-generic/bitops/hweight.h>
+
+#if (BITS_PER_LONG == 64)
+#define __AMO(op)	"amo" #op ".d"
+#elif (BITS_PER_LONG == 32)
+#define __AMO(op)	"amo" #op ".w"
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+#define __test_and_op_bit(op, mod, nr, addr)			\
+({								\
+	unsigned long __res, __mask;				\
+	__mask = BIT_MASK(nr);					\
+	__asm__ __volatile__ (					\
+		__AMO(op) " %0, %2, %1"				\
+		: "=r" (__res), "+A" (addr[BIT_WORD(nr)])	\
+		: "r" (mod(__mask)));				\
+	((__res & __mask) != 0);				\
+})
+
+#define __op_bit(op, mod, nr, addr)				\
+	__asm__ __volatile__ (					\
+		__AMO(op) " zero, %1, %0"			\
+		: "+A" (addr[BIT_WORD(nr)])			\
+		: "r" (mod(BIT_MASK(nr))))
+
+/* Bitmask modifiers */
+#define __NOP(x)	(x)
+#define __NOT(x)	(~(x))
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
+	return __test_and_op_bit(or, __NOP, nr, addr);
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reordered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(and, __NOT, nr, addr);
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
+	return __test_and_op_bit(xor, __NOP, nr, addr);
+}
+
+/**
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
+	__op_bit(or, __NOP, nr, addr);
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ */
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	__op_bit(and, __NOT, nr, addr);
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
+	__op_bit(xor, __NOP, nr, addr);
+}
+
+/**
+ * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and provides acquire barrier semantics.
+ * It can be used to implement bit locks.
+ */
+static inline int test_and_set_bit_lock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	return test_and_set_bit(nr, addr);
+}
+
+/**
+ * clear_bit_unlock - Clear a bit in memory, for unlock
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This operation is atomic and provides release barrier semantics.
+ */
+static inline void clear_bit_unlock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+/**
+ * __clear_bit_unlock - Clear a bit in memory, for unlock
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This operation is like clear_bit_unlock, however it is not atomic.
+ * It does provide release barrier semantics so it can be used to unlock
+ * a bit lock, however it would only be used if no other CPU can modify
+ * any bits in the memory until the lock is released (a good example is
+ * if the bit lock itself protects access to the other bits in the word).
+ */
+static inline void __clear_bit_unlock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+#undef __test_and_op_bit
+#undef __op_bit
+#undef __NOP
+#undef __NOT
+#undef __AMO
+
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/bitops.h>
+
+#endif /* CONFIG_ISA_A */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RISCV_BITOPS_H */
diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
new file mode 100644
index 000000000000..e2f690c20729
--- /dev/null
+++ b/arch/riscv/include/asm/bug.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_BUG_H
+#define _ASM_RISCV_BUG_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+
+#include <asm/asm.h>
+
+#ifdef CONFIG_GENERIC_BUG
+#define __BUG_INSN	_AC(0x00100073, UL) /* sbreak */
+
+#ifndef __ASSEMBLY__
+typedef u32 bug_insn_t;
+
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+#define __BUG_ENTRY_ADDR	INT " 1b - 2b"
+#define __BUG_ENTRY_FILE	INT " %0 - 2b"
+#else
+#define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
+#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"		\
+	__BUG_ENTRY_FILE "\n\t"		\
+	SHORT " %1"
+#else
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR
+#endif
+
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ (					\
+		"1:\n\t"					\
+			"sbreak\n"				\
+			".pushsection __bug_table,\"a\"\n\t"	\
+		"2:\n\t"					\
+			__BUG_ENTRY "\n\t"			\
+			".org 2b + %2\n\t"			\
+			".popsection"				\
+		:						\
+		: "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (sizeof(struct bug_entry)));		\
+	unreachable();						\
+} while (0)
+#endif /* !__ASSEMBLY__ */
+#else /* CONFIG_GENERIC_BUG */
+#ifndef __ASSEMBLY__
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ ("sbreak\n");			\
+	unreachable();						\
+} while (0)
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_GENERIC_BUG */
+
+#define HAVE_ARCH_BUG
+
+#include <asm-generic/bug.h>
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs;
+struct task_struct;
+
+extern void die(struct pt_regs *regs, const char *str);
+extern void do_trap(struct pt_regs *regs, int signo, int code,
+	unsigned long addr, struct task_struct *tsk);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_BUG_H */
diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
new file mode 100644
index 000000000000..e8f0d1110d74
--- /dev/null
+++ b/arch/riscv/include/asm/cache.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CACHE_H
+#define _ASM_RISCV_CACHE_H
+
+#define L1_CACHE_SHIFT		6
+
+#define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
+
+#endif /* _ASM_RISCV_CACHE_H */
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
new file mode 100644
index 000000000000..0595585013b0
--- /dev/null
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CACHEFLUSH_H
+#define _ASM_RISCV_CACHEFLUSH_H
+
+#include <asm-generic/cacheflush.h>
+
+#undef flush_icache_range
+#undef flush_icache_user_range
+
+static inline void local_flush_icache_all(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#ifndef CONFIG_SMP
+
+#define flush_icache_range(start, end) local_flush_icache_all()
+#define flush_icache_user_range(vma, pg, addr, len) local_flush_icache_all()
+
+#else /* CONFIG_SMP */
+
+#define flush_icache_range(start, end) sbi_remote_fence_i(0)
+#define flush_icache_user_range(vma, pg, addr, len) sbi_remote_fence_i(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_CACHEFLUSH_H */
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..c7ee1321ac18
--- /dev/null
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CMPXCHG_H
+#define _ASM_RISCV_CMPXCHG_H
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_ISA_A
+
+#include <asm/barrier.h>
+
+#define __xchg(new, ptr, size)					\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		__asm__ __volatile__ (				\
+			"amoswap.w %0, %2, %1"			\
+			: "=r" (__ret), "+A" (*__ptr)		\
+			: "r" (__new));				\
+		break;						\
+	case 8:							\
+		__asm__ __volatile__ (				\
+			"amoswap.d %0, %2, %1"			\
+			: "=r" (__ret), "+A" (*__ptr)		\
+			: "r" (__new));				\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__ret;							\
+})
+
+#define xchg(ptr, x)    (__xchg((x), (ptr), sizeof(*(ptr))))
+
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+#define __cmpxchg(ptr, old, new, size)					\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(old) __old = (old);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	register unsigned int __rc;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+		"0:"							\
+			"lr.w %0, %2\n"					\
+			"bne  %0, %z3, 1f\n"				\
+			"sc.w %1, %z4, %2\n"				\
+			"bnez %1, 0b\n"					\
+		"1:"							\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new));			\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+		"0:"							\
+			"lr.d %0, %2\n"					\
+			"bne  %0, %z3, 1f\n"				\
+			"sc.d %1, %z4, %2\n"				\
+			"bnez %1, 0b\n"					\
+		"1:"							\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new));			\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define __cmpxchg_mb(ptr, old, new, size)			\
+({								\
+	__typeof__(*(ptr)) __ret;				\
+	smp_mb();						\
+	__ret = __cmpxchg((ptr), (old), (new), (size));		\
+	smp_mb();						\
+	__ret;							\
+})
+
+#define cmpxchg(ptr, o, n) \
+	(__cmpxchg_mb((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg_local(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
+
+#define cmpxchg64(ptr, o, n)			\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
+	cmpxchg((ptr), (o), (n));		\
+})
+
+#define cmpxchg64_local(ptr, o, n)		\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
+	cmpxchg_local((ptr), (o), (n));		\
+})
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/cmpxchg.h>
+
+#endif /* CONFIG_ISA_A */
+
+#endif /* _ASM_RISCV_CMPXCHG_H */
diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
new file mode 100644
index 000000000000..b42bf54f42e4
--- /dev/null
+++ b/arch/riscv/include/asm/compat.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_COMPAT_H
+#define __ASM_COMPAT_H
+#ifdef __KERNEL__
+#ifdef CONFIG_COMPAT
+
+#if defined(CONFIG_64BIT)
+#define COMPAT_UTS_MACHINE "riscv64\0\0"
+#elif defined(CONFIG_32BIT)
+#define COMPAT_UTS_MACHINE "riscv32\0\0"
+#else
+#error "Unknown RISC-V base ISA"
+#endif
+
+#endif /*CONFIG_COMPAT*/
+#endif /*__KERNEL__*/
+#endif /*__ASM_COMPAT_H*/
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
new file mode 100644
index 000000000000..387d0dbf0073
--- /dev/null
+++ b/arch/riscv/include/asm/csr.h
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CSR_H
+#define _ASM_RISCV_CSR_H
+
+#include <linux/const.h>
+
+/* Status register flags */
+#define SR_IE   _AC(0x00000002, UL) /* Interrupt Enable */
+#define SR_PIE  _AC(0x00000020, UL) /* Previous IE */
+#define SR_PS   _AC(0x00000100, UL) /* Previously Supervisor */
+#define SR_SUM  _AC(0x00040000, UL) /* Supervisor may access User Memory */
+
+#define SR_FS           _AC(0x00006000, UL) /* Floating-point Status */
+#define SR_FS_OFF       _AC(0x00000000, UL)
+#define SR_FS_INITIAL   _AC(0x00002000, UL)
+#define SR_FS_CLEAN     _AC(0x00004000, UL)
+#define SR_FS_DIRTY     _AC(0x00006000, UL)
+
+#define SR_XS           _AC(0x00018000, UL) /* Extension Status */
+#define SR_XS_OFF       _AC(0x00000000, UL)
+#define SR_XS_INITIAL   _AC(0x00008000, UL)
+#define SR_XS_CLEAN     _AC(0x00010000, UL)
+#define SR_XS_DIRTY     _AC(0x00018000, UL)
+
+#ifndef CONFIG_64BIT
+#define SR_SD   _AC(0x80000000, UL) /* FS/XS dirty */
+#else
+#define SR_SD   _AC(0x8000000000000000, UL) /* FS/XS dirty */
+#endif
+
+/* SPTBR flags */
+#if __riscv_xlen == 32
+#define SPTBR_PPN     _AC(0x003FFFFF, UL)
+#define SPTBR_MODE_32 _AC(0x80000000, UL)
+#define SPTBR_MODE    SPTBR_MODE_32
+#else
+#define SPTBR_PPN     _AC(0x00000FFFFFFFFFFF, UL)
+#define SPTBR_MODE_39 _AC(0x8000000000000000, UL)
+#define SPTBR_MODE    SPTBR_MODE_39
+#endif
+
+/* Interrupt Enable and Interrupt Pending flags */
+#define SIE_SSIE _AC(0x00000002, UL) /* Software Interrupt Enable */
+#define SIE_STIE _AC(0x00000020, UL) /* Timer Interrupt Enable */
+
+#define EXC_INST_MISALIGNED     0
+#define EXC_INST_ACCESS         1
+#define EXC_BREAKPOINT          3
+#define EXC_LOAD_ACCESS         5
+#define EXC_STORE_ACCESS        7
+#define EXC_SYSCALL             8
+#define EXC_INST_PAGE_FAULT     12
+#define EXC_LOAD_PAGE_FAULT     13
+#define EXC_STORE_PAGE_FAULT    15
+
+#ifndef __ASSEMBLY__
+
+#define csr_swap(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrw %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+	__asm__ __volatile__ ("csrr %0, " #csr			\
+			      : "=r" (__v));			\
+	__v;							\
+})
+
+#define csr_write(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrw " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#define csr_read_set(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrs %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_set(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrs " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#define csr_read_clear(csr, val)				\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrrc %0, " #csr ", %1"		\
+			      : "=r" (__v) : "rK" (__v));	\
+	__v;							\
+})
+
+#define csr_clear(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ ("csrc " #csr ", %0"		\
+			      : : "rK" (__v));			\
+})
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
new file mode 100644
index 000000000000..44612c32fc4a
--- /dev/null
+++ b/arch/riscv/include/asm/current.h
@@ -0,0 +1,42 @@
+/*
+ * Based on arm/arm64/include/asm/current.h
+ *
+ * Copyright (C) 2016 ARM
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+
+#ifndef __ASM_CURRENT_H
+#define __ASM_CURRENT_H
+
+#include <linux/compiler.h>
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+
+/* This only works because "struct thread_info" is at offset 0 from "struct
+ * task_struct".  This constraint seems to be necessary on other architectures
+ * as well, but __switch_to enforces it.  We can't check TASK_TI here because
+ * <asm/asm-offsets.h> includes this, and I can't get the definition of "struct
+ * task_struct" here due to some header ordering problems.  */
+static __always_inline struct task_struct *get_current(void)
+{
+	register struct task_struct *tp __asm__("tp");
+	return tp;
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CURRENT_H */
diff --git a/arch/riscv/include/asm/delay.h b/arch/riscv/include/asm/delay.h
new file mode 100644
index 000000000000..cbb0c9eb96cb
--- /dev/null
+++ b/arch/riscv/include/asm/delay.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2016 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_DELAY_H
+#define _ASM_RISCV_DELAY_H
+
+extern unsigned long riscv_timebase;
+
+#define udelay udelay
+extern void udelay(unsigned long usecs);
+
+#define ndelay ndelay
+extern void ndelay(unsigned long nsecs);
+
+extern void __delay(unsigned long cycles);
+
+#endif /* _ASM_RISCV_DELAY_H */
diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
new file mode 100644
index 000000000000..28975e528d2f
--- /dev/null
+++ b/arch/riscv/include/asm/device.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2016 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+
+#ifndef _ASM_RISCV_DEVICE_H
+#define _ASM_RISCV_DEVICE_H
+
+#include <linux/sysfs.h>
+
+struct dev_archdata {
+	struct dma_map_ops *dma_ops;
+};
+
+struct pdev_archdata {
+};
+
+#endif /* _ASM_RISCV_DEVICE_H */
diff --git a/arch/riscv/include/asm/dma-mapping.h b/arch/riscv/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..9485a58e839e
--- /dev/null
+++ b/arch/riscv/include/asm/dma-mapping.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2003-2004 Hewlett-Packard Co
+ *	David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_RISCV_DMA_MAPPING_H
+#define __ASM_RISCV_DMA_MAPPING_H
+
+#ifdef __KERNEL__
+
+/* Use ops->dma_mapping_error (if it exists) or assume success */
+// #undef DMA_ERROR_CODE
+
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+{
+	return &dma_noop_ops;
+}
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+#endif	/* __KERNEL__ */
+#endif	/* __ASM_RISCV_DMA_MAPPING_H */
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
new file mode 100644
index 000000000000..add1245690f6
--- /dev/null
+++ b/arch/riscv/include/asm/elf.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
+ * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _ASM_RISCV_ELF_H
+#define _ASM_RISCV_ELF_H
+
+#include <uapi/asm/elf.h>
+#include <asm/auxvec.h>
+#include <asm/byteorder.h>
+
+/* TODO: Move definition into include/uapi/linux/elf-em.h */
+#define EM_RISCV	0xF3
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_ARCH	EM_RISCV
+
+#ifdef CONFIG_64BIT
+#define ELF_CLASS	ELFCLASS64
+#else
+#define ELF_CLASS	ELFCLASS32
+#endif
+
+#if defined(__LITTLE_ENDIAN)
+#define ELF_DATA	ELFDATA2LSB
+#elif defined(__BIG_ENDIAN)
+#define ELF_DATA	ELFDATA2MSB
+#else
+#error "Unknown endianness"
+#endif
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+
+#define CORE_DUMP_USE_REGSET
+#define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
+
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+ * use of this is to invoke "./ld.so someprog" to test out a new version of
+ * the loader.  We need to make sure that it is out of the way of the program
+ * that it will "exec", and that there is sufficient room for the brk.
+ */
+#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
+
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this CPU supports.  This could be done in user space,
+ * but it's not easy, and we've already done it here.
+ */
+#define ELF_HWCAP	(0)
+
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.  This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
+#define ELF_PLATFORM	(NULL)
+
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
+		(elf_addr_t)current->mm->context.vdso);		\
+} while (0)
+
+
+#ifdef __KERNEL__
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
+struct linux_binprm;
+extern int arch_setup_additional_pages(struct linux_binprm *bprm,
+	int uses_interp);
+#endif
+
+#endif /* _ASM_RISCV_ELF_H */
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
new file mode 100644
index 000000000000..a3ee80082b88
--- /dev/null
+++ b/arch/riscv/include/asm/io.h
@@ -0,0 +1,152 @@
+/*
+ * {read,write}{b,w,l,q} based on arch/arm64/include/asm/io.h
+ *   which was based on arch/arm/include/io.h
+ *
+ * Copyright (C) 1996-2000 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_IO_H
+#define _ASM_RISCV_IO_H
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_MMU
+
+extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+#define ioremap_nocache(addr, size) ioremap((addr), (size))
+#define ioremap_wc(addr, size) ioremap((addr), (size))
+#define ioremap_wt(addr, size) ioremap((addr), (size))
+
+extern void iounmap(void __iomem *addr);
+
+#endif /* CONFIG_MMU */
+
+/*
+ * Generic IO read/write.  These perform native-endian accesses.
+ */
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+	asm volatile("sb %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	asm volatile("sh %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("sw %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#ifdef __riscv64
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+	asm volatile("sd %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+#endif
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	asm volatile("lb %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	asm volatile("lh %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	asm volatile("lw %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#ifdef __riscv64
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	asm volatile("ld %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+#endif
+
+/* IO barriers.  These only fence on the IO bits because they're only required
+ * to order device access.  We're defining mmiowb because our AMO instructions
+ * (which are used to implement locks) don't specify ordering.  From Chapter 7
+ * of v2.2 of the user ISA:
+ * "The bits order accesses to one of the two address domains, memory or I/O,
+ * depending on which address domain the atomic instruction is accessing. No
+ * ordering constraint is implied to accesses to the other domain, and a FENCE
+ * instruction should be used to order across both domains."
+ */
+
+#define __iormb()	__asm__ __volatile__ ("fence i,io" : : : "memory");
+#define __iowmb()	__asm__ __volatile__ ("fence io,o" : : : "memory");
+
+#define mmiowb()	__asm__ __volatile__ ("fence io,io" : : : "memory");
+
+/*
+ * Relaxed I/O memory access primitives. These follow the Device memory
+ * ordering rules but do not guarantee any ordering relative to Normal memory
+ * accesses.
+ */
+#define readb_relaxed(c)	({ u8  __r = __raw_readb(c); __r; })
+#define readw_relaxed(c)	({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
+#define readl_relaxed(c)	({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+#define readq_relaxed(c)	({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
+
+#define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
+#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
+#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
+
+/*
+ * I/O memory access primitives. Reads are ordered relative to any
+ * following Normal memory access. Writes are ordered relative to any prior
+ * Normal memory access.
+ */
+#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(); __v; })
+
+#define writeb(v,c)		({ __iowmb(); writeb_relaxed((v),(c)); })
+#define writew(v,c)		({ __iowmb(); writew_relaxed((v),(c)); })
+#define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c)); })
+#define writeq(v,c)		({ __iowmb(); writeq_relaxed((v),(c)); })
+
+#include <asm-generic/io.h>
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
new file mode 100644
index 000000000000..e64c61e89f76
--- /dev/null
+++ b/arch/riscv/include/asm/irq.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_IRQ_H
+#define _ASM_RISCV_IRQ_H
+
+#define NR_IRQS         0
+
+#define INTERRUPT_CAUSE_SOFTWARE    1
+#define INTERRUPT_CAUSE_TIMER       5
+#define INTERRUPT_CAUSE_EXTERNAL    9
+
+void riscv_timer_interrupt(void);
+
+#include <asm-generic/irq.h>
+
+/* The value of csr sie before init_traps runs (core is up) */
+DECLARE_PER_CPU(atomic_long_t, riscv_early_sie);
+
+#endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
new file mode 100644
index 000000000000..6fdc860d7f84
--- /dev/null
+++ b/arch/riscv/include/asm/irqflags.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+
+#ifndef _ASM_RISCV_IRQFLAGS_H
+#define _ASM_RISCV_IRQFLAGS_H
+
+#include <asm/processor.h>
+#include <asm/csr.h>
+
+/* read interrupt enabled status */
+static inline unsigned long arch_local_save_flags(void)
+{
+	return csr_read(sstatus);
+}
+
+/* unconditionally enable interrupts */
+static inline void arch_local_irq_enable(void)
+{
+	csr_set(sstatus, SR_IE);
+}
+
+/* unconditionally disable interrupts */
+static inline void arch_local_irq_disable(void)
+{
+	csr_clear(sstatus, SR_IE);
+}
+
+/* get status and disable interrupts */
+static inline unsigned long arch_local_irq_save(void)
+{
+	return csr_read_clear(sstatus, SR_IE);
+}
+
+/* test flags */
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & SR_IE);
+}
+
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+/* set interrupt enabled status */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	csr_set(sstatus, flags & SR_IE);
+}
+
+#endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
new file mode 100644
index 000000000000..1190de7a0f74
--- /dev/null
+++ b/arch/riscv/include/asm/kprobes.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+
+#ifndef ASM_RISCV_KPROBES_H
+#define ASM_RISCV_KPROBES_H
+
+#ifdef CONFIG_KPROBES
+#error "RISC-V doesn't skpport CONFIG_KPROBES"
+#endif
+
+#endif
diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
new file mode 100644
index 000000000000..b7b304ca89c4
--- /dev/null
+++ b/arch/riscv/include/asm/linkage.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_LINKAGE_H
+#define _ASM_RISCV_LINKAGE_H
+
+#define __ALIGN		.balign 4
+#define __ALIGN_STR	".balign 4"
+
+#endif /* _ASM_RISCV_LINKAGE_H */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
new file mode 100644
index 000000000000..66805cba9a27
--- /dev/null
+++ b/arch/riscv/include/asm/mmu.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+
+#ifndef _ASM_RISCV_MMU_H
+#define _ASM_RISCV_MMU_H
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	void *vdso;
+} mm_context_t;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
new file mode 100644
index 000000000000..de1fc1631fc4
--- /dev/null
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_MMU_CONTEXT_H
+#define _ASM_RISCV_MMU_CONTEXT_H
+
+#include <asm-generic/mm_hooks.h>
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <asm/tlbflush.h>
+
+static inline void enter_lazy_tlb(struct mm_struct *mm,
+	struct task_struct *task)
+{
+}
+
+/* Initialize context-related info for a new mm_struct */
+static inline int init_new_context(struct task_struct *task,
+	struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void destroy_context(struct mm_struct *mm)
+{
+}
+
+static inline pgd_t *current_pgdir(void)
+{
+	return pfn_to_virt(csr_read(sptbr) & SPTBR_PPN);
+}
+
+static inline void set_pgdir(pgd_t *pgd)
+{
+	csr_write(sptbr, virt_to_pfn(pgd) | SPTBR_MODE);
+}
+
+static inline void switch_mm(struct mm_struct *prev,
+	struct mm_struct *next, struct task_struct *task)
+{
+	if (likely(prev != next)) {
+		set_pgdir(next->pgd);
+		local_flush_tlb_all();
+	}
+}
+
+static inline void activate_mm(struct mm_struct *prev,
+			       struct mm_struct *next)
+{
+	switch_mm(prev, next, NULL);
+}
+
+static inline void deactivate_mm(struct task_struct *task,
+	struct mm_struct *mm)
+{
+}
+
+#endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
new file mode 100644
index 000000000000..e1491c20d6fd
--- /dev/null
+++ b/arch/riscv/include/asm/page.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2017 XiaojingZhu <zhuxiaoj@ict.ac.cn>
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PAGE_H
+#define _ASM_RISCV_PAGE_H
+
+#include <linux/pfn.h>
+#include <linux/const.h>
+
+#define PAGE_SHIFT	(12)
+#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE - 1))
+
+#ifdef __KERNEL__
+
+/*
+ * PAGE_OFFSET -- the first address of the first page of memory.
+ * When not using MMU this corresponds to the first free page in
+ * physical memory (aligned on a page boundary).
+ */
+#ifdef CONFIG_64BIT
+#define PAGE_OFFSET		_AC(0xffffffff80000000, UL)
+#else
+#define PAGE_OFFSET		_AC(0xc0000000, UL)
+#endif
+
+#define KERN_VIRT_SIZE (-PAGE_OFFSET)
+
+#ifndef __ASSEMBLY__
+
+#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
+#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
+
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
+
+/* align addr on a size boundary - adjust address up if needed */
+#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
+
+#define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
+#define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)
+
+#define clear_user_page(pgaddr, vaddr, page)	memset((pgaddr), 0, PAGE_SIZE)
+#define copy_user_page(vto, vfrom, vaddr, topg) \
+			memcpy((vto), (vfrom), PAGE_SIZE)
+
+/*
+ * Use struct definitions to apply C type checking
+ */
+
+/* Page Global Directory entry */
+typedef struct {
+	unsigned long pgd;
+} pgd_t;
+
+/* Page Table entry */
+typedef struct {
+	unsigned long pte;
+} pte_t;
+
+typedef struct {
+	unsigned long pgprot;
+} pgprot_t;
+
+typedef struct page *pgtable_t;
+
+#define pte_val(x)	((x).pte)
+#define pgd_val(x)	((x).pgd)
+#define pgprot_val(x)	((x).pgprot)
+
+#define __pte(x)	((pte_t) { (x) })
+#define __pgd(x)	((pgd_t) { (x) })
+#define __pgprot(x)	((pgprot_t) { (x) })
+
+#ifdef CONFIG_64BITS
+#define PTE_FMT "%016lx"
+#else
+#define PTE_FMT "%08lx"
+#endif
+
+extern unsigned long va_pa_offset;
+extern unsigned long pfn_base;
+
+extern unsigned long max_low_pfn;
+extern unsigned long min_low_pfn;
+
+#define __pa(x)		((unsigned long)(x) - va_pa_offset)
+#define __va(x)		((void *)((unsigned long) (x) + va_pa_offset))
+
+#define phys_to_pfn(phys)	(PFN_DOWN(phys))
+#define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
+
+#define virt_to_pfn(vaddr)	(phys_to_pfn(__pa(vaddr)))
+#define pfn_to_virt(pfn)	(__va(pfn_to_phys(pfn)))
+
+#define virt_to_page(vaddr)	(pfn_to_page(virt_to_pfn(vaddr)))
+#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
+
+#define page_to_phys(page)	(pfn_to_phys(page_to_pfn(page)))
+#define page_to_bus(page)	(page_to_phys(page))
+#define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
+
+#define pfn_valid(pfn) \
+	(((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
+
+#define ARCH_PFN_OFFSET		(pfn_base)
+
+#endif /* __ASSEMBLY__ */
+
+#define virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
+
+#endif /* __KERNEL__ */
+
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#include <asm-generic/memory_model.h>
+#include <asm-generic/getorder.h>
+
+/* vDSO support */
+/* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
+#define __HAVE_ARCH_GATE_AREA
+
+#endif /* _ASM_RISCV_PAGE_H */
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
new file mode 100644
index 000000000000..c829a4ce8d25
--- /dev/null
+++ b/arch/riscv/include/asm/pci.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2016 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef __ASM_RISCV_PCI_H
+#define __ASM_RISCV_PCI_H
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0
+
+/* RISC-V shim does not initialize PCI bus */
+#define pcibios_assign_all_busses() 1
+
+/* RISC-V TileLink and PCIe share the share address space */
+#define PCI_DMA_BUS_IS_PHYS 1
+
+extern int isa_dma_bridge_buggy;
+
+#ifdef CONFIG_PCI
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on risc-v */
+	return -ENODEV;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif  /* CONFIG_PCI */
+
+#endif  /* __KERNEL__ */
+#endif  /* __ASM_PCI_H */
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
new file mode 100644
index 000000000000..b40074bcb164
--- /dev/null
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGALLOC_H
+#define _ASM_RISCV_PGALLOC_H
+
+#include <linux/mm.h>
+#include <asm/tlb.h>
+
+static inline void pmd_populate_kernel(struct mm_struct *mm,
+	pmd_t *pmd, pte_t *pte)
+{
+	unsigned long pfn = virt_to_pfn(pte);
+
+	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+
+static inline void pmd_populate(struct mm_struct *mm,
+	pmd_t *pmd, pgtable_t pte)
+{
+	unsigned long pfn = virt_to_pfn(page_address(pte));
+
+	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
+{
+	unsigned long pfn = virt_to_pfn(pmd);
+
+	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+}
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+#define pmd_pgtable(pmd)	pmd_page(pmd)
+
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	pgd_t *pgd;
+
+	pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
+	if (likely(pgd != NULL)) {
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
+		/* Copy kernel mappings */
+		memcpy(pgd + USER_PTRS_PER_PGD,
+			init_mm.pgd + USER_PTRS_PER_PGD,
+			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	}
+	return pgd;
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	free_page((unsigned long)pgd);
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return (pmd_t *)__get_free_page(
+		GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	free_page((unsigned long)pmd);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
+
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+	unsigned long address)
+{
+	return (pte_t *)__get_free_page(
+		GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+}
+
+static inline struct page *pte_alloc_one(struct mm_struct *mm,
+	unsigned long address)
+{
+	struct page *pte;
+
+	pte = alloc_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);
+	if (likely(pte != NULL))
+		pgtable_page_ctor(pte);
+	return pte;
+}
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
+{
+	pgtable_page_dtor(pte);
+	__free_page(pte);
+}
+
+#define __pte_free_tlb(tlb, pte, buf)   \
+do {                                    \
+	pgtable_page_dtor(pte);         \
+	tlb_remove_page((tlb), pte);    \
+} while (0)
+
+static inline void check_pgt_cache(void)
+{
+}
+
+#endif /* _ASM_RISCV_PGALLOC_H */
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
new file mode 100644
index 000000000000..d61974b74182
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_32_H
+#define _ASM_RISCV_PGTABLE_32_H
+
+#include <asm-generic/pgtable-nopmd.h>
+#include <linux/const.h>
+
+/* Size of region mapped by a page global directory */
+#define PGDIR_SHIFT     22
+#define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK      (~(PGDIR_SIZE - 1))
+
+#endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
new file mode 100644
index 000000000000..7aa0ea9bd8bb
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_64_H
+#define _ASM_RISCV_PGTABLE_64_H
+
+#include <linux/const.h>
+
+#define PGDIR_SHIFT     30
+/* Size of region mapped by a page global directory */
+#define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
+#define PGDIR_MASK      (~(PGDIR_SIZE - 1))
+
+#define PMD_SHIFT       21
+/* Size of region mapped by a page middle directory */
+#define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
+#define PMD_MASK        (~(PMD_SIZE - 1))
+
+/* Page Middle Directory entry */
+typedef struct {
+	unsigned long pmd;
+} pmd_t;
+
+#define pmd_val(x)      ((x).pmd)
+#define __pmd(x)        ((pmd_t) { (x) })
+
+#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+
+static inline int pud_present(pud_t pud)
+{
+	return (pud_val(pud) & _PAGE_PRESENT);
+}
+
+static inline int pud_none(pud_t pud)
+{
+	return (pud_val(pud) == 0);
+}
+
+static inline int pud_bad(pud_t pud)
+{
+	return !pud_present(pud);
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pud)
+{
+	*pudp = pud;
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	set_pud(pudp, __pud(0));
+}
+
+static inline unsigned long pud_page_vaddr(pud_t pud)
+{
+	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+}
+
+#define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
+static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
+{
+	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
+}
+
+static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+{
+	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+#define pmd_ERROR(e) \
+	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+
+#endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
new file mode 100644
index 000000000000..997ddbb1d370
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_BITS_H
+#define _ASM_RISCV_PGTABLE_BITS_H
+
+/*
+ * PTE format:
+ * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
+ *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ */
+
+#define _PAGE_ACCESSED_OFFSET 6
+
+#define _PAGE_PRESENT   (1 << 0)
+#define _PAGE_READ      (1 << 1)    /* Readable */
+#define _PAGE_WRITE     (1 << 2)    /* Writable */
+#define _PAGE_EXEC      (1 << 3)    /* Executable */
+#define _PAGE_USER      (1 << 4)    /* User */
+#define _PAGE_GLOBAL    (1 << 5)    /* Global */
+#define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
+#define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
+#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
+
+#define _PAGE_SPECIAL   _PAGE_SOFT
+#define _PAGE_TABLE     _PAGE_PRESENT
+
+#define _PAGE_PFN_SHIFT 10
+
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL))
+
+/* Advertise support for _PAGE_SPECIAL */
+#define __HAVE_ARCH_PTE_SPECIAL
+
+#endif /* _ASM_RISCV_PGTABLE_BITS_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
new file mode 100644
index 000000000000..8bb44014f5c3
--- /dev/null
+++ b/arch/riscv/include/asm/pgtable.h
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PGTABLE_H
+#define _ASM_RISCV_PGTABLE_H
+
+#include <linux/mmzone.h>
+
+#include <asm/pgtable-bits.h>
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_MMU
+
+/* Page Upper Directory not used in RISC-V */
+#include <asm-generic/pgtable-nopud.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
+#include <linux/mm_types.h>
+
+#ifdef CONFIG_64BIT
+#include <asm/pgtable-64.h>
+#else
+#include <asm/pgtable-32.h>
+#endif /* CONFIG_64BIT */
+
+/* Number of entries in the page global directory */
+#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
+/* Number of entries in the page table */
+#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+
+/* Number of PGD entries that a user-mode program can use */
+#define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
+#define FIRST_USER_ADDRESS  0
+
+/* Page protection bits */
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
+
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
+#define PAGE_WRITE		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE)
+#define PAGE_EXEC		__pgprot(_PAGE_BASE | _PAGE_EXEC)
+#define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+#define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
+					 _PAGE_EXEC | _PAGE_WRITE)
+
+#define PAGE_COPY		PAGE_READ
+#define PAGE_COPY_EXEC		PAGE_EXEC
+#define PAGE_COPY_READ_EXEC	PAGE_READ_EXEC
+#define PAGE_SHARED		PAGE_WRITE
+#define PAGE_SHARED_EXEC	PAGE_WRITE_EXEC
+
+#define _PAGE_KERNEL		(_PAGE_READ \
+				| _PAGE_WRITE \
+				| _PAGE_PRESENT \
+				| _PAGE_ACCESSED \
+				| _PAGE_DIRTY)
+
+#define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
+
+extern pgd_t swapper_pg_dir[];
+
+/* MAP_PRIVATE permissions: xwr (copy-on-write) */
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READ
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_EXEC
+#define __P101	PAGE_READ_EXEC
+#define __P110	PAGE_COPY_EXEC
+#define __P111	PAGE_COPY_READ_EXEC
+
+/* MAP_SHARED permissions: xwr */
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READ
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_EXEC
+#define __S101	PAGE_READ_EXEC
+#define __S110	PAGE_SHARED_EXEC
+#define __S111	PAGE_SHARED_EXEC
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero,
+ * used for zero-mapped memory areas, etc.
+ */
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PAGE_PRESENT);
+}
+
+static inline int pmd_none(pmd_t pmd)
+{
+	return (pmd_val(pmd) == 0);
+}
+
+static inline int pmd_bad(pmd_t pmd)
+{
+	return !pmd_present(pmd);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	*pmdp = pmd;
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	set_pmd(pmdp, __pmd(0));
+}
+
+
+static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
+{
+	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+#define pgd_index(addr) (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+
+/* Locate an entry in the page global directory */
+static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
+{
+	return mm->pgd + pgd_index(addr);
+}
+/* Locate an entry in the kernel page global directory */
+#define pgd_offset_k(addr)      pgd_offset(&init_mm, (addr))
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+}
+
+static inline unsigned long pmd_page_vaddr(pmd_t pmd)
+{
+	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
+}
+
+/* Yields the page frame number (PFN) of a page table entry */
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
+}
+
+#define pte_page(x)     pfn_to_page(pte_pfn(x))
+
+/* Constructs a page table entry */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
+{
+	return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+static inline pte_t mk_pte(struct page *page, pgprot_t prot)
+{
+	return pfn_pte(page_to_pfn(page), prot);
+}
+
+#define pte_index(addr) (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+
+static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long addr)
+{
+	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(addr);
+}
+
+#define pte_offset_map(dir, addr)	pte_offset_kernel((dir), (addr))
+#define pte_unmap(pte)			((void)(pte))
+
+/*
+ * Certain architectures need to do special things when PTEs within
+ * a page table are directly modified.  Thus, the following hook is
+ * made available.
+ */
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	*ptep = pteval;
+}
+
+static inline void set_pte_at(struct mm_struct *mm,
+	unsigned long addr, pte_t *ptep, pte_t pteval)
+{
+	set_pte(ptep, pteval);
+}
+
+static inline void pte_clear(struct mm_struct *mm,
+	unsigned long addr, pte_t *ptep)
+{
+	set_pte_at(mm, addr, ptep, __pte(0));
+}
+
+static inline int pte_present(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT);
+}
+
+static inline int pte_none(pte_t pte)
+{
+	return (pte_val(pte) == 0);
+}
+
+/* static inline int pte_read(pte_t pte) */
+
+static inline int pte_write(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_WRITE;
+}
+
+static inline int pte_huge(pte_t pte)
+{
+	return pte_present(pte)
+		&& (pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+/* static inline int pte_exec(pte_t pte) */
+
+static inline int pte_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DIRTY;
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
+static inline int pte_special(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SPECIAL;
+}
+
+/* static inline pte_t pte_rdprotect(pte_t pte) */
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+}
+
+/* static inline pte_t pte_mkread(pte_t pte) */
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_WRITE);
+}
+
+/* static inline pte_t pte_mkexec(pte_t pte) */
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_DIRTY));
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_ACCESSED));
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+/* Modify page protection bits */
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))
+
+
+/* Commit new configuration to MMU hardware */
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep)
+{
+	/* The kernel assumes that TLBs don't cache invalid entries, but
+	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
+	 * cache flush; it is necessary even after writing invalid entries.
+	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
+	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
+	 */
+	local_flush_tlb_page(address);
+}
+
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+	return pte_val(pte_a) == pte_val(pte_b);
+}
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline int ptep_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pte_t *ptep,
+					pte_t entry, int dirty)
+{
+	if (!pte_same(*ptep, entry))
+		set_pte_at(vma->vm_mm, address, ptep, entry);
+	/* update_mmu_cache will unconditionally execute, handling both
+	 * the case that the PTE changed and the spurious fault case.
+	 */
+	return true;
+}
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+}
+
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
+}
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pte_t *ptep)
+{
+	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+}
+
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	/*
+	 * This comment is borrowed from x86, but applies equally to RISC-V:
+	 *
+	 * Clearing the accessed bit without a TLB flush
+	 * doesn't cause data corruption. [ It could cause incorrect
+	 * page aging and the (mistaken) reclaim of hot pages, but the
+	 * chance of that should be relatively low. ]
+	 *
+	 * So as a performance optimization don't flush the TLB when
+	 * clearing the accessed bit, it will eventually be flushed by
+	 * a context switch or a VM operation anyway. [ In the rare
+	 * event of it not getting flushed for a long time the delay
+	 * shouldn't really matter because there's no real memory
+	 * pressure for swapout to react to. ]
+	 */
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
+/*
+ * Encode and decode a swap entry
+ *
+ * Format of swap PTE:
+ *	bit            0:	_PAGE_PRESENT (zero)
+ *	bit            1:	reserved for future use (zero)
+ *	bits      2 to 6:	swap type
+ *	bits 7 to XLEN-1:	swap offset
+ */
+#define __SWP_TYPE_SHIFT	2
+#define __SWP_TYPE_BITS		5
+#define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
+#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+
+#define MAX_SWAPFILES_CHECK()	\
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
+
+#define __swp_type(x)	(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
+#define __swp_offset(x)	((x).val >> __SWP_OFFSET_SHIFT)
+#define __swp_entry(type, offset) ((swp_entry_t) \
+	{ ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+#ifdef CONFIG_FLATMEM
+#define kern_addr_valid(addr)   (1) /* FIXME */
+#endif
+
+extern void paging_init(void);
+
+static inline void pgtable_cache_init(void)
+{
+	/* No page table caches to initialize */
+}
+
+#endif /* CONFIG_MMU */
+
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+/* Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
+ * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
+ */
+#ifdef CONFIG_64BIT
+#define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#else
+#define TASK_SIZE VMALLOC_START
+#endif
+
+#include <asm-generic/pgtable.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PGTABLE_H */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
new file mode 100644
index 000000000000..0e523a75a8a0
--- /dev/null
+++ b/arch/riscv/include/asm/processor.h
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PROCESSOR_H
+#define _ASM_RISCV_PROCESSOR_H
+
+#include <linux/const.h>
+
+#include <asm/ptrace.h>
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE >> 1)
+
+#ifdef __KERNEL__
+#define STACK_TOP		TASK_SIZE
+#define STACK_TOP_MAX		STACK_TOP
+#define STACK_ALIGN		16
+#endif /* __KERNEL__ */
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+struct pt_regs;
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr()	({ __label__ _l; _l: &&_l; })
+
+/* CPU-specific state of a task */
+struct thread_struct {
+	/* Callee-saved registers */
+	unsigned long ra;
+	unsigned long sp;	/* Kernel mode stack */
+	unsigned long s[12];	/* s[0]: frame pointer */
+	struct user_fpregs_struct fstate;
+};
+
+#define INIT_THREAD {					\
+	.sp = sizeof(init_stack) + (long)&init_stack,	\
+}
+
+/* Return saved (kernel) PC of a blocked thread. */
+#define thread_saved_pc(t)	((t)->thread.ra)
+#define thread_saved_sp(t)	((t)->thread.sp)
+#define thread_saved_fp(t)	((t)->thread.s[0])
+
+#define task_pt_regs(tsk)						\
+	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE		\
+			    - ALIGN(sizeof(struct pt_regs), STACK_ALIGN)))
+
+#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->sepc)
+#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
+
+
+/* Do necessary setup to start up a newly executed thread. */
+extern void start_thread(struct pt_regs *regs,
+			unsigned long pc, unsigned long sp);
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+extern unsigned long get_wchan(struct task_struct *p);
+
+
+static inline void cpu_relax(void)
+{
+#ifdef __riscv_muldiv
+	int dummy;
+	/* In lieu of a halt instruction, induce a long-latency stall. */
+	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+#endif
+	barrier();
+}
+
+static inline void wait_for_interrupt(void)
+{
+	__asm__ __volatile__ ("wfi");
+}
+
+struct device_node;
+extern int riscv_of_processor_hart(struct device_node *node);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
new file mode 100644
index 000000000000..340201868842
--- /dev/null
+++ b/arch/riscv/include/asm/ptrace.h
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_PTRACE_H
+#define _ASM_RISCV_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+#include <asm/csr.h>
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long sepc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+	/* Supervisor CSRs */
+	unsigned long sstatus;
+	unsigned long sbadaddr;
+	unsigned long scause;
+};
+
+#ifdef CONFIG_64BIT
+#define REG_FMT "%016lx"
+#else
+#define REG_FMT "%08lx"
+#endif
+
+#define user_mode(regs) (((regs)->sstatus & SR_PS) == 0)
+
+
+/* Helpers for working with the instruction pointer */
+#define GET_IP(regs) ((regs)->sepc)
+#define SET_IP(regs, val) (GET_IP(regs) = (val))
+
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return GET_IP(regs);
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	SET_IP(regs, val);
+}
+
+#define profile_pc(regs) instruction_pointer(regs)
+
+/* Helpers for working with the user stack pointer */
+#define GET_USP(regs) ((regs)->sp)
+#define SET_USP(regs, val) (GET_USP(regs) = (val))
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return GET_USP(regs);
+}
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+					  unsigned long val)
+{
+	SET_USP(regs, val);
+}
+
+/* Helpers for working with the frame pointer */
+#define GET_FP(regs) ((regs)->s0)
+#define SET_FP(regs, val) (GET_FP(regs) = (val))
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return GET_FP(regs);
+}
+static inline void frame_pointer_set(struct pt_regs *regs,
+				     unsigned long val)
+{
+	SET_FP(regs, val);
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
new file mode 100644
index 000000000000..b6bb10b92fe2
--- /dev/null
+++ b/arch/riscv/include/asm/sbi.h
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SBI_H
+#define _ASM_RISCV_SBI_H
+
+#include <linux/types.h>
+
+#define SBI_SET_TIMER 0
+#define SBI_CONSOLE_PUTCHAR 1
+#define SBI_CONSOLE_GETCHAR 2
+#define SBI_CLEAR_IPI 3
+#define SBI_SEND_IPI 4
+#define SBI_REMOTE_FENCE_I 5
+#define SBI_REMOTE_SFENCE_VMA 6
+#define SBI_REMOTE_SFENCE_VMA_ASID 7
+#define SBI_SHUTDOWN 8
+
+#define SBI_CALL(which, arg0, arg1, arg2) ({			\
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(which);	\
+	asm volatile ("ecall"					\
+		      : "+r" (a0)				\
+		      : "r" (a1), "r" (a2), "r" (a7)		\
+		      : "memory");				\
+	a0;							\
+})
+
+/* Lazy implementations until SBI is finalized */
+#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0)
+#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0)
+#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0)
+
+static inline void sbi_console_putchar(int ch)
+{
+	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
+}
+
+static inline int sbi_console_getchar(void)
+{
+	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
+}
+
+static inline void sbi_set_timer(uint64_t stime_value)
+{
+#if __riscv_xlen == 32
+	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
+#else
+	SBI_CALL_1(SBI_SET_TIMER, stime_value);
+#endif
+}
+
+static inline void sbi_shutdown(void)
+{
+	SBI_CALL_0(SBI_SHUTDOWN);
+}
+
+static inline void sbi_clear_ipi(void)
+{
+	SBI_CALL_0(SBI_CLEAR_IPI);
+}
+
+static inline void sbi_send_ipi(const unsigned long *hart_mask)
+{
+	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
+}
+
+static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
+{
+	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
+}
+
+static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
+					 unsigned long start,
+					 unsigned long size)
+{
+	SBI_CALL_1(SBI_REMOTE_SFENCE_VMA, hart_mask);
+}
+
+static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
+					      unsigned long start,
+					      unsigned long size,
+					      unsigned long asid)
+{
+	SBI_CALL_1(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask);
+}
+
+#endif
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
new file mode 100644
index 000000000000..f61f8c25f95b
--- /dev/null
+++ b/arch/riscv/include/asm/smp.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SMP_H
+#define _ASM_RISCV_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+
+#ifdef CONFIG_SMP
+
+/* SMP initialization hook for setup_arch */
+void __init init_clockevent(void);
+
+/* SMP initialization hook for setup_arch */
+void __init setup_smp(void);
+
+/* Hook for the generic smp_call_function_many() routine. */
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+/* Hook for the generic smp_call_function_single() routine. */
+void arch_send_call_function_single_ipi(int cpu);
+
+#define raw_smp_processor_id() (current_thread_info()->cpu)
+
+/* Interprocessor interrupt handler */
+irqreturn_t handle_ipi(void);
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..9736f5714e54
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,155 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SPINLOCK_H
+#define _ASM_RISCV_SPINLOCK_H
+
+#include <linux/kernel.h>
+#include <asm/current.h>
+
+/*
+ * Simple spin lock operations.  These provide no fairness guarantees.
+ */
+
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+#define arch_spin_is_locked(x)	((x)->lock != 0)
+#define arch_spin_unlock_wait(x) \
+		do { cpu_relax(); } while ((x)->lock)
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	__asm__ __volatile__ (
+		"amoswap.w.rl x0, x0, %0"
+		: "=A" (lock->lock)
+		:: "memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	int tmp = 1, busy;
+
+	__asm__ __volatile__ (
+		"amoswap.w.aq %0, %2, %1"
+		: "=r" (busy), "+A" (lock->lock)
+		: "r" (tmp)
+		: "memory");
+
+	return !busy;
+}
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	while (1) {
+		if (arch_spin_is_locked(lock))
+			continue;
+
+		if (arch_spin_trylock(lock))
+			break;
+	}
+}
+
+/***********************************************************/
+
+static inline int arch_read_can_lock(arch_rwlock_t *lock)
+{
+	return lock->lock >= 0;
+}
+
+static inline int arch_write_can_lock(arch_rwlock_t *lock)
+{
+	return lock->lock == 0;
+}
+
+static inline void arch_read_lock(arch_rwlock_t *lock)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bltz	%1, 1b\n"
+		"	addi	%1, %1, 1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		: "+A" (lock->lock), "=&r" (tmp)
+		:: "memory");
+}
+
+static inline void arch_write_lock(arch_rwlock_t *lock)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bnez	%1, 1b\n"
+		"	li	%1, -1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		: "+A" (lock->lock), "=&r" (tmp)
+		:: "memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *lock)
+{
+	int busy;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bltz	%1, 1f\n"
+		"	addi	%1, %1, 1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		"1:\n"
+		: "+A" (lock->lock), "=&r" (busy)
+		:: "memory");
+
+	return !busy;
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *lock)
+{
+	int busy;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bnez	%1, 1f\n"
+		"	li	%1, -1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		"1:\n"
+		: "+A" (lock->lock), "=&r" (busy)
+		:: "memory");
+
+	return !busy;
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *lock)
+{
+	__asm__ __volatile__(
+		"amoadd.w.rl x0, %1, %0"
+		: "+A" (lock->lock)
+		: "r" (-1)
+		: "memory");
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *lock)
+{
+	__asm__ __volatile__ (
+		"amoswap.w.rl x0, x0, %0"
+		: "=A" (lock->lock)
+		:: "memory");
+}
+
+#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
+
+#endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..83ac4ac9e2ac
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SPINLOCK_TYPES_H
+#define _ASM_RISCV_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
new file mode 100644
index 000000000000..1c59cf4e8ccc
--- /dev/null
+++ b/arch/riscv/include/asm/string.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2013 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_STRING_H
+#define _ASM_RISCV_STRING_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+#define __HAVE_ARCH_MEMSET
+extern asmlinkage void *memset(void *, int, size_t);
+
+#define __HAVE_ARCH_MEMCPY
+extern asmlinkage void *memcpy(void *, const void *, size_t);
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RISCV_STRING_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
new file mode 100644
index 000000000000..dd6b05bff75b
--- /dev/null
+++ b/arch/riscv/include/asm/switch_to.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SWITCH_TO_H
+#define _ASM_RISCV_SWITCH_TO_H
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/csr.h>
+
+extern void __fstate_save(struct task_struct *save_to);
+extern void __fstate_restore(struct task_struct *restore_from);
+
+static inline void __fstate_clean(struct pt_regs *regs)
+{
+	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+}
+
+static inline void fstate_save(struct task_struct *task,
+			       struct pt_regs *regs)
+{
+	if ((regs->sstatus & SR_FS) == SR_FS_DIRTY) {
+		__fstate_save(task);
+		__fstate_clean(regs);
+	}
+}
+
+static inline void fstate_restore(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	if ((regs->sstatus & SR_FS) != SR_FS_OFF) {
+		__fstate_restore(task);
+		__fstate_clean(regs);
+	}
+}
+
+static inline void __switch_to_aux(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	struct pt_regs *regs;
+
+	regs = task_pt_regs(prev);
+	if (unlikely(regs->sstatus & SR_SD))
+		fstate_save(prev, regs);
+	fstate_restore(next, task_pt_regs(next));
+}
+
+extern struct task_struct *__switch_to(struct task_struct *,
+				       struct task_struct *);
+
+#define switch_to(prev, next, last)			\
+do {							\
+	struct task_struct *__prev = (prev);		\
+	struct task_struct *__next = (next);		\
+	__switch_to_aux(__prev, __next);		\
+	((last) = __switch_to(__prev, __next));		\
+} while (0)
+
+#endif /* _ASM_RISCV_SWITCH_TO_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
new file mode 100644
index 000000000000..c70f0e7a06b8
--- /dev/null
+++ b/arch/riscv/include/asm/syscall.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
+ * Copyright 2010 Tilera Corporation. All Rights Reserved.
+ * Copyright 2015 Regents of the University of California, Berkeley
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ * See asm-generic/syscall.h for descriptions of what we must do here.
+ */
+
+#ifndef _ASM_RISCV_SYSCALL_H
+#define _ASM_RISCV_SYSCALL_H
+
+#include <linux/sched.h>
+#include <linux/err.h>
+
+/* The array of function pointers for syscalls. */
+extern void *sys_call_table[];
+
+/*
+ * Only the low 32 bits of orig_r0 are meaningful, so we return int.
+ * This importantly ignores the high bits on 64-bit, so comparisons
+ * sign-extend the low 32 bits.
+ */
+static inline int syscall_get_nr(struct task_struct *task,
+				 struct pt_regs *regs)
+{
+	return regs->a7;
+}
+
+static inline void syscall_set_nr(struct task_struct *task,
+				  struct pt_regs *regs,
+				  int sysno)
+{
+	regs->a7 = sysno;
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				    struct pt_regs *regs)
+{
+	/* FIXME: We can't do this... */
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->a0;
+
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+					    struct pt_regs *regs,
+					    int error, long val)
+{
+	regs->a0 = (long) error ?: val;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	memcpy(args, &regs->a0 + i * sizeof(regs->a0), n * sizeof(args[0]));
+}
+
+static inline void syscall_set_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 const unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	memcpy(&regs->a0 + i * sizeof(regs->a0), args, n * sizeof(regs->a0));
+}
+
+#endif	/* _ASM_TILE_SYSCALL_H */
diff --git a/arch/riscv/include/asm/syscalls.h b/arch/riscv/include/asm/syscalls.h
new file mode 100644
index 000000000000..d85267c4f7ea
--- /dev/null
+++ b/arch/riscv/include/asm/syscalls.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2014 Darius Rad <darius@bluespec.com>
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SYSCALLS_H
+#define _ASM_RISCV_SYSCALLS_H
+
+#include <linux/linkage.h>
+
+#include <asm-generic/syscalls.h>
+
+/* kernel/sys_riscv.c */
+asmlinkage long sys_sysriscv(unsigned long, unsigned long,
+	unsigned long, unsigned long);
+
+#endif /* _ASM_RISCV_SYSCALLS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
new file mode 100644
index 000000000000..f05b7d68c1ad
--- /dev/null
+++ b/arch/riscv/include/asm/thread_info.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_THREAD_INFO_H
+#define _ASM_RISCV_THREAD_INFO_H
+
+#ifdef __KERNEL__
+
+#include <asm/page.h>
+#include <linux/const.h>
+
+/* thread information allocation */
+#define THREAD_SIZE_ORDER	(1)
+#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
+
+#ifndef __ASSEMBLY__
+
+#include <asm/processor.h>
+#include <asm/csr.h>
+
+typedef unsigned long mm_segment_t;
+
+/*
+ * low level task data that entry.S needs immediate access to
+ * - this struct should fit entirely inside of one cache line
+ * - if the members of this struct changes, the assembly constants
+ *   in asm-offsets.c must be updated accordingly
+ * - thread_info is included in task_struct at an offset of 0.  This means that
+ *   tp points to both thread_info and task_struct.
+ */
+struct thread_info {
+	unsigned long		flags;		/* low level flags */
+	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	mm_segment_t		addr_limit;
+	/* These stack pointers are overwritten on every system call or
+	 * exception.  SP is also saved to the stack it can be recovered when
+	 * overwritten.
+	 */
+	long			kernel_sp;	/* Kernel stack pointer */
+	long			user_sp;	/* User stack pointer */
+};
+
+/*
+ * macros/functions for gaining access to the thread information structure
+ *
+ * preempt_count needs to be 1 initially, until the scheduler is functional.
+ */
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+	.preempt_count	= INIT_PREEMPT_COUNT,	\
+	.addr_limit	= KERNEL_DS,		\
+}
+
+#define init_stack		(init_thread_union.stack)
+
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * thread information flags
+ * - these are process state flags that various assembly files may need to
+ *   access
+ * - pending work-to-be-done flags are in lowest half-word
+ * - other flags in upper half-word(s)
+ */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
+#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
+#define TIF_SIGPENDING		2	/* signal pending */
+#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
+#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
+#define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
+
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+
+#define _TIF_WORK_MASK \
+	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED)
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
new file mode 100644
index 000000000000..bb66b83352fb
--- /dev/null
+++ b/arch/riscv/include/asm/timex.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_TIMEX_H
+#define _ASM_RISCV_TIMEX_H
+
+#include <asm/param.h>
+
+#ifdef __KERNEL__
+
+typedef unsigned long cycles_t;
+
+static inline cycles_t get_cycles(void)
+{
+	cycles_t n;
+
+	__asm__ __volatile__ (
+		"rdtime %0"
+		: "=r" (n));
+	return n;
+}
+
+#define ARCH_HAS_READ_CURRENT_TIMER
+
+static inline int read_current_timer(unsigned long *timer_val)
+{
+	*timer_val = get_cycles();
+	return 0;
+}
+
+#endif
+
+#endif /* _ASM_RISCV_TIMEX_H */
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
new file mode 100644
index 000000000000..c229509288ea
--- /dev/null
+++ b/arch/riscv/include/asm/tlb.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_TLB_H
+#define _ASM_RISCV_TLB_H
+
+#include <asm-generic/tlb.h>
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	flush_tlb_mm(tlb->mm);
+}
+
+#endif /* _ASM_RISCV_TLB_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
new file mode 100644
index 000000000000..5ee4ae370b5e
--- /dev/null
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_TLBFLUSH_H
+#define _ASM_RISCV_TLBFLUSH_H
+
+#ifdef CONFIG_MMU
+
+/* Flush entire local TLB */
+static inline void local_flush_tlb_all(void)
+{
+	__asm__ __volatile__ ("sfence.vma" : : : "memory");
+}
+
+/* Flush one page from local TLB */
+static inline void local_flush_tlb_page(unsigned long addr)
+{
+	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
+}
+
+#ifndef CONFIG_SMP
+
+#define flush_tlb_all() local_flush_tlb_all()
+#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
+#define flush_tlb_range(vma, start, end) local_flush_tlb_all()
+
+#else /* CONFIG_SMP */
+
+#include <asm/sbi.h>
+
+#define flush_tlb_all() sbi_remote_sfence_vma(0, 0, -1)
+#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+#define flush_tlb_range(vma, start, end) \
+	sbi_remote_sfence_vma(0, start, (end) - (start))
+
+#endif /* CONFIG_SMP */
+
+/* Flush the TLB entries of the specified mm context */
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	flush_tlb_all();
+}
+
+/* Flush a range of kernel pages */
+static inline void flush_tlb_kernel_range(unsigned long start,
+	unsigned long end)
+{
+	flush_tlb_all();
+}
+
+#endif /* CONFIG_MMU */
+
+#endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
new file mode 100644
index 000000000000..f3ece74219d7
--- /dev/null
+++ b/arch/riscv/include/asm/uaccess.h
@@ -0,0 +1,440 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ * This file was copied from include/asm-generic/uaccess.h
+ */
+
+#ifndef _ASM_RISCV_UACCESS_H
+#define _ASM_RISCV_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/errno.h>
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <asm/byteorder.h>
+#include <asm/asm.h>
+
+#ifdef CONFIG_RV_PUM
+#define __enable_user_access()							\
+	__asm__ __volatile__ ("csrs sstatus, %0" : : "r" (SR_SUM) : "memory")
+#define __disable_user_access()							\
+	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
+#else
+#define __enable_user_access()
+#define __disable_user_access()
+#endif
+
+/*
+ * The fs value determines whether argument validity checking should be
+ * performed or not.  If get_fs() == USER_DS, checking is performed, with
+ * get_fs() == KERNEL_DS, checking is bypassed.
+ *
+ * For historical reasons, these macros are grossly misnamed.
+ */
+
+#define KERNEL_DS	(~0UL)
+#define USER_DS		(TASK_SIZE)
+
+#define get_ds()	(KERNEL_DS)
+#define get_fs()	(current_thread_info()->addr_limit)
+
+static inline void set_fs(mm_segment_t fs)
+{
+	current_thread_info()->addr_limit = fs;
+}
+
+#define segment_eq(a, b) ((a) == (b))
+
+#define user_addr_max()	(get_fs())
+
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+/**
+ * access_ok: - Checks if a user space pointer is valid
+ * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
+ *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
+ *        to write to a block, it is always safe to read from it.
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns true (nonzero) if the memory block may be valid, false (zero)
+ * if it is definitely invalid.
+ *
+ * Note that, depending on architecture, this function probably just
+ * checks that the pointer is in the user space range - after calling
+ * this function, memory access functions may still return -EFAULT.
+ */
+#define access_ok(type, addr, size) ({					\
+	__chk_user_ptr(addr);						\
+	likely(__access_ok((unsigned long __force)(addr), (size)));	\
+})
+
+/* Ensure that the range [addr, addr+size) is within the process's
+ * address space
+ */
+static inline int __access_ok(unsigned long addr, unsigned long size)
+{
+	const mm_segment_t fs = get_fs();
+
+	return (size <= fs) && (addr <= (fs - size));
+}
+
+/*
+ * The exception table consists of pairs of addresses: the first is the
+ * address of an instruction that is allowed to fault, and the second is
+ * the address at which the program should continue.  No registers are
+ * modified, so it is entirely up to the continuation code to figure out
+ * what to do.
+ *
+ * All the routines below use bits of fixup code that are out of line
+ * with the main instruction path.  This means when everything is well,
+ * we don't even have to jump over them.  Further, they do not intrude
+ * on our cache or tlb entries.
+ */
+
+struct exception_table_entry {
+	unsigned long insn, fixup;
+};
+
+extern int fixup_exception(struct pt_regs *state);
+
+#if defined(__LITTLE_ENDIAN)
+#define __MSW	1
+#define __LSW	0
+#elif defined(__BIG_ENDIAN)
+#define __MSW	0
+#define	__LSW	1
+#else
+#error "Unknown endianness"
+#endif
+
+/*
+ * The "__xxx" versions of the user access functions do not verify the address
+ * space - it must have been done previously with a separate "access_ok()"
+ * call.
+ */
+
+#ifdef CONFIG_MMU
+#define __get_user_asm(insn, x, ptr, err)			\
+do {								\
+	uintptr_t __tmp;					\
+	__typeof__(x) __x;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	" insn " %1, %3\n"			\
+		"2:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"3:\n"						\
+		"	li %0, %4\n"				\
+		"	li %1, 0\n"				\
+		"	jump 2b, %2\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 3b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=&r" (__x), "=r" (__tmp)		\
+		: "m" (*(ptr)), "i" (-EFAULT));			\
+	__disable_user_access();				\
+	(x) = __x;						\
+} while (0)
+#endif /* CONFIG_MMU */
+
+#ifdef CONFIG_64BIT
+#define __get_user_8(x, ptr, err) \
+	__get_user_asm("ld", x, ptr, err)
+#else /* !CONFIG_64BIT */
+#ifdef CONFIG_MMU
+#define __get_user_8(x, ptr, err)				\
+do {								\
+	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u32 __lo, __hi;						\
+	uintptr_t __tmp;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	lw %1, %4\n"				\
+		"2:\n"						\
+		"	lw %2, %5\n"				\
+		"3:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"4:\n"						\
+		"	li %0, %6\n"				\
+		"	li %1, 0\n"				\
+		"	li %2, 0\n"				\
+		"	jump 3b, %3\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 4b\n"			\
+		"	" RISCV_PTR " 2b, 4b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=&r" (__lo), "=r" (__hi),	\
+			"=r" (__tmp)				\
+		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]),	\
+			"i" (-EFAULT));				\
+	__disable_user_access();				\
+	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
+		(((u64)__hi << 32) | __lo)));			\
+} while (0)
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_64BIT */
+
+
+/**
+ * __get_user: - Get a simple variable from user space, with less checking.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define __get_user(x, ptr)					\
+({								\
+	register long __gu_err = 0;				\
+	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	__chk_user_ptr(__gu_ptr);				\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 2:							\
+		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 4:							\
+		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 8:							\
+		__get_user_8((x), __gu_ptr, __gu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__gu_err;						\
+})
+
+/**
+ * get_user: - Get a simple variable from user space.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define get_user(x, ptr)					\
+({								\
+	const __typeof__(*(ptr)) __user *__p = (ptr);		\
+	might_fault();						\
+	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?		\
+		__get_user((x), __p) :				\
+		((x) = 0, -EFAULT);				\
+})
+
+
+#ifdef CONFIG_MMU
+#define __put_user_asm(insn, x, ptr, err)			\
+do {								\
+	uintptr_t __tmp;					\
+	__typeof__(*(ptr)) __x = x;				\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	" insn " %z3, %2\n"			\
+		"2:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"3:\n"						\
+		"	li %0, %4\n"				\
+		"	jump 2b, %1\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 3b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=r" (__tmp), "=m" (*(ptr))	\
+		: "rJ" (__x), "i" (-EFAULT));			\
+	__disable_user_access();				\
+} while (0)
+#endif /* CONFIG_MMU */
+
+
+#ifdef CONFIG_64BIT
+#define __put_user_8(x, ptr, err) \
+	__put_user_asm("sd", x, ptr, err)
+#else /* !CONFIG_64BIT */
+#ifdef CONFIG_MMU
+#define __put_user_8(x, ptr, err)				\
+do {								\
+	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u64 __x = (__typeof__((x)-(x)))(x);			\
+	uintptr_t __tmp;					\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+		"1:\n"						\
+		"	sw %z4, %2\n"				\
+		"2:\n"						\
+		"	sw %z5, %3\n"				\
+		"3:\n"						\
+		"	.section .fixup,\"ax\"\n"		\
+		"	.balign 4\n"				\
+		"4:\n"						\
+		"	li %0, %6\n"				\
+		"	jump 2b, %1\n"				\
+		"	.previous\n"				\
+		"	.section __ex_table,\"a\"\n"		\
+		"	.balign " RISCV_SZPTR "\n"			\
+		"	" RISCV_PTR " 1b, 4b\n"			\
+		"	" RISCV_PTR " 2b, 4b\n"			\
+		"	.previous"				\
+		: "+r" (err), "=r" (__tmp),			\
+			"=m" (__ptr[__LSW]),			\
+			"=m" (__ptr[__MSW])			\
+		: "rJ" (__x), "rJ" (__x >> 32), "i" (-EFAULT));	\
+	__disable_user_access();				\
+} while (0)
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_64BIT */
+
+
+/**
+ * __put_user: - Write a simple value into user space, with less checking.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define __put_user(x, ptr)					\
+({								\
+	register long __pu_err = 0;				\
+	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	__chk_user_ptr(__gu_ptr);				\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 2:							\
+		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 4:							\
+		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 8:							\
+		__put_user_8((x), __gu_ptr, __pu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__pu_err;						\
+})
+
+/**
+ * put_user: - Write a simple value into user space.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define put_user(x, ptr)					\
+({								\
+	__typeof__(*(ptr)) __user *__p = (ptr);			\
+	might_fault();						\
+	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?		\
+		__put_user((x), __p) :				\
+		-EFAULT;					\
+})
+
+
+extern unsigned long __must_check __copy_user(void __user *to,
+	const void __user *from, unsigned long n);
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+static inline unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+
+extern long __must_check strlen_user(const char __user *str);
+extern long __must_check strnlen_user(const char __user *str, long n);
+
+extern
+unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
+
+static inline
+unsigned long __must_check clear_user(void __user *to, unsigned long n)
+{
+	might_fault();
+	return access_ok(VERIFY_WRITE, to, n) ?
+		__clear_user(to, n) : n;
+}
+
+#endif /* _ASM_RISCV_UACCESS_H */
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
new file mode 100644
index 000000000000..9f250ed007cd
--- /dev/null
+++ b/arch/riscv/include/asm/unistd.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#define __ARCH_HAVE_MMU
+#define __ARCH_WANT_SYS_CLONE
+#include <uapi/asm/unistd.h>
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
new file mode 100644
index 000000000000..95768a3810a7
--- /dev/null
+++ b/arch/riscv/include/asm/vdso.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_RISCV_VDSO_H
+#define _ASM_RISCV_VDSO_H
+
+#include <linux/types.h>
+
+struct vdso_data {
+};
+
+#define VDSO_SYMBOL(base, name)					\
+({								\
+	extern const char __vdso_##name[];			\
+	(void __user *)((unsigned long)(base) + __vdso_##name);	\
+})
+
+#endif /* _ASM_RISCV_VDSO_H */
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
new file mode 100644
index 000000000000..aa6238791d3e
--- /dev/null
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ * Derived from arch/x86/include/asm/word-at-a-time.h
+ */
+
+#ifndef _ASM_RISCV_WORD_AT_A_TIME_H
+#define _ASM_RISCV_WORD_AT_A_TIME_H
+
+
+#include <linux/kernel.h>
+
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+static inline unsigned long has_zero(unsigned long val,
+	unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long mask = ((val - c->one_bits) & ~val) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long val,
+	unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return fls64(mask) >> 3;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+#endif /* _ASM_RISCV_WORD_AT_A_TIME_H */
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..b15bf6bc0e94
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+# UAPI Header export list
+include include/uapi/asm-generic/Kbuild.asm
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..1376515547cd
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_ASM_RISCV_AUXVEC_H
+#define _UAPI_ASM_RISCV_AUXVEC_H
+
+/* vDSO location */
+#define AT_SYSINFO_EHDR 33
+
+#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/include/uapi/asm/bitsperlong.h b/arch/riscv/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..0b3cb52fd29d
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_ASM_RISCV_BITSPERLONG_H
+#define _UAPI_ASM_RISCV_BITSPERLONG_H
+
+#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/arch/riscv/include/uapi/asm/byteorder.h b/arch/riscv/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..4ca38af2cd32
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/byteorder.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_ASM_RISCV_BYTEORDER_H
+#define _UAPI_ASM_RISCV_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif /* _UAPI_ASM_RISCV_BYTEORDER_H */
diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
new file mode 100644
index 000000000000..e438edd97589
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
+ * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _UAPI_ASM_ELF_H
+#define _UAPI_ASM_ELF_H
+
+#include <asm/ptrace.h>
+
+/* ELF register definitions */
+typedef unsigned long elf_greg_t;
+typedef struct user_regs_struct elf_gregset_t;
+#define ELF_NGREG (sizeof(elf_gregset_t) / sizeof(elf_greg_t))
+
+typedef struct user_fpregs_struct elf_fpregset_t;
+
+#define ELF_RISCV_R_SYM(r_info) ((r_info) >> 32)
+#define ELF_RISCV_R_TYPE(r_info) ((r_info) & 0xffffffff)
+
+/*
+ * RISC-V relocation types
+ */
+
+/* Relocation types used by the dynamic linker */
+#define R_RISCV_NONE		0
+#define R_RISCV_32		1
+#define R_RISCV_64		2
+#define R_RISCV_RELATIVE	3
+#define R_RISCV_COPY		4
+#define R_RISCV_JUMP_SLOT	5
+#define R_RISCV_TLS_DTPMOD32	6
+#define R_RISCV_TLS_DTPMOD64	7
+#define R_RISCV_TLS_DTPREL32	8
+#define R_RISCV_TLS_DTPREL64	9
+#define R_RISCV_TLS_TPREL32	10
+#define R_RISCV_TLS_TPREL64	11
+
+/* Relocation types not used by the dynamic linker */
+#define R_RISCV_BRANCH		16
+#define R_RISCV_JAL		17
+#define R_RISCV_CALL		18
+#define R_RISCV_CALL_PLT	19
+#define R_RISCV_GOT_HI20	20
+#define R_RISCV_TLS_GOT_HI20	21
+#define R_RISCV_TLS_GD_HI20	22
+#define R_RISCV_PCREL_HI20	23
+#define R_RISCV_PCREL_LO12_I	24
+#define R_RISCV_PCREL_LO12_S	25
+#define R_RISCV_HI20		26
+#define R_RISCV_LO12_I		27
+#define R_RISCV_LO12_S		28
+#define R_RISCV_TPREL_HI20	29
+#define R_RISCV_TPREL_LO12_I	30
+#define R_RISCV_TPREL_LO12_S	31
+#define R_RISCV_TPREL_ADD	32
+#define R_RISCV_ADD8		33
+#define R_RISCV_ADD16		34
+#define R_RISCV_ADD32		35
+#define R_RISCV_ADD64		36
+#define R_RISCV_SUB8		37
+#define R_RISCV_SUB16		38
+#define R_RISCV_SUB32		39
+#define R_RISCV_SUB64		40
+#define R_RISCV_GNU_VTINHERIT	41
+#define R_RISCV_GNU_VTENTRY	42
+#define R_RISCV_ALIGN		43
+#define R_RISCV_RVC_BRANCH	44
+#define R_RISCV_RVC_JUMP	45
+#define R_RISCV_LUI			46
+#define R_RISCV_GPREL_I		47
+#define R_RISCV_GPREL_S		48
+#define R_RISCV_TPREL_I		49
+#define R_RISCV_TPREL_S		50
+#define R_RISCV_RELAX		51
+
+#endif /* _UAPI_ASM_ELF_H */
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..b95ee16e6896
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_ASM_RISCV_PTRACE_H
+#define _UAPI_ASM_RISCV_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* User-mode register state for core dumps, ptrace, sigcontext
+ *
+ * This decouples struct pt_regs from the userspace ABI.
+ * struct user_regs_struct must form a prefix of struct pt_regs.
+ */
+struct user_regs_struct {
+	unsigned long pc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+};
+
+struct user_fpregs_struct {
+	__u64 f[32];
+	__u32 fcsr;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..dc882d598834
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_ASM_RISCV_SIGCONTEXT_H
+#define _UAPI_ASM_RISCV_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+/* Signal context structure
+ *
+ * This contains the context saved before a signal handler is invoked;
+ * it is restored by sys_sigreturn / sys_rt_sigreturn.
+ */
+struct sigcontext {
+	struct user_regs_struct sc_regs;
+	struct user_fpregs_struct sc_fpregs;
+};
+
+#endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
diff --git a/arch/riscv/include/uapi/asm/siginfo.h b/arch/riscv/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..f96849aac662
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/siginfo.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#define __ARCH_SI_PREAMBLE_SIZE	(__SIZEOF_POINTER__ == 4 ? 12 : 16)
+
+#include <asm-generic/siginfo.h>
+
+#endif
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..aedba7d32370
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <asm-generic/unistd.h>
+
+#define __NR_sysriscv  __NR_arch_specific_syscall
+#ifndef __riscv_atomic
+__SYSCALL(__NR_sysriscv, sys_sysriscv)
+#endif
+
+#define RISCV_ATOMIC_CMPXCHG    1
+#define RISCV_ATOMIC_CMPXCHG64  2
-- 
2.13.0
