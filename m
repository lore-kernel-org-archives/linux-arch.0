Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:45428 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934800AbXGLDOZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jul 2007 23:14:25 -0400
Date: Thu, 12 Jul 2007 05:14:19 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch] bitops: lock bitops
Message-ID: <20070712031419.GF32414@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, tony.luck@intel.com, benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Here is a set of patches that aims to mitigate some of the lock_page
overhead on powerpc introduced in the fault path by another set.
Fortunately it also improves various other things too :)

After this set, a dd if=./big-sparse-file of=/dev/null on my G5
goes from 563MB/s to 575MB/s, or about 80ns less time per page.
However I won't post the full set until after getting some acks
from the arch people now, because it is a fair bit of churn in core
code (eg. renaming !TestSetPageLocked to trylock_page).

Not sure who else can take advantage of these. Sparc64 probably.

--
Introduce test_and_set_bit_lock / clear_bit_unlock bitops with lock semantics.
Add non-trivial implementations for powerpc and ia64.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 Documentation/atomic_ops.txt      |   14 +++++++++++
 Documentation/memory-barriers.txt |   14 ++++++++++-
 include/asm-alpha/bitops.h        |    1 
 include/asm-arm/bitops.h          |    1 
 include/asm-arm26/bitops.h        |    1 
 include/asm-avr32/bitops.h        |    1 
 include/asm-blackfin/bitops.h     |    1 
 include/asm-cris/bitops.h         |    1 
 include/asm-frv/bitops.h          |    1 
 include/asm-generic/bitops.h      |    1 
 include/asm-generic/bitops/lock.h |   19 ++++++++++++++++
 include/asm-h8300/bitops.h        |    1 
 include/asm-i386/bitops.h         |    1 
 include/asm-ia64/bitops.h         |   41 ++++++++++++++++++++++++++++++++++
 include/asm-m32r/bitops.h         |    1 
 include/asm-m68k/bitops.h         |    1 
 include/asm-m68knommu/bitops.h    |    1 
 include/asm-mips/bitops.h         |    1 
 include/asm-parisc/bitops.h       |    1 
 include/asm-powerpc/bitops.h      |   45 ++++++++++++++++++++++++++++++++++++++
 include/asm-s390/bitops.h         |    1 
 include/asm-sh/bitops.h           |    1 
 include/asm-sh64/bitops.h         |    1 
 include/asm-sparc/bitops.h        |    1 
 include/asm-sparc64/bitops.h      |    1 
 include/asm-v850/bitops.h         |    1 
 include/asm-x86_64/bitops.h       |    1 
 include/asm-xtensa/bitops.h       |    1 
 28 files changed, 154 insertions(+), 2 deletions(-)

Index: linux-2.6/include/asm-powerpc/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/bitops.h
+++ linux-2.6/include/asm-powerpc/bitops.h
@@ -86,6 +86,24 @@ static __inline__ void clear_bit(int nr,
 	: "cc" );
 }
 
+static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	unsigned long old;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	__asm__ __volatile__(
+	LWSYNC_ON_SMP
+"1:"	PPC_LLARX "%0,0,%3	# clear_bit_unlock\n"
+	"andc	%0,%0,%2\n"
+	PPC405_ERR77(0,%3)
+	PPC_STLCX "%0,0,%3\n"
+	"bne-	1b"
+	: "=&r" (old), "+m" (*p)
+	: "r" (mask), "r" (p)
+	: "cc" );
+}
+
 static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
@@ -125,6 +143,27 @@ static __inline__ int test_and_set_bit(u
 	return (old & mask) != 0;
 }
 
+static __inline__ int test_and_set_bit_lock(unsigned long nr,
+				       volatile unsigned long *addr)
+{
+	unsigned long old, t;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	__asm__ __volatile__(
+"1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit_lock\n"
+	"or	%1,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+	PPC_STLCX "%1,0,%3 \n"
+	"bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (old), "=&r" (t)
+	: "r" (mask), "r" (p)
+	: "cc", "memory");
+
+	return (old & mask) != 0;
+}
+
 static __inline__ int test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
