From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 17/19] csky: Misc headers
Date: Mon,  2 Jul 2018 01:30:20 +0800
Message-ID: <e1c914049eb8fd5e6e0f998871192e03b0508fa4.1530465326.git.ren_guo@c-sky.com>
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
 arch/csky/abiv1/inc/abi/reg_ops.h      |  47 ++++++
 arch/csky/abiv1/inc/abi/regdef.h       |  15 ++
 arch/csky/abiv2/inc/abi/reg_ops.h      |  38 +++++
 arch/csky/abiv2/inc/abi/regdef.h       |  15 ++
 arch/csky/include/asm/bitops.h         | 277 +++++++++++++++++++++++++++++++++
 arch/csky/include/asm/checksum.h       |  77 +++++++++
 arch/csky/include/asm/reg_ops.h        |  16 ++
 arch/csky/include/uapi/asm/byteorder.h |  14 ++
 8 files changed, 499 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv1/inc/abi/regdef.h
 create mode 100644 arch/csky/abiv2/inc/abi/reg_ops.h
 create mode 100644 arch/csky/abiv2/inc/abi/regdef.h
 create mode 100644 arch/csky/include/asm/bitops.h
 create mode 100644 arch/csky/include/asm/checksum.h
 create mode 100644 arch/csky/include/asm/reg_ops.h
 create mode 100644 arch/csky/include/uapi/asm/byteorder.h

diff --git a/arch/csky/abiv1/inc/abi/reg_ops.h b/arch/csky/abiv1/inc/abi/reg_ops.h
new file mode 100644
index 0000000..7c31ac3
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/reg_ops.h
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
+static inline unsigned int mfcr_msa0(void)
+{
+	return cprcr("cpcr30");
+}
+
+static inline void mtcr_msa0(unsigned int value)
+{
+	cpwcr("cpcr30", value);
+}
+
+static inline unsigned int mfcr_msa1(void)
+{
+	return cprcr("cpcr31");
+}
+
+static inline void mtcr_msa1(unsigned int value)
+{
+	cpwcr("cpcr31", value);
+}
+
+static inline unsigned int mfcr_ccr2(void){return 0;}
+
+#endif /* __ABI_REG_OPS_H */
+
diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
new file mode 100644
index 0000000..0c3596d
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r1
+#define r11_sig		r11
+
+#define regs_syscallid(regs) regs->regs[9]
+
+#define DEFAULT_PSR_VALUE	0x8f000000
+
+#define SYSTRACE_SAVENUM	2
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/abiv2/inc/abi/reg_ops.h b/arch/csky/abiv2/inc/abi/reg_ops.h
new file mode 100644
index 0000000..a8b2a52
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/reg_ops.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
+
+static inline unsigned int mfcr_msa0(void)
+{
+	return mfcr("cr<30, 15>");
+}
+
+static inline void mtcr_msa0(unsigned int value)
+{
+	mtcr("cr<30, 15>", value);
+}
+
+static inline unsigned int mfcr_msa1(void)
+{
+	return mfcr("cr<31, 15>");
+}
+
+static inline void mtcr_msa1(unsigned int value)
+{
+	mtcr("cr<31, 15>", value);
+}
+
+#endif /* __ABI_REG_OPS_H */
+
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
new file mode 100644
index 0000000..2c36d60
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef  __ASM_CSKY_REGDEF_H
+#define  __ASM_CSKY_REGDEF_H
+
+#define syscallid	r7
+#define r11_sig		r11
+
+#define regs_syscallid(regs) regs->regs[3]
+
+#define DEFAULT_PSR_VALUE	0x8f000200
+
+#define SYSTRACE_SAVENUM	5
+
+#endif /* __ASM_CSKY_REGDEF_H */
diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
new file mode 100644
index 0000000..b2460c5
--- /dev/null
+++ b/arch/csky/include/asm/bitops.h
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_BITOPS_H
+#define __ASM_CSKY_BITOPS_H
+
+#include <linux/compiler.h>
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
+	asm volatile (
+		"1:	ldex.w		%1, (%3)	\n"
+		"	mov		%0, %1		\n"
+		"	or32		%0, %0, %2	\n"
+		"	stex.w		%0, (%3)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp), "=&r"(old)
+		: "r"(mask), "r"(p)
+		: "memory");
+
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
+	asm volatile (
+		"1:	ldex.w		%1, (%3)	\n"
+		"	mov		%0, %1		\n"
+		"	xor32		%0, %0, %2	\n"
+		"	stex.w		%0, (%3)	\n"
+		"	bez		%0, 1b		\n"
+		: "=&r"(tmp), "=&r"(old)
+		: "r"(mask), "r"(p)
+		: "memory");
+
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
+
diff --git a/arch/csky/include/asm/checksum.h b/arch/csky/include/asm/checksum.h
new file mode 100644
index 0000000..3f7d255
--- /dev/null
+++ b/arch/csky/include/asm/checksum.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
+static __inline__ __sum16
+csum_ipv6_magic(
+	const struct in6_addr *saddr,
+	const struct in6_addr *daddr,
+	__u32 len,
+	unsigned short proto,
+	__wsum sum
+	)
+{
+	sum += saddr->in6_u.u6_addr32[0];
+	sum += saddr->in6_u.u6_addr32[1];
+	sum += saddr->in6_u.u6_addr32[2];
+	sum += saddr->in6_u.u6_addr32[3];
+	sum += daddr->in6_u.u6_addr32[0];
+	sum += daddr->in6_u.u6_addr32[1];
+	sum += daddr->in6_u.u6_addr32[2];
+	sum += daddr->in6_u.u6_addr32[3];
+	sum += (len + proto);
+
+	return csum_fold(sum);
+}
+#define _HAVE_ARCH_IPV6_CSUM
+
+#include <asm-generic/checksum.h>
+
+#endif /* __ASM_CSKY_CHECKSUM_H */
diff --git a/arch/csky/include/asm/reg_ops.h b/arch/csky/include/asm/reg_ops.h
new file mode 100644
index 0000000..6963e5a
--- /dev/null
+++ b/arch/csky/include/asm/reg_ops.h
@@ -0,0 +1,16 @@
+#ifndef __ASM_REGS_OPS_H
+#define __ASM_REGS_OPS_H
+
+#define mfcr(reg)					\
+({							\
+	unsigned int tmp;				\
+	asm volatile("mfcr %0, "reg"\n":"=r"(tmp));	\
+	tmp;						\
+})
+
+#define mtcr(reg, val)					\
+({							\
+	asm volatile("mtcr %0, "reg"\n"::"r"(val));	\
+})
+
+#endif /* __ASM_REGS_OPS_H */
diff --git a/arch/csky/include/uapi/asm/byteorder.h b/arch/csky/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..d254522
--- /dev/null
+++ b/arch/csky/include/uapi/asm/byteorder.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_BYTEORDER_H
+#define __ASM_CSKY_BYTEORDER_H
+
+#if defined(__cskyBE__)
+#include <linux/byteorder/big_endian.h>
+#elif defined(__cskyLE__)
+#include <linux/byteorder/little_endian.h>
+#else
+# error "There is no __cskyBE__, __cskyLE__"
+#endif
+
+#endif /* __ASM_CSKY_BYTEORDER_H */
-- 
2.7.4
