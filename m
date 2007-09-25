Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:34414 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbXIYPwE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2007 11:52:04 -0400
Received: from localhost.localdomain ([127.0.0.1]:51860 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022201AbXIYPwB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Sep 2007 16:52:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PFq0Ku007557
	for <linux-arch@vger.kernel.org>; Tue, 25 Sep 2007 16:52:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PFq0jA007556
	for linux-arch@vger.kernel.org; Tue, 25 Sep 2007 16:52:00 +0100
Date: Tue, 25 Sep 2007 16:52:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Optimize cpumask functions for SMPs with < BITS_PER_LONG processors
Message-ID: <20070925155200.GA7342@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

When debugging a kernel using a logic analyzer (!) a colleague recently
noticed that because the <linux/cpumasks.h> functions are based on the
generic bitops which support arbitrary size bitfields we had a relativly
high overhead resulting from this.  Here's the chainsaw edition of a patch
to optimize this for CONFIG_NR_CPUS <= BITS_PER_LONG.  Comments?

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 31 Jul 2007 13:03:16 +0100

[PATCH] Optimize bitop code for single long bitfields such as cpumask_t on small SMP.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-alpha/bitops.h b/include/asm-alpha/bitops.h
index 9e71201..87e207e 100644
--- a/include/asm-alpha/bitops.h
+++ b/include/asm-alpha/bitops.h
@@ -236,6 +236,8 @@ test_bit(int nr, const volatile void * addr)
 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
diff --git a/include/asm-arm/bitops.h b/include/asm-arm/bitops.h
index b41831b..98dcd15 100644
--- a/include/asm-arm/bitops.h
+++ b/include/asm-arm/bitops.h
@@ -117,7 +117,9 @@ ____atomic_test_and_change_bit(unsigned int bit, volatile unsigned long *p)
 	return res & mask;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 /*
  *  A note about Endian-ness.
diff --git a/include/asm-avr32/bitops.h b/include/asm-avr32/bitops.h
index 5299f8c..784d60b 100644
--- a/include/asm-avr32/bitops.h
+++ b/include/asm-avr32/bitops.h
@@ -230,7 +230,9 @@ static inline int test_and_change_bit(int nr, volatile void * addr)
 	return (old & mask) != 0;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 /* Find First bit Set */
 static inline unsigned long __ffs(unsigned long word)
diff --git a/include/asm-blackfin/bitops.h b/include/asm-blackfin/bitops.h
index 27c2d0e..2fec38f 100644
--- a/include/asm-blackfin/bitops.h
+++ b/include/asm-blackfin/bitops.h
@@ -11,6 +11,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/sched.h>
diff --git a/include/asm-cris/bitops.h b/include/asm-cris/bitops.h
index a569065..2832ebd 100644
--- a/include/asm-cris/bitops.h
+++ b/include/asm-cris/bitops.h
@@ -141,7 +141,9 @@ static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
 	return retval;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 /*
  * Since we define it "external", it collides with the built-in
diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index f8560ed..509d20b 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -303,6 +303,7 @@ int __ilog2_u64(u64 n)
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 
 #define ext2_set_bit_atomic(lock,nr,addr)	test_and_set_bit  ((nr) ^ 0x18, (addr))
diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index 1f9d991..c741462 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -10,7 +10,9 @@
  */
 
 #include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls.h>
diff --git a/include/asm-generic/bitops/atomic-long.h b/include/asm-generic/bitops/atomic-long.h
new file mode 100644
index 0000000..ec8ae3b
--- /dev/null
+++ b/include/asm-generic/bitops/atomic-long.h
@@ -0,0 +1,112 @@
+#ifndef _ASM_GENERIC_BITOPS_ATOMIC_LONG_H_
+#define _ASM_GENERIC_BITOPS_ATOMIC_LONG_H_
+
+#include <asm/types.h>
+
+/*
+ * long_set_bit - Atomically set a bit in memory long
+ * @nr: the bit to set
+ * @addr: the address of the long
+ *
+ * This function is atomic and may not be reordered.  See __long_set_bit()
+ * if you do not require the atomic guarantees.
+ *
+ * Note: there are no guarantees that this function will not be reordered
+ * on non x86 architectures, so if you are writing portable code,
+ * make sure not to rely on its reordering guarantees.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline void long_set_bit(int nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+/*
+ * long_clear_bit - Clears a bit in memory long
+ * @nr: Bit to clear
+ * @addr: Address of long variable
+ *
+ * long_clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline void long_clear_bit(int nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+/*
+ * long_change_bit - Toggle a bit in memory long
+ * @nr: Bit to change
+ * @addr: Address of long variable
+ *
+ * long_change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline void long_change_bit(int nr, volatile unsigned long *addr)
+{
+	change_bit(nr, addr);
+}
+
+/*
+ * long_test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address of long in memory
+ *
+ * This operation is atomic and cannot be reordered.
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline int long_test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	return test_and_set_bit(nr, addr);
+}
+
+/*
+ * long_test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reorderdered on other architectures other than x86.
+ * It also implies a memory barrier.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline int long_test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	return test_and_clear_bit(nr, addr);
+}
+
+/*
+ * long_test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It also implies a memory barrier.
+ *
+ * Note that @nr must be less than BITS_PER_LONG; this function is
+ * restricted to acting on a single-word quantity.
+ */
+static inline int long_test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	return test_and_change_bit(nr, addr);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_ATOMIC_LONG_H */
diff --git a/include/asm-generic/bitops/non-atomic-long.h b/include/asm-generic/bitops/non-atomic-long.h
new file mode 100644
index 0000000..d26a39a
--- /dev/null
+++ b/include/asm-generic/bitops/non-atomic-long.h
@@ -0,0 +1,119 @@
+/*
+ * Bitops that only work on a single long instead of an array as their more
+ * generic non-long_* relatives which allows some better code optimization.
+ * For a bit number argument <= BITS_PER_LONG the two variants are identical,
+ * for numbers > BITS_PER_LONG the operation of thelong_* variants is
+ * undefined.
+ */
+#ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_LONG_H_
+#define _ASM_GENERIC_BITOPS_NON_ATOMIC_LONG_H_
+
+#include <asm/types.h>
+
+#define LONG_BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+
+/**
+ * __long_set_bit - Set a bit in memory long..
+ * @nr: the bit to set
+ * @addr: the address of the long variable.
+ *
+ * Unlike long_set_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static inline void __long_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+
+	*p  |= mask;
+}
+
+static inline void __long_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+
+	*p &= ~mask;
+}
+
+/**
+ * __long_change_bit - Toggle a bit in memory long
+ * @nr: the bit to change
+ * @addr: the address of the long variable
+ *
+ * Unlike long_change_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static inline void __long_change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+
+	*p ^= mask;
+}
+
+/**
+ * __long_test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address of long variable
+ *
+ * This operation is non-atomic and can be reordered.
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
+static inline int __long_test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+	unsigned long old = *p;
+
+	*p = old | mask;
+	return (old & mask) != 0;
+}
+
+/*
+ * __long_test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address of long variable in memory
+ *
+ * This operation is non-atomic and can be reordered.
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
+static inline int __long_test_and_clear_bit(int nr,
+					    volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+	unsigned long old = *p;
+
+	*p = old & ~mask;
+	return (old & mask) != 0;
+}
+
+/* WARNING: non atomic and it can be reordered! */
+static inline int __long_test_and_change_bit(int nr,
+					     volatile unsigned long *addr)
+{
+	unsigned long mask = LONG_BITOP_MASK(nr);
+	unsigned long *p = (unsigned long *) addr;
+	unsigned long old = *p;
+
+	*p = old ^ mask;
+	return (old & mask) != 0;
+}
+
+/**
+ * long_test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+
+static inline int long_test_bit(int nr, const volatile unsigned long *addr)
+{
+	return 1UL & (*addr >> nr);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_LONG_H_ */
diff --git a/include/asm-h8300/bitops.h b/include/asm-h8300/bitops.h
index d76299c..ba6d3f5 100644
--- a/include/asm-h8300/bitops.h
+++ b/include/asm-h8300/bitops.h
@@ -194,6 +194,7 @@ static __inline__ unsigned long __ffs(unsigned long word)
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/minix.h>
diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
index a20fe98..1079ba8 100644
--- a/include/asm-i386/bitops.h
+++ b/include/asm-i386/bitops.h
@@ -58,6 +58,8 @@ static inline void __set_bit(int nr, volatile unsigned long * addr)
 		:"Ir" (nr));
 }
 
