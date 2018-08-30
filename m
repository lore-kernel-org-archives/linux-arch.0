From: Will Deacon <will.deacon@arm.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Thu, 30 Aug 2018 14:57:50 +0100
Message-ID: <20180830135749.GA13005@arm.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535629996.4465.44.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Eugeniy,

On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> On Thu, 2018-08-30 at 10:51 +0100, Will Deacon wrote:
> > On Thu, Aug 30, 2018 at 11:44:11AM +0200, Peter Zijlstra wrote:
> > > On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> > > > On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > > > > Hi Guys,
> > > > > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > > > > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > > > > even on boot.
> > > > > 
> > > > > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > > > > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_torvalds_linux_commit_84c6591103dbeaf393a092a3fc7b09510825f6b9&d=DwIBAg&c=DPL6
> > > > > _X_6JkXFx7AXWqB0tg&r=ZlJN1MriPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=6y0FFvkGdIQ6kX2lZ31V99lMfMV-
> > > > > RyWyYhiUGzh0Bi0&s=GNwmhSynIcWqgZhiOwFEEH_AtbZAH443_L6QH4nw_ls&e=
> > > > > 
> > > > > Reverting the commit solves this problem.
> > > > > 
> > > > > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > > > > generic bitops implementation and it works fine.
> > > > > 
> > > > > Do you have any ideas what went wrong?
> > > > 
> > > > Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> > > > commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> > > > __clear_bit_unlock()")
> > > > That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> > > > __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> > > > 
> > > > This patch undoes that which could explain the issues you see. @Peter, @Will ?
> > > 
> > > Right, so the thinking is that on platforms that suffer that issue,
> > > atomic_set*() should DTRT. And if you look at your spinlock based atomic
> > > implementation, you'll note that atomic_set() does indeed do the right
> > > thing.
> > > 
> > > arch/arc/include/asm/atomic.h:108
> > 
> > Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644c56a
> > boils down to concurrent atomic_long_set_release() vs
> > atomic_long_fetch_or_acquire(), which really needs to work.
> > 
> > I'll keep digging. In the meantime, Vineet, do you have any useful crash
> > logs and do you only see the crashes in certain configurations (e.g. SMP but
> > !CONFIG_ARC_HAS_LLSC)?
> 
> We don't have such configuration (SMP with !CONFIG_ARC_HAS_LLSC).

Ok, thanks for confirming. If you could put your .config somewhere that
would be helpful, since the build fails for me with defconfig.

> I can see crashes with LLSC enabled in both SMP running on 4 cores
> and SMP running on 1 core.
> 
> 
> There are some crash logs (not sure if they are really useful):
> Crashes are quite spontaneous and mostly happens in IO-related code: 

Aha: arc seems to have separate spinlocks for protecting bitops and atomics.
This is a seriously bad idea, because you only implement some of the bitops
API in the architecture and rely on asm-generic to give you bitops/lock.h,
assuming that it's going to be implemented in terms of the other parts of
the bitops API (it isn't anymore).

Here's a quick hack (totally untested, since I can't even build an arc kernel)
which moves arc over to asm-generic for all of the bitops API and ditches
the bitops lock. You could probably also drop the ffs() stuff, but I'll
leave that up to you. The "downside" is serialisation between bitops and
atomics, but I actually think you probably want that for xchg/cmpxchg
anyway.

Will