@@ -185,6 +224,12 @@ static __inline__ void set_bits(unsigned
 
 #include <asm-generic/bitops/non-atomic.h>
 
+static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	__asm__ __volatile__(LWSYNC_ON_SMP);
+	__clear_bit(nr, addr);
+}
+
 /*
  * Return the zero-based bit position (LE, not IBM bit numbering) of
  * the most significant 1-bit in a double word.
Index: linux-2.6/include/asm-alpha/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/bitops.h
+++ linux-2.6/include/asm-alpha/bitops.h
@@ -367,6 +367,7 @@ static inline unsigned int hweight8(unsi
 #else
 #include <asm-generic/bitops/hweight.h>
 #endif
+#include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6/include/asm-arm/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-arm/bitops.h
+++ linux-2.6/include/asm-arm/bitops.h
@@ -286,6 +286,7 @@ static inline int constant_fls(int x)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 /*
  * Ext2 is defined to use little-endian byte ordering.
Index: linux-2.6/include/asm-arm26/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/bitops.h
+++ linux-2.6/include/asm-arm26/bitops.h
@@ -167,6 +167,7 @@ extern int _find_next_bit_le(const unsig
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 /*
  * Ext2 is defined to use little-endian byte ordering.
Index: linux-2.6/include/asm-avr32/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-avr32/bitops.h
+++ linux-2.6/include/asm-avr32/bitops.h
@@ -288,6 +288,7 @@ static inline int ffs(unsigned long word
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
Index: linux-2.6/include/asm-cris/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-cris/bitops.h
+++ linux-2.6/include/asm-cris/bitops.h
@@ -154,6 +154,7 @@ static inline int test_and_change_bit(in
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
 
Index: linux-2.6/include/asm-frv/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-frv/bitops.h
+++ linux-2.6/include/asm-frv/bitops.h
@@ -302,6 +302,7 @@ int __ilog2_u64(u64 n)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
 
Index: linux-2.6/include/asm-generic/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops.h
+++ linux-2.6/include/asm-generic/bitops.h
@@ -22,6 +22,7 @@
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
Index: linux-2.6/include/asm-generic/bitops/lock.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-generic/bitops/lock.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_GENERIC_BITOPS_LOCK_H_
+#define _ASM_GENERIC_BITOPS_LOCK_H_
+
+#define test_and_set_bit_lock(nr, addr)	test_and_set_bit(nr, addr)
+
+#define clear_bit_unlock(nr, addr)	\
+do {					\
+	smp_mb__before_clear_bit();	\
+	clear_bit(nr, addr);		\
+} while (0)
+
+#define __clear_bit_unlock(nr, addr)	\
+do {					\
+	smp_mb__before_clear_bit();	\
+	__clear_bit(nr, addr);		\
+} while (0)
+
+#endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
+
Index: linux-2.6/include/asm-h8300/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/bitops.h
+++ linux-2.6/include/asm-h8300/bitops.h
@@ -194,6 +194,7 @@ static __inline__ unsigned long __ffs(un
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/minix.h>
Index: linux-2.6/include/asm-i386/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-i386/bitops.h
+++ linux-2.6/include/asm-i386/bitops.h
@@ -402,6 +402,7 @@ static inline int fls(int x)
 }
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/bitops.h
+++ linux-2.6/include/asm-ia64/bitops.h
@@ -94,6 +94,38 @@ clear_bit (int nr, volatile void *addr)
 }
 
 /**
+ * clear_bit_unlock - Clears a bit in memory with release
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit_unlock() is atomic and may not be reordered.  It does
+ * contain a memory barrier suitable for unlock type operations.
+ */
+static __inline__ void
+clear_bit_unlock (int nr, volatile void *addr)
+{
+	__u32 mask, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	mask = ~(1 << (nr & 31));
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old & mask;
+	} while (cmpxchg_rel(m, old, new) != old);
+}
+
+/**
+ * __clear_bit_unlock - Non-atomically clear a bit with release
+ *
+ * This is like clear_bit_unlock, but the implementation may use a non-atomic
+ * store (this one uses an atomic, however).
+ */
+#define __clear_bit_unlock clear_bit_unlock
+
+/**
  * __clear_bit - Clears a bit in memory (non-atomic version)
  */
 static __inline__ void
@@ -170,6 +202,15 @@ test_and_set_bit (int nr, volatile void 
 }
 
 /**
+ * test_and_set_bit_lock - Set a bit and return its old value for lock
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This is the same as test_and_set_bit on ia64
+ */
+#define test_and_set_bit_lock test_and_set_bit
+
+/**
  * __test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
Index: linux-2.6/include/asm-m32r/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/bitops.h
+++ linux-2.6/include/asm-m32r/bitops.h
@@ -255,6 +255,7 @@ static __inline__ int test_and_change_bi
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6/include/asm-m68k/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/bitops.h
+++ linux-2.6/include/asm-m68k/bitops.h
@@ -314,6 +314,7 @@ static inline int fls(int x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 /* Bitmap functions for the minix filesystem */
 
