From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v10 06/19] h8300: Assembly headers.
Date: Mon,  4 May 2015 19:41:49 +0900
Message-ID: <1430736122-20929-8-git-send-email-ysato@users.sourceforge.jp>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:56221 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbbEDKms (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 06:42:48 -0400
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/include/asm/Kbuild        |  72 ++++++++++++++
 arch/h8300/include/asm/atomic.h      | 159 ++++++++++++++++++++++++++++++
 arch/h8300/include/asm/bitops.h      | 185 +++++++++++++++++++++++++++++++++++
 arch/h8300/include/asm/bitsperlong.h |  14 +++
 arch/h8300/include/asm/bootparams.h  |  17 ++++
 arch/h8300/include/asm/bug.h         |  12 +++
 arch/h8300/include/asm/cache.h       |  11 +++
 arch/h8300/include/asm/checksum.h    | 102 +++++++++++++++++++
 arch/h8300/include/asm/cmpxchg.h     |  65 ++++++++++++
 arch/h8300/include/asm/dma-mapping.h |  57 +++++++++++
 arch/h8300/include/asm/elf.h         | 101 +++++++++++++++++++
 arch/h8300/include/asm/flat.h        |  28 ++++++
 arch/h8300/include/asm/io.h          |  57 +++++++++++
 arch/h8300/include/asm/irq.h         |  26 +++++
 arch/h8300/include/asm/irqflags.h    |  96 ++++++++++++++++++
 arch/h8300/include/asm/mc146818rtc.h |   9 ++
 arch/h8300/include/asm/mutex.h       |   9 ++
 arch/h8300/include/asm/page.h        |  11 +++
 arch/h8300/include/asm/page_offset.h |   2 +
 arch/h8300/include/asm/pci.h         |  19 ++++
 arch/h8300/include/asm/pgtable.h     |  49 ++++++++++
 arch/h8300/include/asm/processor.h   | 144 +++++++++++++++++++++++++++
 arch/h8300/include/asm/ptrace.h      |  36 +++++++
 arch/h8300/include/asm/segment.h     |  49 ++++++++++
 arch/h8300/include/asm/signal.h      |  22 +++++
 arch/h8300/include/asm/smp.h         |   1 +
 arch/h8300/include/asm/string.h      |  17 ++++
 arch/h8300/include/asm/switch_to.h   |  51 ++++++++++
 arch/h8300/include/asm/syscall.h     |  56 +++++++++++
 arch/h8300/include/asm/thread_info.h | 108 ++++++++++++++++++++
 arch/h8300/include/asm/tlb.h         |   8 ++
 arch/h8300/include/asm/traps.h       |  41 ++++++++
 arch/h8300/include/asm/uaccess.h     | 131 +++++++++++++++++++++++++
 arch/h8300/include/asm/unaligned.h   |  11 +++
 arch/h8300/include/asm/user.h        |  74 ++++++++++++++
 35 files changed, 1850 insertions(+)
 create mode 100644 arch/h8300/include/asm/Kbuild
 create mode 100644 arch/h8300/include/asm/atomic.h
 create mode 100644 arch/h8300/include/asm/bitops.h
 create mode 100644 arch/h8300/include/asm/bitsperlong.h
 create mode 100644 arch/h8300/include/asm/bootparams.h
 create mode 100644 arch/h8300/include/asm/bug.h
 create mode 100644 arch/h8300/include/asm/cache.h
 create mode 100644 arch/h8300/include/asm/checksum.h
 create mode 100644 arch/h8300/include/asm/cmpxchg.h
 create mode 100644 arch/h8300/include/asm/dma-mapping.h
 create mode 100644 arch/h8300/include/asm/elf.h
 create mode 100644 arch/h8300/include/asm/flat.h
 create mode 100644 arch/h8300/include/asm/io.h
 create mode 100644 arch/h8300/include/asm/irq.h
 create mode 100644 arch/h8300/include/asm/irqflags.h
 create mode 100644 arch/h8300/include/asm/mc146818rtc.h
 create mode 100644 arch/h8300/include/asm/mutex.h
 create mode 100644 arch/h8300/include/asm/page.h
 create mode 100644 arch/h8300/include/asm/page_offset.h
 create mode 100644 arch/h8300/include/asm/pci.h
 create mode 100644 arch/h8300/include/asm/pgtable.h
 create mode 100644 arch/h8300/include/asm/processor.h
 create mode 100644 arch/h8300/include/asm/ptrace.h
 create mode 100644 arch/h8300/include/asm/segment.h
 create mode 100644 arch/h8300/include/asm/signal.h
 create mode 100644 arch/h8300/include/asm/smp.h
 create mode 100644 arch/h8300/include/asm/string.h
 create mode 100644 arch/h8300/include/asm/switch_to.h
 create mode 100644 arch/h8300/include/asm/syscall.h
 create mode 100644 arch/h8300/include/asm/thread_info.h
 create mode 100644 arch/h8300/include/asm/tlb.h
 create mode 100644 arch/h8300/include/asm/traps.h
 create mode 100644 arch/h8300/include/asm/uaccess.h
 create mode 100644 arch/h8300/include/asm/unaligned.h
 create mode 100644 arch/h8300/include/asm/user.h

diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
new file mode 100644
index 0000000..3a0df64
--- /dev/null
+++ b/arch/h8300/include/asm/Kbuild
@@ -0,0 +1,72 @@
+generic-y += asm-offsets.h
+generic-y += auxvec.h
+generic-y += barrier.h
+generic-y += bugs.h
+generic-y += cacheflush.h
+generic-y += clkdev.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += delay.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += dma.h
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
+generic-y += linkage.h
+generic-y += local.h
+generic-y += local64.h
+generic-y += mcs_spinlock.h
+generic-y += mman.h
+generic-y += mmu.h
+generic-y += mmu_context.h
+generic-y += module.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += parport.h
+generic-y += percpu.h
+generic-y += pgalloc.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += preempt.h
+generic-y += resource.h
+generic-y += scatterlist.h
+generic-y += sections.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += sizes.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += spinlock.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += timex.h
+generic-y += tlbflush.h
+generic-y += trace_clock.h
+generic-y += topology.h
+generic-y += types.h
+generic-y += ucontext.h
+generic-y += vga.h
+generic-y += xor.h
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
new file mode 100644
index 0000000..7ca73f8
--- /dev/null
+++ b/arch/h8300/include/asm/atomic.h
@@ -0,0 +1,159 @@
+#ifndef __ARCH_H8300_ATOMIC__
+#define __ARCH_H8300_ATOMIC__
+
+#include <linux/types.h>
+#include <asm/cmpxchg.h>
+
+/*
+ * Atomic operations that C can't guarantee us.  Useful for
+ * resource counting etc..
+ */
+
+#define ATOMIC_INIT(i)	{ (i) }
+
+#define atomic_read(v)		ACCESS_ONCE((v)->counter)
+#define atomic_set(v, i)	(((v)->counter) = i)
+
+#include <linux/kernel.h>
+
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	h8300flags flags;
+	int ret;
+
+	flags = arch_local_irq_save();
+	ret = v->counter += i;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+#define atomic_add(i, v) atomic_add_return(i, v)
+#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	h8300flags flags;
+	int ret;
+
+	flags = arch_local_irq_save();
+	ret = v->counter -= i;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+#define atomic_sub(i, v) atomic_sub_return(i, v)
+#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
+
+static inline int atomic_inc_return(atomic_t *v)
+{
+	h8300flags flags;
+	int ret;
+
+	flags = arch_local_irq_save();
+	v->counter++;
+	ret = v->counter;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+#define atomic_inc(v) atomic_inc_return(v)
+
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
+static inline int atomic_dec_return(atomic_t *v)
+{
+	h8300flags flags;
+	int ret;
+
+	flags = arch_local_irq_save();
+	--v->counter;
+	ret = v->counter;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+#define atomic_dec(v) atomic_dec_return(v)
+
+static inline int atomic_dec_and_test(atomic_t *v)
+{
+	h8300flags flags;
+	int ret;
+
+	flags = arch_local_irq_save();
+	--v->counter;
+	ret = v->counter;
+	arch_local_irq_restore(flags);
+	return ret == 0;
+}
+
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	h8300flags flags;
+
+	flags = arch_local_irq_save();
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int ret;
+	h8300flags flags;
+
+	flags = arch_local_irq_save();
+	ret = v->counter;
+	if (ret != u)
+		v->counter += a;
+	arch_local_irq_restore(flags);
+	return ret;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *v)
+{
+	unsigned char ccr;
+	unsigned long tmp;
+
+	__asm__ __volatile__("stc ccr,%w3\n\t"
+			     "orc #0x80,ccr\n\t"
+			     "mov.l %0,%1\n\t"
+			     "and.l %2,%1\n\t"
+			     "mov.l %1,%0\n\t"
+			     "ldc %w3,ccr"
+			     : "=m"(*v), "=r"(tmp)
+			     : "g"(~(mask)), "r"(ccr));
+}
+
+static inline void atomic_set_mask(unsigned long mask, unsigned long *v)
+{
+	unsigned char ccr;
+	unsigned long tmp;
+
+	__asm__ __volatile__("stc ccr,%w3\n\t"
+			     "orc #0x80,ccr\n\t"
+			     "mov.l %0,%1\n\t"
+			     "or.l %2,%1\n\t"
+			     "mov.l %1,%0\n\t"
+			     "ldc %w3,ccr"
+			     : "=m"(*v), "=r"(tmp)
+			     : "g"(~(mask)), "r"(ccr));
+}
+
+/* Atomic operations are already serializing */
+#define smp_mb__before_atomic_dec()    barrier()
+#define smp_mb__after_atomic_dec() barrier()
+#define smp_mb__before_atomic_inc()    barrier()
+#define smp_mb__after_atomic_inc() barrier()
+
+#endif /* __ARCH_H8300_ATOMIC __ */
diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
new file mode 100644
index 0000000..05999ab
--- /dev/null
+++ b/arch/h8300/include/asm/bitops.h
@@ -0,0 +1,185 @@
+#ifndef _H8300_BITOPS_H
+#define _H8300_BITOPS_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ * Copyright 2002, Yoshinori Sato
+ */
+
+#include <linux/compiler.h>
+
+#ifdef __KERNEL__
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+/*
+ * Function prototypes to keep gcc -Wall happy
+ */
+
+/*
+ * ffz = Find First Zero in word. Undefined if no zero exists,
+ * so code should check against ~0UL first..
+ */
+static inline unsigned long ffz(unsigned long word)
+{
+	unsigned long result;
+
+	result = -1;
+	__asm__("1:\n\t"
+		"shlr.l %2\n\t"
+		"adds #1,%0\n\t"
+		"bcs 1b"
+		: "=r"(result)
+		: "0"(result), "r"(word));
+	return result;
+}
+
+#define H8300_GEN_BITOP(FNAME, OP)				\
+static inline void FNAME(int nr, volatile unsigned long *addr)	\
+{								\
+	unsigned char *b_addr;					\
+	unsigned char bit = nr & 7;				\
+								\
+	b_addr = (unsigned char *)addr + ((nr >> 3) ^ 3);	\
+	if (__builtin_constant_p(nr)) {				\
+		__asm__(OP " %1,%0" : "+WU"(*b_addr) : "i"(nr & 7));	\
+	} else {						\
+		__asm__(OP " %s1,%0" : "+WU"(*b_addr) : "r"(bit));	\
+	}							\
+}
+
+/*
+ * clear_bit() doesn't provide any barrier for the compiler.
+ */
+#define smp_mb__before_clear_bit()	barrier()
+#define smp_mb__after_clear_bit()	barrier()
+
+H8300_GEN_BITOP(set_bit,    "bset")
+H8300_GEN_BITOP(clear_bit,  "bclr")
+H8300_GEN_BITOP(change_bit, "bnot")
+#define __set_bit(nr, addr)    set_bit((nr), (addr))
+#define __clear_bit(nr, addr)  clear_bit((nr), (addr))
+#define __change_bit(nr, addr) change_bit((nr), (addr))
+
+#undef H8300_GEN_BITOP
+
+static inline int test_bit(int nr, const unsigned long *addr)
+{
+	int ret = 0;
+	unsigned char *b_addr;
+	unsigned char bit = nr & 7;
+
+	b_addr = (unsigned char *)addr + ((nr >> 3) ^ 3);
+	if (__builtin_constant_p(nr)) {
+		__asm__("bld %Z2,%1\n\t"
+			"rotxl %0\n\t"
+			: "=r"(ret)
+			: "WU"(*b_addr), "i"(nr & 7), "0"(ret) : "cc");
+	} else {
+		__asm__("btst %w2,%1\n\t"
+			"beq 1f\n\t"
+			"inc.l #1,%0\n"
+			"1:"
+			: "=r"(ret)
+			: "WU"(*b_addr), "r"(bit), "0"(ret) : "cc");
+	}
+	return ret;
+}
+
+#define __test_bit(nr, addr) test_bit(nr, addr)
+
+#define H8300_GEN_TEST_BITOP(FNNAME, OP)				\
+static inline int FNNAME(int nr, void *addr)				\
+{									\
+	int retval = 0;							\
+	char ccrsave;							\
+	unsigned char *b_addr;						\
+	unsigned char bit = nr & 7;					\
+									\
+	b_addr = (unsigned char *)addr + ((nr >> 3) ^ 3);		\
+	if (__builtin_constant_p(nr)) {					\
+		__asm__("stc ccr,%s2\n\t"				\
+			"orc #0x80,ccr\n\t"				\
+			"bld %4,%1\n\t"					\
+			OP " %4,%1\n\t"					\
+			"rotxl.l %0\n\t"				\
+			"ldc %s2,ccr"					\
+			: "=r"(retval), "+WU" (*b_addr), "=&r"(ccrsave)	\
+			: "0"(retval), "i"(nr & 7) : "cc");		\
+	} else {							\
+		__asm__("stc ccr,%t3\n\t"				\
+			"orc #0x80,ccr\n\t"				\
+			"btst %s3,%1\n\t"				\
+			OP " %s3,%1\n\t"				\
+			"beq 1f\n\t"					\
+			"inc.l #1,%0\n\t"				\
+			"1:\n"						\
+			"ldc %t3,ccr"					\
+			: "=r"(retval), "+WU" (*b_addr)			\
+			: "0" (retval), "r"(bit) : "cc");		\
+	}								\
+	return retval;							\
+}									\
+									\
+static inline int __ ## FNNAME(int nr, void *addr)			\
+{									\
+	int retval = 0;							\
+	unsigned char *b_addr;						\
+	unsigned char bit = nr & 7;					\
+									\
+	b_addr = (unsigned char *)addr + ((nr >> 3) ^ 3);		\
+	if (__builtin_constant_p(nr)) {					\
+		__asm__("bld %3,%1\n\t"					\
+			OP " %3,%1\n\t"					\
+			"rotxl.l %0\n\t"				\
+			: "=r"(retval), "+WU"(*b_addr)			\
+			: "0" (retval), "i"(nr & 7));			\
+	} else {							\
+		__asm__("btst %s3,%1\n\t"				\
+			OP " %s3,%1\n\t"				\
+			"beq 1f\n\t"					\
+			"inc.l #1,%0\n\t"				\
+			"1:"						\
+			: "=r"(retval), "+WU"(*b_addr)			\
+			: "0" (retval), "r"(bit));			\
+	}								\
+	return retval;							\
+}
+
+H8300_GEN_TEST_BITOP(test_and_set_bit,	  "bset")
+H8300_GEN_TEST_BITOP(test_and_clear_bit,  "bclr")
+H8300_GEN_TEST_BITOP(test_and_change_bit, "bnot")
+#undef H8300_GEN_TEST_BITOP
+
+#include <asm-generic/bitops/ffs.h>
+
+static inline unsigned long __ffs(unsigned long word)
+{
+	unsigned long result;
+
+	result = -1;
+	__asm__("1:\n\t"
+		"shlr.l %2\n\t"
+		"adds #1,%0\n\t"
+		"bcc 1b"
+		: "=r" (result)
+		: "0"(result), "r"(word));
+	return result;
+}
+
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#endif /* __KERNEL__ */
+
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/fls64.h>
+
+#endif /* _H8300_BITOPS_H */
diff --git a/arch/h8300/include/asm/bitsperlong.h b/arch/h8300/include/asm/bitsperlong.h
new file mode 100644
index 0000000..e140e46
--- /dev/null
+++ b/arch/h8300/include/asm/bitsperlong.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_H8300_BITS_PER_LONG
+#define __ASM_H8300_BITS_PER_LONG
+
+#include <asm-generic/bitsperlong.h>
+
+#if !defined(__ASSEMBLY__)
+/* h8300-unknown-linux required long */
+#define __kernel_size_t __kernel_size_t
+typedef unsigned long	__kernel_size_t;
+typedef long		__kernel_ssize_t;
+typedef long		__kernel_ptrdiff_t;
+#endif
+
+#endif /* __ASM_H8300_BITS_PER_LONG */
diff --git a/arch/h8300/include/asm/bootparams.h b/arch/h8300/include/asm/bootparams.h
new file mode 100644
index 0000000..6c0b145
--- /dev/null
+++ b/arch/h8300/include/asm/bootparams.h
@@ -0,0 +1,17 @@
+/*
+H8/300 kernel boot parameters
+*/
+
+#ifndef __ASM_H8300_BOOTPARAMS__
+#define __ASM_H8300_BOOTPARAMS__
+
+struct bootparams {
+	short size;
+	unsigned char gpio_ddr[24];
+	unsigned char gpio_use[24];
+	unsigned int clock_freq;
+	unsigned int ram_end;
+	unsigned char *command_line;
+} __packed __aligned(2);
+
+#endif
diff --git a/arch/h8300/include/asm/bug.h b/arch/h8300/include/asm/bug.h
new file mode 100644
index 0000000..1e1be81
--- /dev/null
+++ b/arch/h8300/include/asm/bug.h
@@ -0,0 +1,12 @@
+#ifndef _H8300_BUG_H
+#define _H8300_BUG_H
+
+/* always true */
+#define is_valid_bugaddr(addr) (1)
+
+#include <asm-generic/bug.h>
+
+struct pt_regs;
+extern void die(const char *str, struct pt_regs *fp, unsigned long err);
+
+#endif
diff --git a/arch/h8300/include/asm/cache.h b/arch/h8300/include/asm/cache.h
new file mode 100644
index 0000000..0ef1edc
--- /dev/null
+++ b/arch/h8300/include/asm/cache.h
@@ -0,0 +1,11 @@
+#ifndef __ARCH_H8300_CACHE_H
+#define __ARCH_H8300_CACHE_H
+
+/* bytes per L1 cache line */
+#define        L1_CACHE_SHIFT  2
+#define        L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)
+
+#define __cacheline_aligned
+#define ____cacheline_aligned
+
+#endif
diff --git a/arch/h8300/include/asm/checksum.h b/arch/h8300/include/asm/checksum.h
new file mode 100644
index 0000000..59e2adc9
--- /dev/null
+++ b/arch/h8300/include/asm/checksum.h
@@ -0,0 +1,102 @@
+#ifndef _H8300_CHECKSUM_H
+#define _H8300_CHECKSUM_H
+
+/*
+ * computes the checksum of a memory block at buff, length len,
+ * and adds in "sum" (32-bit)
+ *
+ * returns a 32-bit number suitable for feeding into itself
+ * or csum_tcpudp_magic
+ *
+ * this function must be called with even lengths, except
+ * for the last fragment, which may be odd
+ *
+ * it's best to have buff aligned on a 32-bit boundary
+ */
+__wsum csum_partial(const void *buff, int len, __wsum sum);
+
+/*
+ * the same as csum_partial, but copies from src while it
+ * checksums
+ *
+ * here even more important to align src and dst on a 32-bit (or even
+ * better 64-bit) boundary
+ */
+
+__wsum csum_partial_copy_nocheck(const void *src, void *dst,
+				 int len, __wsum sum);
+
+
+/*
+ * the same as csum_partial_copy, but copies from user space.
+ *
+ * here even more important to align src and dst on a 32-bit (or even
+ * better 64-bit) boundary
+ */
+
+extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
+					  int len, __wsum sum, int *csum_err);
+
+__sum16 ip_fast_csum(const void *iph, unsigned int ihl);
+
+
+/*
+ *	Fold a partial checksum
+ */
+
+static inline __sum16 csum_fold(__wsum sum)
+{
+	__asm__("add.w %e0,%f0\n\t"
+		"xor.w %e0,%e0\n\t"
+		"rotxl.w %e0\n\t"
+		"add.w %e0,%f0\n\t"
+		"sub.w %e0,%e0\n\t"
+		: "=r"(sum)
+		: "0"(sum));
+	return (__force __sum16)~sum;
+}
+
+
+/*
+ * computes the checksum of the TCP/UDP pseudo-header
+ * returns a 16-bit checksum, already complemented
+ */
+
+static inline __wsum
+csum_tcpudp_nofold(__be32 saddr, __be32 daddr, unsigned short len,
+		  unsigned short proto, __wsum sum)
+{
+	int tmp;
+
+	__asm__ ("sub.l %1,%1\n\t"
+		 "add.l %3,%0\n\t"
+		 "addx	#0,%w1\n\t"
+		 "add.l	%4,%0\n\t"
+		 "addx	#0,%w1\n\t"
+		 "add.l %5,%0\n\t"
+		 "addx	#0,%w1\n\t"
+		 "add.l	%1,%0\n\t"
+		 "bcc	1f\n\t"
+		 "inc.l	#1,%0\n"
+		 "1:"
+		 : "=&r" (sum), "=&r"(tmp)
+		 : "0" (sum), "1" (daddr),
+		   "r" (saddr), "r" (len + proto));
+	return sum;
+}
+
+static inline __sum16
+csum_tcpudp_magic(__be32 saddr, __be32 daddr, unsigned short len,
+		  unsigned short proto, __wsum sum)
+{
+	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
+}
+
+/*
+ * this routine is used for miscellaneous IP-like checksums, mainly
+ * in icmp.c
+ */
+
+extern __sum16 ip_compute_csum(const void *buff, int len);
+
+#endif /* _H8300_CHECKSUM_H */
diff --git a/arch/h8300/include/asm/cmpxchg.h b/arch/h8300/include/asm/cmpxchg.h
new file mode 100644
index 0000000..95fec4c
--- /dev/null
+++ b/arch/h8300/include/asm/cmpxchg.h
@@ -0,0 +1,65 @@
+#ifndef __ARCH_H8300_CMPXCHG__
+#define __ARCH_H8300_CMPXCHG__
+
+#include <linux/irqflags.h>
+
+#define xchg(ptr, x) \
+	((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), \
+				    sizeof(*(ptr))))
+
+struct __xchg_dummy { unsigned long a[100]; };
+#define __xg(x) ((volatile struct __xchg_dummy *)(x))
+
+static inline unsigned long __xchg(unsigned long x,
+				   volatile void *ptr, int size)
+{
+	unsigned long tmp, flags;
+
+	local_irq_save(flags);
+
+	switch (size) {
+	case 1:
+		__asm__ __volatile__
+			("mov.b %2,%0\n\t"
+			 "mov.b %1,%2"
+			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
+		break;
+	case 2:
+		__asm__ __volatile__
+			("mov.w %2,%0\n\t"
+			 "mov.w %1,%2"
+			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
+		break;
+	case 4:
+		__asm__ __volatile__
+			("mov.l %2,%0\n\t"
+			 "mov.l %1,%2"
+			 : "=&r" (tmp) : "r" (x), "m" (*__xg(ptr)));
+		break;
+	default:
+		tmp = 0;
+	}
+	local_irq_restore(flags);
+	return tmp;
+}
+
+#include <asm-generic/cmpxchg-local.h>
+
+/*
+ * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
+ * them available.
+ */
+#define cmpxchg_local(ptr, o, n)					 \
+	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr),		 \
+						     (unsigned long)(o), \
+						     (unsigned long)(n), \
+						     sizeof(*(ptr))))
+#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+
+#ifndef CONFIG_SMP
+#include <asm-generic/cmpxchg.h>
+#endif
+
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+#endif /* __ARCH_H8300_CMPXCHG__ */
diff --git a/arch/h8300/include/asm/dma-mapping.h b/arch/h8300/include/asm/dma-mapping.h
new file mode 100644
index 0000000..6e67a909
--- /dev/null
+++ b/arch/h8300/include/asm/dma-mapping.h
@@ -0,0 +1,57 @@
+#ifndef _H8300_DMA_MAPPING_H
+#define _H8300_DMA_MAPPING_H
+
+#include <asm-generic/dma-coherent.h>
+
+extern struct dma_map_ops h8300_dma_map_ops;
+
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	return &h8300_dma_map_ops;
+}
+
+#include <asm-generic/dma-mapping-common.h>
+
+static inline int dma_supported(struct device *dev, u64 mask)
+{
+	return 0;
+}
+
+static inline int dma_set_mask(struct device *dev, u64 mask)
+{
+	return 0;
+}
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
+#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+
+#define dma_alloc_coherent(d, s, h, f) dma_alloc_attrs(d, s, h, f, NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t flag,
+				    struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	void *memory;
+
+	memory = ops->alloc(dev, size, dma_handle, flag, attrs);
+	return memory;
+}
+
+#define dma_free_coherent(d, s, c, h) dma_free_attrs(d, s, c, h, NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *cpu_addr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	ops->free(dev, size, cpu_addr, dma_handle, attrs);
+}
+
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+#endif
diff --git a/arch/h8300/include/asm/elf.h b/arch/h8300/include/asm/elf.h
new file mode 100644
index 0000000..09031d0
--- /dev/null
+++ b/arch/h8300/include/asm/elf.h
@@ -0,0 +1,101 @@
+#ifndef __ASM_H8300_ELF_H
+#define __ASM_H8300_ELF_H
+
+/*
+ * ELF register definitions..
+ */
+
+#include <asm/ptrace.h>
+#include <asm/user.h>
+
+typedef unsigned long elf_greg_t;
+
+#define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+typedef unsigned long elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ((x)->e_machine == EM_H8_300)
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA	ELFDATA2MSB
+#define ELF_ARCH	EM_H8_300
+#if defined(CONFIG_CPU_H8300H)
+#define ELF_CORE_EFLAGS 0x810000
+#endif
+#if defined(CONFIG_CPU_H8S)
+#define ELF_CORE_EFLAGS 0x820000
+#endif
+
+#define ELF_PLAT_INIT(_r) do { (_r)->er1 = 0; } while (0)
+
+#define ELF_EXEC_PAGESIZE	4096
+
+/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+   use of this is to invoke "./ld.so someprog" to test out a new version of
+   the loader.  We need to make sure that it is out of the way of the program
+   that it will "exec", and that there is sufficient room for the brk.  */
+
+#define ELF_ET_DYN_BASE         0xD0000000UL
+
+/* This yields a mask that user programs can use to figure out what
+   instruction set this cpu supports.  */
+
+#define ELF_HWCAP	(0)
+
+/* This yields a string that ld.so will use to load implementation
+   specific libraries for optimization.  This is more specific in
+   intent than poking at uname or /proc/cpuinfo.  */
+
+#define ELF_PLATFORM  (NULL)
+
+#define R_H8_NONE       0
+#define R_H8_DIR32      1
+#define R_H8_DIR32_28   2
+#define R_H8_DIR32_24   3
+#define R_H8_DIR32_16   4
+#define R_H8_DIR32U     6
+#define R_H8_DIR32U_28  7
+#define R_H8_DIR32U_24  8
+#define R_H8_DIR32U_20  9
+#define R_H8_DIR32U_16 10
+#define R_H8_DIR24     11
+#define R_H8_DIR24_20  12
+#define R_H8_DIR24_16  13
+#define R_H8_DIR24U    14
+#define R_H8_DIR24U_20 15
+#define R_H8_DIR24U_16 16
+#define R_H8_DIR16     17
+#define R_H8_DIR16U    18
+#define R_H8_DIR16S_32 19
+#define R_H8_DIR16S_28 20
+#define R_H8_DIR16S_24 21
+#define R_H8_DIR16S_20 22
+#define R_H8_DIR16S    23
+#define R_H8_DIR8      24
+#define R_H8_DIR8U     25
+#define R_H8_DIR8Z_32  26
+#define R_H8_DIR8Z_28  27
+#define R_H8_DIR8Z_24  28
+#define R_H8_DIR8Z_20  29
+#define R_H8_DIR8Z_16  30
+#define R_H8_PCREL16   31
+#define R_H8_PCREL8    32
+#define R_H8_BPOS      33
+#define R_H8_PCREL32   34
+#define R_H8_GOT32O    35
+#define R_H8_GOT16O    36
+#define R_H8_DIR16A8   59
+#define R_H8_DIR16R8   60
+#define R_H8_DIR24A8   61
+#define R_H8_DIR24R8   62
+#define R_H8_DIR32A16  63
+#define R_H8_ABS32     65
+#define R_H8_ABS32A16 127
+
+#endif
diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
new file mode 100644
index 0000000..a4898ec
--- /dev/null
+++ b/arch/h8300/include/asm/flat.h
@@ -0,0 +1,28 @@
+/*
+ * arch/h8300/asm/include/flat.h -- uClinux flat-format executables
+ */
+
+#ifndef __H8300_FLAT_H__
+#define __H8300_FLAT_H__
+
+#define	flat_argvp_envp_on_stack()		1
+#define	flat_old_ram_flag(flags)		1
+#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
+#define	flat_set_persistent(relval, p)		0
+
+/*
+ * on the H8 a couple of the relocations have an instruction in the
+ * top byte.  As there can only be 24bits of address space,  we just
+ * always preserve that 8bits at the top,  when it isn't an instruction
+ * is is 0 (davidm@snapgear.com)
+ */
+
+#define	flat_get_relocate_addr(rel)		(rel & ~0x00000001)
+#define flat_get_addr_from_rp(rp, relval, flags, persistent) \
+	({(void)persistent; \
+		get_unaligned(rp) & (((flags) & FLAT_FLAG_GOTPIC) ?	\
+				     0xffffffff : 0x00ffffff); })
+#define flat_put_addr_at_rp(rp, addr, rel) \
+	put_unaligned(((*(char *)(rp)) << 24) | ((addr) & 0x00ffffff), (rp))
+
+#endif /* __H8300_FLAT_H__ */
diff --git a/arch/h8300/include/asm/io.h b/arch/h8300/include/asm/io.h
new file mode 100644
index 0000000..1d09b2f
--- /dev/null
+++ b/arch/h8300/include/asm/io.h
@@ -0,0 +1,57 @@
+#ifndef _H8300_IO_H
+#define _H8300_IO_H
+
+#ifdef __KERNEL__
+
+#include <asm-generic/io.h>
+
+/* H8/300 internal I/O functions */
+static inline unsigned char ctrl_inb(unsigned long addr)
+{
+	return *(volatile unsigned char *)addr;
+}
+
+static inline unsigned short ctrl_inw(unsigned long addr)
+{
+	return *(volatile unsigned short *)addr;
+}
+
+static inline unsigned long ctrl_inl(unsigned long addr)
+{
+	return *(volatile unsigned long *)addr;
+}
+
+static inline void ctrl_outb(unsigned char b, unsigned long addr)
+{
+	*(volatile unsigned char *)addr = b;
+}
+
+static inline void ctrl_outw(unsigned short b, unsigned long addr)
+{
+	*(volatile unsigned short *)addr = b;
+}
+
+static inline void ctrl_outl(unsigned long b, unsigned long addr)
+{
+	*(volatile unsigned long *)addr = b;
+}
+
+static inline void ctrl_bclr(int b, unsigned long addr)
+{
+	if (__builtin_constant_p(b))
+		__asm__("bclr %1,%0" : : "WU"(addr), "i"(b));
+	else
+		__asm__("bclr %w1,%0" : : "WU"(addr), "r"(b));
+}
+
+static inline void ctrl_bset(int b, unsigned long addr)
+{
+	if (__builtin_constant_p(b))
+		__asm__("bset %1,%0" : : "WU"(addr), "i"(b));
+	else
+		__asm__("bset %w1,%0" : : "WU"(addr), "r"(b));
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _H8300_IO_H */
diff --git a/arch/h8300/include/asm/irq.h b/arch/h8300/include/asm/irq.h
new file mode 100644
index 0000000..69f23f0
--- /dev/null
+++ b/arch/h8300/include/asm/irq.h
@@ -0,0 +1,26 @@
+#ifndef _H8300_IRQ_H_
+#define _H8300_IRQ_H_
+
+#include <linux/irqchip.h>
+
+#if defined(CONFIG_CPU_H8300H)
+#define NR_IRQS 64
+#define IRQ_CHIP h8300h_irq_chip
+#define EXT_IRQ0 12
+#define EXT_IRQS 6
+#elif defined(CONFIG_CPU_H8S)
+#define NR_IRQS 128
+#define IRQ_CHIP h8s_irq_chip
+#define EXT_IRQ0 16
+#define EXT_IRQS 16
+#endif
+
+static inline int irq_canonicalize(int irq)
+{
+	return irq;
+}
+
+void h8300_init_ipr(void);
+extern struct irq_chip h8300h_irq_chip;
+extern struct irq_chip h8s_irq_chip;
+#endif /* _H8300_IRQ_H_ */
diff --git a/arch/h8300/include/asm/irqflags.h b/arch/h8300/include/asm/irqflags.h
new file mode 100644
index 0000000..5e1e324
--- /dev/null
+++ b/arch/h8300/include/asm/irqflags.h
@@ -0,0 +1,96 @@
+#ifndef _H8300_IRQFLAGS_H
+#define _H8300_IRQFLAGS_H
+
+#ifdef CONFIG_CPU_H8300H
+typedef unsigned char h8300flags;
+
+static inline h8300flags arch_local_save_flags(void)
+{
+	h8300flags flags;
+
+	__asm__ volatile ("stc ccr,%w0" : "=r" (flags));
+	return flags;
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	__asm__ volatile ("orc  #0xc0,ccr");
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	__asm__ volatile ("andc #0x3f,ccr");
+}
+
+static inline h8300flags arch_local_irq_save(void)
+{
+	h8300flags flags;
+
+	__asm__ volatile ("stc ccr,%w0\n\t"
+		      "orc  #0xc0,ccr" : "=r" (flags));
+	return flags;
+}
+
+static inline void arch_local_irq_restore(h8300flags flags)
+{
+	__asm__ volatile ("ldc %w0,ccr" : : "r" (flags) : "cc");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & 0xc0) == 0xc0;
+}
+#endif
+#ifdef CONFIG_CPU_H8S
+typedef unsigned short h8300flags;
+
+static inline h8300flags arch_local_save_flags(void)
+{
+	h8300flags flags;
+
+	__asm__ volatile ("stc ccr,%w0\n\tstc exr,%x0" : "=r" (flags));
+	return flags;
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	__asm__ volatile ("orc #0x80,ccr\n\t");
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	__asm__ volatile ("andc #0x7f,ccr\n\t"
+		      "andc #0xf0,exr\n\t");
+}
+
+static inline h8300flags arch_local_irq_save(void)
+{
+	h8300flags flags;
+
+	__asm__ volatile ("stc ccr,%w0\n\t"
+		      "stc exr,%x0\n\t"
+		      "orc  #0x80,ccr\n\t"
+		      : "=r" (flags));
+	return flags;
+}
+
+static inline void arch_local_irq_restore(h8300flags flags)
+{
+	__asm__ volatile ("ldc %w0,ccr\n\t"
+		      "ldc %x0,exr"
+		      : : "r" (flags) : "cc");
+}
+
+static inline int arch_irqs_disabled_flags(h8300flags flags)
+{
+	return (flags & 0x0080) == 0x0080;
+}
+
+#endif
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#endif /* _H8300_IRQFLAGS_H */
diff --git a/arch/h8300/include/asm/mc146818rtc.h b/arch/h8300/include/asm/mc146818rtc.h
new file mode 100644
index 0000000..ab9d964
--- /dev/null
+++ b/arch/h8300/include/asm/mc146818rtc.h
@@ -0,0 +1,9 @@
+/*
+ * Machine dependent access functions for RTC registers.
+ */
+#ifndef _H8300_MC146818RTC_H
+#define _H8300_MC146818RTC_H
+
+/* empty include file to satisfy the include in genrtc.c/ide-geometry.c */
+
+#endif /* _H8300_MC146818RTC_H */
diff --git a/arch/h8300/include/asm/mutex.h b/arch/h8300/include/asm/mutex.h
new file mode 100644
index 0000000..458c1f7
--- /dev/null
+++ b/arch/h8300/include/asm/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
diff --git a/arch/h8300/include/asm/page.h b/arch/h8300/include/asm/page.h
new file mode 100644
index 0000000..ee2f07c
--- /dev/null
+++ b/arch/h8300/include/asm/page.h
@@ -0,0 +1,11 @@
+#ifndef _H8300_PAGE_H
+#define _H8300_PAGE_H
+
+#include <asm-generic/page.h>
+#include <linux/types.h>
+
+#define MAP_NR(addr) (((uintptr_t)(addr)-PAGE_OFFSET) >> PAGE_SHIFT)
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#endif
diff --git a/arch/h8300/include/asm/page_offset.h b/arch/h8300/include/asm/page_offset.h
new file mode 100644
index 0000000..888576d
--- /dev/null
+++ b/arch/h8300/include/asm/page_offset.h
@@ -0,0 +1,2 @@
+
+#define PAGE_OFFSET_RAW		0x00000000
diff --git a/arch/h8300/include/asm/pci.h b/arch/h8300/include/asm/pci.h
new file mode 100644
index 0000000..0b2acaa
--- /dev/null
+++ b/arch/h8300/include/asm/pci.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_H8300_PCI_H
+#define _ASM_H8300_PCI_H
+
+/*
+ * asm-h8300/pci.h - H8/300 specific PCI declarations.
+ *
+ * Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#define pcibios_assign_all_busses()	0
+
+static inline void pcibios_penalize_isa_irq(int irq, int active)
+{
+	/* We don't do dynamic PCI IRQ allocation */
+}
+
+#define PCI_DMA_BUS_IS_PHYS	(1)
+
+#endif /* _ASM_H8300_PCI_H */
diff --git a/arch/h8300/include/asm/pgtable.h b/arch/h8300/include/asm/pgtable.h
new file mode 100644
index 0000000..8341db6
--- /dev/null
+++ b/arch/h8300/include/asm/pgtable.h
@@ -0,0 +1,49 @@
+#ifndef _H8300_PGTABLE_H
+#define _H8300_PGTABLE_H
+#include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable.h>
+#define pgtable_cache_init()   do { } while (0)
+extern void paging_init(void);
+#define PAGE_NONE		__pgprot(0)    /* these mean nothing to NO_MM */
+#define PAGE_SHARED		__pgprot(0)    /* these mean nothing to NO_MM */
+#define PAGE_COPY		__pgprot(0)    /* these mean nothing to NO_MM */
+#define PAGE_READONLY	__pgprot(0)    /* these mean nothing to NO_MM */
+#define PAGE_KERNEL		__pgprot(0)    /* these mean nothing to NO_MM */
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+#define kern_addr_valid(addr)	(1)
+#define pgprot_writecombine(prot)  (prot)
+#define pgprot_noncached pgprot_writecombine
+
+static inline int pte_file(pte_t pte) { return 0; }
+#define swapper_pg_dir ((pgd_t *) 0)
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+#define ZERO_PAGE(vaddr)	(virt_to_page(0))
+
+/*
+ * These would be in other places but having them here reduces the diffs.
+ */
+extern unsigned int kobjsize(const void *objp);
+extern int is_in_rom(unsigned long);
+
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()   do { } while (0)
+
+/*
+ * All 32bit addresses are effectively valid for vmalloc...
+ * Sort of meaningless for non-VM targets.
+ */
+#define	VMALLOC_START	0
+#define	VMALLOC_END	0xffffffff
+
+#define arch_enter_lazy_cpu_mode()    do {} while (0)
+
+#endif /* _H8300_PGTABLE_H */
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
new file mode 100644
index 0000000..54e3fd8
--- /dev/null
+++ b/arch/h8300/include/asm/processor.h
@@ -0,0 +1,144 @@
+/*
+ * include/asm-h8300/processor.h
+ *
+ * Copyright (C) 2002 Yoshinori Sato
+ *
+ * Based on: linux/asm-m68nommu/processor.h
+ *
+ * Copyright (C) 1995 Hamish Macdonald
+ */
+
+#ifndef __ASM_H8300_PROCESSOR_H
+#define __ASM_H8300_PROCESSOR_H
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l; })
+
+#include <linux/compiler.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/current.h>
+
+static inline unsigned long rdusp(void)
+{
+	extern unsigned int	_sw_usp;
+
+	return _sw_usp;
+}
+
+static inline void wrusp(unsigned long usp)
+{
+	extern unsigned int	_sw_usp;
+
+	_sw_usp = usp;
+}
+
+/*
+ * User space process size: 3.75GB. This is hardcoded into a few places,
+ * so don't change it unless you know what you are doing.
+ */
+#define TASK_SIZE	(0xFFFFFFFFUL)
+
+#ifdef __KERNEL__
+#define STACK_TOP	TASK_SIZE
+#define STACK_TOP_MAX	STACK_TOP
+#endif
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's. We won't be using it
+ */
+#define TASK_UNMAPPED_BASE	0
+
+struct thread_struct {
+	unsigned long  ksp;		/* kernel stack pointer */
+	unsigned long  usp;		/* user stack pointer */
+	unsigned long  ccr;		/* saved status register */
+	unsigned long  esp0;            /* points to SR of stack frame */
+	struct {
+		unsigned short *addr;
+		unsigned short inst;
+	} breakinfo;
+};
+
+#define INIT_THREAD  {						\
+	.ksp  = sizeof(init_stack) + (unsigned long)init_stack, \
+	.usp  = 0,						\
+	.ccr  = PS_S,						\
+	.esp0 = 0,						\
+	.breakinfo = {						\
+		.addr = (unsigned short *)-1,			\
+		.inst = 0					\
+	}							\
+}
+
+/*
+ * Do necessary setup to start up a newly executed thread.
+ *
+ * pass the data segment into user programs if it exists,
+ * it can't hurt anything as far as I can tell
+ */
+#if defined(CONFIG_CPU_H8300H)
+#define start_thread(_regs, _pc, _usp)				\
+do {								\
+	(_regs)->pc = (_pc);					\
+	(_regs)->ccr = 0x00;	   /* clear all flags */	\
+	(_regs)->er5 = current->mm->start_data;	/* GOT base */	\
+	(_regs)->sp = ((unsigned long)(_usp)) - sizeof(unsigned long) * 3; \
+} while (0)
+#endif
+#if defined(CONFIG_CPU_H8S)
+#define start_thread(_regs, _pc, _usp)				\
+do {								\
+	(_regs)->pc = (_pc);					\
+	(_regs)->ccr = 0x00;	   /* clear kernel flag */	\
+	(_regs)->exr = 0x78;	   /* enable all interrupts */	\
+	(_regs)->er5 = current->mm->start_data;	/* GOT base */	\
+	/* 14 = space for retaddr(4), vector(4), er0(4) and exr(2) on stack */ \
+	(_regs)->sp = ((unsigned long)(_usp)) - 14;		\
+} while (0)
+#endif
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+/*
+ * Free current thread data structures etc..
+ */
+static inline void exit_thread(void)
+{
+}
+
+/*
+ * Return saved PC of a blocked thread.
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk);
+unsigned long get_wchan(struct task_struct *p);
+
+#define	KSTK_EIP(tsk)	\
+	({			 \
+		unsigned long eip = 0;	      \
+		if ((tsk)->thread.esp0 > PAGE_SIZE &&	\
+		    MAP_NR((tsk)->thread.esp0) < max_mapnr)	 \
+			eip = ((struct pt_regs *) (tsk)->thread.esp0)->pc; \
+		eip; })
+
+#define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
+
+#define cpu_relax()    barrier()
+#define cpu_relax_lowlatency()	cpu_relax()
+
+#define HARD_RESET_NOW() ({		\
+	local_irq_disable();		\
+	asm("jmp @@0");			\
+})
+
+#endif
diff --git a/arch/h8300/include/asm/ptrace.h b/arch/h8300/include/asm/ptrace.h
new file mode 100644
index 0000000..e693fb4
--- /dev/null
+++ b/arch/h8300/include/asm/ptrace.h
@@ -0,0 +1,36 @@
+#ifndef _H8300_PTRACE_H
+#define _H8300_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+#ifndef PS_S
+#define PS_S  (0x10)
+#endif
+
+#if defined(CONFIG_CPU_H8300H)
+#define H8300_REGS_NO 11
+#endif
+#if defined(CONFIG_CPU_H8S)
+#define H8300_REGS_NO 12
+#endif
+
+#define arch_has_single_step()	(1)
+
+#define user_mode(regs) (!((regs)->ccr & PS_S))
+#define instruction_pointer(regs) ((regs)->pc)
+#define profile_pc(regs) instruction_pointer(regs)
+#define user_stack_pointer(regs) ((regs)->sp)
+#define current_pt_regs() ((struct pt_regs *) \
+	(THREAD_SIZE + (unsigned long)current_thread_info()) - 1)
+#define signal_pt_regs() ((struct pt_regs *)current->thread.esp0)
+#define current_user_stack_pointer() rdusp()
+#define task_pt_regs(task) \
+	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
+
+extern long h8300_get_reg(struct task_struct *task, int regno);
+extern int h8300_put_reg(struct task_struct *task, int regno,
+			 unsigned long data);
+
+#endif /* __ASSEMBLY__ */
+#endif /* _H8300_PTRACE_H */
diff --git a/arch/h8300/include/asm/segment.h b/arch/h8300/include/asm/segment.h
new file mode 100644
index 0000000..c8bc68e
--- /dev/null
+++ b/arch/h8300/include/asm/segment.h
@@ -0,0 +1,49 @@
+#ifndef _H8300_SEGMENT_H
+#define _H8300_SEGMENT_H
+
+/* define constants */
+#define USER_DATA     (1)
+#ifndef __USER_DS
+#define __USER_DS     (USER_DATA)
+#endif
+#define USER_PROGRAM  (2)
+#define SUPER_DATA    (3)
+#ifndef __KERNEL_DS
+#define __KERNEL_DS   (SUPER_DATA)
+#endif
+#define SUPER_PROGRAM (4)
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
+#define USER_DS		MAKE_MM_SEG(__USER_DS)
+#define KERNEL_DS	MAKE_MM_SEG(__KERNEL_DS)
+
+/*
+ * Get/set the SFC/DFC registers for MOVES instructions
+ */
+
+static inline mm_segment_t get_fs(void)
+{
+	return USER_DS;
+}
+
+static inline mm_segment_t get_ds(void)
+{
+	/* return the supervisor data space code */
+	return KERNEL_DS;
+}
+
+static inline void set_fs(mm_segment_t val)
+{
+}
+
+#define segment_eq(a, b)	((a).seg == (b).seg)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _H8300_SEGMENT_H */
diff --git a/arch/h8300/include/asm/signal.h b/arch/h8300/include/asm/signal.h
new file mode 100644
index 0000000..5870835
--- /dev/null
+++ b/arch/h8300/include/asm/signal.h
@@ -0,0 +1,22 @@
+#ifndef _H8300_SIGNAL_H
+#define _H8300_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+#define _NSIG		64
+#define _NSIG_BPW	32
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+
+typedef unsigned long old_sigset_t;		/* at least 32 bits */
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+#define __ARCH_HAS_SA_RESTORER
+#include <asm/sigcontext.h>
+
+#endif /* _H8300_SIGNAL_H */
diff --git a/arch/h8300/include/asm/smp.h b/arch/h8300/include/asm/smp.h
new file mode 100644
index 0000000..9e9bd7e
--- /dev/null
+++ b/arch/h8300/include/asm/smp.h
@@ -0,0 +1 @@
+/* nothing required here yet */
diff --git a/arch/h8300/include/asm/string.h b/arch/h8300/include/asm/string.h
new file mode 100644
index 0000000..5dc5a8a
--- /dev/null
+++ b/arch/h8300/include/asm/string.h
@@ -0,0 +1,17 @@
+#ifndef _H8300_STRING_H_
+#define _H8300_STRING_H_
+
+#ifdef __KERNEL__ /* only set these up for kernel code */
+
+#include <asm/setup.h>
+#include <asm/page.h>
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, size_t count);
+
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *d, const void *s, size_t count);
+
+#endif /* KERNEL */
+
+#endif
diff --git a/arch/h8300/include/asm/switch_to.h b/arch/h8300/include/asm/switch_to.h
new file mode 100644
index 0000000..7ad1bf9
--- /dev/null
+++ b/arch/h8300/include/asm/switch_to.h
@@ -0,0 +1,51 @@
+#ifndef _H8300_SWITCH_TO_H
+#define _H8300_SWITCH_TO_H
+
+/*
+ * switch_to(n) should switch tasks to task ptr, first checking that
+ * ptr isn't the current task, in which case it does nothing.  This
+ * also clears the TS-flag if the task we switched to has used the
+ * math co-processor latest.
+ */
+/*
+ * switch_to() saves the extra registers, that are not saved
+ * automatically by SAVE_SWITCH_STACK in resume(), ie. d0-d5 and
+ * a0-a1. Some of these are used by schedule() and its predecessors
+ * and so we might get see unexpected behaviors when a task returns
+ * with unexpected register values.
+ *
+ * syscall stores these registers itself and none of them are used
+ * by syscall after the function in the syscall has been called.
+ *
+ * Beware that resume now expects *next to be in d1 and the offset of
+ * tss to be in a1. This saves a few instructions as we no longer have
+ * to push them onto the stack and read them back right after.
+ *
+ * 02/17/96 - Jes Sorensen (jds@kom.auc.dk)
+ *
+ * Changed 96/09/19 by Andreas Schwab
+ * pass prev in a0, next in a1, offset of tss in d1, and whether
+ * the mm structures are shared in d2 (to avoid atc flushing).
+ *
+ * H8/300 Porting 2002/09/04 Yoshinori Sato
+ */
+
+asmlinkage void resume(void);
+#define switch_to(prev, next, last) \
+do {			     \
+	void *_last;					    \
+	__asm__ __volatile__(				    \
+		"mov.l	%1, er0\n\t"			    \
+		"mov.l	%2, er1\n\t"			    \
+		"mov.l	%3, er2\n\t"			    \
+		"jsr @_resume\n\t"			    \
+		"mov.l	er2,%0\n\t"			    \
+		: "=r" (_last)				    \
+		: "r" (&(prev->thread)),		    \
+		  "r" (&(next->thread)),		    \
+		  "g" (prev)				    \
+		: "cc", "er0", "er1", "er2", "er3");	    \
+	(last) = _last;					    \
+} while (0)
+
+#endif /* _H8300_SWITCH_TO_H */
diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
new file mode 100644
index 0000000..b41f688
--- /dev/null
+++ b/arch/h8300/include/asm/syscall.h
@@ -0,0 +1,56 @@
+#ifndef __ASM_H8300_SYSCALLS_32_H
+#define __ASM_H8300_SYSCALLS_32_H
+
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->orig_er0;
+}
+
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+
+	while (n > 0) {
+		switch (i) {
+		case 0:
+			*args++ = regs->er1;
+			break;
+		case 1:
+			*args++ = regs->er2;
+			break;
+		case 2:
+			*args++ = regs->er3;
+			break;
+		case 3:
+			*args++ = regs->er4;
+			break;
+		case 4:
+			*args++ = regs->er5;
+			break;
+		case 5:
+			*args++ = regs->er6;
+			break;
+		}
+		i++;
+		n--;
+	}
+}
+
+
+
+/* Misc syscall related bits */
+asmlinkage long do_syscall_trace_enter(struct pt_regs *regs);
+asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_H8300_SYSCALLS_32_H */
diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
new file mode 100644
index 0000000..a536241
--- /dev/null
+++ b/arch/h8300/include/asm/thread_info.h
@@ -0,0 +1,108 @@
+/* thread_info.h: h8300 low-level thread information
+ * adapted from the i386 and PPC versions by Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * Copyright (C) 2002  David Howells (dhowells@redhat.com)
+ * - Incorporating suggestions made by Linus Torvalds and Dave Miller
+ */
+
+#ifndef _ASM_THREAD_INFO_H
+#define _ASM_THREAD_INFO_H
+
+#include <asm/page.h>
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+/*
+ * low level task data.
+ * If you change this, change the TI_* offsets below to match.
+ */
+struct thread_info {
+	struct task_struct *task;		/* main task structure */
+	unsigned long	   flags;		/* low level flags */
+	int		   cpu;			/* cpu we're on */
+	int		   preempt_count;	/* 0 => preemptable, <0 => BUG */
+	struct restart_block restart_block;
+};
+
+/*
+ * macros/functions for gaining access to the thread information structure
+ */
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.task =		&tsk,			\
+	.flags =	0,			\
+	.cpu =		0,			\
+	.preempt_count = INIT_PREEMPT_COUNT,	\
+	.restart_block	= {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
+}
+
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack		(init_thread_union.stack)
+
+
+/*
+ * Size of kernel stack for each process. This must be a power of 2...
+ */
+#define THREAD_SIZE_ORDER	1
+#define THREAD_SIZE		8192	/* 2 pages */
+
+
+/* how to get the thread information struct from C */
+static inline struct thread_info *current_thread_info(void)
+{
+	struct thread_info *ti;
+
+	__asm__("mov.l	sp, %0\n\t"
+		"and.w	%1, %T0"
+		: "=&r"(ti)
+		: "i" (~(THREAD_SIZE-1) & 0xffff));
+	return ti;
+}
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * thread information flag bit numbers
+ */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
+#define TIF_SIGPENDING		1	/* signal pending */
+#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_SINGLESTEP		3	/* singlestepping active */
+#define TIF_MEMDIE		4	/* is terminating due to OOM killer */
+#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
+#define TIF_NOTIFY_RESUME	6	/* callback before returning to user */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_SYSCALL_TRACEPOINT	8	/* for ftrace syscall instrumentation */
+#define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+
+/* as above, but as bit values */
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+
+/* work to do in syscall trace */
+#define _TIF_WORK_SYSCALL_MASK	(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
+				 _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT)
+
+/* work to do on any return to u-space */
+#define _TIF_ALLWORK_MASK	(_TIF_SYSCALL_TRACE | _TIF_SIGPENDING      | \
+				 _TIF_NEED_RESCHED  | _TIF_SYSCALL_AUDIT   | \
+				 _TIF_SINGLESTEP    | _TIF_NOTIFY_RESUME   | \
+				 _TIF_SYSCALL_TRACEPOINT)
+
+/* work to do on interrupt/exception return */
+#define _TIF_WORK_MASK		(_TIF_ALLWORK_MASK & ~(_TIF_SYSCALL_TRACE | \
+				 _TIF_SYSCALL_AUDIT | _TIF_SINGLESTEP))
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/h8300/include/asm/tlb.h b/arch/h8300/include/asm/tlb.h
new file mode 100644
index 0000000..2c6fa4ee
--- /dev/null
+++ b/arch/h8300/include/asm/tlb.h
@@ -0,0 +1,8 @@
+#ifndef __H8300_TLB_H__
+#define __H8300_TLB_H__
+
+#define tlb_flush(tlb)	do { } while (0)
+
+#include <asm-generic/tlb.h>
+
+#endif
diff --git a/arch/h8300/include/asm/traps.h b/arch/h8300/include/asm/traps.h
new file mode 100644
index 0000000..aa34e75
--- /dev/null
+++ b/arch/h8300/include/asm/traps.h
@@ -0,0 +1,41 @@
+/*
+ *  linux/include/asm-h8300/traps.h
+ *
+ *  Copyright (C) 2003 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _H8300_TRAPS_H
+#define _H8300_TRAPS_H
+
+extern void _system_call(void);
+extern void _interrupt_entry(void);
+extern void _trace_break(void);
+extern void _nmi(void);
+extern void _interrupt_entry(void);
+
+extern unsigned long *_interrupt_redirect_table;
+
+#define JMP_OP 0x5a000000
+#define JSR_OP 0x5e000000
+#define VECTOR(address) ((JMP_OP)|((unsigned long)address))
+#define REDIRECT(address) ((JSR_OP)|((unsigned long)address))
+#define CPU_VECTOR ((unsigned long *)0x000000)
+#define ADDR_MASK (0xffffff)
+
+#define TRACE_VEC 5
+
+#define TRAP0_VEC 8
+#define TRAP1_VEC 9
+#define TRAP2_VEC 10
+#define TRAP3_VEC 11
+
+extern char _start, _etext;
+#define check_kernel_text(addr) \
+	((addr >= (unsigned long)(&_start)) && \
+	 (addr <  (unsigned long)(&_etext)))
+
+#endif /* _H8300_TRAPS_H */
diff --git a/arch/h8300/include/asm/uaccess.h b/arch/h8300/include/asm/uaccess.h
new file mode 100644
index 0000000..582af79
--- /dev/null
+++ b/arch/h8300/include/asm/uaccess.h
@@ -0,0 +1,131 @@
+#ifndef __H8300_UACCESS_H
+#define __H8300_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+
+#include <asm/segment.h>
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+/* We let the MMU do all checking */
+#define access_ok(type, addr, size) __access_ok((unsigned long)addr, size)
+static inline int __access_ok(unsigned long addr, unsigned long size)
+{
+	return 1;
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
+/* Returns 0 if exception not found and fixup otherwise.  */
+extern unsigned long search_exception_table(unsigned long);
+
+
+/*
+ * These are the main single-value transfer routines.  They automatically
+ * use the right size if we just have the right pointer type.
+ */
+
+#define put_user(x, ptr)				\
+({							\
+	int __pu_err = 0;				\
+	typeof(*(ptr)) __pu_val = (x);			\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+	/* falll through */ \
+	case 2:						\
+	/* fall through */ \
+	case 4:						\
+		*(ptr) = x;				\
+		break;					\
+	case 8:						\
+		memcpy(ptr, &__pu_val, sizeof(*(ptr))); \
+		break;					\
+	default:					\
+		__pu_err = __put_user_bad();		\
+		break;					\
+	}						\
+	__pu_err;					\
+})
+
+#define __put_user(x, ptr) put_user(x, ptr)
+
+extern int __put_user_bad(void);
+
+/*
+ * Tell gcc we read from memory instead of writing: this is because
+ * we do not write to any memory gcc knows about, so there are no
+ * aliasing issues.
+ */
+
+#define __ptr(x) ((unsigned long *)(x))
+
+/*
+ * Tell gcc we read from memory instead of writing: this is because
+ * we do not write to any memory gcc knows about, so there are no
+ * aliasing issues.
+ */
+
+#define get_user(x, ptr)					\
+({								\
+	typeof(*(ptr)) __gu_val;				\
+	int __gu_err = 0;					\
+	switch (sizeof(*(ptr))) {				\
+	case 1:							\
+		*(u8 *)&__gu_val = *((u8 *)(ptr));		\
+		break;						\
+	case 2:							\
+		*(u16 *)&__gu_val = *((u16 *)ptr);		\
+		break;						\
+	case 4:							\
+		*(u32 *)&__gu_val = *((u32 *)ptr);		\
+		break;						\
+	case 8:							\
+		memcpy((void *)&__gu_val, ptr, sizeof(*(ptr)));	\
+		break;						\
+	default:						\
+		__gu_err = __get_user_bad();			\
+		break;						\
+	}							\
+	(x) = (typeof(*(ptr)))__gu_val;				\
+	__gu_err;						\
+})
+#define __get_user(x, ptr) get_user(x, ptr)
+
+extern int __get_user_bad(void);
+
+#define copy_from_user(to, from, n)		(memcpy(to, from, n), 0)
+#define copy_to_user(to, from, n)		(memcpy(to, from, n), 0)
+
+#define __copy_from_user(to, from, n) copy_from_user(to, from, n)
+#define __copy_to_user(to, from, n) copy_to_user(to, from, n)
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
+unsigned long clear_user(void __user *addr, unsigned long size);
+#define strnlen_user(s, n) (strnlen(s, n) + 1)
+long strncpy_from_user(char *d, const char *s, long n);
+
+#define __clear_user	clear_user
+
+#endif /* _H8300_UACCESS_H */
diff --git a/arch/h8300/include/asm/unaligned.h b/arch/h8300/include/asm/unaligned.h
new file mode 100644
index 0000000..b8d06c7
--- /dev/null
+++ b/arch/h8300/include/asm/unaligned.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_H8300_UNALIGNED_H
+#define _ASM_H8300_UNALIGNED_H
+
+#include <linux/unaligned/be_memmove.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
+
+#endif /* _ASM_H8300_UNALIGNED_H */
diff --git a/arch/h8300/include/asm/user.h b/arch/h8300/include/asm/user.h
new file mode 100644
index 0000000..2e3555f
--- /dev/null
+++ b/arch/h8300/include/asm/user.h
@@ -0,0 +1,74 @@
+#ifndef _H8300_USER_H
+#define _H8300_USER_H
+
+#include <asm/page.h>
+
+/* Core file format: The core file is written in such a way that gdb
+   can understand it and provide useful information to the user (under
+   linux we use the 'trad-core' bfd).  There are quite a number of
+   obstacles to being able to view the contents of the floating point
+   registers, and until these are solved you will not be able to view the
+   contents of them.  Actually, you can read in the core file and look at
+   the contents of the user struct to find out what the floating point
+   registers contain.
+   The actual file contents are as follows:
+   UPAGE: 1 page consisting of a user struct that tells gdb what is present
+   in the file.  Directly after this is a copy of the task_struct, which
+   is currently not used by gdb, but it may come in useful at some point.
+   All of the registers are stored as part of the upage.  The upage should
+   always be only one page.
+   DATA: The data area is stored.  We use current->end_text to
+   current->brk to pick up all of the user variables, plus any memory
+   that may have been malloced.  No attempt is made to determine if a page
+   is demand-zero or if a page is totally unused, we just cover the entire
+   range.  All of the addresses are rounded in such a way that an integral
+   number of pages is written.
+   STACK: We need the stack information in order to get a meaningful
+   backtrace.  We need to write the data from (esp) to
+   current->start_stack, so we round each of these off in order to be able
+   to write an integer number of pages.
+   The minimum core file size is 3 pages, or 12288 bytes.
+*/
+
+/* This is the old layout of "struct pt_regs" as of Linux 1.x, and
+   is still the layout used by user (the new pt_regs doesn't have
+   all registers). */
+struct user_regs_struct {
+	long er1, er2, er3, er4, er5, er6;
+	long er0;
+	long usp;
+	long orig_er0;
+	long ccr;
+	long pc;
+};
+
+/* When the kernel dumps core, it starts by dumping the user struct -
+   this will be used by gdb to figure out where the data and stack segments
+   are within the file, and what virtual addresses to use. */
+struct user {
+/* We start with the registers, to mimic the way that "memory" is returned
+   from the ptrace(3,...) function.  */
+	struct user_regs_struct regs;	/* Where the registers are actually stored */
+/* ptrace does not yet supply these.  Someday.... */
+/* The rest of this junk is to help gdb figure out what goes where */
+	unsigned long int u_tsize;	/* Text segment size (pages). */
+	unsigned long int u_dsize;	/* Data segment size (pages). */
+	unsigned long int u_ssize;	/* Stack segment size (pages). */
+	unsigned long start_code;     /* Starting virtual address of text. */
+	unsigned long start_stack;	/* Starting virtual address of stack area.
+					   This is actually the bottom of the stack,
+					   the top of the stack is always found in the
+					   esp register.  */
+	long int signal;		/* Signal that caused the core dump. */
+	int reserved;			/* No longer used */
+	unsigned long u_ar0;		/* Used by gdb to help find the values for */
+	/* the registers. */
+	unsigned long magic;		/* To uniquely identify a core file */
+	char u_comm[32];		/* User command that was responsible */
+};
+#define NBPG PAGE_SIZE
+#define UPAGES 1
+#define HOST_TEXT_START_ADDR (u.start_code)
+#define HOST_STACK_END_ADDR (u.start_stack + u.u_ssize * NBPG)
+
+#endif
-- 
2.1.4