--->8

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59a..50b0d5a56e32 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -17,242 +17,6 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <asm/barrier.h>
-#ifndef CONFIG_ARC_HAS_LLSC
-#include <asm/smp.h>
-#endif
-
-#ifdef CONFIG_ARC_HAS_LLSC
-
-/*
- * Hardware assisted Atomic-R-M-W
- */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned int temp;						\
-									\
-	m += nr >> 5;							\
-									\
-	nr &= 0x1f;							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock       %0, [%1]		\n"			\
-	"	" #asm_op " %0, %0, %2	\n"				\
-	"	scond       %0, [%1]		\n"			\
-	"	bnz         1b			\n"			\
-	: "=&r"(temp)	/* Early clobber, to prevent reg reuse */	\
-	: "r"(m),	/* Not "m": llock only supports reg direct addr mode */	\
-	  "ir"(nr)							\
-	: "cc");							\
-}
-
-/*
- * Semantically:
- *    Test the bit
- *    if clear
- *        set it and return 0 (old value)
- *    else
- *        return 1 (old value).
- *
- * Since ARC lacks a equivalent h/w primitive, the bit is set unconditionally
- * and the old value of bit is returned
- */
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old, temp;					\
-									\
-	m += nr >> 5;							\
-									\
-	nr &= 0x1f;							\
-									\
-	/*								\
-	 * Explicit full memory barrier needed before/after as		\
-	 * LLOCK/SCOND themselves don't provide any such smenatic	\
-	 */								\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"1:	llock       %0, [%2]	\n"				\
-	"	" #asm_op " %1, %0, %3	\n"				\
-	"	scond       %1, [%2]	\n"				\
-	"	bnz         1b		\n"				\
-	: "=&r"(old), "=&r"(temp)					\
-	: "r"(m), "ir"(nr)						\
-	: "cc");							\
-									\
-	smp_mb();							\
-									\
-	return (old & (1 << nr)) != 0;					\
-}
-
-#elif !defined(CONFIG_ARC_PLAT_EZNPS)
-
-/*
- * Non hardware assisted Atomic-R-M-W
- * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
- *
- * There's "significant" micro-optimization in writing our own variants of
- * bitops (over generic variants)
- *
- * (1) The generic APIs have "signed" @nr while we have it "unsigned"
- *     This avoids extra code to be generated for pointer arithmatic, since
- *     is "not sure" that index is NOT -ve
- * (2) Utilize the fact that ARCompact bit fidding insn (BSET/BCLR/ASL) etc
- *     only consider bottom 5 bits of @nr, so NO need to mask them off.
- *     (GCC Quirk: however for constant @nr we still need to do the masking
- *             at compile time)
- */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long temp, flags;					\
-	m += nr >> 5;							\
-									\
-	/*								\
-	 * spin lock/unlock provide the needed smp_mb() before/after	\
-	 */								\
-	bitops_lock(flags);						\
-									\
-	temp = *m;							\
-	*m = temp c_op (1UL << (nr & 0x1f));					\
-									\
-	bitops_unlock(flags);						\
-}
-
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old, flags;					\
-	m += nr >> 5;							\
-									\
-	bitops_lock(flags);						\
-									\
-	old = *m;							\
-	*m = old c_op (1UL << (nr & 0x1f));				\
-									\
-	bitops_unlock(flags);						\
-									\
-	return (old & (1UL << (nr & 0x1f))) != 0;			\
-}
-
-#else /* CONFIG_ARC_PLAT_EZNPS */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	m += nr >> 5;							\
-									\
-	nr = (1UL << (nr & 0x1f));					\
-	if (asm_op == CTOP_INST_AAND_DI_R2_R2_R3)			\
-		nr = ~nr;						\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"	.word %2\n"						\
-	:								\
-	: "r"(nr), "r"(m), "i"(asm_op)					\
-	: "r2", "r3", "memory");					\
-}
-
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old;						\
-									\
-	m += nr >> 5;							\
-									\
-	nr = old = (1UL << (nr & 0x1f));				\
-	if (asm_op == CTOP_INST_AAND_DI_R2_R2_R3)			\
-		old = ~old;						\
-									\
-	/* Explicit full memory barrier needed before/after */		\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"       .word %2\n"						\
-	"	mov %0, r2"						\
-	: "+r"(old)							\
-	: "r"(m), "i"(asm_op)						\
-	: "r2", "r3", "memory");					\
-									\
-	smp_mb();							\
-									\
-	return (old & nr) != 0;					\
-}
-
-#endif /* CONFIG_ARC_PLAT_EZNPS */
-
-/***************************************
- * Non atomic variants
- **************************************/
-
-#define __BIT_OP(op, c_op, asm_op)					\
-static inline void __##op##_bit(unsigned long nr, volatile unsigned long *m)	\
-{									\
-	unsigned long temp;						\
-	m += nr >> 5;							\
-									\
-	temp = *m;							\
-	*m = temp c_op (1UL << (nr & 0x1f));				\
-}
-
-#define __TEST_N_BIT_OP(op, c_op, asm_op)				\
-static inline int __test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old;						\
-	m += nr >> 5;							\
-									\
-	old = *m;							\
-	*m = old c_op (1UL << (nr & 0x1f));				\
-									\
-	return (old & (1UL << (nr & 0x1f))) != 0;			\
-}
-
-#define BIT_OPS(op, c_op, asm_op)					\
-									\
-	/* set_bit(), clear_bit(), change_bit() */			\
-	BIT_OP(op, c_op, asm_op)					\
-									\
-	/* test_and_set_bit(), test_and_clear_bit(), test_and_change_bit() */\
-	TEST_N_BIT_OP(op, c_op, asm_op)					\
-									\
-	/* __set_bit(), __clear_bit(), __change_bit() */		\
-	__BIT_OP(op, c_op, asm_op)					\
-									\
-	/* __test_and_set_bit(), __test_and_clear_bit(), __test_and_change_bit() */\
-	__TEST_N_BIT_OP(op, c_op, asm_op)
-
-#ifndef CONFIG_ARC_PLAT_EZNPS
-BIT_OPS(set, |, bset)
-BIT_OPS(clear, & ~, bclr)
-BIT_OPS(change, ^, bxor)
-#else
-BIT_OPS(set, |, CTOP_INST_AOR_DI_R2_R2_R3)
-BIT_OPS(clear, & ~, CTOP_INST_AAND_DI_R2_R2_R3)
-BIT_OPS(change, ^, CTOP_INST_AXOR_DI_R2_R2_R3)
-#endif
-
-/*
- * This routine doesn't need to be atomic.
- */
-static inline int
-test_bit(unsigned int nr, const volatile unsigned long *addr)
-{
-	unsigned long mask;
-
-	addr += nr >> 5;
-
-	mask = 1UL << (nr & 0x1f);
-
-	return ((mask & *addr) != 0);
-}
 
 #ifdef CONFIG_ISA_ARCOMPACT
 