+#define __long_set_bit(nr,addr) __set_bit((nr), (addr))
+
 /**
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
@@ -83,6 +85,9 @@ static inline void __clear_bit(int nr, volatile unsigned long * addr)
 		:"+m" (ADDR)
 		:"Ir" (nr));
 }
+
+#define __long_clear_bit(nr,addr) __clear_bit((nr), (addr))
+
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
 
@@ -103,6 +108,8 @@ static inline void __change_bit(int nr, volatile unsigned long * addr)
 		:"Ir" (nr));
 }
 
+#define __long_change_bit(nr,addr) __change_bit((nr), (addr))
+
 /**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
@@ -161,6 +168,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long * addr)
 	return oldbit;
 }
 
+#define __long_test_and_set_bit(nr,addr) __test_and_set_bit((nr), (addr))
+
 /**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
@@ -201,6 +210,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 	return oldbit;
 }
 
+#define __long_test_and_clear_bit(nr,addr) __test_and_clear_bit((nr), (addr))
+
 /* WARNING: non atomic and it can be reordered! */
 static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
@@ -213,6 +224,8 @@ static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
 	return oldbit;
 }
 
+#define __long_test_and_change_bit(nr,addr) __test_and_change_bit((nr), (addr))
+
 /**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
@@ -262,6 +275,10 @@ static inline int variable_test_bit(int nr, const volatile unsigned long * addr)
  constant_test_bit((nr),(addr)) : \
  variable_test_bit((nr),(addr)))
 
+#define long_test_bit(nr,addr) test_bit((nr), (addr))
+
+#include <asm-generic/bitops/atomic-long.h>
+
 #undef ADDR
 
 /**
diff --git a/include/asm-ia64/bitops.h b/include/asm-ia64/bitops.h
index 6cc517e..7c97528 100644
--- a/include/asm-ia64/bitops.h
+++ b/include/asm-ia64/bitops.h
@@ -279,6 +279,8 @@ test_bit (int nr, const volatile void *addr)
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
 }
 
+#include <asm-generic/bitops/atomic-long.h>
+
 /**
  * ffz - find the first zero bit in a long word
  * @x: The long word to find the bit in
diff --git a/include/asm-m32r/bitops.h b/include/asm-m32r/bitops.h
index 66ab672..20ecc60 100644
--- a/include/asm-m32r/bitops.h
+++ b/include/asm-m32r/bitops.h
@@ -243,7 +243,9 @@ static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 	return (oldbit != 0);
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/fls.h>
diff --git a/include/asm-m68k/bitops.h b/include/asm-m68k/bitops.h
index 1a61fdb..86d67ba 100644
--- a/include/asm-m68k/bitops.h
+++ b/include/asm-m68k/bitops.h
@@ -172,6 +172,8 @@ static inline int test_bit(int nr, const unsigned long *vaddr)
 	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
+
 static inline int find_first_zero_bit(const unsigned long *vaddr,
 				      unsigned size)
 {
diff --git a/include/asm-m68knommu/bitops.h b/include/asm-m68knommu/bitops.h
index 7d6075d..d8f9a20 100644
--- a/include/asm-m68knommu/bitops.h
+++ b/include/asm-m68knommu/bitops.h
@@ -158,6 +158,7 @@ static __inline__ int __test_bit(int nr, const volatile unsigned long * addr)
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
 
diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index 148bc79..210fef4 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -51,16 +51,16 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
+static inline void long_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long *m = (unsigned long *) addr;
+	unsigned short bit = nr;
 	unsigned long temp;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# set_bit	\n"
+		"1:	" __LL "%0, %1			# long_set_bit	\n"
 		"	or	%0, %2					\n"
 		"	" __SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
@@ -70,7 +70,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (__builtin_constant_p(bit)) {
 		__asm__ __volatile__(
-		"1:	" __LL "%0, %1			# set_bit	\n"
+		"1:	" __LL "%0, %1			# long_set_bit	\n"
 		"	" __INS "%0, %4, %2, 1				\n"
 		"	" __SC "%0, %1					\n"
 		"	beqz	%0, 2f					\n"
@@ -83,7 +83,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# set_bit	\n"
+		"1:	" __LL "%0, %1			# long_set_bit	\n"
 		"	or	%0, %2					\n"
 		"	" __SC	"%0, %1					\n"
 		"	beqz	%0, 2f					\n"
@@ -98,7 +98,6 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		*a |= mask;
@@ -106,6 +105,15 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	}
 }
 
+static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	long_set_bit(bit, m);
+}
+
+
 /*
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
@@ -116,16 +124,16 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
+static inline void long_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long *m = (unsigned long *) addr;
+	unsigned short bit = nr;
 	unsigned long temp;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# clear_bit	\n"
+		"1:	" __LL "%0, %1			# long_clear_bit\n"
 		"	and	%0, %2					\n"
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
@@ -135,7 +143,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (__builtin_constant_p(bit)) {
 		__asm__ __volatile__(
-		"1:	" __LL "%0, %1			# clear_bit	\n"
+		"1:	" __LL "%0, %1			# long_clear_bit\n"
 		"	" __INS "%0, $0, %2, 1				\n"
 		"	" __SC "%0, %1					\n"
 		"	beqz	%0, 2f					\n"
@@ -148,7 +156,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# clear_bit	\n"
+		"1:	" __LL "%0, %1			# long_clear_bit\n"
 		"	and	%0, %2					\n"
 		"	" __SC "%0, %1					\n"
 		"	beqz	%0, 2f					\n"
@@ -163,7 +171,6 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		*a &= ~mask;
@@ -171,6 +178,14 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	}
 }
 
+static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	long_clear_bit(bit, m);
+}
+
 /*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
@@ -180,37 +195,38 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
+static inline void long_change_bit(unsigned long nr,
+				   volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned short bit = nr;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"	.set	mips3				\n"
-		"1:	" __LL "%0, %1		# change_bit	\n"
-		"	xor	%0, %2				\n"
-		"	" __SC	"%0, %1				\n"
-		"	beqzl	%0, 1b				\n"
-		"	.set	mips0				\n"
+		"	.set	mips3					\n"
+		"1:	" __LL "%0, %1		# long_change_bit	\n"
+		"	xor	%0, %2					\n"
+		"	" __SC	"%0, %1					\n"
+		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << bit), "m" (*m));
 	} else if (cpu_has_llsc) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"	.set	mips3				\n"
-		"1:	" __LL "%0, %1		# change_bit	\n"
-		"	xor	%0, %2				\n"
-		"	" __SC	"%0, %1				\n"
-		"	beqz	%0, 2f				\n"
-		"	.subsection 2				\n"
-		"2:	b	1b				\n"
-		"	.previous				\n"
-		"	.set	mips0				\n"
+		"	.set	mips3					\n"
+		"1:	" __LL "%0, %1		# long_change_bit	\n"
+		"	xor	%0, %2					\n"
+		"	" __SC	"%0, %1					\n"
+		"	beqz	%0, 2f					\n"
+		"	.subsection 2					\n"
+		"2:	b	1b					\n"
+		"	.previous					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << bit), "m" (*m));
 	} else {
@@ -218,7 +234,6 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		*a ^= mask;
@@ -226,6 +241,15 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 	}
 }
 
+static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	long_change_bit(bit, m);
+}
+
+
 /*
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
@@ -234,19 +258,19 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(unsigned long nr,
+static inline int long_test_and_set_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned short bit = nr;
 	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
+		"1:	" __LL "%0, %1		# long_test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
@@ -256,14 +280,14 @@ static inline int test_and_set_bit(unsigned long nr,
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noreorder				\n"
 		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
+		"1:	" __LL "%0, %1		# long_test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqz	%2, 2f					\n"
@@ -281,7 +305,6 @@ static inline int test_and_set_bit(unsigned long nr,
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		res = (mask & *a);
@@ -294,6 +317,15 @@ static inline int test_and_set_bit(unsigned long nr,
 	return res != 0;
 }
 
+static inline int test_and_set_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	return long_test_and_set_bit(bit, m);
+}
+
 /*
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
@@ -302,19 +334,19 @@ static inline int test_and_set_bit(unsigned long nr,
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(unsigned long nr,
+static inline int long_test_and_clear_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned short bit = nr;
 	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
+		"1:	" __LL	"%0, %1		# long_test_and_clear_bit\n"
 		"	or	%2, %0, %3				\n"
 		"	xor	%2, %3					\n"
 		"	" __SC 	"%2, %1					\n"
@@ -326,11 +358,11 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "memory");
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (__builtin_constant_p(nr)) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
+		"1:	" __LL	"%0, %1		# long_test_and_clear_bit\n"
 		"	" __EXT "%2, %0, %3, 1				\n"
 		"	" __INS	"%0, $0, %3, 1				\n"
 		"	" __SC 	"%0, %1					\n"
@@ -343,14 +375,14 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "memory");
 #endif
 	} else if (cpu_has_llsc) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noreorder				\n"
 		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
+		"1:	" __LL	"%0, %1		# long_test_and_clear_bit\n"
 		"	or	%2, %0, %3				\n"
 		"	xor	%2, %3					\n"
 		"	" __SC 	"%2, %1					\n"
@@ -369,7 +401,6 @@ static inline int test_and_clear_bit(unsigned long nr,
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		res = (mask & *a);
@@ -382,6 +413,15 @@ static inline int test_and_clear_bit(unsigned long nr,
 	return res != 0;
 }
 
+static inline int test_and_clear_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	return long_test_and_clear_bit(bit, m);
+}
+
 /*
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
@@ -390,19 +430,19 @@ static inline int test_and_clear_bit(unsigned long nr,
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(unsigned long nr,
+static inline int long_test_and_change_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	unsigned short bit = nr;
 	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
+		"1:	" __LL	"%0, %1		# long_test_and_change_bit\n"
 		"	xor	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
@@ -412,14 +452,14 @@ static inline int test_and_change_bit(unsigned long nr,
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
 	} else if (cpu_has_llsc) {
-		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long *m = (unsigned long *) addr;
 		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	noreorder				\n"
 		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
+		"1:	" __LL	"%0, %1		# long_test_and_change_bit\n"
 		"	xor	%2, %0, %3				\n"
 		"	" __SC	"\t%2, %1				\n"
 		"	beqz	%2, 2f					\n"
@@ -437,7 +477,6 @@ static inline int test_and_change_bit(unsigned long nr,
 		unsigned long mask;
 		unsigned long flags;
 
-		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
 		res = (mask & *a);
@@ -450,7 +489,17 @@ static inline int test_and_change_bit(unsigned long nr,
 	return res != 0;
 }
 
+static inline int test_and_change_bit(unsigned long nr,
+	volatile unsigned long *addr)
+{
+	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+	unsigned short bit = nr & SZLONG_MASK;
+
+	return long_test_and_change_bit(bit, m);
+}
+
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
diff --git a/include/asm-parisc/bitops.h b/include/asm-parisc/bitops.h
index 015cb0d..8a091cd 100644
--- a/include/asm-parisc/bitops.h
+++ b/include/asm-parisc/bitops.h
@@ -108,7 +108,9 @@ static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
 	return (oldbit & mask) ? 1 : 0;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 #ifdef __KERNEL__
 
diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index 8144a27..032b39e 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -183,7 +183,9 @@ static __inline__ void set_bits(unsigned long mask, unsigned long *addr)
 	: "cc");
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 /*
  * Return the zero-based bit position (LE, not IBM bit numbering) of
diff --git a/include/asm-s390/bitops.h b/include/asm-s390/bitops.h
index f79c9b7..a52679a 100644
--- a/include/asm-s390/bitops.h
+++ b/include/asm-s390/bitops.h
@@ -435,6 +435,8 @@ __constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)) )
 
+#include <asm-generic/bitops/atomic-long.h>
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
diff --git a/include/asm-sh/bitops.h b/include/asm-sh/bitops.h
index 1c16792..7b8c9b7 100644
--- a/include/asm-sh/bitops.h
+++ b/include/asm-sh/bitops.h
@@ -98,7 +98,9 @@ static inline int test_and_change_bit(int nr, volatile void * addr)
 	return retval;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 static inline unsigned long ffz(unsigned long word)
 {
diff --git a/include/asm-sh64/bitops.h b/include/asm-sh64/bitops.h
index f3bdcdb..09c8824 100644
--- a/include/asm-sh64/bitops.h
+++ b/include/asm-sh64/bitops.h
@@ -109,7 +109,9 @@ static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 	return retval;
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 static __inline__ unsigned long ffz(unsigned long word)
 {
diff --git a/include/asm-sparc/bitops.h b/include/asm-sparc/bitops.h
index 329e696..1aa4cbd 100644
--- a/include/asm-sparc/bitops.h
+++ b/include/asm-sparc/bitops.h
@@ -84,7 +84,9 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 	(void) ___change_bit(ADDR, mask);
 }
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 #define smp_mb__before_clear_bit()	do { } while(0)
 #define smp_mb__after_clear_bit()	do { } while(0)
diff --git a/include/asm-sparc64/bitops.h b/include/asm-sparc64/bitops.h
index 3d5e1af..9eacf61 100644
--- a/include/asm-sparc64/bitops.h
+++ b/include/asm-sparc64/bitops.h
@@ -17,7 +17,9 @@ extern void set_bit(unsigned long nr, volatile unsigned long *addr);
 extern void clear_bit(unsigned long nr, volatile unsigned long *addr);
 extern void change_bit(unsigned long nr, volatile unsigned long *addr);
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 #ifdef CONFIG_SMP
 #define smp_mb__before_clear_bit()	membar_storeload_loadload()
diff --git a/include/asm-v850/bitops.h b/include/asm-v850/bitops.h
index 1fa99ba..0810259 100644
--- a/include/asm-v850/bitops.h
+++ b/include/asm-v850/bitops.h
@@ -138,6 +138,7 @@ static inline int __test_bit (int nr, const void *addr)
 #define smp_mb__before_clear_bit()	barrier ()
 #define smp_mb__after_clear_bit()	barrier ()
 
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/fls64.h>
diff --git a/include/asm-x86_64/bitops.h b/include/asm-x86_64/bitops.h
index d4dbbe5..1fb5315 100644
--- a/include/asm-x86_64/bitops.h
+++ b/include/asm-x86_64/bitops.h
@@ -254,6 +254,8 @@ static __inline__ int variable_test_bit(int nr, volatile const void * addr)
 
 #undef ADDR
 
+#include <asm-generic/bitops/atomic-long.h>
+
 extern long find_first_zero_bit(const unsigned long * addr, unsigned long size);
 extern long find_next_zero_bit (const unsigned long * addr, long size, long offset);
 extern long find_first_bit(const unsigned long * addr, unsigned long size);
diff --git a/include/asm-xtensa/bitops.h b/include/asm-xtensa/bitops.h
index 1c1e0d9..1754bac 100644
--- a/include/asm-xtensa/bitops.h
+++ b/include/asm-xtensa/bitops.h
@@ -27,7 +27,9 @@
 #define smp_mb__after_clear_bit()	barrier()
 
 #include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/atomic-long.h>
 #include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/non-atomic-long.h>
 
 #if XCHAL_HAVE_NSA
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23f5514..3147f21 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -91,13 +91,19 @@ extern cpumask_t _unused_cpumask_arg_;
 #define cpu_set(cpu, dst) __cpu_set((cpu), &(dst))
 static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
 {
-	set_bit(cpu, dstp->bits);
+	if (NR_CPUS <= BITS_PER_LONG)
+		long_set_bit(cpu, dstp->bits);
+	else
+		set_bit(cpu, dstp->bits);
 }
 
 #define cpu_clear(cpu, dst) __cpu_clear((cpu), &(dst))
 static inline void __cpu_clear(int cpu, volatile cpumask_t *dstp)
 {
-	clear_bit(cpu, dstp->bits);
+	if (NR_CPUS <= BITS_PER_LONG)
+		long_clear_bit(cpu, dstp->bits);
+	else
+		clear_bit(cpu, dstp->bits);
 }
 
 #define cpus_setall(dst) __cpus_setall(&(dst), NR_CPUS)
@@ -113,12 +119,25 @@ static inline void __cpus_clear(cpumask_t *dstp, int nbits)
 }
 
 /* No static inline type checking - see Subtlety (1) above. */
-#define cpu_isset(cpu, cpumask) test_bit((cpu), (cpumask).bits)
+#define cpu_isset(cpu, cpumask)						\
+({									\
+	int __res;							\
+									\
+	if (NR_CPUS <= BITS_PER_LONG)					\
+		__res = long_test_bit((cpu), (cpumask).bits);		\
+	else								\
+		__res = test_bit((cpu), (cpumask).bits);		\
+									\
+	__res;								\
+})
 
 #define cpu_test_and_set(cpu, cpumask) __cpu_test_and_set((cpu), &(cpumask))
 static inline int __cpu_test_and_set(int cpu, cpumask_t *addr)
 {
-	return test_and_set_bit(cpu, addr->bits);
+	if (NR_CPUS <= BITS_PER_LONG)
+		return long_test_and_set_bit(cpu, addr->bits);
+	else
+		return test_and_set_bit(cpu, addr->bits);
 }
 
 #define cpus_and(dst, src1, src2) __cpus_and(&(dst), &(src1), &(src2), NR_CPUS)
