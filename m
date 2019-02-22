Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39488 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:17 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 12/20] powerpc: mmiowb: Hook up mmwiob() implementation to asm-generic code
Date: Fri, 22 Feb 2019 18:50:18 +0000
Message-ID: <20190222185026.10973-13-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185018.3fTfj_qzfIyNK0uoZ3r88fmbGkj7jhnr5bIYIuT3VjU@z>

In a bid to kill off explicit mmiowb() usage in driver code, hook up
the asm-generic mmiowb() tracking code but override all of the functions
so that the existing (flawed) implementation is preserved on Power.

Future work should either use the asm-generic implementation entirely,
or implement a similar counting mechanism to avoid erroneously skipping
barrier invocations when they are needed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/Kbuild     |  1 -
 arch/powerpc/include/asm/io.h       | 33 +++--------------------------
 arch/powerpc/include/asm/mmiowb.h   | 41 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h | 17 ---------------
 5 files changed, 45 insertions(+), 48 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mmiowb.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..242ee248b922 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MMIOWB			if PPC64 && SMP
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 57bd1f6660f4..77ff7fb24823 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -8,7 +8,6 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += vtime.h
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 7f19fbd3ba55..828100476ba6 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -34,14 +34,11 @@ extern struct pci_dev *isa_bridge_pcidev;
 #include <asm/byteorder.h>
 #include <asm/synch.h>
 #include <asm/delay.h>
+#include <asm/mmiowb.h>
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_PPC64
-#include <asm/paca.h>
-#endif
-
 #define SIO_CONFIG_RA	0x398
 #define SIO_CONFIG_RD	0x399
 
@@ -107,12 +104,6 @@ extern bool isa_io_special;
  *
  */
 
-#ifdef CONFIG_PPC64
-#define IO_SET_SYNC_FLAG()	do { local_paca->io_sync = 1; } while(0)
-#else
-#define IO_SET_SYNC_FLAG()
-#endif
-
 #define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
@@ -127,7 +118,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
 		: "=Z" (*addr) : "r" (val) : "memory");			\
-	IO_SET_SYNC_FLAG();						\
+	mmiowb_set_pending();						\
 }
 
 #define DEF_MMIO_IN_D(name, size, insn)				\
@@ -144,7 +135,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
 		: "=m" (*addr) : "r" (val) : "memory");			\
-	IO_SET_SYNC_FLAG();						\
+	mmiowb_set_pending();						\
 }
 
 DEF_MMIO_IN_D(in_8,     8, lbz);
@@ -652,24 +643,6 @@ static inline void name at					\
 
 #include <asm-generic/iomap.h>
 
-#ifdef CONFIG_PPC32
-#define mmiowb()
-#else
-/*
- * Enforce synchronisation of stores vs. spin_unlock
- * (this does it explicitly, though our implementation of spin_unlock
- * does it implicitely too)
- */
-static inline void mmiowb(void)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__("sync; li %0,0; stb %0,%1(13)"
-	: "=&r" (tmp) : "i" (offsetof(struct paca_struct, io_sync))
-	: "memory");
-}
-#endif /* !CONFIG_PPC32 */
-
 static inline void iosync(void)
 {
         __asm__ __volatile__ ("sync" : : : "memory");
diff --git a/arch/powerpc/include/asm/mmiowb.h b/arch/powerpc/include/asm/mmiowb.h
new file mode 100644
index 000000000000..7647ffcced1c
--- /dev/null
+++ b/arch/powerpc/include/asm/mmiowb.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMIOWB_H
+#define _ASM_POWERPC_MMIOWB_H
+
+#ifdef CONFIG_ARCH_HAS_MMIOWB
+
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+#include <asm/paca.h>
+
+#define mmiowb()		mb()
+
+/*
+ * Note: this is broken, as it doesn't correctly handle sequences such as:
+ *
+ *	spin_lock(&foo);	// io_sync = 0
+ *	outb(42, port);		// io_sync = 1
+ *	spin_lock(&bar);	// io_sync = 0
+ *	...
+ *	spin_unlock(&bar);
+ *	spin_unlock(&foo);
+ *
+ * The implementation in asm-generic/mmiowb.h deals with this by counting
+ * the critical sections.
+ */
+#define mmiowb_set_pending()	do { local_paca->io_sync = 1; } while (0)
+#define mmiowb_spin_lock()	do { get_paca()->io_sync = 0; } while (0)
+
+#define mmiowb_spin_unlock()	do {					\
+	if (unlikely(get_paca()->io_sync)) {				\
+		mmiowb();						\
+		get_paca()->io_sync = 0;				\
+	}								\
+} while (0)
+#else
+#define mmiowb()		do { } while (0)
+#endif /* CONFIG_ARCH_HAS_MMIOWB */
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* _ASM_POWERPC_MMIOWB_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 685c72310f5d..15b39c407c4e 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -39,19 +39,6 @@
 #define LOCK_TOKEN	1
 #endif
 
-#if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
-#define CLEAR_IO_SYNC	(get_paca()->io_sync = 0)
-#define SYNC_IO		do {						\
-				if (unlikely(get_paca()->io_sync)) {	\
-					mb();				\
-					get_paca()->io_sync = 0;	\
-				}					\
-			} while (0)
-#else
-#define CLEAR_IO_SYNC
-#define SYNC_IO
-#endif
-
 #ifdef CONFIG_PPC_PSERIES
 #define vcpu_is_preempted vcpu_is_preempted
 static inline bool vcpu_is_preempted(int cpu)
@@ -99,7 +86,6 @@ static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
-	CLEAR_IO_SYNC;
 	return __arch_spin_trylock(lock) == 0;
 }
 
@@ -130,7 +116,6 @@ extern void __rw_yield(arch_rwlock_t *lock);
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
-	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__arch_spin_trylock(lock) == 0))
 			break;
@@ -148,7 +133,6 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 {
 	unsigned long flags_dis;
 
-	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__arch_spin_trylock(lock) == 0))
 			break;
@@ -167,7 +151,6 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	SYNC_IO;
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
 				PPC_RELEASE_BARRIER: : :"memory");
 	lock->slock = 0;
-- 
2.11.0