@@ -428,6 +192,9 @@ static inline __attribute__ ((const)) int __ffs(unsigned long x)
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/lock.h>
 
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
+
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/arc/include/asm/smp.h b/arch/arc/include/asm/smp.h
index 0861007d9ef3..8df446c2b299 100644
--- a/arch/arc/include/asm/smp.h
+++ b/arch/arc/include/asm/smp.h
@@ -108,7 +108,6 @@ static inline const char *arc_platform_smp_cpuinfo(void)
 #include <asm/spinlock.h>
 
 extern arch_spinlock_t smp_atomic_ops_lock;
-extern arch_spinlock_t smp_bitops_lock;
 
 #define atomic_ops_lock(flags)	do {		\
 	local_irq_save(flags);			\
@@ -120,24 +119,11 @@ extern arch_spinlock_t smp_bitops_lock;
 	local_irq_restore(flags);		\
 } while (0)
 
-#define bitops_lock(flags)	do {		\
-	local_irq_save(flags);			\
-	arch_spin_lock(&smp_bitops_lock);	\
-} while (0)
-
-#define bitops_unlock(flags) do {		\
-	arch_spin_unlock(&smp_bitops_lock);	\
-	local_irq_restore(flags);		\
-} while (0)
-
 #else /* !CONFIG_SMP */
 
 #define atomic_ops_lock(flags)		local_irq_save(flags)
 #define atomic_ops_unlock(flags)	local_irq_restore(flags)
 
-#define bitops_lock(flags)		local_irq_save(flags)
-#define bitops_unlock(flags)		local_irq_restore(flags)
-
 #endif /* !CONFIG_SMP */
 
 #endif	/* !CONFIG_ARC_HAS_LLSC */
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 21d86c36692b..80c80c540743 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -32,10 +32,7 @@
 
 #ifndef CONFIG_ARC_HAS_LLSC
 arch_spinlock_t smp_atomic_ops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-arch_spinlock_t smp_bitops_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-
 EXPORT_SYMBOL_GPL(smp_atomic_ops_lock);
-EXPORT_SYMBOL_GPL(smp_bitops_lock);
 #endif
 
 struct plat_smp_ops  __weak plat_smp_ops;
