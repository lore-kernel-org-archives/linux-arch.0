From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Fri, 17 Jul 2015 10:32:21 +0100
Message-ID: <20150717093221.GB18994@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
 <20150716151142.GR3717@linux.vnet.ibm.com>
 <1437087265.28088.53.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437087265.28088.53.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2015 at 11:54:25PM +0100, Benjamin Herrenschmidt wrote:
> On Thu, 2015-07-16 at 08:11 -0700, Paul E. McKenney wrote:
> > > So isync in lock in architecturally incorrect, despite being what
> > the
> > > architecture recommends using, yay !
> > 
> > Well, the architecture isn't expecting that crazies like myself would
> > want to have an unlock-lock provide ordering to some CPU not holding
> > the lock.  :-/
> 
> Yes, isync in lock effectively allows any load or store before the lock
> to leak into the lock and get re-ordered with things in there.
> 
> lwsync leaves us exposed to the re-order inside the LL/SC of a
> subsequent load.
> 
> So to get the full barrier semantic, the only option is a full sync,
> either in lock or unlock. Instinctively I prefer in lock but there's
> an argument to have it in unlock so we can get rid of the iosync
> business.

Yeah, removing the iosync logic kills mmiowb() as well (totally untested
diff below and I was too scared to touch that paca thing!). It also sticks
the full barrier in one place, since there's no try_unlock to worry about.

Will

--->8

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a8d2ef30d473..bb34f3bb66dc 100644
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
@@ -626,23 +617,7 @@ static inline void name at					\
 #define writel_relaxed(v, addr)	writel(v, addr)
 #define writeq_relaxed(v, addr)	writeq(v, addr)
 
-#ifdef CONFIG_PPC32
 #define mmiowb()
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
 
 static inline void iosync(void)
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
 
