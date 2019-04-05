Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfDEOAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:39 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 13/21] powerpc/mmiowb: Hook up mmwiob() implementation to asm-generic code
Date: Fri,  5 Apr 2019 14:59:28 +0100
Message-ID: <20190405135936.7266-14-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405135928.ogvPVbE618jNFTdQA5qN_F9u1qwRnsFCKG2aVCixQio@z>

In a bid to kill off explicit mmiowb() usage in driver code, hook up
the asm-generic mmiowb() tracking code but provide a definition of
arch_mmiowb_state() so that the tracking data can remain in the paca
as it does at present

This replaces the existing (flawed) implementation.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/Kbuild     |  1 -
 arch/powerpc/include/asm/io.h       | 33 +++------------------------------
 arch/powerpc/include/asm/mmiowb.h   | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/paca.h     |  6 +++++-
 arch/powerpc/include/asm/spinlock.h | 17 -----------------
 arch/powerpc/xmon/xmon.c            |  5 ++++-
 7 files changed, 33 insertions(+), 50 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mmiowb.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..5e3d0853c31d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -132,6 +132,7 @@ config PPC
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MMIOWB			if PPC64
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 74b6605ca55f..a0c132bedfae 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -7,7 +7,6 @@ generic-y += export.h
 generic-y += irq_regs.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += vtime.h
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 4b73847e9b95..1fad67b46409 100644
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
index 000000000000..b10180613507
--- /dev/null
+++ b/arch/powerpc/include/asm/mmiowb.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMIOWB_H
+#define _ASM_POWERPC_MMIOWB_H
+
+#ifdef CONFIG_MMIOWB
+
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+#include <asm/paca.h>
+
+#define arch_mmiowb_state()	(&local_paca->mmiowb_state)
+#define mmiowb()		mb()
+
+#else
+#define mmiowb()		do { } while (0)
+#endif /* CONFIG_MMIOWB */
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* _ASM_POWERPC_MMIOWB_H */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e843bc5d1a0f..134e912d403f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -34,6 +34,8 @@
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
 
+#include <asm-generic/mmiowb_types.h>
+
 register struct paca_struct *local_paca asm("r13");
 
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
@@ -171,7 +173,6 @@ struct paca_struct {
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
-	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -264,6 +265,9 @@ struct paca_struct {
 #ifdef CONFIG_STACKPROTECTOR
 	unsigned long canary;
 #endif
+#ifdef CONFIG_MMIOWB
+	struct mmiowb_state mmiowb_state;
+#endif
 } ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
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
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0f44f992360..13c6a47e6150 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2429,7 +2429,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, trap_save, "%#-*x");
 	DUMP(p, irq_soft_mask, "%#-*x");
 	DUMP(p, irq_happened, "%#-*x");
-	DUMP(p, io_sync, "%#-*x");
+#ifdef CONFIG_MMIOWB
+	DUMP(p, mmiowb_state.nesting_count, "%#-*x");
+	DUMP(p, mmiowb_state.mmiowb_pending, "%#-*x");
+#endif
 	DUMP(p, irq_work_pending, "%#-*x");
 	DUMP(p, nap_state_lost, "%#-*x");
 	DUMP(p, sprg_vdso, "%#-*llx");
-- 
2.11.0