Index: linux-2.6/include/asm-m68knommu/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/bitops.h
+++ linux-2.6/include/asm-m68knommu/bitops.h
@@ -160,6 +160,7 @@ static __inline__ int __test_bit(int nr,
 
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
Index: linux-2.6/include/asm-mips/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-mips/bitops.h
+++ linux-2.6/include/asm-mips/bitops.h
@@ -556,6 +556,7 @@ static inline int ffs(int word)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/minix.h>
Index: linux-2.6/include/asm-parisc/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/bitops.h
+++ linux-2.6/include/asm-parisc/bitops.h
@@ -208,6 +208,7 @@ static __inline__ int fls(int x)
 
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
Index: linux-2.6/include/asm-s390/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-s390/bitops.h
+++ linux-2.6/include/asm-s390/bitops.h
@@ -746,6 +746,7 @@ static inline int sched_find_first_bit(u
 #include <asm-generic/bitops/fls64.h>
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 /*
  * ATTENTION: intel byte ordering convention for ext2 and minix !!
Index: linux-2.6/include/asm-sh/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-sh/bitops.h
+++ linux-2.6/include/asm-sh/bitops.h
@@ -137,6 +137,7 @@ static inline unsigned long __ffs(unsign
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
Index: linux-2.6/include/asm-sh64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/bitops.h
+++ linux-2.6/include/asm-sh64/bitops.h
@@ -136,6 +136,7 @@ static __inline__ unsigned long ffz(unsi
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
Index: linux-2.6/include/asm-sparc/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/bitops.h
+++ linux-2.6/include/asm-sparc/bitops.h
@@ -96,6 +96,7 @@ static inline void change_bit(unsigned l
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
Index: linux-2.6/include/asm-sparc64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/bitops.h
+++ linux-2.6/include/asm-sparc64/bitops.h
@@ -81,6 +81,7 @@ static inline unsigned int hweight8(unsi
 #include <asm-generic/bitops/hweight.h>
 
 #endif
+#include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/find.h>
Index: linux-2.6/include/asm-v850/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-v850/bitops.h
+++ linux-2.6/include/asm-v850/bitops.h
@@ -145,6 +145,7 @@ static inline int __test_bit (int nr, co
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
 #define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
Index: linux-2.6/include/asm-xtensa/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/bitops.h
+++ linux-2.6/include/asm-xtensa/bitops.h
@@ -108,6 +108,7 @@ static inline int fls (unsigned int x)
 #endif
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/minix.h>
 
Index: linux-2.6/Documentation/atomic_ops.txt
===================================================================
--- linux-2.6.orig/Documentation/atomic_ops.txt
+++ linux-2.6/Documentation/atomic_ops.txt
@@ -369,6 +369,20 @@ brothers:
 	 */
 	 smp_mb__after_clear_bit();
 
+There are two special bitops with lock barrier semantics (acquire/release,
+same as spinlocks). These operate in the same way as their non-_lock/unlock
+postfixed variants, except that they are to provide acquire/release semantics,
+respectively. This means they can be used for bit_spin_trylock and
+bit_spin_unlock type operations without specifying any more barriers.
+
+	int test_and_set_bit_lock(unsigned long nr, unsigned long *addr);
+	void clear_bit_unlock(unsigned long nr, unsigned long *addr);
+	void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
+
+The __clear_bit_unlock version is non-atomic, however it still implements
+unlock barrier semantics. This can be useful if the lock itself is protecting
+the other bits in the word.
+
 Finally, there are non-atomic versions of the bitmask operations
 provided.  They are used in contexts where some other higher-level SMP
 locking scheme is being used to protect the bitmask, and thus less
Index: linux-2.6/Documentation/memory-barriers.txt
===================================================================
--- linux-2.6.orig/Documentation/memory-barriers.txt
+++ linux-2.6/Documentation/memory-barriers.txt
@@ -1479,7 +1479,8 @@ kernel.
 
 Any atomic operation that modifies some state in memory and returns information
 about the state (old or new) implies an SMP-conditional general memory barrier
-(smp_mb()) on each side of the actual operation.  These include:
+(smp_mb()) on each side of the actual operation (with the exception of
+explicit lock operations, described later).  These include:
 
 	xchg();
 	cmpxchg();
@@ -1536,10 +1537,19 @@ If they're used for constructing a lock 
 do need memory barriers as a lock primitive generally has to do things in a
 specific order.
 
-
 Basically, each usage case has to be carefully considered as to whether memory
 barriers are needed or not.
 
+The following operations are special locking primitives:
+
+	test_and_set_bit_lock();
+	clear_bit_unlock();
+	__clear_bit_unlock();
+
+These implement LOCK-class and UNLOCK-class operations. These should be used in
+preference to other operations when implementing locking primitives, because
+their implementations can be optimised on many architectures.
+
 [!] Note that special memory barrier primitives are available for these
 situations because on some CPUs the atomic instructions used imply full memory
 barriers, and so barrier instructions are superfluous in conjunction with them,
Index: linux-2.6/include/asm-blackfin/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-blackfin/bitops.h
+++ linux-2.6/include/asm-blackfin/bitops.h
@@ -199,6 +199,7 @@ static __inline__ int __test_bit(int nr,
 
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/ext2-non-atomic.h>
Index: linux-2.6/include/asm-x86_64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/bitops.h
+++ linux-2.6/include/asm-x86_64/bitops.h
@@ -408,6 +408,7 @@ static __inline__ int fls(int x)
 #define ARCH_HAS_FAST_MULTIPLIER 1
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
 
