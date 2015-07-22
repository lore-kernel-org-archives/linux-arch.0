From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 22 Jul 2015 17:49:44 +0100
Message-ID: <20150722164943.GQ6650@arm.com>
References: <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
 <20150716151142.GR3717@linux.vnet.ibm.com>
 <1437087265.28088.53.camel@kernel.crashing.org>
 <20150717093221.GB18994@arm.com>
 <1437171254.28088.87.camel@kernel.crashing.org>
 <20150720133906.GG9908@arm.com>
 <1437427094.3775.22.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36930 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965449AbbGVQto (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jul 2015 12:49:44 -0400
Content-Disposition: inline
In-Reply-To: <1437427094.3775.22.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, Jul 20, 2015 at 10:18:14PM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-07-20 at 14:39 +0100, Will Deacon wrote:
> > On Fri, Jul 17, 2015 at 11:14:14PM +0100, Benjamin Herrenschmidt wrote:
> > > On Fri, 2015-07-17 at 10:32 +0100, Will Deacon wrote:
> > > >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > > >  {
> > > > -       SYNC_IO;
> > > > -       __asm__ __volatile__("# arch_spin_unlock\n\t"
> > > > -                               PPC_RELEASE_BARRIER: : :"memory");
> > > > +       smp_mb();
> > > >         lock->slock = 0;
> > > >  }
> > > 
> > > That probably needs to be mb() in case somebody has the expectation that
> > > it does a barrier vs. DMA on UP.
> > 
> > Hmm, but on !SMP doesn't arch_spin_unlock effectively expand to barrier()
> > in the core code?
> 
> include/linux/spinlock_up.h:# define arch_spin_unlock(lock)	do {
> barrier(); (void)(lock); } while (0)
> 
> Indeed...

So, leaving mmiowb() alone, we end up with the patch below.

Will

--->8

From 9373a4226986dd69b6aaf896590ea43abeb1cc8e Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 22 Jul 2015 17:37:58 +0100
Subject: [PATCH] powerpc: kill smp_mb__after_unlock_lock

PowerPC is the only architecture defining smp_mb__after_unlock_lock,
but we can remove it by adding an unconditional sync (smp_mb()) to the
spin_unlock code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/powerpc/include/asm/io.h       | 13 +------------
 arch/powerpc/include/asm/spinlock.h | 22 +---------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a8d2ef30d473..a3ad51046b04 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -105,12 +105,6 @@ extern bool isa_io_special;
  *
  */
 
-#ifdef CONFIG_PPC64
-#define IO_SET_SYNC_FLAG()	do { local_paca->io_sync = 1; } while(0)
-#else
-#define IO_SET_SYNC_FLAG()
-#endif
-
 /* gcc 4.0 and older doesn't have 'Z' constraint */
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
 #define DEF_MMIO_IN_X(name, size, insn)				\
@@ -127,7 +121,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
 		: "=m" (*addr) : "r" (val), "r" (addr) : "memory");	\
-	IO_SET_SYNC_FLAG();						\
 }
 #else /* newer gcc */
 #define DEF_MMIO_IN_X(name, size, insn)				\
@@ -144,7 +137,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
 		: "=Z" (*addr) : "r" (val) : "memory");			\
-	IO_SET_SYNC_FLAG();						\
 }
 #endif
 
@@ -162,7 +154,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
 		: "=m" (*addr) : "r" (val) : "memory");			\
-	IO_SET_SYNC_FLAG();						\
 }
 
 DEF_MMIO_IN_D(in_8,     8, lbz);
@@ -630,9 +621,7 @@ static inline void name at					\
 #define mmiowb()
 #else
 /*
- * Enforce synchronisation of stores vs. spin_unlock
- * (this does it explicitly, though our implementation of spin_unlock
- * does it implicitely too)
+ * Explicitly enforce synchronisation of stores vs. spin_unlock
  */
 static inline void mmiowb(void)
 {
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 4dbe072eecbe..9da89ea4ff31 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -28,8 +28,6 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
-
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
@@ -41,19 +39,6 @@
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
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -91,7 +76,6 @@ static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
-	CLEAR_IO_SYNC;
 	return __arch_spin_trylock(lock) == 0;
 }
 
@@ -122,7 +106,6 @@ extern void __rw_yield(arch_rwlock_t *lock);
 
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
-	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__arch_spin_trylock(lock) == 0))
 			break;
@@ -140,7 +123,6 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 {
 	unsigned long flags_dis;
 
-	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__arch_spin_trylock(lock) == 0))
 			break;
@@ -158,9 +140,7 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	SYNC_IO;
-	__asm__ __volatile__("# arch_spin_unlock\n\t"
-				PPC_RELEASE_BARRIER: : :"memory");
+	smp_mb();
 	lock->slock = 0;
 }
 
-- 
2.1.4
