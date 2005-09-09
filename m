Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 9 Sep 2005 12:15:21 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: spinlock-consolidation.patch
Message-Id: <20050909121521.12942a8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
To: linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>


Guys, I'm planning on sending this Linuswards in about two days time. 
There's never a right time for this sort of thing and there may be some
relatively trivial breakage for architectures I don't test for.  But it
kills 1300 lines of code.

So.  Last call, please...



From: Ingo Molnar <mingo@elte.hu>

This patch (written by me and also containing many suggestions of Arjan van
de Ven) does a major cleanup of the spinlock code.  It does the following
things:

 - consolidates and enhances the spinlock/rwlock debugging code

 - simplifies the asm/spinlock.h files

 - encapsulates the raw spinlock type and moves generic spinlock
   features (such as ->break_lock) into the generic code.

 - cleans up the spinlock code hierarchy to get rid of the spaghetti.

Most notably there's now only a single variant of the debugging code,
located in lib/spinlock_debug.c.  (previously we had one SMP debugging
variant per architecture, plus a separate generic one for UP builds)

Also, i've enhanced the rwlock debugging facility, it will now track
write-owners.  There is new spinlock-owner/CPU-tracking on SMP builds too. 
All locks have lockup detection now, which will work for both soft and hard
spin/rwlock lockups.

The arch-level include files now only contain the minimally necessary
subset of the spinlock code - all the rest that can be generalized now
lives in the generic headers:

 include/asm-i386/spinlock_types.h       |   16
 include/asm-x86_64/spinlock_types.h     |   16

I have also split up the various spinlock variants into separate files, 
making it easier to see which does what. The new layout is:

   SMP                         |  UP
   ----------------------------|-----------------------------------
   asm/spinlock_types_smp.h    |  linux/spinlock_types_up.h
   linux/spinlock_types.h      |  linux/spinlock_types.h
   asm/spinlock_smp.h          |  linux/spinlock_up.h
   linux/spinlock_api_smp.h    |  linux/spinlock_api_up.h
   linux/spinlock.h            |  linux/spinlock.h

/*
 * here's the role of the various spinlock/rwlock related include files:
 *
 * on SMP builds:
 *
 *  asm/spinlock_types.h: contains the raw_spinlock_t/raw_rwlock_t and the
 *                        initializers
 *
 *  linux/spinlock_types.h:
 *                        defines the generic type and initializers
 *
 *  asm/spinlock.h:       contains the __raw_spin_*()/etc. lowlevel
 *                        implementations, mostly inline assembly code
 *
 *   (also included on UP-debug builds:)
 *
 *  linux/spinlock_api_smp.h:
 *                        contains the prototypes for the _spin_*() APIs.
 *
 *  linux/spinlock.h:     builds the final spin_*() APIs.
 *
 * on UP builds:
 *
 *  linux/spinlock_type_up.h:
 *                        contains the generic, simplified UP spinlock type.
 *                        (which is an empty structure on non-debug builds)
 *
 *  linux/spinlock_types.h:
 *                        defines the generic type and initializers
 *
 *  linux/spinlock_up.h:
 *                        contains the __raw_spin_*()/etc. version of UP
 *                        builds. (which are NOPs on non-debug, non-preempt
 *                        builds)
 *
 *   (included on UP-non-debug builds:)
 *
 *  linux/spinlock_api_up.h:
 *                        builds the _spin_*() APIs.
 *
 *  linux/spinlock.h:     builds the final spin_*() APIs.
 */

All SMP and UP architectures are converted by this patch.

arm, i386, ia64, ppc, ppc64, s390/s390x, x64 was build-tested via
crosscompilers.  m32r, mips, sh, sparc, have not been tested yet, but should
be mostly fine.

From: Grant Grundler <grundler@parisc-linux.org>

  Booted and lightly tested on a500-44 (64-bit, SMP kernel, dual CPU). 
  Builds 32-bit SMP kernel (not booted or tested).  I did not try to build
  non-SMP kernels.  That should be trivial to fix up later if necessary.

  I converted bit ops atomic_hash lock to raw_spinlock_t.  Doing so avoids
  some ugly nesting of linux/*.h and asm/*.h files.  Those particular locks
  are well tested and contained entirely inside arch specific code.  I do NOT
  expect any new issues to arise with them.

 If someone does ever need to use debug/metrics with them, then they will
  need to unravel this hairball between spinlocks, atomic ops, and bit ops
  that exist only because parisc has exactly one atomic instruction: LDCW
  (load and clear word).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjanv@infradead.org>
Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
Cc: Matthew Wilcox <willy@debian.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 dev/null                             |  845 -----------------------------------
 arch/alpha/kernel/alpha_ksyms.c      |    9 
 arch/alpha/kernel/smp.c              |  172 -------
 arch/m32r/kernel/smp.c               |   48 -
 arch/mips/lib/dec_and_lock.c         |    8 
 arch/parisc/lib/Makefile             |    2 
 arch/parisc/lib/bitops.c             |    4 
 arch/ppc/lib/Makefile                |    1 
 arch/ppc/lib/dec_and_lock.c          |    8 
 arch/ppc64/lib/dec_and_lock.c        |    8 
 arch/ppc64/lib/locks.c               |   14 
 arch/s390/lib/spinlock.c             |   12 
 arch/sparc/kernel/sparc_ksyms.c      |   10 
 arch/sparc/lib/Makefile              |    2 
 arch/sparc64/kernel/process.c        |    5 
 arch/sparc64/kernel/sparc64_ksyms.c  |    5 
 arch/sparc64/lib/Makefile            |    1 
 fs/buffer.c                          |    1 
 include/asm-alpha/spinlock.h         |   96 +--
 include/asm-alpha/spinlock_types.h   |   20 
 include/asm-arm/spinlock.h           |   54 --
 include/asm-arm/spinlock_types.h     |   20 
 include/asm-i386/spinlock.h          |  200 ++------
 include/asm-i386/spinlock_types.h    |   20 
 include/asm-ia64/spinlock.h          |   69 +-
 include/asm-ia64/spinlock_types.h    |   21 
 include/asm-m32r/spinlock.h          |  127 +----
 include/asm-m32r/spinlock_types.h    |   23 
 include/asm-mips/spinlock.h          |   75 +--
 include/asm-mips/spinlock_types.h    |   20 
 include/asm-parisc/atomic.h          |   12 
 include/asm-parisc/bitops.h          |    2 
 include/asm-parisc/cacheflush.h      |    1 
 include/asm-parisc/processor.h       |    1 
 include/asm-parisc/spinlock.h        |  163 +-----
 include/asm-parisc/spinlock_types.h  |   21 
 include/asm-parisc/system.h          |   24 
 include/asm-ppc/spinlock.h           |   89 ---
 include/asm-ppc/spinlock_types.h     |   20 
 include/asm-ppc64/spinlock.h         |  191 +++----
 include/asm-ppc64/spinlock_types.h   |   20 
 include/asm-s390/spinlock.h          |   63 --
 include/asm-s390/spinlock_types.h    |   21 
 include/asm-sh/spinlock.h            |   61 --
 include/asm-sh/spinlock_types.h      |   22 
 include/asm-sparc/spinlock.h         |  140 -----
 include/asm-sparc/spinlock_types.h   |   20 
 include/asm-sparc64/spinlock.h       |  160 ------
 include/asm-sparc64/spinlock_types.h |   20 
 include/asm-x86_64/spinlock.h        |  164 +-----
 include/asm-x86_64/spinlock_types.h  |   20 
 include/linux/bit_spinlock.h         |   77 +++
 include/linux/jbd.h                  |    1 
 include/linux/spinlock.h             |  629 +++++---------------------
 include/linux/spinlock_api_smp.h     |   57 ++
 include/linux/spinlock_api_up.h      |   80 +++
 include/linux/spinlock_types.h       |   67 ++
 include/linux/spinlock_types_up.h    |   51 ++
 include/linux/spinlock_up.h          |   74 +++
 kernel/Makefile                      |    1 
 kernel/sched.c                       |    4 
 kernel/spinlock.c                    |   15 
 lib/Makefile                         |    1 
 lib/dec_and_lock.c                   |    3 
 lib/kernel_lock.c                    |    3 
 lib/spinlock_debug.c                 |  257 ++++++++++
 66 files changed, 1592 insertions(+), 2863 deletions(-)

diff -puN arch/alpha/kernel/alpha_ksyms.c~spinlock-consolidation arch/alpha/kernel/alpha_ksyms.c
--- devel/arch/alpha/kernel/alpha_ksyms.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/alpha/kernel/alpha_ksyms.c	2005-09-09 12:12:31.000000000 -0700
@@ -185,15 +185,6 @@ EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-#ifdef CONFIG_DEBUG_SPINLOCK
-EXPORT_SYMBOL(_raw_spin_unlock);
-EXPORT_SYMBOL(debug_spin_lock);
-EXPORT_SYMBOL(debug_spin_trylock);
-#endif
-#ifdef CONFIG_DEBUG_RWLOCK
-EXPORT_SYMBOL(_raw_write_lock);
-EXPORT_SYMBOL(_raw_read_lock);
-#endif
 EXPORT_SYMBOL(cpu_present_mask);
 #endif /* CONFIG_SMP */
 
diff -puN arch/alpha/kernel/smp.c~spinlock-consolidation arch/alpha/kernel/smp.c
--- devel/arch/alpha/kernel/smp.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/alpha/kernel/smp.c	2005-09-09 12:12:31.000000000 -0700
@@ -989,175 +989,3 @@ flush_icache_user_range(struct vm_area_s
 
 	preempt_enable();
 }
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-void
-_raw_spin_unlock(spinlock_t * lock)
-{
-	mb();
-	lock->lock = 0;
-
-	lock->on_cpu = -1;
-	lock->previous = NULL;
-	lock->task = NULL;
-	lock->base_file = "none";
-	lock->line_no = 0;
-}
-
-void
-debug_spin_lock(spinlock_t * lock, const char *base_file, int line_no)
-{
-	long tmp;
-	long stuck;
-	void *inline_pc = __builtin_return_address(0);
-	unsigned long started = jiffies;
-	int printed = 0;
-	int cpu = smp_processor_id();
-
-	stuck = 1L << 30;
- try_again:
-
-	/* Use sub-sections to put the actual loop at the end
-	   of this object file's text section so as to perfect
-	   branch prediction.  */
-	__asm__ __volatile__(
-	"1:	ldl_l	%0,%1\n"
-	"	subq	%2,1,%2\n"
-	"	blbs	%0,2f\n"
-	"	or	%0,1,%0\n"
-	"	stl_c	%0,%1\n"
-	"	beq	%0,3f\n"
-	"4:	mb\n"
-	".subsection 2\n"
-	"2:	ldl	%0,%1\n"
-	"	subq	%2,1,%2\n"
-	"3:	blt	%2,4b\n"
-	"	blbs	%0,2b\n"
-	"	br	1b\n"
-	".previous"
-	: "=r" (tmp), "=m" (lock->lock), "=r" (stuck)
-	: "m" (lock->lock), "2" (stuck) : "memory");
-
-	if (stuck < 0) {
-		printk(KERN_WARNING
-		       "%s:%d spinlock stuck in %s at %p(%d)"
-		       " owner %s at %p(%d) %s:%d\n",
-		       base_file, line_no,
-		       current->comm, inline_pc, cpu,
-		       lock->task->comm, lock->previous,
-		       lock->on_cpu, lock->base_file, lock->line_no);
-		stuck = 1L << 36;
-		printed = 1;
-		goto try_again;
-	}
-
-	/* Exiting.  Got the lock.  */
-	lock->on_cpu = cpu;
-	lock->previous = inline_pc;
-	lock->task = current;
-	lock->base_file = base_file;
-	lock->line_no = line_no;
-
-	if (printed) {
-		printk(KERN_WARNING
-		       "%s:%d spinlock grabbed in %s at %p(%d) %ld ticks\n",
-		       base_file, line_no, current->comm, inline_pc,
-		       cpu, jiffies - started);
-	}
-}
-
-int
-debug_spin_trylock(spinlock_t * lock, const char *base_file, int line_no)
-{
-	int ret;
-	if ((ret = !test_and_set_bit(0, lock))) {
-		lock->on_cpu = smp_processor_id();
-		lock->previous = __builtin_return_address(0);
-		lock->task = current;
-	} else {
-		lock->base_file = base_file;
-		lock->line_no = line_no;
-	}
-	return ret;
-}
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-#ifdef CONFIG_DEBUG_RWLOCK
-void _raw_write_lock(rwlock_t * lock)
-{
-	long regx, regy;
-	int stuck_lock, stuck_reader;
-	void *inline_pc = __builtin_return_address(0);
-
- try_again:
-
-	stuck_lock = 1<<30;
-	stuck_reader = 1<<30;
-
-	__asm__ __volatile__(
-	"1:	ldl_l	%1,%0\n"
-	"	blbs	%1,6f\n"
-	"	blt	%1,8f\n"
-	"	mov	1,%1\n"
-	"	stl_c	%1,%0\n"
-	"	beq	%1,6f\n"
-	"4:	mb\n"
-	".subsection 2\n"
-	"6:	blt	%3,4b	# debug\n"
-	"	subl	%3,1,%3	# debug\n"
-	"	ldl	%1,%0\n"
-	"	blbs	%1,6b\n"
-	"8:	blt	%4,4b	# debug\n"
-	"	subl	%4,1,%4	# debug\n"
-	"	ldl	%1,%0\n"
-	"	blt	%1,8b\n"
-	"	br	1b\n"
-	".previous"
-	: "=m" (*(volatile int *)lock), "=&r" (regx), "=&r" (regy),
-	  "=&r" (stuck_lock), "=&r" (stuck_reader)
-	: "m" (*(volatile int *)lock), "3" (stuck_lock), "4" (stuck_reader) : "memory");
-
-	if (stuck_lock < 0) {
-		printk(KERN_WARNING "write_lock stuck at %p\n", inline_pc);
-		goto try_again;
-	}
-	if (stuck_reader < 0) {
-		printk(KERN_WARNING "write_lock stuck on readers at %p\n",
-		       inline_pc);
-		goto try_again;
-	}
-}
-
-void _raw_read_lock(rwlock_t * lock)
-{
-	long regx;
-	int stuck_lock;
-	void *inline_pc = __builtin_return_address(0);
-
- try_again:
-
-	stuck_lock = 1<<30;
-
-	__asm__ __volatile__(
-	"1:	ldl_l	%1,%0;"
-	"	blbs	%1,6f;"
-	"	subl	%1,2,%1;"
-	"	stl_c	%1,%0;"
-	"	beq	%1,6f;"
-	"4:	mb\n"
-	".subsection 2\n"
-	"6:	ldl	%1,%0;"
-	"	blt	%2,4b	# debug\n"
-	"	subl	%2,1,%2	# debug\n"
-	"	blbs	%1,6b;"
-	"	br	1b\n"
-	".previous"
-	: "=m" (*(volatile int *)lock), "=&r" (regx), "=&r" (stuck_lock)
-	: "m" (*(volatile int *)lock), "2" (stuck_lock) : "memory");
-
-	if (stuck_lock < 0) {
-		printk(KERN_WARNING "read_lock stuck at %p\n", inline_pc);
-		goto try_again;
-	}
-}
-#endif /* CONFIG_DEBUG_RWLOCK */
diff -puN arch/m32r/kernel/smp.c~spinlock-consolidation arch/m32r/kernel/smp.c
--- devel/arch/m32r/kernel/smp.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/m32r/kernel/smp.c	2005-09-09 12:12:31.000000000 -0700
@@ -892,7 +892,6 @@ unsigned long send_IPI_mask_phys(cpumask
 	int try)
 {
 	spinlock_t *ipilock;
-	unsigned long flags = 0;
 	volatile unsigned long *ipicr_addr;
 	unsigned long ipicr_val;
 	unsigned long my_physid_mask;
@@ -916,50 +915,27 @@ unsigned long send_IPI_mask_phys(cpumask
 	 * write IPICRi (send IPIi)
 	 * unlock ipi_lock[i]
 	 */
+	spin_lock(ipilock);
 	__asm__ __volatile__ (
-		";; LOCK ipi_lock[i]		\n\t"
+		";; CHECK IPICRi == 0		\n\t"
 		".fillinsn			\n"
 		"1:				\n\t"
-		"mvfc	%1, psw 		\n\t"
-		"clrpsw	#0x40 -> nop		\n\t"
-		DCACHE_CLEAR("r4", "r5", "%2")
-		"lock	r4, @%2			\n\t"
-		"addi	r4, #-1			\n\t"
-		"unlock	r4, @%2			\n\t"
-		"mvtc	%1, psw			\n\t"
-		"bnez	r4, 2f			\n\t"
-		LOCK_SECTION_START(".balign 4 \n\t")
-		".fillinsn			\n"
-		"2:				\n\t"
-		"ld	r4, @%2			\n\t"
-		"blez	r4, 2b			\n\t"
+		"ld	%0, @%1			\n\t"
+		"and	%0, %4			\n\t"
+		"beqz	%0, 2f			\n\t"
+		"bnez	%3, 3f			\n\t"
 		"bra	1b			\n\t"
-		LOCK_SECTION_END
-		";; CHECK IPICRi == 0		\n\t"
-		".fillinsn			\n"
-		"3:				\n\t"
-		"ld	%0, @%3			\n\t"
-		"and	%0, %6			\n\t"
-		"beqz	%0, 4f			\n\t"
-		"bnez	%5, 5f			\n\t"
-		"bra	3b			\n\t"
 		";; WRITE IPICRi (send IPIi)	\n\t"
 		".fillinsn			\n"
-		"4:				\n\t"
-		"st	%4, @%3			\n\t"
-		";; UNLOCK ipi_lock[i]		\n\t"
+		"2:				\n\t"
+		"st	%2, @%1			\n\t"
 		".fillinsn			\n"
-		"5:				\n\t"
-		"ldi	r4, #1			\n\t"
-		"st	r4, @%2			\n\t"
+		"3:				\n\t"
 		: "=&r"(ipicr_val)
-		: "r"(flags), "r"(&ipilock->slock), "r"(ipicr_addr),
-		  "r"(mask), "r"(try), "r"(my_physid_mask)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
+		: "r"(ipicr_addr), "r"(mask), "r"(try), "r"(my_physid_mask)
+		: "memory"
 	);
+	spin_unlock(ipilock);
 
 	return ipicr_val;
 }
diff -puN arch/mips/lib/dec_and_lock.c~spinlock-consolidation arch/mips/lib/dec_and_lock.c
--- devel/arch/mips/lib/dec_and_lock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/mips/lib/dec_and_lock.c	2005-09-09 12:12:31.000000000 -0700
@@ -20,14 +20,7 @@
  * has a cmpxchg, and where atomic->value is an int holding
  * the value of the atomic (i.e. the high bits aren't used
  * for a lock or anything like that).
- *
- * N.B. ATOMIC_DEC_AND_LOCK gets defined in include/linux/spinlock.h
- * if spinlocks are empty and thus atomic_dec_and_lock is defined
- * to be atomic_dec_and_test - in that case we don't need it
- * defined here as well.
  */
-
-#ifndef ATOMIC_DEC_AND_LOCK
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -52,4 +45,3 @@ int _atomic_dec_and_lock(atomic_t *atomi
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif /* ATOMIC_DEC_AND_LOCK */
diff -puN arch/parisc/lib/bitops.c~spinlock-consolidation arch/parisc/lib/bitops.c
--- devel/arch/parisc/lib/bitops.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/parisc/lib/bitops.c	2005-09-09 12:12:31.000000000 -0700
@@ -13,8 +13,8 @@
 #include <asm/atomic.h>
 
 #ifdef CONFIG_SMP
-spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned = {
-	[0 ... (ATOMIC_HASH_SIZE-1)]  = SPIN_LOCK_UNLOCKED
+raw_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned = {
+	[0 ... (ATOMIC_HASH_SIZE-1)]  = __RAW_SPIN_LOCK_UNLOCKED
 };
 #endif
 
diff -L arch/parisc/lib/debuglocks.c -puN arch/parisc/lib/debuglocks.c~spinlock-consolidation /dev/null
--- devel/arch/parisc/lib/debuglocks.c
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
@@ -1,277 +0,0 @@
-/* 
- *    Debugging versions of SMP locking primitives.
- *
- *    Copyright (C) 2004 Thibaut VARENE <varenet@parisc-linux.org>
- *
- *    Some code stollen from alpha & sparc64 ;)
- *
- *    This program is free software; you can redistribute it and/or modify
- *    it under the terms of the GNU General Public License as published by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *    We use pdc_printf() throughout the file for all output messages, to avoid
- *    losing messages because of disabled interrupts. Since we're using these
- *    messages for debugging purposes, it makes sense not to send them to the
- *    linux console.
- */
-
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/hardirq.h>	/* in_interrupt() */
-#include <asm/system.h>
-#include <asm/hardirq.h>	/* in_interrupt() */
-#include <asm/pdc.h>
-
-#undef INIT_STUCK
-#define INIT_STUCK 1L << 30
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-
-
-void _dbg_spin_lock(spinlock_t * lock, const char *base_file, int line_no)
-{
-	volatile unsigned int *a;
-	long stuck = INIT_STUCK;
-	void *inline_pc = __builtin_return_address(0);
-	unsigned long started = jiffies;
-	int printed = 0;
-	int cpu = smp_processor_id();
-
-try_again:
-
-	/* Do the actual locking */
-	/* <T-Bone> ggg: we can't get stuck on the outter loop?
-	 * <ggg> T-Bone: We can hit the outer loop
-	 *	alot if multiple CPUs are constantly racing for a lock
-	 *	and the backplane is NOT fair about which CPU sees
-	 *	the update first. But it won't hang since every failed
-	 *	attempt will drop us back into the inner loop and
-	 *	decrement `stuck'.
-	 * <ggg> K-class and some of the others are NOT fair in the HW
-	 * 	implementation so we could see false positives.
-	 * 	But fixing the lock contention is easier than
-	 * 	fixing the HW to be fair.
-	 * <tausq> __ldcw() returns 1 if we get the lock; otherwise we
-	 * 	spin until the value of the lock changes, or we time out.
-	 */
-	mb();
-	a = __ldcw_align(lock);
-	while (stuck && (__ldcw(a) == 0))
-		while ((*a == 0) && --stuck);
-	mb();
-
-	if (unlikely(stuck <= 0)) {
-		pdc_printf(
-			"%s:%d: spin_lock(%s/%p) stuck in %s at %p(%d)"
-			" owned by %s:%d in %s at %p(%d)\n",
-			base_file, line_no, lock->module, lock,
-			current->comm, inline_pc, cpu,
-			lock->bfile, lock->bline, lock->task->comm,
-			lock->previous, lock->oncpu);
-		stuck = INIT_STUCK;
-		printed = 1;
-		goto try_again;
-	}
-
-	/* Exiting.  Got the lock.  */
-	lock->oncpu = cpu;
-	lock->previous = inline_pc;
-	lock->task = current;
-	lock->bfile = (char *)base_file;
-	lock->bline = line_no;
-
-	if (unlikely(printed)) {
-		pdc_printf(
-			"%s:%d: spin_lock grabbed in %s at %p(%d) %ld ticks\n",
-			base_file, line_no, current->comm, inline_pc,
-			cpu, jiffies - started);
-	}
-}
-
-void _dbg_spin_unlock(spinlock_t * lock, const char *base_file, int line_no)
-{
-	CHECK_LOCK(lock);
-	volatile unsigned int *a;
-	mb();
-	a = __ldcw_align(lock);
-	if (unlikely((*a != 0) && lock->babble)) {
-		lock->babble--;
-		pdc_printf(
-			"%s:%d: spin_unlock(%s:%p) not locked\n",
-			base_file, line_no, lock->module, lock);
-	}
-	*a = 1;	
-	mb();
-}
-
-int _dbg_spin_trylock(spinlock_t * lock, const char *base_file, int line_no)
-{
-	int ret;
-	volatile unsigned int *a;
-	mb();
-	a = __ldcw_align(lock);
-	ret = (__ldcw(a) != 0);
-	mb();
-	if (ret) {
-		lock->oncpu = smp_processor_id();
-		lock->previous = __builtin_return_address(0);
-		lock->task = current;
-	} else {
-		lock->bfile = (char *)base_file;
-		lock->bline = line_no;
-	}
-	return ret;
-}
-
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-#ifdef CONFIG_DEBUG_RWLOCK
-
-/* Interrupts trouble detailed explanation, thx Grant:
- *
- * o writer (wants to modify data) attempts to acquire the rwlock
- * o He gets the write lock.
- * o Interupts are still enabled, we take an interrupt with the
- *   write still holding the lock.
- * o interrupt handler tries to acquire the rwlock for read.
- * o deadlock since the writer can't release it at this point.
- * 
- * In general, any use of spinlocks that competes between "base"
- * level and interrupt level code will risk deadlock. Interrupts
- * need to be disabled in the base level routines to avoid it.
- * Or more precisely, only the IRQ the base level routine
- * is competing with for the lock.  But it's more efficient/faster
- * to just disable all interrupts on that CPU to guarantee
- * once it gets the lock it can release it quickly too.
- */
- 
-void _dbg_write_lock(rwlock_t *rw, const char *bfile, int bline)
-{
-	void *inline_pc = __builtin_return_address(0);
-	unsigned long started = jiffies;
-	long stuck = INIT_STUCK;
-	int printed = 0;
-	int cpu = smp_processor_id();
-	
-	if(unlikely(in_interrupt())) {	/* acquiring write lock in interrupt context, bad idea */
-		pdc_printf("write_lock caller: %s:%d, IRQs enabled,\n", bfile, bline);
-		BUG();
-	}
-
-	/* Note: if interrupts are disabled (which is most likely), the printk
-	will never show on the console. We might need a polling method to flush
-	the dmesg buffer anyhow. */
-	
-retry:
-	_raw_spin_lock(&rw->lock);
-
-	if(rw->counter != 0) {
-		/* this basically never happens */
-		_raw_spin_unlock(&rw->lock);
-		
-		stuck--;
-		if ((unlikely(stuck <= 0)) && (rw->counter < 0)) {
-			pdc_printf(
-				"%s:%d: write_lock stuck on writer"
-				" in %s at %p(%d) %ld ticks\n",
-				bfile, bline, current->comm, inline_pc,
-				cpu, jiffies - started);
-			stuck = INIT_STUCK;
-			printed = 1;
-		}
-		else if (unlikely(stuck <= 0)) {
-			pdc_printf(
-				"%s:%d: write_lock stuck on reader"
-				" in %s at %p(%d) %ld ticks\n",
-				bfile, bline, current->comm, inline_pc,
-				cpu, jiffies - started);
-			stuck = INIT_STUCK;
-			printed = 1;
-		}
-		
-		while(rw->counter != 0);
-
-		goto retry;
-	}
-
-	/* got it.  now leave without unlocking */
-	rw->counter = -1; /* remember we are locked */
-
-	if (unlikely(printed)) {
-		pdc_printf(
-			"%s:%d: write_lock grabbed in %s at %p(%d) %ld ticks\n",
-			bfile, bline, current->comm, inline_pc,
-			cpu, jiffies - started);
-	}
-}
-
-int _dbg_write_trylock(rwlock_t *rw, const char *bfile, int bline)
-{
-#if 0
-	void *inline_pc = __builtin_return_address(0);
-	int cpu = smp_processor_id();
-#endif
-	
-	if(unlikely(in_interrupt())) {	/* acquiring write lock in interrupt context, bad idea */
-		pdc_printf("write_lock caller: %s:%d, IRQs enabled,\n", bfile, bline);
-		BUG();
-	}
-
-	/* Note: if interrupts are disabled (which is most likely), the printk
-	will never show on the console. We might need a polling method to flush
-	the dmesg buffer anyhow. */
-	
-	_raw_spin_lock(&rw->lock);
-
-	if(rw->counter != 0) {
-		/* this basically never happens */
-		_raw_spin_unlock(&rw->lock);
-		return 0;
-	}
-
-	/* got it.  now leave without unlocking */
-	rw->counter = -1; /* remember we are locked */
-#if 0
-	pdc_printf("%s:%d: try write_lock grabbed in %s at %p(%d)\n",
-		   bfile, bline, current->comm, inline_pc, cpu);
-#endif
-	return 1;
-}
-
-void _dbg_read_lock(rwlock_t * rw, const char *bfile, int bline)
-{
-#if 0
-	void *inline_pc = __builtin_return_address(0);
-	unsigned long started = jiffies;
-	int cpu = smp_processor_id();
-#endif
-	unsigned long flags;
-
-	local_irq_save(flags);
-	_raw_spin_lock(&rw->lock); 
-
-	rw->counter++;
-#if 0
-	pdc_printf(
-		"%s:%d: read_lock grabbed in %s at %p(%d) %ld ticks\n",
-		bfile, bline, current->comm, inline_pc,
-		cpu, jiffies - started);
-#endif
-	_raw_spin_unlock(&rw->lock);
-	local_irq_restore(flags);
-}
-
-#endif /* CONFIG_DEBUG_RWLOCK */
diff -puN arch/parisc/lib/Makefile~spinlock-consolidation arch/parisc/lib/Makefile
--- devel/arch/parisc/lib/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/parisc/lib/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -5,5 +5,3 @@
 lib-y	:= lusercopy.o bitops.o checksum.o io.o memset.o fixup.o memcpy.o
 
 obj-y	:= iomap.o
-
-lib-$(CONFIG_SMP) += debuglocks.o
diff -puN arch/ppc64/lib/dec_and_lock.c~spinlock-consolidation arch/ppc64/lib/dec_and_lock.c
--- devel/arch/ppc64/lib/dec_and_lock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/ppc64/lib/dec_and_lock.c	2005-09-09 12:12:31.000000000 -0700
@@ -20,14 +20,7 @@
  * has a cmpxchg, and where atomic->value is an int holding
  * the value of the atomic (i.e. the high bits aren't used
  * for a lock or anything like that).
- *
- * N.B. ATOMIC_DEC_AND_LOCK gets defined in include/linux/spinlock.h
- * if spinlocks are empty and thus atomic_dec_and_lock is defined
- * to be atomic_dec_and_test - in that case we don't need it
- * defined here as well.
  */
-
-#ifndef ATOMIC_DEC_AND_LOCK
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -52,4 +45,3 @@ int _atomic_dec_and_lock(atomic_t *atomi
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif /* ATOMIC_DEC_AND_LOCK */
diff -puN arch/ppc64/lib/locks.c~spinlock-consolidation arch/ppc64/lib/locks.c
--- devel/arch/ppc64/lib/locks.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/ppc64/lib/locks.c	2005-09-09 12:12:31.000000000 -0700
@@ -23,12 +23,12 @@
 /* waiting for a spinlock... */
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 
-void __spin_yield(spinlock_t *lock)
+void __spin_yield(raw_spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
 	struct paca_struct *holder_paca;
 
-	lock_value = lock->lock;
+	lock_value = lock->slock;
 	if (lock_value == 0)
 		return;
 	holder_cpu = lock_value & 0xffff;
@@ -38,7 +38,7 @@ void __spin_yield(spinlock_t *lock)
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
-	if (lock->lock != lock_value)
+	if (lock->slock != lock_value)
 		return;		/* something has changed */
 #ifdef CONFIG_PPC_ISERIES
 	HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
@@ -54,7 +54,7 @@ void __spin_yield(spinlock_t *lock)
  * This turns out to be the same for read and write locks, since
  * we only know the holder if it is write-locked.
  */
-void __rw_yield(rwlock_t *rw)
+void __rw_yield(raw_rwlock_t *rw)
 {
 	int lock_value;
 	unsigned int holder_cpu, yield_count;
@@ -82,9 +82,9 @@ void __rw_yield(rwlock_t *rw)
 }
 #endif
 
-void spin_unlock_wait(spinlock_t *lock)
+void __raw_spin_unlock_wait(raw_spinlock_t *lock)
 {
-	while (lock->lock) {
+	while (lock->slock) {
 		HMT_low();
 		if (SHARED_PROCESSOR)
 			__spin_yield(lock);
@@ -92,4 +92,4 @@ void spin_unlock_wait(spinlock_t *lock)
 	HMT_medium();
 }
 
-EXPORT_SYMBOL(spin_unlock_wait);
+EXPORT_SYMBOL(__raw_spin_unlock_wait);
diff -puN arch/ppc/lib/dec_and_lock.c~spinlock-consolidation arch/ppc/lib/dec_and_lock.c
--- devel/arch/ppc/lib/dec_and_lock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/ppc/lib/dec_and_lock.c	2005-09-09 12:12:31.000000000 -0700
@@ -11,14 +11,7 @@
  * has a cmpxchg, and where atomic->value is an int holding
  * the value of the atomic (i.e. the high bits aren't used
  * for a lock or anything like that).
- *
- * N.B. ATOMIC_DEC_AND_LOCK gets defined in include/linux/spinlock.h
- * if spinlocks are empty and thus atomic_dec_and_lock is defined
- * to be atomic_dec_and_test - in that case we don't need it
- * defined here as well.
  */
-
-#ifndef ATOMIC_DEC_AND_LOCK
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -43,4 +36,3 @@ int _atomic_dec_and_lock(atomic_t *atomi
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif /* ATOMIC_DEC_AND_LOCK */
diff -puN arch/ppc/lib/Makefile~spinlock-consolidation arch/ppc/lib/Makefile
--- devel/arch/ppc/lib/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/ppc/lib/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -4,6 +4,5 @@
 
 obj-y			:= checksum.o string.o strcase.o dec_and_lock.o div64.o
 
-obj-$(CONFIG_SMP)	+= locks.o
 obj-$(CONFIG_8xx)	+= rheap.o
 obj-$(CONFIG_CPM2)	+= rheap.o
diff -puN arch/s390/lib/spinlock.c~spinlock-consolidation arch/s390/lib/spinlock.c
--- devel/arch/s390/lib/spinlock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/s390/lib/spinlock.c	2005-09-09 12:12:31.000000000 -0700
@@ -36,7 +36,7 @@ _diag44(void)
 }
 
 void
-_raw_spin_lock_wait(spinlock_t *lp, unsigned int pc)
+_raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc)
 {
 	int count = spin_retry;
 
@@ -53,7 +53,7 @@ _raw_spin_lock_wait(spinlock_t *lp, unsi
 EXPORT_SYMBOL(_raw_spin_lock_wait);
 
 int
-_raw_spin_trylock_retry(spinlock_t *lp, unsigned int pc)
+_raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc)
 {
 	int count = spin_retry;
 
@@ -67,7 +67,7 @@ _raw_spin_trylock_retry(spinlock_t *lp, 
 EXPORT_SYMBOL(_raw_spin_trylock_retry);
 
 void
-_raw_read_lock_wait(rwlock_t *rw)
+_raw_read_lock_wait(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	int count = spin_retry;
@@ -86,7 +86,7 @@ _raw_read_lock_wait(rwlock_t *rw)
 EXPORT_SYMBOL(_raw_read_lock_wait);
 
 int
-_raw_read_trylock_retry(rwlock_t *rw)
+_raw_read_trylock_retry(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	int count = spin_retry;
@@ -102,7 +102,7 @@ _raw_read_trylock_retry(rwlock_t *rw)
 EXPORT_SYMBOL(_raw_read_trylock_retry);
 
 void
-_raw_write_lock_wait(rwlock_t *rw)
+_raw_write_lock_wait(raw_rwlock_t *rw)
 {
 	int count = spin_retry;
 
@@ -119,7 +119,7 @@ _raw_write_lock_wait(rwlock_t *rw)
 EXPORT_SYMBOL(_raw_write_lock_wait);
 
 int
-_raw_write_trylock_retry(rwlock_t *rw)
+_raw_write_trylock_retry(raw_rwlock_t *rw)
 {
 	int count = spin_retry;
 
diff -puN arch/sparc64/kernel/process.c~spinlock-consolidation arch/sparc64/kernel/process.c
--- devel/arch/sparc64/kernel/process.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/sparc64/kernel/process.c	2005-09-09 12:12:31.000000000 -0700
@@ -607,11 +607,6 @@ int copy_thread(int nr, unsigned long cl
 	struct thread_info *t = p->thread_info;
 	char *child_trap_frame;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	p->thread.smp_lock_count = 0;
-	p->thread.smp_lock_pc = 0;
-#endif
-
 	/* Calculate offset to stack_frame & pt_regs */
 	child_trap_frame = ((char *)t) + (THREAD_SIZE - (TRACEREG_SZ+STACKFRAME_SZ));
 	memcpy(child_trap_frame, (((struct sparc_stackf *)regs)-1), (TRACEREG_SZ+STACKFRAME_SZ));
diff -puN arch/sparc64/kernel/sparc64_ksyms.c~spinlock-consolidation arch/sparc64/kernel/sparc64_ksyms.c
--- devel/arch/sparc64/kernel/sparc64_ksyms.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/sparc64/kernel/sparc64_ksyms.c	2005-09-09 12:12:31.000000000 -0700
@@ -115,17 +115,12 @@ EXPORT_PER_CPU_SYMBOL(__cpu_data);
 
 /* used by various drivers */
 #ifdef CONFIG_SMP
-#ifndef CONFIG_DEBUG_SPINLOCK
 /* Out of line rw-locking implementation. */
 EXPORT_SYMBOL(__read_lock);
 EXPORT_SYMBOL(__read_unlock);
 EXPORT_SYMBOL(__write_lock);
 EXPORT_SYMBOL(__write_unlock);
 EXPORT_SYMBOL(__write_trylock);
-/* Out of line spin-locking implementation. */
-EXPORT_SYMBOL(_raw_spin_lock);
-EXPORT_SYMBOL(_raw_spin_lock_flags);
-#endif
 
 /* Hard IRQ locking */
 EXPORT_SYMBOL(synchronize_irq);
diff -L arch/sparc64/lib/debuglocks.c -puN arch/sparc64/lib/debuglocks.c~spinlock-consolidation /dev/null
--- devel/arch/sparc64/lib/debuglocks.c
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
@@ -1,366 +0,0 @@
-/* $Id: debuglocks.c,v 1.9 2001/11/17 00:10:48 davem Exp $
- * debuglocks.c: Debugging versions of SMP locking primitives.
- *
- * Copyright (C) 1998 David S. Miller (davem@redhat.com)
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <asm/system.h>
-
-#ifdef CONFIG_SMP
-
-static inline void show (char *str, spinlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-
-	printk("%s(%p) CPU#%d stuck at %08x, owner PC(%08x):CPU(%x)\n",
-	       str, lock, cpu, (unsigned int) caller,
-	       lock->owner_pc, lock->owner_cpu);
-}
-
-static inline void show_read (char *str, rwlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-
-	printk("%s(%p) CPU#%d stuck at %08x, writer PC(%08x):CPU(%x)\n",
-	       str, lock, cpu, (unsigned int) caller,
-	       lock->writer_pc, lock->writer_cpu);
-}
-
-static inline void show_write (char *str, rwlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-	int i;
-
-	printk("%s(%p) CPU#%d stuck at %08x\n",
-	       str, lock, cpu, (unsigned int) caller);
-	printk("Writer: PC(%08x):CPU(%x)\n",
-	       lock->writer_pc, lock->writer_cpu);
-	printk("Readers:");
-	for (i = 0; i < NR_CPUS; i++)
-		if (lock->reader_pc[i])
-			printk(" %d[%08x]", i, lock->reader_pc[i]);
-	printk("\n");
-}
-
-#undef INIT_STUCK
-#define INIT_STUCK 100000000
-
-void _do_spin_lock(spinlock_t *lock, char *str, unsigned long caller)
-{
-	unsigned long val;
-	int stuck = INIT_STUCK;
-	int cpu = get_cpu();
-	int shown = 0;
-
-again:
-	__asm__ __volatile__("ldstub [%1], %0"
-			     : "=r" (val)
-			     : "r" (&(lock->lock))
-			     : "memory");
-	membar_storeload_storestore();
-	if (val) {
-		while (lock->lock) {
-			if (!--stuck) {
-				if (shown++ <= 2)
-					show(str, lock, caller);
-				stuck = INIT_STUCK;
-			}
-			rmb();
-		}
-		goto again;
-	}
-	lock->owner_pc = ((unsigned int)caller);
-	lock->owner_cpu = cpu;
-	current->thread.smp_lock_count++;
-	current->thread.smp_lock_pc = ((unsigned int)caller);
-
-	put_cpu();
-}
-
-int _do_spin_trylock(spinlock_t *lock, unsigned long caller)
-{
-	unsigned long val;
-	int cpu = get_cpu();
-
-	__asm__ __volatile__("ldstub [%1], %0"
-			     : "=r" (val)
-			     : "r" (&(lock->lock))
-			     : "memory");
-	membar_storeload_storestore();
-	if (!val) {
-		lock->owner_pc = ((unsigned int)caller);
-		lock->owner_cpu = cpu;
-		current->thread.smp_lock_count++;
-		current->thread.smp_lock_pc = ((unsigned int)caller);
-	}
-
-	put_cpu();
-
-	return val == 0;
-}
-
-void _do_spin_unlock(spinlock_t *lock)
-{
-	lock->owner_pc = 0;
-	lock->owner_cpu = NO_PROC_ID;
-	membar_storestore_loadstore();
-	lock->lock = 0;
-	current->thread.smp_lock_count--;
-}
-
-/* Keep INIT_STUCK the same... */
-
-void _do_read_lock(rwlock_t *rw, char *str, unsigned long caller)
-{
-	unsigned long val;
-	int stuck = INIT_STUCK;
-	int cpu = get_cpu();
-	int shown = 0;
-
-wlock_again:
-	/* Wait for any writer to go away.  */
-	while (((long)(rw->lock)) < 0) {
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_read(str, rw, caller);
-			stuck = INIT_STUCK;
-		}
-		rmb();
-	}
-	/* Try once to increment the counter.  */
-	__asm__ __volatile__(
-"	ldx		[%0], %%g1\n"
-"	brlz,a,pn	%%g1, 2f\n"
-"	 mov		1, %0\n"
-"	add		%%g1, 1, %%g7\n"
-"	casx		[%0], %%g1, %%g7\n"
-"	sub		%%g1, %%g7, %0\n"
-"2:"	: "=r" (val)
-	: "0" (&(rw->lock))
-	: "g1", "g7", "memory");
-	membar_storeload_storestore();
-	if (val)
-		goto wlock_again;
-	rw->reader_pc[cpu] = ((unsigned int)caller);
-	current->thread.smp_lock_count++;
-	current->thread.smp_lock_pc = ((unsigned int)caller);
-
-	put_cpu();
-}
-
-void _do_read_unlock(rwlock_t *rw, char *str, unsigned long caller)
-{
-	unsigned long val;
-	int stuck = INIT_STUCK;
-	int cpu = get_cpu();
-	int shown = 0;
-
-	/* Drop our identity _first_. */
-	rw->reader_pc[cpu] = 0;
-	current->thread.smp_lock_count--;
-runlock_again:
-	/* Spin trying to decrement the counter using casx.  */
-	__asm__ __volatile__(
-"	membar	#StoreLoad | #LoadLoad\n"
-"	ldx	[%0], %%g1\n"
-"	sub	%%g1, 1, %%g7\n"
-"	casx	[%0], %%g1, %%g7\n"
-"	membar	#StoreLoad | #StoreStore\n"
-"	sub	%%g1, %%g7, %0\n"
-	: "=r" (val)
-	: "0" (&(rw->lock))
-	: "g1", "g7", "memory");
-	if (val) {
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_read(str, rw, caller);
-			stuck = INIT_STUCK;
-		}
-		goto runlock_again;
-	}
-
-	put_cpu();
-}
-
-void _do_write_lock(rwlock_t *rw, char *str, unsigned long caller)
-{
-	unsigned long val;
-	int stuck = INIT_STUCK;
-	int cpu = get_cpu();
-	int shown = 0;
-
-wlock_again:
-	/* Spin while there is another writer. */
-	while (((long)rw->lock) < 0) {
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_write(str, rw, caller);
-			stuck = INIT_STUCK;
-		}
-		rmb();
-	}
-
-	/* Try to acuire the write bit.  */
-	__asm__ __volatile__(
-"	mov	1, %%g3\n"
-"	sllx	%%g3, 63, %%g3\n"
-"	ldx	[%0], %%g1\n"
-"	brlz,pn	%%g1, 1f\n"
-"	 or	%%g1, %%g3, %%g7\n"
-"	casx	[%0], %%g1, %%g7\n"
-"	membar	#StoreLoad | #StoreStore\n"
-"	ba,pt	%%xcc, 2f\n"
-"	 sub	%%g1, %%g7, %0\n"
-"1:	mov	1, %0\n"
-"2:"	: "=r" (val)
-	: "0" (&(rw->lock))
-	: "g3", "g1", "g7", "memory");
-	if (val) {
-		/* We couldn't get the write bit. */
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_write(str, rw, caller);
-			stuck = INIT_STUCK;
-		}
-		goto wlock_again;
-	}
-	if ((rw->lock & ((1UL<<63)-1UL)) != 0UL) {
-		/* Readers still around, drop the write
-		 * lock, spin, and try again.
-		 */
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_write(str, rw, caller);
-			stuck = INIT_STUCK;
-		}
-		__asm__ __volatile__(
-"		mov	1, %%g3\n"
-"		sllx	%%g3, 63, %%g3\n"
-"1:		ldx	[%0], %%g1\n"
-"		andn	%%g1, %%g3, %%g7\n"
-"		casx	[%0], %%g1, %%g7\n"
-"		cmp	%%g1, %%g7\n"
-"		membar	#StoreLoad | #StoreStore\n"
-"		bne,pn	%%xcc, 1b\n"
-"		 nop"
-		: /* no outputs */
-		: "r" (&(rw->lock))
-		: "g3", "g1", "g7", "cc", "memory");
-		while(rw->lock != 0) {
-			if (!--stuck) {
-				if (shown++ <= 2)
-					show_write(str, rw, caller);
-				stuck = INIT_STUCK;
-			}
-			rmb();
-		}
-		goto wlock_again;
-	}
-
-	/* We have it, say who we are. */
-	rw->writer_pc = ((unsigned int)caller);
-	rw->writer_cpu = cpu;
-	current->thread.smp_lock_count++;
-	current->thread.smp_lock_pc = ((unsigned int)caller);
-
-	put_cpu();
-}
-
-void _do_write_unlock(rwlock_t *rw, unsigned long caller)
-{
-	unsigned long val;
-	int stuck = INIT_STUCK;
-	int shown = 0;
-
-	/* Drop our identity _first_ */
-	rw->writer_pc = 0;
-	rw->writer_cpu = NO_PROC_ID;
-	current->thread.smp_lock_count--;
-wlock_again:
-	__asm__ __volatile__(
-"	membar	#StoreLoad | #LoadLoad\n"
-"	mov	1, %%g3\n"
-"	sllx	%%g3, 63, %%g3\n"
-"	ldx	[%0], %%g1\n"
-"	andn	%%g1, %%g3, %%g7\n"
-"	casx	[%0], %%g1, %%g7\n"
-"	membar	#StoreLoad | #StoreStore\n"
-"	sub	%%g1, %%g7, %0\n"
-	: "=r" (val)
-	: "0" (&(rw->lock))
-	: "g3", "g1", "g7", "memory");
-	if (val) {
-		if (!--stuck) {
-			if (shown++ <= 2)
-				show_write("write_unlock", rw, caller);
-			stuck = INIT_STUCK;
-		}
-		goto wlock_again;
-	}
-}
-
-int _do_write_trylock(rwlock_t *rw, char *str, unsigned long caller)
-{
-	unsigned long val;
-	int cpu = get_cpu();
-
-	/* Try to acuire the write bit.  */
-	__asm__ __volatile__(
-"	mov	1, %%g3\n"
-"	sllx	%%g3, 63, %%g3\n"
-"	ldx	[%0], %%g1\n"
-"	brlz,pn	%%g1, 1f\n"
-"	 or	%%g1, %%g3, %%g7\n"
-"	casx	[%0], %%g1, %%g7\n"
-"	membar	#StoreLoad | #StoreStore\n"
-"	ba,pt	%%xcc, 2f\n"
-"	 sub	%%g1, %%g7, %0\n"
-"1:	mov	1, %0\n"
-"2:"	: "=r" (val)
-	: "0" (&(rw->lock))
-	: "g3", "g1", "g7", "memory");
-
-	if (val) {
-		put_cpu();
-		return 0;
-	}
-
-	if ((rw->lock & ((1UL<<63)-1UL)) != 0UL) {
-		/* Readers still around, drop the write
-		 * lock, return failure.
-		 */
-		__asm__ __volatile__(
-"		mov	1, %%g3\n"
-"		sllx	%%g3, 63, %%g3\n"
-"1:		ldx	[%0], %%g1\n"
-"		andn	%%g1, %%g3, %%g7\n"
-"		casx	[%0], %%g1, %%g7\n"
-"		cmp	%%g1, %%g7\n"
-"		membar	#StoreLoad | #StoreStore\n"
-"		bne,pn	%%xcc, 1b\n"
-"		 nop"
-		: /* no outputs */
-		: "r" (&(rw->lock))
-		: "g3", "g1", "g7", "cc", "memory");
-
-		put_cpu();
-
-		return 0;
-	}
-
-	/* We have it, say who we are. */
-	rw->writer_pc = ((unsigned int)caller);
-	rw->writer_cpu = cpu;
-	current->thread.smp_lock_count++;
-	current->thread.smp_lock_pc = ((unsigned int)caller);
-
-	put_cpu();
-
-	return 1;
-}
-
-#endif /* CONFIG_SMP */
diff -puN arch/sparc64/lib/Makefile~spinlock-consolidation arch/sparc64/lib/Makefile
--- devel/arch/sparc64/lib/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/sparc64/lib/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -14,7 +14,6 @@ lib-y := PeeCeeI.o copy_page.o clear_pag
 	 copy_in_user.o user_fixup.o memmove.o \
 	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o
 
-lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 
 obj-y += iomap.o
diff -puN arch/sparc/kernel/sparc_ksyms.c~spinlock-consolidation arch/sparc/kernel/sparc_ksyms.c
--- devel/arch/sparc/kernel/sparc_ksyms.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/sparc/kernel/sparc_ksyms.c	2005-09-09 12:12:31.000000000 -0700
@@ -114,17 +114,7 @@ DOT_ALIAS2(unsigned, urem, unsigned, uns
 /* used by various drivers */
 EXPORT_SYMBOL(sparc_cpu_model);
 EXPORT_SYMBOL(kernel_thread);
-#ifdef CONFIG_DEBUG_SPINLOCK
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(_do_spin_lock);
-EXPORT_SYMBOL(_do_spin_unlock);
-EXPORT_SYMBOL(_spin_trylock);
-EXPORT_SYMBOL(_do_read_lock);
-EXPORT_SYMBOL(_do_read_unlock);
-EXPORT_SYMBOL(_do_write_lock);
-EXPORT_SYMBOL(_do_write_unlock);
-#endif
-#else
 // XXX find what uses (or used) these.
 EXPORT_SYMBOL(___rw_read_enter);
 EXPORT_SYMBOL(___rw_read_exit);
diff -L arch/sparc/lib/debuglocks.c -puN arch/sparc/lib/debuglocks.c~spinlock-consolidation /dev/null
--- devel/arch/sparc/lib/debuglocks.c
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
@@ -1,202 +0,0 @@
-/* $Id: debuglocks.c,v 1.11 2001/09/20 00:35:31 davem Exp $
- * debuglocks.c: Debugging versions of SMP locking primitives.
- *
- * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1998-99 Anton Blanchard (anton@progsoc.uts.edu.au)
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/threads.h>	/* For NR_CPUS */
-#include <linux/spinlock.h>
-#include <asm/psr.h>
-#include <asm/system.h>
-
-#ifdef CONFIG_SMP
-
-/* Some notes on how these debugging routines work.  When a lock is acquired
- * an extra debugging member lock->owner_pc is set to the caller of the lock
- * acquisition routine.  Right before releasing a lock, the debugging program
- * counter is cleared to zero.
- *
- * Furthermore, since PC's are 4 byte aligned on Sparc, we stuff the CPU
- * number of the owner in the lowest two bits.
- */
-
-#define STORE_CALLER(A) __asm__ __volatile__("mov %%i7, %0" : "=r" (A));
-
-static inline void show(char *str, spinlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-
-	printk("%s(%p) CPU#%d stuck at %08lx, owner PC(%08lx):CPU(%lx)\n",str,
-		lock, cpu, caller, lock->owner_pc & ~3, lock->owner_pc & 3);
-}
-
-static inline void show_read(char *str, rwlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-
-	printk("%s(%p) CPU#%d stuck at %08lx, owner PC(%08lx):CPU(%lx)\n", str,
-		lock, cpu, caller, lock->owner_pc & ~3, lock->owner_pc & 3);
-}
-
-static inline void show_write(char *str, rwlock_t *lock, unsigned long caller)
-{
-	int cpu = smp_processor_id();
-	int i;
-
-	printk("%s(%p) CPU#%d stuck at %08lx, owner PC(%08lx):CPU(%lx)", str,
-		lock, cpu, caller, lock->owner_pc & ~3, lock->owner_pc & 3);
-
-	for(i = 0; i < NR_CPUS; i++)
-		printk(" reader[%d]=%08lx", i, lock->reader_pc[i]);
-
-	printk("\n");
-}
-
-#undef INIT_STUCK
-#define INIT_STUCK 100000000
-
-void _do_spin_lock(spinlock_t *lock, char *str)
-{
-	unsigned long caller;
-	unsigned long val;
-	int cpu = smp_processor_id();
-	int stuck = INIT_STUCK;
-
-	STORE_CALLER(caller);
-
-again:
-	__asm__ __volatile__("ldstub [%1], %0" : "=r" (val) : "r" (&(lock->lock)));
-	if(val) {
-		while(lock->lock) {
-			if (!--stuck) {
-				show(str, lock, caller);
-				stuck = INIT_STUCK;
-			}
-			barrier();
-		}
-		goto again;
-	}
-	lock->owner_pc = (cpu & 3) | (caller & ~3);
-}
-
-int _spin_trylock(spinlock_t *lock)
-{
-	unsigned long val;
-	unsigned long caller;
-	int cpu = smp_processor_id();
-
-	STORE_CALLER(caller);
-
-	__asm__ __volatile__("ldstub [%1], %0" : "=r" (val) : "r" (&(lock->lock)));
-	if(!val) {
-		/* We got it, record our identity for debugging. */
-		lock->owner_pc = (cpu & 3) | (caller & ~3);
-	}
-	return val == 0;
-}
-
-void _do_spin_unlock(spinlock_t *lock)
-{
-	lock->owner_pc = 0;
-	barrier();
-	lock->lock = 0;
-}
-
-void _do_read_lock(rwlock_t *rw, char *str)
-{
-	unsigned long caller;
-	unsigned long val;
-	int cpu = smp_processor_id();
-	int stuck = INIT_STUCK;
-
-	STORE_CALLER(caller);
-
-wlock_again:
-	__asm__ __volatile__("ldstub [%1 + 3], %0" : "=r" (val) : "r" (&(rw->lock)));
-	if(val) {
-		while(rw->lock & 0xff) {
-			if (!--stuck) {
-				show_read(str, rw, caller);
-				stuck = INIT_STUCK;
-			}
-			barrier();
-		}
-		goto wlock_again;
-	}
-
-	rw->reader_pc[cpu] = caller;
-	barrier();
-	rw->lock++;
-}
-
-void _do_read_unlock(rwlock_t *rw, char *str)
-{
-	unsigned long caller;
-	unsigned long val;
-	int cpu = smp_processor_id();
-	int stuck = INIT_STUCK;
-
-	STORE_CALLER(caller);
-
-wlock_again:
-	__asm__ __volatile__("ldstub [%1 + 3], %0" : "=r" (val) : "r" (&(rw->lock)));
-	if(val) {
-		while(rw->lock & 0xff) {
-			if (!--stuck) {
-				show_read(str, rw, caller);
-				stuck = INIT_STUCK;
-			}
-			barrier();
-		}
-		goto wlock_again;
-	}
-
-	rw->reader_pc[cpu] = 0;
-	barrier();
-	rw->lock -= 0x1ff;
-}
-
-void _do_write_lock(rwlock_t *rw, char *str)
-{
-	unsigned long caller;
-	unsigned long val;
-	int cpu = smp_processor_id();
-	int stuck = INIT_STUCK;
-
-	STORE_CALLER(caller);
-
-wlock_again:
-	__asm__ __volatile__("ldstub [%1 + 3], %0" : "=r" (val) : "r" (&(rw->lock)));
-	if(val) {
-wlock_wait:
-		while(rw->lock) {
-			if (!--stuck) {
-				show_write(str, rw, caller);
-				stuck = INIT_STUCK;
-			}
-			barrier();
-		}
-		goto wlock_again;
-	}
-
-	if (rw->lock & ~0xff) {
-		*(((unsigned char *)&rw->lock)+3) = 0;
-		barrier();
-		goto wlock_wait;
-	}
-
-	barrier();
-	rw->owner_pc = (cpu & 3) | (caller & ~3);
-}
-
-void _do_write_unlock(rwlock_t *rw)
-{
-	rw->owner_pc = 0;
-	barrier();
-	rw->lock = 0;
-}
-
-#endif /* SMP */
diff -puN arch/sparc/lib/Makefile~spinlock-consolidation arch/sparc/lib/Makefile
--- devel/arch/sparc/lib/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/arch/sparc/lib/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -9,5 +9,3 @@ lib-y := mul.o rem.o sdiv.o udiv.o umul.
 	 strncpy_from_user.o divdi3.o udivdi3.o strlen_user.o \
 	 copy_user.o locks.o atomic.o atomic32.o bitops.o \
 	 lshrdi3.o ashldi3.o rwsem.o muldi3.o bitext.o
-
-lib-$(CONFIG_DEBUG_SPINLOCK) +=	debuglocks.o
diff -puN fs/buffer.c~spinlock-consolidation fs/buffer.c
--- devel/fs/buffer.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/fs/buffer.c	2005-09-09 12:12:31.000000000 -0700
@@ -40,6 +40,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/mpage.h>
+#include <linux/bit_spinlock.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
diff -puN include/asm-alpha/spinlock.h~spinlock-consolidation include/asm-alpha/spinlock.h
--- devel/include/asm-alpha/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-alpha/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -6,7 +6,6 @@
 #include <linux/kernel.h>
 #include <asm/current.h>
 
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
@@ -14,43 +13,18 @@
  * We make no fairness assumptions. They have a cost.
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	int on_cpu;
-	int line_no;
-	void *previous;
-	struct task_struct * task;
-	const char *base_file;
-#endif
-} spinlock_t;
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPIN_LOCK_UNLOCKED	(spinlock_t){ 0, -1, 0, NULL, NULL, NULL }
-#else
-#define SPIN_LOCK_UNLOCKED	(spinlock_t){ 0 }
-#endif
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-extern void _raw_spin_unlock(spinlock_t * lock);
-extern void debug_spin_lock(spinlock_t * lock, const char *, int);
-extern int debug_spin_trylock(spinlock_t * lock, const char *, int);
-#define _raw_spin_lock(LOCK) \
-	debug_spin_lock(LOCK, __BASE_FILE__, __LINE__)
-#define _raw_spin_trylock(LOCK) \
-	debug_spin_trylock(LOCK, __BASE_FILE__, __LINE__)
-#else
-static inline void _raw_spin_unlock(spinlock_t * lock)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_is_locked(x)	((x)->lock != 0)
+#define __raw_spin_unlock_wait(x) \
+		do { cpu_relax(); } while ((x)->lock)
+
+static inline void __raw_spin_unlock(raw_spinlock_t * lock)
 {
 	mb();
 	lock->lock = 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t * lock)
+static inline void __raw_spin_lock(raw_spinlock_t * lock)
 {
 	long tmp;
 
@@ -70,80 +44,64 @@ static inline void _raw_spin_lock(spinlo
 	: "m"(lock->lock) : "memory");
 }
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	return !test_and_set_bit(0, &lock->lock);
 }
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 /***********************************************************/
 
-typedef struct {
-	volatile unsigned int lock;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED	(rwlock_t){ 0 }
-
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-static inline int read_can_lock(rwlock_t *lock)
+static inline int __raw_read_can_lock(raw_rwlock_t *lock)
 {
 	return (lock->lock & 1) == 0;
 }
 
-static inline int write_can_lock(rwlock_t *lock)
+static inline int __raw_write_can_lock(raw_rwlock_t *lock)
 {
 	return lock->lock == 0;
 }
 
-#ifdef CONFIG_DEBUG_RWLOCK
-extern void _raw_write_lock(rwlock_t * lock);
-extern void _raw_read_lock(rwlock_t * lock);
-#else
-static inline void _raw_write_lock(rwlock_t * lock)
+static inline void __raw_read_lock(raw_rwlock_t *lock)
 {
 	long regx;
 
 	__asm__ __volatile__(
 	"1:	ldl_l	%1,%0\n"
-	"	bne	%1,6f\n"
-	"	lda	%1,1\n"
+	"	blbs	%1,6f\n"
+	"	subl	%1,2,%1\n"
 	"	stl_c	%1,%0\n"
 	"	beq	%1,6f\n"
 	"	mb\n"
 	".subsection 2\n"
 	"6:	ldl	%1,%0\n"
-	"	bne	%1,6b\n"
+	"	blbs	%1,6b\n"
 	"	br	1b\n"
 	".previous"
 	: "=m" (*lock), "=&r" (regx)
 	: "m" (*lock) : "memory");
 }
 
-static inline void _raw_read_lock(rwlock_t * lock)
+static inline void __raw_write_lock(raw_rwlock_t *lock)
 {
 	long regx;
 
 	__asm__ __volatile__(
 	"1:	ldl_l	%1,%0\n"
-	"	blbs	%1,6f\n"
-	"	subl	%1,2,%1\n"
+	"	bne	%1,6f\n"
+	"	lda	%1,1\n"
 	"	stl_c	%1,%0\n"
 	"	beq	%1,6f\n"
 	"	mb\n"
 	".subsection 2\n"
 	"6:	ldl	%1,%0\n"
-	"	blbs	%1,6b\n"
+	"	bne	%1,6b\n"
 	"	br	1b\n"
 	".previous"
 	: "=m" (*lock), "=&r" (regx)
 	: "m" (*lock) : "memory");
 }
-#endif /* CONFIG_DEBUG_RWLOCK */
 
-static inline int _raw_read_trylock(rwlock_t * lock)
+static inline int __raw_read_trylock(raw_rwlock_t * lock)
 {
 	long regx;
 	int success;
@@ -165,7 +123,7 @@ static inline int _raw_read_trylock(rwlo
 	return success;
 }
 
-static inline int _raw_write_trylock(rwlock_t * lock)
+static inline int __raw_write_trylock(raw_rwlock_t * lock)
 {
 	long regx;
 	int success;
@@ -187,13 +145,7 @@ static inline int _raw_write_trylock(rwl
 	return success;
 }
 
-static inline void _raw_write_unlock(rwlock_t * lock)
-{
-	mb();
-	lock->lock = 0;
-}
-
-static inline void _raw_read_unlock(rwlock_t * lock)
+static inline void __raw_read_unlock(raw_rwlock_t * lock)
 {
 	long regx;
 	__asm__ __volatile__(
@@ -209,4 +161,10 @@ static inline void _raw_read_unlock(rwlo
 	: "m" (*lock) : "memory");
 }
 
+static inline void __raw_write_unlock(raw_rwlock_t * lock)
+{
+	mb();
+	lock->lock = 0;
+}
+
 #endif /* _ALPHA_SPINLOCK_H */
diff -puN /dev/null include/asm-alpha/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-alpha/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef _ALPHA_SPINLOCK_TYPES_H
+#define _ALPHA_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-arm/spinlock.h~spinlock-consolidation include/asm-arm/spinlock.h
--- devel/include/asm-arm/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-arm/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -16,21 +16,14 @@
  * Unlocked value: 0
  * Locked value: 1
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+#define __raw_spin_is_locked(x)		((x)->lock != 0)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
+
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -47,7 +40,7 @@ static inline void _raw_spin_lock(spinlo
 	smp_mb();
 }
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -67,7 +60,7 @@ static inline int _raw_spin_trylock(spin
 	}
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	smp_mb();
 
@@ -80,23 +73,14 @@ static inline void _raw_spin_unlock(spin
 
 /*
  * RWLOCKS
- */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED	(rwlock_t) { 0 }
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)
-#define rwlock_is_locked(x)	(*((volatile unsigned int *)(x)) != 0)
-
-/*
+ *
+ *
  * Write locks are easy - we just set bit 31.  When unlocking, we can
  * just write zero since the lock is exclusively held.
  */
-static inline void _raw_write_lock(rwlock_t *rw)
+#define rwlock_is_locked(x)	(*((volatile unsigned int *)(x)) != 0)
+
+static inline void __raw_write_lock(rwlock_t *rw)
 {
 	unsigned long tmp;
 
@@ -113,7 +97,7 @@ static inline void _raw_write_lock(rwloc
 	smp_mb();
 }
 
-static inline int _raw_write_trylock(rwlock_t *rw)
+static inline int __raw_write_trylock(rwlock_t *rw)
 {
 	unsigned long tmp;
 
@@ -133,7 +117,7 @@ static inline int _raw_write_trylock(rwl
 	}
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	smp_mb();
 
@@ -156,7 +140,7 @@ static inline void _raw_write_unlock(rwl
  * currently active.  However, we know we won't have any write
  * locks.
  */
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned long tmp, tmp2;
 
@@ -173,7 +157,7 @@ static inline void _raw_read_lock(rwlock
 	smp_mb();
 }
 
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(rwlock_t *rw)
 {
 	unsigned long tmp, tmp2;
 
@@ -190,6 +174,6 @@ static inline void _raw_read_unlock(rwlo
 	: "cc");
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 #endif /* __ASM_SPINLOCK_H */
diff -puN /dev/null include/asm-arm/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-arm/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-i386/spinlock.h~spinlock-consolidation include/asm-i386/spinlock.h
--- devel/include/asm-i386/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-i386/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -7,46 +7,21 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 
-asmlinkage int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int slock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-/*
+ *
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
+ *
+ * (the type definitions are in asm/spinlock_types.h)
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define __raw_spin_is_locked(x) \
+		(*(volatile signed char *)(&(x)->slock) <= 0)
 
-#define spin_lock_string \
+#define __raw_spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"jns 3f\n" \
@@ -57,7 +32,7 @@ typedef struct {
 	"jmp 1b\n" \
 	"3:\n\t"
 
-#define spin_lock_string_flags \
+#define __raw_spin_lock_string_flags \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"jns 4f\n\t" \
@@ -73,86 +48,71 @@ typedef struct {
 	"jmp 1b\n" \
 	"4:\n\t"
 
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
+{
+	__asm__ __volatile__(
+		__raw_spin_lock_string
+		:"=m" (lock->slock) : : "memory");
+}
+
+static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
+{
+	__asm__ __volatile__(
+		__raw_spin_lock_string_flags
+		:"=m" (lock->slock) : "r" (flags) : "memory");
+}
+
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+{
+	char oldval;
+	__asm__ __volatile__(
+		"xchgb %b0,%1"
+		:"=q" (oldval), "=m" (lock->slock)
+		:"0" (0) : "memory");
+	return oldval > 0;
+}
+
 /*
- * This works. Despite all the confusion.
- * (except on PPro SMP or if we are using OOSTORE)
+ * __raw_spin_unlock based on writing $1 to the low byte.
+ * This method works. Despite all the confusion.
+ * (except on PPro SMP or if we are using OOSTORE, so we use xchgb there)
  * (PPro errata 66, 92)
  */
 
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
 
-#define spin_unlock_string \
+#define __raw_spin_unlock_string \
 	"movb $1,%0" \
 		:"=m" (lock->slock) : : "memory"
 
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
-#endif
 	__asm__ __volatile__(
-		spin_unlock_string
+		__raw_spin_unlock_string
 	);
 }
 
 #else
 
-#define spin_unlock_string \
+#define __raw_spin_unlock_string \
 	"xchgb %b0, %1" \
 		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	char oldval = 1;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
-#endif
-	__asm__ __volatile__(
-		spin_unlock_string
-	);
-}
 
-#endif
-
-static inline int _raw_spin_trylock(spinlock_t *lock)
-{
-	char oldval;
 	__asm__ __volatile__(
-		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->slock)
-		:"0" (0) : "memory");
-	return oldval > 0;
+		__raw_spin_unlock_string
+	);
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
-{
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
 #endif
-	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->slock) : : "memory");
-}
 
-static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
-{
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
-	__asm__ __volatile__(
-		spin_lock_string_flags
-		:"=m" (lock->slock) : "r" (flags) : "memory");
-}
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -163,72 +123,41 @@ static inline void _raw_spin_lock_flags 
  * can "mix" irq-safe locks - any writer needs to get a
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
+ *
+ * On x86, we implement read-write locks as a 32-bit counter
+ * with the high bit (sign) being the "contended" bit.
+ *
+ * The inline assembly is non-obvious. Think about it.
+ *
+ * Changed to use the same technique as rw semaphores.  See
+ * semaphore.h for details.  -ben
+ *
+ * the helpers are in arch/i386/kernel/semaphore.c
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 /**
  * read_can_lock - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_can_lock(x) ((int)(x)->lock > 0)
+#define __raw_read_can_lock(x)		((int)(x)->lock > 0)
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+#define __raw_write_can_lock(x)		((x)->lock == RW_LOCK_BIAS)
 
-/*
- * On x86, we implement read-write locks as a 32-bit counter
- * with the high bit (sign) being the "contended" bit.
- *
- * The inline assembly is non-obvious. Think about it.
- *
- * Changed to use the same technique as rw semaphores.  See
- * semaphore.h for details.  -ben
- */
-/* the spinlock helpers are in arch/i386/kernel/semaphore.c */
-
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
-
-static inline int _raw_read_trylock(rwlock_t *lock)
+static inline int __raw_read_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
@@ -238,7 +167,7 @@ static inline int _raw_read_trylock(rwlo
 	return 0;
 }
 
-static inline int _raw_write_trylock(rwlock_t *lock)
+static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
@@ -247,4 +176,15 @@ static inline int _raw_write_trylock(rwl
 	return 0;
 }
 
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+}
+
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ", %0"
+				 : "=m" (rw->lock) : : "memory");
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -puN /dev/null include/asm-i386/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-i386/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
+
+#endif
diff -puN include/asm-ia64/spinlock.h~spinlock-consolidation include/asm-ia64/spinlock.h
--- devel/include/asm-ia64/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-ia64/spinlock.h	2005-09-09 12:12:38.000000000 -0700
@@ -17,28 +17,20 @@
 #include <asm/intrinsics.h>
 #include <asm/system.h>
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED			(spinlock_t) { 0 }
-#define spin_lock_init(x)			((x)->lock = 0)
+#define __raw_spin_lock_init(x)			((x)->lock = 0)
 
 #ifdef ASM_SUPPORTED
 /*
  * Try to get the lock.  If we fail to get the lock, make a non-standard call to
  * ia64_spinlock_contention().  We do not use a normal call because that would force all
- * callers of spin_lock() to be non-leaf routines.  Instead, ia64_spinlock_contention() is
- * carefully coded to touch only those registers that spin_lock() marks "clobbered".
+ * callers of __raw_spin_lock() to be non-leaf routines.  Instead, ia64_spinlock_contention() is
+ * carefully coded to touch only those registers that __raw_spin_lock() marks "clobbered".
  */
 
 #define IA64_SPINLOCK_CLOBBERS "ar.ccv", "ar.pfs", "p14", "p15", "r27", "r28", "r29", "r30", "b6", "memory"
 
 static inline void
-_raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
+__raw_spin_lock_flags (raw_spinlock_t *lock, unsigned long flags)
 {
 	register volatile unsigned int *ptr asm ("r31") = &lock->lock;
 
@@ -94,17 +86,17 @@ _raw_spin_lock_flags (spinlock_t *lock, 
 #endif
 }
 
-#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
+#define __raw_spin_lock(lock) __raw_spin_lock_flags(lock, 0)
 
 /* Unlock by doing an ordered store and releasing the cacheline with nta */
-static inline void _raw_spin_unlock(spinlock_t *x) {
+static inline void __raw_spin_unlock(raw_spinlock_t *x) {
 	barrier();
 	asm volatile ("st4.rel.nta [%0] = r0\n\t" :: "r"(x));
 }
 
 #else /* !ASM_SUPPORTED */
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
-# define _raw_spin_lock(x)								\
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+# define __raw_spin_lock(x)								\
 do {											\
 	__u32 *ia64_spinlock_ptr = (__u32 *) (x);					\
 	__u64 ia64_spinlock_val;							\
@@ -117,29 +109,20 @@ do {											\
 		} while (ia64_spinlock_val);						\
 	}										\
 } while (0)
-#define _raw_spin_unlock(x)	do { barrier(); ((spinlock_t *) x)->lock = 0; } while (0)
+#define __raw_spin_unlock(x)	do { barrier(); ((raw_spinlock_t *) x)->lock = 0; } while (0)
 #endif /* !ASM_SUPPORTED */
 
-#define spin_is_locked(x)	((x)->lock != 0)
-#define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
-#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
-
-typedef struct {
-	volatile unsigned int read_counter	: 24;
-	volatile unsigned int write_lock	:  8;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#define __raw_spin_is_locked(x)		((x)->lock != 0)
+#define __raw_spin_trylock(x)		(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-#define read_can_lock(rw)	(*(volatile int *)(rw) >= 0)
-#define write_can_lock(rw)	(*(volatile int *)(rw) == 0)
+#define __raw_read_can_lock(rw)		(*(volatile int *)(rw) >= 0)
+#define __raw_write_can_lock(rw)	(*(volatile int *)(rw) == 0)
 
-#define _raw_read_lock(rw)								\
+#define __raw_read_lock(rw)								\
 do {											\
-	rwlock_t *__read_lock_ptr = (rw);						\
+	raw_rwlock_t *__read_lock_ptr = (rw);						\
 											\
 	while (unlikely(ia64_fetchadd(1, (int *) __read_lock_ptr, acq) < 0)) {		\
 		ia64_fetchadd(-1, (int *) __read_lock_ptr, rel);			\
@@ -148,14 +131,14 @@ do {											\
 	}										\
 } while (0)
 
-#define _raw_read_unlock(rw)					\
+#define __raw_read_unlock(rw)					\
 do {								\
-	rwlock_t *__read_lock_ptr = (rw);			\
+	raw_rwlock_t *__read_lock_ptr = (rw);			\
 	ia64_fetchadd(-1, (int *) __read_lock_ptr, rel);	\
 } while (0)
 
 #ifdef ASM_SUPPORTED
-#define _raw_write_lock(rw)							\
+#define __raw_write_lock(rw)							\
 do {										\
  	__asm__ __volatile__ (							\
 		"mov ar.ccv = r0\n"						\
@@ -170,7 +153,7 @@ do {										\
 		:: "r"(rw) : "ar.ccv", "p7", "r2", "r29", "memory");		\
 } while(0)
 
-#define _raw_write_trylock(rw)							\
+#define __raw_write_trylock(rw)							\
 ({										\
 	register long result;							\
 										\
@@ -182,7 +165,7 @@ do {										\
 	(result == 0);								\
 })
 
-static inline void _raw_write_unlock(rwlock_t *x)
+static inline void __raw_write_unlock(raw_rwlock_t *x)
 {
 	u8 *y = (u8 *)x;
 	barrier();
@@ -191,7 +174,7 @@ static inline void _raw_write_unlock(rwl
 
 #else /* !ASM_SUPPORTED */
 
-#define _raw_write_lock(l)								\
+#define __raw_write_lock(l)								\
 ({											\
 	__u64 ia64_val, ia64_set_val = ia64_dep_mi(-1, 0, 31, 1);			\
 	__u32 *ia64_write_lock_ptr = (__u32 *) (l);					\
@@ -202,7 +185,7 @@ static inline void _raw_write_unlock(rwl
 	} while (ia64_val);								\
 })
 
-#define _raw_write_trylock(rw)						\
+#define __raw_write_trylock(rw)						\
 ({									\
 	__u64 ia64_val;							\
 	__u64 ia64_set_val = ia64_dep_mi(-1, 0, 31,1);			\
@@ -210,7 +193,7 @@ static inline void _raw_write_unlock(rwl
 	(ia64_val == 0);						\
 })
 
-static inline void _raw_write_unlock(rwlock_t *x)
+static inline void __raw_write_unlock(raw_rwlock_t *x)
 {
 	barrier();
 	x->write_lock = 0;
@@ -218,6 +201,6 @@ static inline void _raw_write_unlock(rwl
 
 #endif /* !ASM_SUPPORTED */
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 #endif /*  _ASM_IA64_SPINLOCK_H */
diff -puN /dev/null include/asm-ia64/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ia64/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,21 @@
+#ifndef _ASM_IA64_SPINLOCK_TYPES_H
+#define _ASM_IA64_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int read_counter	: 31;
+	volatile unsigned int write_lock	:  1;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0, 0 }
+
+#endif
diff -puN include/asm-m32r/spinlock.h~spinlock-consolidation include/asm-m32r/spinlock.h
--- devel/include/asm-m32r/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-m32r/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -14,57 +14,30 @@
 #include <asm/atomic.h>
 #include <asm/page.h>
 
-extern int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
-#define RW_LOCK_BIAS		 0x01000000
-#define RW_LOCK_BIAS_STR	"0x01000000"
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile int slock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-/*
+ *
+ * (the type definitions are in asm/spinlock_types.h)
+ *
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile int *)(&(x)->slock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_is_locked(x)		(*(volatile int *)(&(x)->slock) <= 0)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_unlock_wait(x) \
+		do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
 /**
- * _raw_spin_trylock - Try spin lock and return a result
+ * __raw_spin_trylock - Try spin lock and return a result
  * @lock: Pointer to the lock variable
  *
- * _raw_spin_trylock() tries to get the lock and returns a result.
+ * __raw_spin_trylock() tries to get the lock and returns a result.
  * On the m32r, the result value is 1 (= Success) or 0 (= Failure).
  */
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	int oldval;
 	unsigned long tmp1, tmp2;
@@ -78,7 +51,7 @@ static inline int _raw_spin_trylock(spin
 	 * }
 	 */
 	__asm__ __volatile__ (
-		"# spin_trylock			\n\t"
+		"# __raw_spin_trylock		\n\t"
 		"ldi	%1, #0;			\n\t"
 		"mvfc	%2, psw;		\n\t"
 		"clrpsw	#0x40 -> nop;		\n\t"
@@ -97,16 +70,10 @@ static inline int _raw_spin_trylock(spin
 	return (oldval > 0);
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp0, tmp1;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
-		printk("pc: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
 	/*
 	 * lock->slock :  =1 : unlock
 	 *             : <=0 : lock
@@ -118,7 +85,7 @@ static inline void _raw_spin_lock(spinlo
 	 * }
 	 */
 	__asm__ __volatile__ (
-		"# spin_lock			\n\t"
+		"# __raw_spin_lock		\n\t"
 		".fillinsn			\n"
 		"1:				\n\t"
 		"mvfc	%1, psw;		\n\t"
@@ -145,12 +112,8 @@ static inline void _raw_spin_lock(spinlo
 	);
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
-#endif
 	mb();
 	lock->slock = 1;
 }
@@ -164,59 +127,32 @@ static inline void _raw_spin_unlock(spin
  * can "mix" irq-safe locks - any writer needs to get a
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
+ *
+ * On x86, we implement read-write locks as a 32-bit counter
+ * with the high bit (sign) being the "contended" bit.
+ *
+ * The inline assembly is non-obvious. Think about it.
+ *
+ * Changed to use the same technique as rw semaphores.  See
+ * semaphore.h for details.  -ben
  */
-typedef struct {
-	volatile int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 /**
  * read_can_lock - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_can_lock(x) ((int)(x)->lock > 0)
+#define __raw_read_can_lock(x) ((int)(x)->lock > 0)
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
-
-/*
- * On x86, we implement read-write locks as a 32-bit counter
- * with the high bit (sign) being the "contended" bit.
- *
- * The inline assembly is non-obvious. Think about it.
- *
- * Changed to use the same technique as rw semaphores.  See
- * semaphore.h for details.  -ben
- */
-/* the spinlock helpers are in arch/i386/kernel/semaphore.c */
+#define __raw_write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned long tmp0, tmp1;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	/*
 	 * rw->lock :  >0 : unlock
 	 *          : <=0 : lock
@@ -264,13 +200,10 @@ static inline void _raw_read_lock(rwlock
 	);
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned long tmp0, tmp1, tmp2;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	/*
 	 * rw->lock :  =RW_LOCK_BIAS_STR : unlock
 	 *          : !=RW_LOCK_BIAS_STR : lock
@@ -320,7 +253,7 @@ static inline void _raw_write_lock(rwloc
 	);
 }
 
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned long tmp0, tmp1;
 
@@ -342,7 +275,7 @@ static inline void _raw_read_unlock(rwlo
 	);
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	unsigned long tmp0, tmp1, tmp2;
 
@@ -366,9 +299,9 @@ static inline void _raw_write_unlock(rwl
 	);
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
-static inline int _raw_write_trylock(rwlock_t *lock)
+static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
diff -puN /dev/null include/asm-m32r/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-m32r/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,23 @@
+#ifndef _ASM_M32R_SPINLOCK_TYPES_H
+#define _ASM_M32R_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+
+typedef struct {
+	volatile int lock;
+} raw_rwlock_t;
+
+#define RW_LOCK_BIAS			0x01000000
+#define RW_LOCK_BIAS_STR		"0x01000000"
+
+#define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
+
+#endif
diff -puN include/asm-mips/spinlock.h~spinlock-consolidation include/asm-mips/spinlock.h
--- devel/include/asm-mips/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-mips/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -16,20 +16,10 @@
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
-
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_is_locked(x)	((x)->lock != 0)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_unlock_wait(x) \
+		do { cpu_relax(); } while ((x)->lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -38,13 +28,13 @@ typedef struct {
  * We make no fairness assumptions.  They have a cost.
  */
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned int tmp;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_spin_lock	\n"
+		"	.set	noreorder	# __raw_spin_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bnez	%1, 1b					\n"
 		"	 li	%1, 1					\n"
@@ -58,7 +48,7 @@ static inline void _raw_spin_lock(spinlo
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_spin_lock	\n"
+		"	.set	noreorder	# __raw_spin_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bnez	%1, 1b					\n"
 		"	 li	%1, 1					\n"
@@ -72,10 +62,10 @@ static inline void _raw_spin_lock(spinlo
 	}
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(
-	"	.set	noreorder	# _raw_spin_unlock	\n"
+	"	.set	noreorder	# __raw_spin_unlock	\n"
 	"	sync						\n"
 	"	sw	$0, %0					\n"
 	"	.set\treorder					\n"
@@ -84,13 +74,13 @@ static inline void _raw_spin_unlock(spin
 	: "memory");
 }
 
-static inline unsigned int _raw_spin_trylock(spinlock_t *lock)
+static inline unsigned int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned int temp, res;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_spin_trylock	\n"
+		"	.set	noreorder	# __raw_spin_trylock	\n"
 		"1:	ll	%0, %3					\n"
 		"	ori	%2, %0, 1				\n"
 		"	sc	%2, %1					\n"
@@ -104,7 +94,7 @@ static inline unsigned int _raw_spin_try
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_spin_trylock	\n"
+		"	.set	noreorder	# __raw_spin_trylock	\n"
 		"1:	ll	%0, %3					\n"
 		"	ori	%2, %0, 1				\n"
 		"	sc	%2, %1					\n"
@@ -129,24 +119,13 @@ static inline unsigned int _raw_spin_try
  * read-locks.
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-
-#define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_read_lock	\n"
+		"	.set	noreorder	# __raw_read_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bltz	%1, 1b					\n"
 		"	 addu	%1, 1					\n"
@@ -160,7 +139,7 @@ static inline void _raw_read_lock(rwlock
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_read_lock	\n"
+		"	.set	noreorder	# __raw_read_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bltz	%1, 1b					\n"
 		"	 addu	%1, 1					\n"
@@ -177,13 +156,13 @@ static inline void _raw_read_lock(rwlock
 /* Note the use of sub, not subu which will make the kernel die with an
    overflow exception if we ever try to unlock an rwlock that is already
    unlocked or is being held by a writer.  */
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# _raw_read_unlock	\n"
+		"1:	ll	%1, %2		# __raw_read_unlock	\n"
 		"	sub	%1, 1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
@@ -193,7 +172,7 @@ static inline void _raw_read_unlock(rwlo
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_read_unlock	\n"
+		"	.set	noreorder	# __raw_read_unlock	\n"
 		"1:	ll	%1, %2					\n"
 		"	sub	%1, 1					\n"
 		"	sc	%1, %0					\n"
@@ -206,13 +185,13 @@ static inline void _raw_read_unlock(rwlo
 	}
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_write_lock	\n"
+		"	.set	noreorder	# __raw_write_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bnez	%1, 1b					\n"
 		"	 lui	%1, 0x8000				\n"
@@ -226,7 +205,7 @@ static inline void _raw_write_lock(rwloc
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_write_lock	\n"
+		"	.set	noreorder	# __raw_write_lock	\n"
 		"1:	ll	%1, %2					\n"
 		"	bnez	%1, 1b					\n"
 		"	 lui	%1, 0x8000				\n"
@@ -241,26 +220,26 @@ static inline void _raw_write_lock(rwloc
 	}
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__(
-	"	sync			# _raw_write_unlock	\n"
+	"	sync			# __raw_write_unlock	\n"
 	"	sw	$0, %0					\n"
 	: "=m" (rw->lock)
 	: "m" (rw->lock)
 	: "memory");
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
-static inline int _raw_write_trylock(rwlock_t *rw)
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 	int ret;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_write_trylock	\n"
+		"	.set	noreorder	# __raw_write_trylock	\n"
 		"	li	%2, 0					\n"
 		"1:	ll	%1, %3					\n"
 		"	bnez	%1, 2f					\n"
@@ -277,7 +256,7 @@ static inline int _raw_write_trylock(rwl
 		: "memory");
 	} else {
 		__asm__ __volatile__(
-		"	.set	noreorder	# _raw_write_trylock	\n"
+		"	.set	noreorder	# __raw_write_trylock	\n"
 		"	li	%2, 0					\n"
 		"1:	ll	%1, %3					\n"
 		"	bnez	%1, 2f					\n"
diff -puN /dev/null include/asm-mips/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-mips/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef _ASM_SPINLOCK_TYPES_H
+#define _ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-parisc/atomic.h~spinlock-consolidation include/asm-parisc/atomic.h
--- devel/include/asm-parisc/atomic.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/atomic.h	2005-09-09 12:12:31.000000000 -0700
@@ -24,19 +24,19 @@
 #  define ATOMIC_HASH_SIZE 4
 #  define ATOMIC_HASH(a) (&(__atomic_hash[ (((unsigned long) a)/L1_CACHE_BYTES) & (ATOMIC_HASH_SIZE-1) ]))
 
-extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
+extern raw_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
 
-/* Can't use _raw_spin_lock_irq because of #include problems, so
+/* Can't use raw_spin_lock_irq because of #include problems, so
  * this is the substitute */
 #define _atomic_spin_lock_irqsave(l,f) do {	\
-	spinlock_t *s = ATOMIC_HASH(l);		\
+	raw_spinlock_t *s = ATOMIC_HASH(l);		\
 	local_irq_save(f);			\
-	_raw_spin_lock(s);			\
+	__raw_spin_lock(s);			\
 } while(0)
 
 #define _atomic_spin_unlock_irqrestore(l,f) do {	\
-	spinlock_t *s = ATOMIC_HASH(l);			\
-	_raw_spin_unlock(s);				\
+	raw_spinlock_t *s = ATOMIC_HASH(l);			\
+	__raw_spin_unlock(s);				\
 	local_irq_restore(f);				\
 } while(0)
 
diff -puN include/asm-parisc/bitops.h~spinlock-consolidation include/asm-parisc/bitops.h
--- devel/include/asm-parisc/bitops.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/bitops.h	2005-09-09 12:12:31.000000000 -0700
@@ -2,7 +2,7 @@
 #define _PARISC_BITOPS_H
 
 #include <linux/compiler.h>
-#include <asm/system.h>
+#include <asm/spinlock.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
 
diff -puN include/asm-parisc/cacheflush.h~spinlock-consolidation include/asm-parisc/cacheflush.h
--- devel/include/asm-parisc/cacheflush.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/cacheflush.h	2005-09-09 12:12:31.000000000 -0700
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <asm/cache.h>	/* for flush_user_dcache_range_asm() proto */
 
 /* The usual comment is "Caches aren't brain-dead on the <architecture>".
  * Unfortunately, that doesn't apply to PA-RISC. */
diff -puN include/asm-parisc/processor.h~spinlock-consolidation include/asm-parisc/processor.h
--- devel/include/asm-parisc/processor.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/processor.h	2005-09-09 12:12:31.000000000 -0700
@@ -11,6 +11,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/spinlock_types.h>
 
 #include <asm/hardware.h>
 #include <asm/page.h>
diff -puN include/asm-parisc/spinlock.h~spinlock-consolidation include/asm-parisc/spinlock.h
--- devel/include/asm-parisc/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -2,30 +2,25 @@
 #define __ASM_SPINLOCK_H
 
 #include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/spinlock_types.h>
 
 /* Note that PA-RISC has to use `1' to mean unlocked and `0' to mean locked
  * since it only has load-and-zero. Moreover, at least on some PA processors,
  * the semaphore address has to be 16-byte aligned.
  */
 
-#ifndef CONFIG_DEBUG_SPINLOCK
-
-#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
-#undef SPIN_LOCK_UNLOCKED
-#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-static inline int spin_is_locked(spinlock_t *x)
+static inline int __raw_spin_is_locked(raw_spinlock_t *x)
 {
 	volatile unsigned int *a = __ldcw_align(x);
 	return *a == 0;
 }
 
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_unlock_wait(x) \
+		do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
-static inline void _raw_spin_lock(spinlock_t *x)
+static inline void __raw_spin_lock(raw_spinlock_t *x)
 {
 	volatile unsigned int *a;
 
@@ -36,7 +31,7 @@ static inline void _raw_spin_lock(spinlo
 	mb();
 }
 
-static inline void _raw_spin_unlock(spinlock_t *x)
+static inline void __raw_spin_unlock(raw_spinlock_t *x)
 {
 	volatile unsigned int *a;
 	mb();
@@ -45,7 +40,7 @@ static inline void _raw_spin_unlock(spin
 	mb();
 }
 
-static inline int _raw_spin_trylock(spinlock_t *x)
+static inline int __raw_spin_trylock(raw_spinlock_t *x)
 {
 	volatile unsigned int *a;
 	int ret;
@@ -57,131 +52,38 @@ static inline int _raw_spin_trylock(spin
 
 	return ret;
 }
-	
-#define spin_lock_own(LOCK, LOCATION)	((void)0)
-
-#else /* !(CONFIG_DEBUG_SPINLOCK) */
-
-#define SPINLOCK_MAGIC	0x1D244B3C
-
-#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 }, SPINLOCK_MAGIC, 10, __FILE__ , NULL, 0, -1, NULL, NULL }
-#undef SPIN_LOCK_UNLOCKED
-#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-#define CHECK_LOCK(x)							\
-	do {								\
-	 	if (unlikely((x)->magic != SPINLOCK_MAGIC)) {			\
-			printk(KERN_ERR "%s:%d: spin_is_locked"		\
-			" on uninitialized spinlock %p.\n",		\
-				__FILE__, __LINE__, (x)); 		\
-		} 							\
-	} while(0)
-
-#define spin_is_locked(x)						\
-	({								\
-	 	CHECK_LOCK(x);						\
-		volatile unsigned int *a = __ldcw_align(x);		\
-		if (unlikely((*a == 0) && (x)->babble)) {				\
-			(x)->babble--;					\
-			printk("KERN_WARNING				\
-				%s:%d: spin_is_locked(%s/%p) already"	\
-				" locked by %s:%d in %s at %p(%d)\n",	\
-				__FILE__,__LINE__, (x)->module,	(x),	\
-				(x)->bfile, (x)->bline, (x)->task->comm,\
-				(x)->previous, (x)->oncpu);		\
-		}							\
-		*a == 0;						\
-	})
-
-#define spin_unlock_wait(x)						\
-	do {								\
-	 	CHECK_LOCK(x);						\
-		volatile unsigned int *a = __ldcw_align(x);		\
-		if (unlikely((*a == 0) && (x)->babble)) {				\
-			(x)->babble--;					\
-			printk("KERN_WARNING				\
-				%s:%d: spin_unlock_wait(%s/%p)"		\
-				" owned by %s:%d in %s at %p(%d)\n",	\
-				__FILE__,__LINE__, (x)->module, (x),	\
-				(x)->bfile, (x)->bline, (x)->task->comm,\
-				(x)->previous, (x)->oncpu);		\
-		}							\
-		barrier();						\
-	} while (*((volatile unsigned char *)(__ldcw_align(x))) == 0)
-
-extern void _dbg_spin_lock(spinlock_t *lock, const char *base_file, int line_no);
-extern void _dbg_spin_unlock(spinlock_t *lock, const char *, int);
-extern int _dbg_spin_trylock(spinlock_t * lock, const char *, int);
-
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
-
-#define _raw_spin_unlock(lock)	_dbg_spin_unlock(lock, __FILE__, __LINE__)
-#define _raw_spin_lock(lock) _dbg_spin_lock(lock, __FILE__, __LINE__)
-#define _raw_spin_trylock(lock) _dbg_spin_trylock(lock, __FILE__, __LINE__)
-
-/* just in case we need it */
-#define spin_lock_own(LOCK, LOCATION)					\
-do {									\
-	volatile unsigned int *a = __ldcw_align(LOCK);			\
-	if (!((*a == 0) && ((LOCK)->oncpu == smp_processor_id())))	\
-		printk("KERN_WARNING					\
-			%s: called on %d from %p but lock %s on %d\n",	\
-			LOCATION, smp_processor_id(),			\
-			__builtin_return_address(0),			\
-			(*a == 0) ? "taken" : "freed", (LOCK)->on_cpu);	\
-} while (0)
-
-#endif /* !(CONFIG_DEBUG_SPINLOCK) */
 
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
  */
-typedef struct {
-	spinlock_t lock;
-	volatile int counter;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { __SPIN_LOCK_UNLOCKED, 0 }
-
-#define rwlock_init(lp)	do { *(lp) = RW_LOCK_UNLOCKED; } while (0)
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 /* read_lock, read_unlock are pretty straightforward.  Of course it somehow
  * sucks we end up saving/restoring flags twice for read_lock_irqsave aso. */
 
-#ifdef CONFIG_DEBUG_RWLOCK
-extern void _dbg_read_lock(rwlock_t * rw, const char *bfile, int bline);
-#define _raw_read_lock(rw) _dbg_read_lock(rw, __FILE__, __LINE__)
-#else
-static  __inline__ void _raw_read_lock(rwlock_t *rw)
+static  __inline__ void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned long flags;
 	local_irq_save(flags);
-	_raw_spin_lock(&rw->lock); 
+	__raw_spin_lock(&rw->lock);
 
 	rw->counter++;
 
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 	local_irq_restore(flags);
 }
-#endif	/* CONFIG_DEBUG_RWLOCK */
 
-static  __inline__ void _raw_read_unlock(rwlock_t *rw)
+static  __inline__ void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned long flags;
 	local_irq_save(flags);
-	_raw_spin_lock(&rw->lock); 
+	__raw_spin_lock(&rw->lock);
 
 	rw->counter--;
 
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 	local_irq_restore(flags);
 }
 
@@ -194,20 +96,17 @@ static  __inline__ void _raw_read_unlock
  * writers) in interrupt handlers someone fucked up and we'd dead-lock
  * sooner or later anyway.   prumpf */
 
-#ifdef CONFIG_DEBUG_RWLOCK
-extern void _dbg_write_lock(rwlock_t * rw, const char *bfile, int bline);
-#define _raw_write_lock(rw) _dbg_write_lock(rw, __FILE__, __LINE__)
-#else
-static  __inline__ void _raw_write_lock(rwlock_t *rw)
+static  __inline__ void __raw_write_lock(raw_rwlock_t *rw)
 {
 retry:
-	_raw_spin_lock(&rw->lock);
+	__raw_spin_lock(&rw->lock);
 
 	if(rw->counter != 0) {
 		/* this basically never happens */
-		_raw_spin_unlock(&rw->lock);
+		__raw_spin_unlock(&rw->lock);
 
-		while(rw->counter != 0);
+		while (rw->counter != 0)
+			cpu_relax();
 
 		goto retry;
 	}
@@ -215,26 +114,21 @@ retry:
 	/* got it.  now leave without unlocking */
 	rw->counter = -1; /* remember we are locked */
 }
-#endif /* CONFIG_DEBUG_RWLOCK */
 
 /* write_unlock is absolutely trivial - we don't have to wait for anything */
 
-static  __inline__ void _raw_write_unlock(rwlock_t *rw)
+static  __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	rw->counter = 0;
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 }
 
-#ifdef CONFIG_DEBUG_RWLOCK
-extern int _dbg_write_trylock(rwlock_t * rw, const char *bfile, int bline);
-#define _raw_write_trylock(rw) _dbg_write_trylock(rw, __FILE__, __LINE__)
-#else
-static  __inline__ int _raw_write_trylock(rwlock_t *rw)
+static  __inline__ int __raw_write_trylock(raw_rwlock_t *rw)
 {
-	_raw_spin_lock(&rw->lock);
+	__raw_spin_lock(&rw->lock);
 	if (rw->counter != 0) {
 		/* this basically never happens */
-		_raw_spin_unlock(&rw->lock);
+		__raw_spin_unlock(&rw->lock);
 
 		return 0;
 	}
@@ -243,14 +137,13 @@ static  __inline__ int _raw_write_tryloc
 	rw->counter = -1; /* remember we are locked */
 	return 1;
 }
-#endif /* CONFIG_DEBUG_RWLOCK */
 
-static __inline__ int is_read_locked(rwlock_t *rw)
+static __inline__ int __raw_is_read_locked(raw_rwlock_t *rw)
 {
 	return rw->counter > 0;
 }
 
-static __inline__ int is_write_locked(rwlock_t *rw)
+static __inline__ int __raw_is_write_locked(raw_rwlock_t *rw)
 {
 	return rw->counter < 0;
 }
diff -puN /dev/null include/asm-parisc/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-parisc/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,21 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock[4];
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
+
+typedef struct {
+	raw_spinlock_t lock;
+	volatile int counter;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ __RAW_SPIN_LOCK_UNLOCKED, 0 }
+
+#endif
diff -puN include/asm-parisc/system.h~spinlock-consolidation include/asm-parisc/system.h
--- devel/include/asm-parisc/system.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-parisc/system.h	2005-09-09 12:12:31.000000000 -0700
@@ -160,29 +160,7 @@ static inline void set_eiem(unsigned lon
 })
 
 #ifdef CONFIG_SMP
-/*
- * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int lock[4];
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned long magic;
-	volatile unsigned int babble;
-	const char *module;
-	char *bfile;
-	int bline;
-	int oncpu;
-	void *previous;
-	struct task_struct * task;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define __lock_aligned __attribute__((__section__(".data.lock_aligned")))
-
+# define __lock_aligned __attribute__((__section__(".data.lock_aligned")))
 #endif
 
 #define KERNEL_START (0x10100000 - 0x1000)
diff -puN include/asm-ppc64/spinlock.h~spinlock-consolidation include/asm-ppc64/spinlock.h
--- devel/include/asm-ppc64/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-ppc64/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -15,36 +15,42 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
+ *
+ * (the type definitions are in asm/spinlock_types.h)
  */
 #include <linux/config.h>
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #include <asm/iSeries/HvCall.h>
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
+#define __raw_spin_is_locked(x)		((x)->slock != 0)
 
-typedef struct {
-	volatile signed int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
+/*
+ * This returns the old value in the lock, so we succeeded
+ * in getting the lock if the return value is 0.
+ */
+static __inline__ unsigned long __spin_trylock(raw_spinlock_t *lock)
+{
+	unsigned long tmp, tmp2;
 
-#ifdef __KERNEL__
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+	__asm__ __volatile__(
+"	lwz		%1,%3(13)		# __spin_trylock\n\
+1:	lwarx		%0,0,%2\n\
+	cmpwi		0,%0,0\n\
+	bne-		2f\n\
+	stwcx.		%1,0,%2\n\
+	bne-		1b\n\
+	isync\n\
+2:"	: "=&r" (tmp), "=&r" (tmp2)
+	: "r" (&lock->slock), "i" (offsetof(struct paca_struct, lock_token))
+	: "cr0", "memory");
 
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+	return tmp;
+}
 
-static __inline__ void _raw_spin_unlock(spinlock_t *lock)
+static int __inline__ __raw_spin_trylock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__("lwsync	# spin_unlock": : :"memory");
-	lock->lock = 0;
+	return __spin_trylock(lock) == 0;
 }
 
 /*
@@ -64,44 +70,15 @@ static __inline__ void _raw_spin_unlock(
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (get_paca()->lppaca.shared_proc)
-extern void __spin_yield(spinlock_t *lock);
-extern void __rw_yield(rwlock_t *lock);
+extern void __spin_yield(raw_spinlock_t *lock);
+extern void __rw_yield(raw_rwlock_t *lock);
 #else /* SPLPAR || ISERIES */
 #define __spin_yield(x)	barrier()
 #define __rw_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
-extern void spin_unlock_wait(spinlock_t *lock);
-
-/*
- * This returns the old value in the lock, so we succeeded
- * in getting the lock if the return value is 0.
- */
-static __inline__ unsigned long __spin_trylock(spinlock_t *lock)
-{
-	unsigned long tmp, tmp2;
-
-	__asm__ __volatile__(
-"	lwz		%1,%3(13)		# __spin_trylock\n\
-1:	lwarx		%0,0,%2\n\
-	cmpwi		0,%0,0\n\
-	bne-		2f\n\
-	stwcx.		%1,0,%2\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp), "=&r" (tmp2)
-	: "r" (&lock->lock), "i" (offsetof(struct paca_struct, lock_token))
-	: "cr0", "memory");
-
-	return tmp;
-}
-
-static int __inline__ _raw_spin_trylock(spinlock_t *lock)
-{
-	return __spin_trylock(lock) == 0;
-}
 
-static void __inline__ _raw_spin_lock(spinlock_t *lock)
+static void __inline__ __raw_spin_lock(raw_spinlock_t *lock)
 {
 	while (1) {
 		if (likely(__spin_trylock(lock) == 0))
@@ -110,12 +87,12 @@ static void __inline__ _raw_spin_lock(sp
 			HMT_low();
 			if (SHARED_PROCESSOR)
 				__spin_yield(lock);
-		} while (unlikely(lock->lock != 0));
+		} while (unlikely(lock->slock != 0));
 		HMT_medium();
 	}
 }
 
-static void __inline__ _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
+static void __inline__ __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
 	unsigned long flags_dis;
 
@@ -128,12 +105,20 @@ static void __inline__ _raw_spin_lock_fl
 			HMT_low();
 			if (SHARED_PROCESSOR)
 				__spin_yield(lock);
-		} while (unlikely(lock->lock != 0));
+		} while (unlikely(lock->slock != 0));
 		HMT_medium();
 		local_irq_restore(flags_dis);
 	}
 }
 
+static __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
+{
+	__asm__ __volatile__("lwsync	# __raw_spin_unlock": : :"memory");
+	lock->slock = 0;
+}
+
+extern void __raw_spin_unlock_wait(raw_spinlock_t *lock);
+
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -144,24 +129,15 @@ static void __inline__ _raw_spin_lock_fl
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-#define read_can_lock(rw)	((rw)->lock >= 0)
-#define write_can_lock(rw)	(!(rw)->lock)
-
-static __inline__ void _raw_write_unlock(rwlock_t *rw)
-{
-	__asm__ __volatile__("lwsync		# write_unlock": : :"memory");
-	rw->lock = 0;
-}
+#define __raw_read_can_lock(rw)		((rw)->lock >= 0)
+#define __raw_write_can_lock(rw)	(!(rw)->lock)
 
 /*
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
  */
-static long __inline__ __read_trylock(rwlock_t *rw)
+static long __inline__ __read_trylock(raw_rwlock_t *rw)
 {
 	long tmp;
 
@@ -180,45 +156,11 @@ static long __inline__ __read_trylock(rw
 	return tmp;
 }
 
-static int __inline__ _raw_read_trylock(rwlock_t *rw)
-{
-	return __read_trylock(rw) > 0;
-}
-
-static void __inline__ _raw_read_lock(rwlock_t *rw)
-{
-	while (1) {
-		if (likely(__read_trylock(rw) > 0))
-			break;
-		do {
-			HMT_low();
-			if (SHARED_PROCESSOR)
-				__rw_yield(rw);
-		} while (unlikely(rw->lock < 0));
-		HMT_medium();
-	}
-}
-
-static void __inline__ _raw_read_unlock(rwlock_t *rw)
-{
-	long tmp;
-
-	__asm__ __volatile__(
-	"eieio				# read_unlock\n\
-1:	lwarx		%0,0,%1\n\
-	addic		%0,%0,-1\n\
-	stwcx.		%0,0,%1\n\
-	bne-		1b"
-	: "=&r"(tmp)
-	: "r"(&rw->lock)
-	: "cr0", "memory");
-}
-
 /*
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
  */
-static __inline__ long __write_trylock(rwlock_t *rw)
+static __inline__ long __write_trylock(raw_rwlock_t *rw)
 {
 	long tmp, tmp2;
 
@@ -237,12 +179,21 @@ static __inline__ long __write_trylock(r
 	return tmp;
 }
 
-static int __inline__ _raw_write_trylock(rwlock_t *rw)
+static void __inline__ __raw_read_lock(raw_rwlock_t *rw)
 {
-	return __write_trylock(rw) == 0;
+	while (1) {
+		if (likely(__read_trylock(rw) > 0))
+			break;
+		do {
+			HMT_low();
+			if (SHARED_PROCESSOR)
+				__rw_yield(rw);
+		} while (unlikely(rw->lock < 0));
+		HMT_medium();
+	}
 }
 
-static void __inline__ _raw_write_lock(rwlock_t *rw)
+static void __inline__ __raw_write_lock(raw_rwlock_t *rw)
 {
 	while (1) {
 		if (likely(__write_trylock(rw) == 0))
@@ -256,5 +207,35 @@ static void __inline__ _raw_write_lock(r
 	}
 }
 
-#endif /* __KERNEL__ */
+static int __inline__ __raw_read_trylock(raw_rwlock_t *rw)
+{
+	return __read_trylock(rw) > 0;
+}
+
+static int __inline__ __raw_write_trylock(raw_rwlock_t *rw)
+{
+	return __write_trylock(rw) == 0;
+}
+
+static void __inline__ __raw_read_unlock(raw_rwlock_t *rw)
+{
+	long tmp;
+
+	__asm__ __volatile__(
+	"eieio				# read_unlock\n\
+1:	lwarx		%0,0,%1\n\
+	addic		%0,%0,-1\n\
+	stwcx.		%0,0,%1\n\
+	bne-		1b"
+	: "=&r"(tmp)
+	: "r"(&rw->lock)
+	: "cr0", "memory");
+}
+
+static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
+{
+	__asm__ __volatile__("lwsync	# write_unlock": : :"memory");
+	rw->lock = 0;
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -puN /dev/null include/asm-ppc64/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ppc64/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile signed int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-ppc/spinlock.h~spinlock-consolidation include/asm-ppc/spinlock.h
--- devel/include/asm-ppc/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-ppc/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -5,41 +5,21 @@
 
 /*
  * Simple spin lock operations.
+ *
+ * (the type definitions are in asm/raw_spinlock_types.h)
  */
 
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-	volatile unsigned long owner_cpu;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#ifdef __KERNEL__
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_DEBUG_INIT     , 0, 0
-#else
-#define SPINLOCK_DEBUG_INIT     /* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
-
-#define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
-
-#ifndef CONFIG_DEBUG_SPINLOCK
+#define __raw_spin_is_locked(x)		((x)->lock != 0)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
 	__asm__ __volatile__(
-	"b	1f		# spin_lock\n\
+	"b	1f		# __raw_spin_lock\n\
 2:	lwzx	%0,0,%1\n\
 	cmpwi	0,%0,0\n\
 	bne+	2b\n\
@@ -55,21 +35,13 @@ static inline void _raw_spin_lock(spinlo
 	: "cr0", "memory");
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__("eieio		# spin_unlock": : :"memory");
+	__asm__ __volatile__("eieio	# __raw_spin_unlock": : :"memory");
 	lock->lock = 0;
 }
 
-#define _raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
-
-#else
-
-extern void _raw_spin_lock(spinlock_t *lock);
-extern void _raw_spin_unlock(spinlock_t *lock);
-extern int _raw_spin_trylock(spinlock_t *lock);
-
-#endif
+#define __raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -81,22 +53,11 @@ extern int _raw_spin_trylock(spinlock_t 
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile signed int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 
-#define read_can_lock(rw)	((rw)->lock >= 0)
-#define write_can_lock(rw)	(!(rw)->lock)
+#define __raw_read_can_lock(rw)	((rw)->lock >= 0)
+#define __raw_write_can_lock(rw)	(!(rw)->lock)
 
-#ifndef CONFIG_DEBUG_SPINLOCK
-
-static __inline__ int _raw_read_trylock(rwlock_t *rw)
+static __inline__ int __raw_read_trylock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -116,7 +77,7 @@ static __inline__ int _raw_read_trylock(
 	return tmp > 0;
 }
 
-static __inline__ void _raw_read_lock(rwlock_t *rw)
+static __inline__ void __raw_read_lock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -137,7 +98,7 @@ static __inline__ void _raw_read_lock(rw
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_read_unlock(rwlock_t *rw)
+static __inline__ void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -153,7 +114,7 @@ static __inline__ void _raw_read_unlock(
 	: "cr0", "memory");
 }
 
-static __inline__ int _raw_write_trylock(rwlock_t *rw)
+static __inline__ int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -173,7 +134,7 @@ static __inline__ int _raw_write_trylock
 	return tmp == 0;
 }
 
-static __inline__ void _raw_write_lock(rwlock_t *rw)
+static __inline__ void __raw_write_lock(raw_rwlock_t *rw)
 {
 	signed int tmp;
 
@@ -194,22 +155,10 @@ static __inline__ void _raw_write_lock(r
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_write_unlock(rwlock_t *rw)
+static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
 	rw->lock = 0;
 }
 
-#else
-
-extern void _raw_read_lock(rwlock_t *rw);
-extern void _raw_read_unlock(rwlock_t *rw);
-extern void _raw_write_lock(rwlock_t *rw);
-extern void _raw_write_unlock(rwlock_t *rw);
-extern int _raw_read_trylock(rwlock_t *rw);
-extern int _raw_write_trylock(rwlock_t *rw);
-
-#endif
-
 #endif /* __ASM_SPINLOCK_H */
-#endif /* __KERNEL__ */
diff -puN /dev/null include/asm-ppc/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-ppc/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned long lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile signed int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-s390/spinlock.h~spinlock-consolidation include/asm-s390/spinlock.h
--- devel/include/asm-s390/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-s390/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -27,25 +27,19 @@ _raw_compare_and_swap(volatile unsigned 
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
+ *
+ * (the type definitions are in asm/spinlock_types.h)
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} __attribute__ ((aligned (4))) spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-#define spin_lock_init(lp)	do { (lp)->lock = 0; } while(0)
-#define spin_unlock_wait(lp)	do { barrier(); } while(((volatile spinlock_t *)(lp))->lock)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_is_locked(x) ((x)->lock != 0)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-extern void _raw_spin_lock_wait(spinlock_t *lp, unsigned int pc);
-extern int _raw_spin_trylock_retry(spinlock_t *lp, unsigned int pc);
+extern void _raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc);
+extern int _raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc);
 
-static inline void _raw_spin_lock(spinlock_t *lp)
+static inline void __raw_spin_lock(raw_spinlock_t *lp)
 {
 	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 
@@ -53,7 +47,7 @@ static inline void _raw_spin_lock(spinlo
 		_raw_spin_lock_wait(lp, pc);
 }
 
-static inline int _raw_spin_trylock(spinlock_t *lp)
+static inline int __raw_spin_trylock(raw_spinlock_t *lp)
 {
 	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 
@@ -62,7 +56,7 @@ static inline int _raw_spin_trylock(spin
 	return _raw_spin_trylock_retry(lp, pc);
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lp)
+static inline void __raw_spin_unlock(raw_spinlock_t *lp)
 {
 	_raw_compare_and_swap(&lp->lock, lp->lock, 0);
 }
@@ -77,36 +71,25 @@ static inline void _raw_spin_unlock(spin
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned int lock;
-	volatile unsigned long owner_pc;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
 /**
  * read_can_lock - would read_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define read_can_lock(x) ((int)(x)->lock >= 0)
+#define __raw_read_can_lock(x) ((int)(x)->lock >= 0)
 
 /**
  * write_can_lock - would write_trylock() succeed?
  * @lock: the rwlock in question.
  */
-#define write_can_lock(x) ((x)->lock == 0)
+#define __raw_write_can_lock(x) ((x)->lock == 0)
 
-extern void _raw_read_lock_wait(rwlock_t *lp);
-extern int _raw_read_trylock_retry(rwlock_t *lp);
-extern void _raw_write_lock_wait(rwlock_t *lp);
-extern int _raw_write_trylock_retry(rwlock_t *lp);
+extern void _raw_read_lock_wait(raw_rwlock_t *lp);
+extern int _raw_read_trylock_retry(raw_rwlock_t *lp);
+extern void _raw_write_lock_wait(raw_rwlock_t *lp);
+extern int _raw_write_trylock_retry(raw_rwlock_t *lp);
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	old = rw->lock & 0x7fffffffU;
@@ -114,7 +97,7 @@ static inline void _raw_read_lock(rwlock
 		_raw_read_lock_wait(rw);
 }
 
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned int old, cmp;
 
@@ -125,18 +108,18 @@ static inline void _raw_read_unlock(rwlo
 	} while (cmp != old);
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	if (unlikely(_raw_compare_and_swap(&rw->lock, 0, 0x80000000) != 0))
 		_raw_write_lock_wait(rw);
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	_raw_compare_and_swap(&rw->lock, 0x80000000, 0);
 }
 
-static inline int _raw_read_trylock(rwlock_t *rw)
+static inline int __raw_read_trylock(raw_rwlock_t *rw)
 {
 	unsigned int old;
 	old = rw->lock & 0x7fffffffU;
@@ -145,7 +128,7 @@ static inline int _raw_read_trylock(rwlo
 	return _raw_read_trylock_retry(rw);
 }
 
-static inline int _raw_write_trylock(rwlock_t *rw)
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	if (likely(_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0))
 		return 1;
diff -puN /dev/null include/asm-s390/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-s390/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,21 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} __attribute__ ((aligned (4))) raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+	volatile unsigned int owner_pc;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0, 0 }
+
+#endif
diff -puN include/asm-sh/spinlock.h~spinlock-consolidation include/asm-sh/spinlock.h
--- devel/include/asm-sh/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-sh/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -15,20 +15,11 @@
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+
+#define __raw_spin_is_locked(x)	((x)->lock != 0)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+#define __raw_spin_unlock_wait(x) \
+	do { cpu_relax(); } while (__raw_spin_is_locked(x))
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -36,7 +27,7 @@ typedef struct {
  *
  * We make no fairness assumptions.  They have a cost.
  */
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__ (
 		"1:\n\t"
@@ -49,14 +40,14 @@ static inline void _raw_spin_lock(spinlo
 	);
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	assert_spin_locked(lock);
 
 	lock->lock = 0;
 }
 
-#define _raw_spin_trylock(x) (!test_and_set_bit(0, &(x)->lock))
+#define __raw_spin_trylock(x) (!test_and_set_bit(0, &(x)->lock))
 
 /*
  * Read-write spinlocks, allowing multiple readers but only one writer.
@@ -66,51 +57,40 @@ static inline void _raw_spin_unlock(spin
  * needs to get a irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	spinlock_t lock;
-	atomic_t counter;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_BIAS		0x01000000
-#define RW_LOCK_UNLOCKED	(rwlock_t) { { 0 }, { RW_LOCK_BIAS } }
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-	_raw_spin_lock(&rw->lock);
+	__raw_spin_lock(&rw->lock);
 
 	atomic_inc(&rw->counter);
 
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 }
 
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	_raw_spin_lock(&rw->lock);
+	__raw_spin_lock(&rw->lock);
 
 	atomic_dec(&rw->counter);
 
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-	_raw_spin_lock(&rw->lock);
+	__raw_spin_lock(&rw->lock);
 	atomic_set(&rw->counter, -1);
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	atomic_set(&rw->counter, 0);
-	_raw_spin_unlock(&rw->lock);
+	__raw_spin_unlock(&rw->lock);
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
-static inline int _raw_write_trylock(rwlock_t *rw)
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	if (atomic_sub_and_test(RW_LOCK_BIAS, &rw->counter))
 		return 1;
@@ -121,4 +101,3 @@ static inline int _raw_write_trylock(rwl
 }
 
 #endif /* __ASM_SH_SPINLOCK_H */
-
diff -puN /dev/null include/asm-sh/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sh/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,22 @@
+#ifndef __ASM_SH_SPINLOCK_TYPES_H
+#define __ASM_SH_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned long lock;
+} raw_spinlock_t;
+
+#define __SPIN_LOCK_UNLOCKED		{ 0 }
+
+typedef struct {
+	raw_spinlock_t lock;
+	atomic_t counter;
+} raw_rwlock_t;
+
+#define RW_LOCK_BIAS			0x01000000
+#define __RAW_RW_LOCK_UNLOCKED		{ { 0 }, { RW_LOCK_BIAS } }
+
+#endif
diff -puN include/asm-sparc64/spinlock.h~spinlock-consolidation include/asm-sparc64/spinlock.h
--- devel/include/asm-sparc64/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-sparc64/spinlock.h	2005-09-09 12:12:39.000000000 -0700
@@ -29,24 +29,13 @@
  * must be pre-V9 branches.
  */
 
-#ifndef CONFIG_DEBUG_SPINLOCK
+#define __raw_spin_is_locked(lp)	((lp)->lock != 0)
 
-typedef struct {
-	volatile unsigned char lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) {0,}
-
-#define spin_lock_init(lp)	do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(lp)  ((lp)->lock != 0)
-
-#define spin_unlock_wait(lp)	\
-do {	rmb();			\
-} while((lp)->lock)
+#define __raw_spin_unlock_wait(lp)	\
+	do {	rmb();			\
+	} while((lp)->lock)
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -67,7 +56,7 @@ static inline void _raw_spin_lock(spinlo
 	: "memory");
 }
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned long result;
 
@@ -81,7 +70,7 @@ static inline int _raw_spin_trylock(spin
 	return (result == 0UL);
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(
 "	membar		#StoreStore | #LoadStore\n"
@@ -91,7 +80,7 @@ static inline void _raw_spin_unlock(spin
 	: "memory");
 }
 
-static inline void _raw_spin_lock_flags(spinlock_t *lock, unsigned long flags)
+static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
 	unsigned long tmp1, tmp2;
 
@@ -115,51 +104,9 @@ static inline void _raw_spin_lock_flags(
 	: "memory");
 }
 
-#else /* !(CONFIG_DEBUG_SPINLOCK) */
-
-typedef struct {
-	volatile unsigned char lock;
-	unsigned int owner_pc, owner_cpu;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 0, 0xff }
-#define spin_lock_init(lp)	do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(__lock)	((__lock)->lock != 0)
-#define spin_unlock_wait(__lock)	\
-do { \
-	rmb(); \
-} while((__lock)->lock)
-
-extern void _do_spin_lock(spinlock_t *lock, char *str, unsigned long caller);
-extern void _do_spin_unlock(spinlock_t *lock);
-extern int _do_spin_trylock(spinlock_t *lock, unsigned long caller);
-
-#define _raw_spin_trylock(lp)	\
-	_do_spin_trylock(lp, (unsigned long) __builtin_return_address(0))
-#define _raw_spin_lock(lock)	\
-	_do_spin_lock(lock, "spin_lock", \
-		      (unsigned long) __builtin_return_address(0))
-#define _raw_spin_unlock(lock)	_do_spin_unlock(lock)
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
-
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
-#ifndef CONFIG_DEBUG_SPINLOCK
-
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-#define RW_LOCK_UNLOCKED	(rwlock_t) {0,}
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
-
-static void inline __read_lock(rwlock_t *lock)
+static void inline __read_lock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -184,7 +131,7 @@ static void inline __read_lock(rwlock_t 
 	: "memory");
 }
 
-static void inline __read_unlock(rwlock_t *lock)
+static void inline __read_unlock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -201,7 +148,7 @@ static void inline __read_unlock(rwlock_
 	: "memory");
 }
 
-static void inline __write_lock(rwlock_t *lock)
+static void inline __write_lock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2;
 
@@ -228,7 +175,7 @@ static void inline __write_lock(rwlock_t
 	: "memory");
 }
 
-static void inline __write_unlock(rwlock_t *lock)
+static void inline __write_unlock(raw_rwlock_t *lock)
 {
 	__asm__ __volatile__(
 "	membar		#LoadStore | #StoreStore\n"
@@ -238,7 +185,7 @@ static void inline __write_unlock(rwlock
 	: "memory");
 }
 
-static int inline __write_trylock(rwlock_t *lock)
+static int inline __write_trylock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2, result;
 
@@ -263,78 +210,15 @@ static int inline __write_trylock(rwlock
 	return result;
 }
 
-#define _raw_read_lock(p)	__read_lock(p)
-#define _raw_read_unlock(p)	__read_unlock(p)
-#define _raw_write_lock(p)	__write_lock(p)
-#define _raw_write_unlock(p)	__write_unlock(p)
-#define _raw_write_trylock(p)	__write_trylock(p)
-
-#else /* !(CONFIG_DEBUG_SPINLOCK) */
-
-typedef struct {
-	volatile unsigned long lock;
-	unsigned int writer_pc, writer_cpu;
-	unsigned int reader_pc[NR_CPUS];
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-#define RW_LOCK_UNLOCKED	(rwlock_t) { 0, 0, 0xff, { } }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
-
-extern void _do_read_lock(rwlock_t *rw, char *str, unsigned long caller);
-extern void _do_read_unlock(rwlock_t *rw, char *str, unsigned long caller);
-extern void _do_write_lock(rwlock_t *rw, char *str, unsigned long caller);
-extern void _do_write_unlock(rwlock_t *rw, unsigned long caller);
-extern int _do_write_trylock(rwlock_t *rw, char *str, unsigned long caller);
-
-#define _raw_read_lock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_read_lock(lock, "read_lock", \
-		      (unsigned long) __builtin_return_address(0)); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_read_unlock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_read_unlock(lock, "read_unlock", \
-		      (unsigned long) __builtin_return_address(0)); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_write_lock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_write_lock(lock, "write_lock", \
-		      (unsigned long) __builtin_return_address(0)); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_write_unlock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_write_unlock(lock, \
-		      (unsigned long) __builtin_return_address(0)); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_write_trylock(lock) \
-({	unsigned long flags; \
-	int val; \
-	local_irq_save(flags); \
-	val = _do_write_trylock(lock, "write_trylock", \
-				(unsigned long) __builtin_return_address(0)); \
-	local_irq_restore(flags); \
-	val; \
-})
-
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
-#define read_can_lock(rw)	(!((rw)->lock & 0x80000000UL))
-#define write_can_lock(rw)	(!(rw)->lock)
+#define __raw_read_lock(p)	__read_lock(p)
+#define __raw_read_unlock(p)	__read_unlock(p)
+#define __raw_write_lock(p)	__write_lock(p)
+#define __raw_write_unlock(p)	__write_unlock(p)
+#define __raw_write_trylock(p)	__write_trylock(p)
+
+#define __raw_read_trylock(lock)	generic__raw_read_trylock(lock)
+#define __raw_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
+#define __raw_write_can_lock(rw)	(!(rw)->lock)
 
 #endif /* !(__ASSEMBLY__) */
 
diff -puN /dev/null include/asm-sparc64/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sparc64/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __SPARC64_SPINLOCK_TYPES_H
+#define __SPARC64_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned char lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-sparc/spinlock.h~spinlock-consolidation include/asm-sparc/spinlock.h
--- devel/include/asm-sparc/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-sparc/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -12,96 +12,12 @@
 
 #include <asm/psr.h>
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-struct _spinlock_debug {
-	unsigned char lock;
-	unsigned long owner_pc;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-};
-typedef struct _spinlock_debug spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0, 0 }
-#define spin_lock_init(lp)	do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(lp)  (*((volatile unsigned char *)(&((lp)->lock))) != 0)
-#define spin_unlock_wait(lp)	do { barrier(); } while(*(volatile unsigned char *)(&(lp)->lock))
-
-extern void _do_spin_lock(spinlock_t *lock, char *str);
-extern int _spin_trylock(spinlock_t *lock);
-extern void _do_spin_unlock(spinlock_t *lock);
-
-#define _raw_spin_trylock(lp)	_spin_trylock(lp)
-#define _raw_spin_lock(lock)	_do_spin_lock(lock, "spin_lock")
-#define _raw_spin_unlock(lock)	_do_spin_unlock(lock)
-
-struct _rwlock_debug {
-	volatile unsigned int lock;
-	unsigned long owner_pc;
-	unsigned long reader_pc[NR_CPUS];
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-};
-typedef struct _rwlock_debug rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, {0} }
-
-#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
-
-extern void _do_read_lock(rwlock_t *rw, char *str);
-extern void _do_read_unlock(rwlock_t *rw, char *str);
-extern void _do_write_lock(rwlock_t *rw, char *str);
-extern void _do_write_unlock(rwlock_t *rw);
+#define __raw_spin_is_locked(lock) (*((volatile unsigned char *)(lock)) != 0)
 
-#define _raw_read_lock(lock)	\
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_read_lock(lock, "read_lock"); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_read_unlock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_read_unlock(lock, "read_unlock"); \
-	local_irq_restore(flags); \
-} while(0)
-
-#define _raw_write_lock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_write_lock(lock, "write_lock"); \
-	local_irq_restore(flags); \
-} while(0)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-#define _raw_write_unlock(lock) \
-do {	unsigned long flags; \
-	local_irq_save(flags); \
-	_do_write_unlock(lock); \
-	local_irq_restore(flags); \
-} while(0)
-
-#else /* !CONFIG_DEBUG_SPINLOCK */
-
-typedef struct {
-	unsigned char lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-
-#define spin_lock_init(lock)   (*((unsigned char *)(lock)) = 0)
-#define spin_is_locked(lock)    (*((volatile unsigned char *)(lock)) != 0)
-
-#define spin_unlock_wait(lock) \
-do { \
-	barrier(); \
-} while(*((volatile unsigned char *)lock))
-
-extern __inline__ void _raw_spin_lock(spinlock_t *lock)
+extern __inline__ void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(
 	"\n1:\n\t"
@@ -121,7 +37,7 @@ extern __inline__ void _raw_spin_lock(sp
 	: "g2", "memory", "cc");
 }
 
-extern __inline__ int _raw_spin_trylock(spinlock_t *lock)
+extern __inline__ int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned int result;
 	__asm__ __volatile__("ldstub [%1], %0"
@@ -131,7 +47,7 @@ extern __inline__ int _raw_spin_trylock(
 	return (result == 0);
 }
 
-extern __inline__ void _raw_spin_unlock(spinlock_t *lock)
+extern __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__("stb %%g0, [%0]" : : "r" (lock) : "memory");
 }
@@ -147,23 +63,11 @@ extern __inline__ void _raw_spin_unlock(
  *
  * XXX This might create some problems with my dual spinlock
  * XXX scheme, deadlocks etc. -DaveM
- */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-
-#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
-
-
-/* Sort of like atomic_t's on Sparc, but even more clever.
+ *
+ * Sort of like atomic_t's on Sparc, but even more clever.
  *
  *	------------------------------------
- *	| 24-bit counter           | wlock |  rwlock_t
+ *	| 24-bit counter           | wlock |  raw_rwlock_t
  *	------------------------------------
  *	 31                       8 7     0
  *
@@ -174,9 +78,9 @@ typedef struct {
  *
  * Unfortunately this scheme limits us to ~16,000,000 cpus.
  */
-extern __inline__ void _read_lock(rwlock_t *rw)
+extern __inline__ void __read_lock(raw_rwlock_t *rw)
 {
-	register rwlock_t *lp asm("g1");
+	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
@@ -187,16 +91,16 @@ extern __inline__ void _read_lock(rwlock
 	: "g2", "g4", "memory", "cc");
 }
 
-#define _raw_read_lock(lock) \
+#define __raw_read_lock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	_read_lock(lock); \
+	__raw_read_lock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void _read_unlock(rwlock_t *rw)
+extern __inline__ void __read_unlock(raw_rwlock_t *rw)
 {
-	register rwlock_t *lp asm("g1");
+	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
@@ -207,16 +111,16 @@ extern __inline__ void _read_unlock(rwlo
 	: "g2", "g4", "memory", "cc");
 }
 
-#define _raw_read_unlock(lock) \
+#define __raw_read_unlock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	_read_unlock(lock); \
+	__raw_read_unlock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-extern __inline__ void _raw_write_lock(rwlock_t *rw)
+extern __inline__ void __raw_write_lock(raw_rwlock_t *rw)
 {
-	register rwlock_t *lp asm("g1");
+	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
@@ -227,11 +131,9 @@ extern __inline__ void _raw_write_lock(r
 	: "g2", "g4", "memory", "cc");
 }
 
-#define _raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
-
-#endif /* CONFIG_DEBUG_SPINLOCK */
+#define __raw_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 #endif /* !(__ASSEMBLY__) */
 
diff -puN /dev/null include/asm-sparc/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-sparc/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __SPARC_SPINLOCK_TYPES_H
+#define __SPARC_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	unsigned char lock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff -puN include/asm-x86_64/spinlock.h~spinlock-consolidation include/asm-x86_64/spinlock.h
--- devel/include/asm-x86_64/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/asm-x86_64/spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -6,47 +6,21 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
-extern int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
-/*
+ *
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
  * We make no fairness assumptions. They have a cost.
+ *
+ * (the type definitions are in asm/spinlock_types.h)
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_is_locked(x) \
+		(*(volatile signed char *)(&(x)->slock) <= 0)
 
-#define spin_lock_string \
+#define __raw_spin_lock_string \
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
@@ -58,74 +32,40 @@ typedef struct {
 	"jmp 1b\n" \
 	LOCK_SECTION_END
 
-/*
- * This works. Despite all the confusion.
- * (except on PPro SMP or if we are using OOSTORE)
- * (PPro errata 66, 92)
- */
- 
-#if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
-
-#define spin_unlock_string \
+#define __raw_spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
-
+		:"=m" (lock->slock) : : "memory"
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	assert_spin_locked(lock);
-#endif
 	__asm__ __volatile__(
-		spin_unlock_string
-	);
-}
-
-#else
-
-#define spin_unlock_string \
-	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
-		:"0" (oldval) : "memory"
-
-static inline void _raw_spin_unlock(spinlock_t *lock)
-{
-	char oldval = 1;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	assert_spin_locked(lock);
-#endif
-	__asm__ __volatile__(
-		spin_unlock_string
-	);
+		__raw_spin_lock_string
+		:"=m" (lock->slock) : : "memory");
 }
 
-#endif
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	char oldval;
+
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
+		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
+
 	return oldval > 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC) {
-		printk("eip: %p\n", __builtin_return_address(0));
-		BUG();
-	}
-#endif
 	__asm__ __volatile__(
-		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		__raw_spin_unlock_string
+	);
 }
 
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -136,33 +76,7 @@ static inline void _raw_spin_lock(spinlo
  * can "mix" irq-safe locks - any writer needs to get a
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
- */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
-#define read_can_lock(x)	((int)(x)->lock > 0)
-#define write_can_lock(x)	((x)->lock == RW_LOCK_BIAS)
-
-/*
+ *
  * On x86, we implement read-write locks as a 32-bit counter
  * with the high bit (sign) being the "contended" bit.
  *
@@ -170,29 +84,24 @@ typedef struct {
  *
  * Changed to use the same technique as rw semaphores.  See
  * semaphore.h for details.  -ben
+ *
+ * the helpers are in arch/i386/kernel/semaphore.c
  */
-/* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void _raw_read_lock(rwlock_t *rw)
+#define __raw_read_can_lock(x)		((int)(x)->lock > 0)
+#define __raw_write_can_lock(x)		((x)->lock == RW_LOCK_BIAS)
+
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(rw->magic != RWLOCK_MAGIC);
-#endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
-
-static inline int _raw_read_trylock(rwlock_t *lock)
+static inline int __raw_read_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
@@ -202,7 +111,7 @@ static inline int _raw_read_trylock(rwlo
 	return 0;
 }
 
-static inline int _raw_write_trylock(rwlock_t *lock)
+static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
@@ -211,4 +120,15 @@ static inline int _raw_write_trylock(rwl
 	return 0;
 }
 
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+}
+
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
+{
+	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0"
+				: "=m" (rw->lock) : : "memory");
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -puN /dev/null include/asm-x86_64/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/asm-x86_64/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef __ASM_SPINLOCK_TYPES_H
+#define __ASM_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+
+typedef struct {
+	volatile unsigned int lock;
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED		{ RW_LOCK_BIAS }
+
+#endif
diff -puN /dev/null include/linux/bit_spinlock.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/bit_spinlock.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,77 @@
+#ifndef __LINUX_BIT_SPINLOCK_H
+#define __LINUX_BIT_SPINLOCK_H
+
+/*
+ *  bit-based spin_lock()
+ *
+ * Don't use this unless you really need to: spin_lock() and spin_unlock()
+ * are significantly faster.
+ */
+static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	while (test_and_set_bit(bitnum, addr)) {
+		while (test_bit(bitnum, addr)) {
+			preempt_enable();
+			cpu_relax();
+			preempt_disable();
+		}
+	}
+#endif
+	__acquire(bitlock);
+}
+
+/*
+ * Return true if it was acquired
+ */
+static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+{
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	if (test_and_set_bit(bitnum, addr)) {
+		preempt_enable();
+		return 0;
+	}
+#endif
+	__acquire(bitlock);
+	return 1;
+}
+
+/*
+ *  bit-based spin_unlock()
+ */
+static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	BUG_ON(!test_bit(bitnum, addr));
+	smp_mb__before_clear_bit();
+	clear_bit(bitnum, addr);
+#endif
+	preempt_enable();
+	__release(bitlock);
+}
+
+/*
+ * Return true if the lock is held.
+ */
+static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	return test_bit(bitnum, addr);
+#elif defined CONFIG_PREEMPT
+	return preempt_count();
+#else
+	return 1;
+#endif
+}
+
+#endif /* __LINUX_BIT_SPINLOCK_H */
+
diff -puN include/linux/jbd.h~spinlock-consolidation include/linux/jbd.h
--- devel/include/linux/jbd.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/linux/jbd.h	2005-09-09 12:12:31.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/buffer_head.h>
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
+#include <linux/bit_spinlock.h>
 #include <asm/semaphore.h>
 #endif
 
diff -puN /dev/null include/linux/spinlock_api_smp.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/spinlock_api_smp.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,57 @@
+#ifndef __LINUX_SPINLOCK_API_SMP_H
+#define __LINUX_SPINLOCK_API_SMP_H
+
+#ifndef __LINUX_SPINLOCK_H
+# error "please don't include this file directly"
+#endif
+
+/*
+ * include/linux/spinlock_api_smp.h
+ *
+ * spinlock API declarations on SMP (and debug)
+ * (implemented in kernel/spinlock.c)
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+int in_lock_functions(unsigned long addr);
+
+#define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
+
+void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(spinlock_t);
+void __lockfunc _read_lock(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _write_lock(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
+void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(spinlock_t);
+void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
+void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+							__acquires(spinlock_t);
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
+							__acquires(rwlock_t);
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+							__acquires(rwlock_t);
+int __lockfunc _spin_trylock(spinlock_t *lock);
+int __lockfunc _read_trylock(rwlock_t *lock);
+int __lockfunc _write_trylock(rwlock_t *lock);
+int __lockfunc _spin_trylock_bh(spinlock_t *lock);
+void __lockfunc _spin_unlock(spinlock_t *lock)		__releases(spinlock_t);
+void __lockfunc _read_unlock(rwlock_t *lock)		__releases(rwlock_t);
+void __lockfunc _write_unlock(rwlock_t *lock)		__releases(rwlock_t);
+void __lockfunc _spin_unlock_bh(spinlock_t *lock)	__releases(spinlock_t);
+void __lockfunc _read_unlock_bh(rwlock_t *lock)		__releases(rwlock_t);
+void __lockfunc _write_unlock_bh(rwlock_t *lock)	__releases(rwlock_t);
+void __lockfunc _spin_unlock_irq(spinlock_t *lock)	__releases(spinlock_t);
+void __lockfunc _read_unlock_irq(rwlock_t *lock)	__releases(rwlock_t);
+void __lockfunc _write_unlock_irq(rwlock_t *lock)	__releases(rwlock_t);
+void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+							__releases(spinlock_t);
+void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+							__releases(rwlock_t);
+void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+							__releases(rwlock_t);
+
+#endif /* __LINUX_SPINLOCK_API_SMP_H */
diff -puN /dev/null include/linux/spinlock_api_up.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/spinlock_api_up.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,80 @@
+#ifndef __LINUX_SPINLOCK_API_UP_H
+#define __LINUX_SPINLOCK_API_UP_H
+
+#ifndef __LINUX_SPINLOCK_H
+# error "please don't include this file directly"
+#endif
+
+/*
+ * include/linux/spinlock_api_up.h
+ *
+ * spinlock API implementation on UP-nondebug (inlined implementation)
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+#define in_lock_functions(ADDR)		0
+
+#define assert_spin_locked(lock)	do { (void)(lock); } while (0)
+
+/*
+ * In the UP-nondebug case there's no real locking going on, so the
+ * only thing we have to do is to keep the preempt counts and irq
+ * flags straight, to supress compiler warnings of unused lock
+ * variables, and to add the proper checker annotations:
+ */
+#define __LOCK(lock) \
+  do { preempt_disable(); __acquire(lock); (void)(lock); } while (0)
+
+#define __LOCK_BH(lock) \
+  do { local_bh_disable(); __LOCK(lock); } while (0)
+
+#define __LOCK_IRQ(lock) \
+  do { local_irq_disable(); __LOCK(lock); } while (0)
+
+#define __LOCK_IRQSAVE(lock, flags) \
+  do { local_irq_save(flags); __LOCK(lock); } while (0)
+
+#define __UNLOCK(lock) \
+  do { preempt_enable(); __release(lock); (void)(lock); } while (0)
+
+#define __UNLOCK_BH(lock) \
+  do { preempt_enable_no_resched(); local_bh_enable(); __release(lock); (void)(lock); } while (0)
+
+#define __UNLOCK_IRQ(lock) \
+  do { local_irq_enable(); __UNLOCK(lock); } while (0)
+
+#define __UNLOCK_IRQRESTORE(lock, flags) \
+  do { local_irq_restore(flags); __UNLOCK(lock); } while (0)
+
+#define _spin_lock(lock)			__LOCK(lock)
+#define _read_lock(lock)			__LOCK(lock)
+#define _write_lock(lock)			__LOCK(lock)
+#define _spin_lock_bh(lock)			__LOCK_BH(lock)
+#define _read_lock_bh(lock)			__LOCK_BH(lock)
+#define _write_lock_bh(lock)			__LOCK_BH(lock)
+#define _spin_lock_irq(lock)			__LOCK_IRQ(lock)
+#define _read_lock_irq(lock)			__LOCK_IRQ(lock)
+#define _write_lock_irq(lock)			__LOCK_IRQ(lock)
+#define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
+#define _spin_trylock(lock)			({ __LOCK(lock); 1; })
+#define _read_trylock(lock)			({ __LOCK(lock); 1; })
+#define _write_trylock(lock)			({ __LOCK(lock); 1; })
+#define _spin_trylock_bh(lock)			({ __LOCK_BH(lock); 1; })
+#define _spin_unlock(lock)			__UNLOCK(lock)
+#define _read_unlock(lock)			__UNLOCK(lock)
+#define _write_unlock(lock)			__UNLOCK(lock)
+#define _spin_unlock_bh(lock)			__UNLOCK_BH(lock)
+#define _write_unlock_bh(lock)			__UNLOCK_BH(lock)
+#define _read_unlock_bh(lock)			__UNLOCK_BH(lock)
+#define _spin_unlock_irq(lock)			__UNLOCK_IRQ(lock)
+#define _read_unlock_irq(lock)			__UNLOCK_IRQ(lock)
+#define _write_unlock_irq(lock)			__UNLOCK_IRQ(lock)
+#define _spin_unlock_irqrestore(lock, flags)	__UNLOCK_IRQRESTORE(lock, flags)
+#define _read_unlock_irqrestore(lock, flags)	__UNLOCK_IRQRESTORE(lock, flags)
+#define _write_unlock_irqrestore(lock, flags)	__UNLOCK_IRQRESTORE(lock, flags)
+
+#endif /* __LINUX_SPINLOCK_API_UP_H */
diff -puN include/linux/spinlock.h~spinlock-consolidation include/linux/spinlock.h
--- devel/include/linux/spinlock.h~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/include/linux/spinlock.h	2005-09-09 12:12:38.000000000 -0700
@@ -2,7 +2,48 @@
 #define __LINUX_SPINLOCK_H
 
 /*
- * include/linux/spinlock.h - generic locking declarations
+ * include/linux/spinlock.h - generic spinlock/rwlock declarations
+ *
+ * here's the role of the various spinlock/rwlock related include files:
+ *
+ * on SMP builds:
+ *
+ *  asm/spinlock_types.h: contains the raw_spinlock_t/raw_rwlock_t and the
+ *                        initializers
+ *
+ *  linux/spinlock_types.h:
+ *                        defines the generic type and initializers
+ *
+ *  asm/spinlock.h:       contains the __raw_spin_*()/etc. lowlevel
+ *                        implementations, mostly inline assembly code
+ *
+ *   (also included on UP-debug builds:)
+ *
+ *  linux/spinlock_api_smp.h:
+ *                        contains the prototypes for the _spin_*() APIs.
+ *
+ *  linux/spinlock.h:     builds the final spin_*() APIs.
+ *
+ * on UP builds:
+ *
+ *  linux/spinlock_type_up.h:
+ *                        contains the generic, simplified UP spinlock type.
+ *                        (which is an empty structure on non-debug builds)
+ *
+ *  linux/spinlock_types.h:
+ *                        defines the generic type and initializers
+ *
+ *  linux/spinlock_up.h:
+ *                        contains the __raw_spin_*()/etc. version of UP
+ *                        builds. (which are NOPs on non-debug, non-preempt
+ *                        builds)
+ *
+ *   (included on UP-non-debug builds:)
+ *
+ *  linux/spinlock_api_up.h:
+ *                        builds the _spin_*() APIs.
+ *
+ *  linux/spinlock.h:     builds the final spin_*() APIs.
  */
 
 #include <linux/config.h>
@@ -13,7 +54,6 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
-#include <asm/processor.h>	/* for cpu relax */
 #include <asm/system.h>
 
 /*
@@ -35,423 +75,84 @@
 #define __lockfunc fastcall __attribute__((section(".spinlock.text")))
 
 /*
- * If CONFIG_SMP is set, pull in the _raw_* definitions
+ * Pull the raw_spinlock_t and raw_rwlock_t definitions:
  */
-#ifdef CONFIG_SMP
-
-#define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
-#include <asm/spinlock.h>
+#include <linux/spinlock_types.h>
 
-int __lockfunc _spin_trylock(spinlock_t *lock);
-int __lockfunc _read_trylock(rwlock_t *lock);
-int __lockfunc _write_trylock(rwlock_t *lock);
-
-void __lockfunc _spin_lock(spinlock_t *lock)	__acquires(spinlock_t);
-void __lockfunc _read_lock(rwlock_t *lock)	__acquires(rwlock_t);
-void __lockfunc _write_lock(rwlock_t *lock)	__acquires(rwlock_t);
-
-void __lockfunc _spin_unlock(spinlock_t *lock)	__releases(spinlock_t);
-void __lockfunc _read_unlock(rwlock_t *lock)	__releases(rwlock_t);
-void __lockfunc _write_unlock(rwlock_t *lock)	__releases(rwlock_t);
-
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)	__acquires(spinlock_t);
-unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
-unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)	__acquires(rwlock_t);
-
-void __lockfunc _spin_lock_irq(spinlock_t *lock)	__acquires(spinlock_t);
-void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
-void __lockfunc _read_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _read_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(rwlock_t);
-void __lockfunc _write_lock_bh(rwlock_t *lock)		__acquires(rwlock_t);
-
-void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)	__releases(spinlock_t);
-void __lockfunc _spin_unlock_irq(spinlock_t *lock)				__releases(spinlock_t);
-void __lockfunc _spin_unlock_bh(spinlock_t *lock)				__releases(spinlock_t);
-void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
-void __lockfunc _read_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
-void __lockfunc _read_unlock_bh(rwlock_t *lock)					__releases(rwlock_t);
-void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)	__releases(rwlock_t);
-void __lockfunc _write_unlock_irq(rwlock_t *lock)				__releases(rwlock_t);
-void __lockfunc _write_unlock_bh(rwlock_t *lock)				__releases(rwlock_t);
-
-int __lockfunc _spin_trylock_bh(spinlock_t *lock);
-int __lockfunc generic_raw_read_trylock(rwlock_t *lock);
-int in_lock_functions(unsigned long addr);
+extern int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock);
 
+/*
+ * Pull the __raw*() functions/declarations (UP-nondebug doesnt need them):
+ */
+#if defined(CONFIG_SMP)
+# include <asm/spinlock.h>
 #else
+# include <linux/spinlock_up.h>
+#endif
 
-#define in_lock_functions(ADDR) 0
+#define spin_lock_init(lock)	do { *(lock) = SPIN_LOCK_UNLOCKED; } while (0)
+#define rwlock_init(lock)	do { *(lock) = RW_LOCK_UNLOCKED; } while (0)
 
-#if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
-# define _atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
-# define ATOMIC_DEC_AND_LOCK
-#endif
+#define spin_is_locked(lock)	__raw_spin_is_locked(&(lock)->raw_lock)
 
-#ifdef CONFIG_DEBUG_SPINLOCK
- 
-#define SPINLOCK_MAGIC	0x1D244B3C
-typedef struct {
-	unsigned long magic;
-	volatile unsigned long lock;
-	volatile unsigned int babble;
-	const char *module;
-	char *owner;
-	int oline;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
-
-#define spin_lock_init(x) \
-	do { \
-		(x)->magic = SPINLOCK_MAGIC; \
-		(x)->lock = 0; \
-		(x)->babble = 5; \
-		(x)->module = __FILE__; \
-		(x)->owner = NULL; \
-		(x)->oline = 0; \
-	} while (0)
-
-#define CHECK_LOCK(x) \
-	do { \
-	 	if ((x)->magic != SPINLOCK_MAGIC) { \
-			printk(KERN_ERR "%s:%d: spin_is_locked on uninitialized spinlock %p.\n", \
-					__FILE__, __LINE__, (x)); \
-		} \
-	} while(0)
-
-#define _raw_spin_lock(x)		\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_lock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-	} while (0)
-
-/* without debugging, spin_is_locked on UP always says
- * FALSE. --> printk if already locked. */
-#define spin_is_locked(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_is_locked(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		0; \
-	})
-
-/* with debugging, assert_spin_locked() on UP does check
- * the lock value properly */
-#define assert_spin_locked(x) \
-	({ \
-		CHECK_LOCK(x); \
-		BUG_ON(!(x)->lock); \
-	})
-
-/* without debugging, spin_trylock on UP always says
- * TRUE. --> printk if already locked. */
-#define _raw_spin_trylock(x) \
-	({ \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_trylock(%s:%p) already locked by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, \
-					(x), (x)->owner, (x)->oline); \
-		} \
-		(x)->lock = 1; \
-		(x)->owner = __FILE__; \
-		(x)->oline = __LINE__; \
-		1; \
-	})
-
-#define spin_unlock_wait(x)	\
-	do { \
-	 	CHECK_LOCK(x); \
-		if ((x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock_wait(%s:%p) owned by %s/%d\n", \
-					__FILE__,__LINE__, (x)->module, (x), \
-					(x)->owner, (x)->oline); \
-		}\
-	} while (0)
-
-#define _raw_spin_unlock(x) \
-	do { \
-	 	CHECK_LOCK(x); \
-		if (!(x)->lock&&(x)->babble) { \
-			(x)->babble--; \
-			printk("%s:%d: spin_unlock(%s:%p) not locked\n", \
-					__FILE__,__LINE__, (x)->module, (x));\
-		} \
-		(x)->lock = 0; \
-	} while (0)
-#else
-/*
- * gcc versions before ~2.95 have a nasty bug with empty initializers.
+/**
+ * spin_unlock_wait - wait until the spinlock gets unlocked
+ * @lock: the spinlock in question.
  */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
+#define spin_unlock_wait(lock)	__raw_spin_unlock_wait(&(lock)->raw_lock)
 
 /*
- * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
+ * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
  */
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
-#define spin_is_locked(lock)	((void)(lock), 0)
-#define assert_spin_locked(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_trylock(lock)	(((void)(lock), 1))
-#define spin_unlock_wait(lock)	(void)(lock)
-#define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
-#endif /* CONFIG_DEBUG_SPINLOCK */
-
-/* RW spinlocks: No debug version */
-
-#if (__GNUC__ > 2)
-  typedef struct { } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+# include <linux/spinlock_api_smp.h>
 #else
-  typedef struct { int gcc_is_buggy; } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+# include <linux/spinlock_api_up.h>
 #endif
 
-#define rwlock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_read_lock(lock)	do { (void)(lock); } while(0)
-#define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
-#define _raw_write_lock(lock)	do { (void)(lock); } while(0)
-#define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
-#define read_can_lock(lock)	(((void)(lock), 1))
-#define write_can_lock(lock)	(((void)(lock), 1))
-#define _raw_read_trylock(lock) ({ (void)(lock); (1); })
-#define _raw_write_trylock(lock) ({ (void)(lock); (1); })
-
-#define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
-				1 : ({preempt_enable(); 0;});})
-
-#define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
-				_raw_spin_trylock(lock) ? \
-				1 : ({preempt_enable_no_resched(); local_bh_enable(); 0;});})
-
-#define _spin_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while(0)
-
-#define _write_lock(lock) \
-do { \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while(0)
- 
-#define _read_lock(lock)	\
-do { \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while(0)
-
-#define _spin_unlock(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while(0)
-
-#define _read_unlock(lock) \
-do { \
-	_raw_read_unlock(lock); \
-	preempt_enable(); \
-	__release(lock); \
-} while(0)
-
-#define _spin_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _read_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _read_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _read_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_read_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _write_lock_irqsave(lock, flags) \
-do {	\
-	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _write_lock_irq(lock) \
-do { \
-	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _write_lock_bh(lock) \
-do { \
-	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_write_lock(lock); \
-	__acquire(lock); \
-} while (0)
-
-#define _spin_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _spin_unlock_irq(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	local_irq_enable(); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _spin_unlock_bh(lock) \
-do { \
-	_raw_spin_unlock(lock); \
-	preempt_enable_no_resched(); \
-	local_bh_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_bh(lock) \
-do { \
-	_raw_write_unlock(lock); \
-	preempt_enable_no_resched(); \
-	local_bh_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_read_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_irqrestore(lock, flags) \
-do { \
-	_raw_write_unlock(lock); \
-	local_irq_restore(flags); \
-	preempt_enable(); \
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_irq(lock)	\
-do { \
-	_raw_read_unlock(lock);	\
-	local_irq_enable();	\
-	preempt_enable();	\
-	__release(lock); \
-} while (0)
-
-#define _read_unlock_bh(lock)	\
-do { \
-	_raw_read_unlock(lock);	\
-	preempt_enable_no_resched();	\
-	local_bh_enable();	\
-	__release(lock); \
-} while (0)
-
-#define _write_unlock_irq(lock)	\
-do { \
-	_raw_write_unlock(lock);	\
-	local_irq_enable();	\
-	preempt_enable();	\
-	__release(lock); \
-} while (0)
+#ifdef CONFIG_DEBUG_SPINLOCK
+ extern void _raw_spin_lock(spinlock_t *lock);
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+ extern int _raw_spin_trylock(spinlock_t *lock);
+ extern void _raw_spin_unlock(spinlock_t *lock);
+
+ extern void _raw_read_lock(rwlock_t *lock);
+ extern int _raw_read_trylock(rwlock_t *lock);
+ extern void _raw_read_unlock(rwlock_t *lock);
+ extern void _raw_write_lock(rwlock_t *lock);
+ extern int _raw_write_trylock(rwlock_t *lock);
+ extern void _raw_write_unlock(rwlock_t *lock);
+#else
+# define _raw_spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
+# define _raw_spin_trylock(lock)	__raw_spin_trylock(&(lock)->raw_lock)
+# define _raw_spin_lock(lock)		__raw_spin_lock(&(lock)->raw_lock)
+# define _raw_spin_lock_flags(lock, flags) \
+		__raw_spin_lock_flags(&(lock)->raw_lock, *(flags))
+# define _raw_read_lock(rwlock)		__raw_read_lock(&(rwlock)->raw_lock)
+# define _raw_write_lock(rwlock)	__raw_write_lock(&(rwlock)->raw_lock)
+# define _raw_read_unlock(rwlock)	__raw_read_unlock(&(rwlock)->raw_lock)
+# define _raw_write_unlock(rwlock)	__raw_write_unlock(&(rwlock)->raw_lock)
+# define _raw_read_trylock(rwlock)	__raw_read_trylock(&(rwlock)->raw_lock)
+# define _raw_write_trylock(rwlock)	__raw_write_trylock(&(rwlock)->raw_lock)
+#endif
 
-#endif /* !SMP */
+#define read_can_lock(rwlock)		__raw_read_can_lock(&(rwlock)->raw_lock)
+#define write_can_lock(rwlock)		__raw_write_can_lock(&(rwlock)->raw_lock)
 
 /*
  * Define the various spin_lock and rw_lock methods.  Note we define these
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define spin_trylock(lock)	__cond_lock(_spin_trylock(lock))
-#define read_trylock(lock)	__cond_lock(_read_trylock(lock))
-#define write_trylock(lock)	__cond_lock(_write_trylock(lock))
-
-#define spin_lock(lock)		_spin_lock(lock)
-#define write_lock(lock)	_write_lock(lock)
-#define read_lock(lock)		_read_lock(lock)
+#define spin_trylock(lock)		__cond_lock(_spin_trylock(lock))
+#define read_trylock(lock)		__cond_lock(_read_trylock(lock))
+#define write_trylock(lock)		__cond_lock(_write_trylock(lock))
+
+#define spin_lock(lock)			_spin_lock(lock)
+#define write_lock(lock)		_write_lock(lock)
+#define read_lock(lock)			_read_lock(lock)
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
@@ -470,137 +171,59 @@ do { \
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
 
-#define spin_unlock(lock)	_spin_unlock(lock)
-#define write_unlock(lock)	_write_unlock(lock)
-#define read_unlock(lock)	_read_unlock(lock)
+#define spin_unlock(lock)		_spin_unlock(lock)
+#define write_unlock(lock)		_write_unlock(lock)
+#define read_unlock(lock)		_read_unlock(lock)
 
-#define spin_unlock_irqrestore(lock, flags)	_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags) \
+					_spin_unlock_irqrestore(lock, flags)
 #define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
-#define read_unlock_irqrestore(lock, flags)	_read_unlock_irqrestore(lock, flags)
-#define read_unlock_irq(lock)			_read_unlock_irq(lock)
-#define read_unlock_bh(lock)			_read_unlock_bh(lock)
-
-#define write_unlock_irqrestore(lock, flags)	_write_unlock_irqrestore(lock, flags)
-#define write_unlock_irq(lock)			_write_unlock_irq(lock)
-#define write_unlock_bh(lock)			_write_unlock_bh(lock)
+#define read_unlock_irqrestore(lock, flags) \
+					_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define read_unlock_bh(lock)		_read_unlock_bh(lock)
+
+#define write_unlock_irqrestore(lock, flags) \
+					_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
+#define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
-#define spin_trylock_bh(lock)			__cond_lock(_spin_trylock_bh(lock))
+#define spin_trylock_bh(lock)		__cond_lock(_spin_trylock_bh(lock))
 
 #define spin_trylock_irq(lock) \
 ({ \
 	local_irq_disable(); \
 	_spin_trylock(lock) ? \
-	1 : ({local_irq_enable(); 0; }); \
+	1 : ({ local_irq_enable(); 0;  }); \
 })
 
 #define spin_trylock_irqsave(lock, flags) \
 ({ \
 	local_irq_save(flags); \
 	_spin_trylock(lock) ? \
-	1 : ({local_irq_restore(flags); 0;}); \
+	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
-#ifdef CONFIG_LOCKMETER
-extern void _metered_spin_lock   (spinlock_t *lock);
-extern void _metered_spin_unlock (spinlock_t *lock);
-extern int  _metered_spin_trylock(spinlock_t *lock);
-extern void _metered_read_lock    (rwlock_t *lock);
-extern void _metered_read_unlock  (rwlock_t *lock);
-extern void _metered_write_lock   (rwlock_t *lock);
-extern void _metered_write_unlock (rwlock_t *lock);
-extern int  _metered_read_trylock (rwlock_t *lock);
-extern int  _metered_write_trylock(rwlock_t *lock);
-#endif
-
-/* "lock on reference count zero" */
-#ifndef ATOMIC_DEC_AND_LOCK
-#include <asm/atomic.h>
-extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-#endif
-
-#define atomic_dec_and_lock(atomic,lock) __cond_lock(_atomic_dec_and_lock(atomic,lock))
-
-/*
- *  bit-based spin_lock()
- *
- * Don't use this unless you really need to: spin_lock() and spin_unlock()
- * are significantly faster.
- */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (test_and_set_bit(bitnum, addr)) {
-		while (test_bit(bitnum, addr)) {
-			preempt_enable();
-			cpu_relax();
-			preempt_disable();
-		}
-	}
-#endif
-	__acquire(bitlock);
-}
-
 /*
- * Return true if it was acquired
+ * Pull the atomic_t declaration:
+ * (asm-mips/atomic.h needs above definitions)
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
-{
-	preempt_disable();	
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	if (test_and_set_bit(bitnum, addr)) {
-		preempt_enable();
-		return 0;
-	}
-#endif
-	__acquire(bitlock);
-	return 1;
-}
-
-/*
- *  bit-based spin_unlock()
- */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
-#endif
-	preempt_enable();
-	__release(bitlock);
-}
-
-/*
- * Return true if the lock is held.
+#include <asm/atomic.h>
+/**
+ * atomic_dec_and_lock - lock on reaching reference count zero
+ * @atomic: the atomic counter
+ * @lock: the spinlock in question
  */
-static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT
-	return preempt_count();
-#else
-	return 1;
-#endif
-}
-
-#define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
-#define DEFINE_RWLOCK(x) rwlock_t x = RW_LOCK_UNLOCKED
+extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
+#define atomic_dec_and_lock(atomic, lock) \
+		__cond_lock(_atomic_dec_and_lock(atomic, lock))
 
 /**
  * spin_can_lock - would spin_trylock() succeed?
  * @lock: the spinlock in question.
  */
-#define spin_can_lock(lock)		(!spin_is_locked(lock))
+#define spin_can_lock(lock)	(!spin_is_locked(lock))
 
 #endif /* __LINUX_SPINLOCK_H */
diff -puN /dev/null include/linux/spinlock_types.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/spinlock_types.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,67 @@
+#ifndef __LINUX_SPINLOCK_TYPES_H
+#define __LINUX_SPINLOCK_TYPES_H
+
+/*
+ * include/linux/spinlock_types.h - generic spinlock type definitions
+ *                                  and initializers
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
+#else
+# include <linux/spinlock_types_up.h>
+#endif
+
+typedef struct {
+	raw_spinlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+} spinlock_t;
+
+#define SPINLOCK_MAGIC		0xdead4ead
+
+typedef struct {
+	raw_rwlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+} rwlock_t;
+
+#define RWLOCK_MAGIC		0xdeaf1eed
+
+#define SPINLOCK_OWNER_INIT	((void *)-1L)
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define SPIN_LOCK_UNLOCKED						\
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
+				.magic = SPINLOCK_MAGIC,		\
+				.owner = SPINLOCK_OWNER_INIT,		\
+				.owner_cpu = -1 }
+#define RW_LOCK_UNLOCKED						\
+	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
+				.magic = RWLOCK_MAGIC,			\
+				.owner = SPINLOCK_OWNER_INIT,		\
+				.owner_cpu = -1 }
+#else
+# define SPIN_LOCK_UNLOCKED \
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED }
+#define RW_LOCK_UNLOCKED \
+	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED }
+#endif
+
+#define DEFINE_SPINLOCK(x)	spinlock_t x = SPIN_LOCK_UNLOCKED
+#define DEFINE_RWLOCK(x)	rwlock_t x = RW_LOCK_UNLOCKED
+
+#endif /* __LINUX_SPINLOCK_TYPES_H */
diff -puN /dev/null include/linux/spinlock_types_up.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/spinlock_types_up.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,51 @@
+#ifndef __LINUX_SPINLOCK_TYPES_UP_H
+#define __LINUX_SPINLOCK_TYPES_UP_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+/*
+ * include/linux/spinlock_types_up.h - spinlock type definitions for UP
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ */
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+typedef struct {
+	volatile unsigned int slock;
+} raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED { 1 }
+
+#else
+
+/*
+ * All gcc 2.95 versions and early versions of 2.96 have a nasty bug
+ * with empty initializers.
+ */
+#if (__GNUC__ > 2)
+typedef struct { } raw_spinlock_t;
+
+#define __RAW_SPIN_LOCK_UNLOCKED { }
+#else
+typedef struct { int gcc_is_buggy; } raw_spinlock_t;
+#define __RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) { 0 }
+#endif
+
+#endif
+
+#if (__GNUC__ > 2)
+typedef struct {
+	/* no debug version on UP */
+} raw_rwlock_t;
+
+#define __RAW_RW_LOCK_UNLOCKED { }
+#else
+typedef struct { int gcc_is_buggy; } raw_rwlock_t;
+#define __RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) { 0 }
+#endif
+
+#endif /* __LINUX_SPINLOCK_TYPES_UP_H */
diff -puN /dev/null include/linux/spinlock_up.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/include/linux/spinlock_up.h	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,74 @@
+#ifndef __LINUX_SPINLOCK_UP_H
+#define __LINUX_SPINLOCK_UP_H
+
+#ifndef __LINUX_SPINLOCK_H
+# error "please don't include this file directly"
+#endif
+
+/*
+ * include/linux/spinlock_up.h - UP-debug version of spinlocks.
+ *
+ * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ *
+ * In the debug case, 1 means unlocked, 0 means locked. (the values
+ * are inverted, to catch initialization bugs)
+ *
+ * No atomicity anywhere, we are on UP.
+ */
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+#define __raw_spin_is_locked(x)		((x)->slock == 0)
+
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
+{
+	lock->slock = 0;
+}
+
+static inline void
+__raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
+{
+	local_irq_save(flags);
+	lock->slock = 0;
+}
+
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+{
+	char oldval = lock->slock;
+
+	lock->slock = 0;
+
+	return oldval > 0;
+}
+
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
+{
+	lock->slock = 1;
+}
+
+/*
+ * Read-write spinlocks. No debug version.
+ */
+#define __raw_read_lock(lock)		do { (void)(lock); } while (0)
+#define __raw_write_lock(lock)		do { (void)(lock); } while (0)
+#define __raw_read_trylock(lock)	({ (void)(lock); 1; })
+#define __raw_write_trylock(lock)	({ (void)(lock); 1; })
+#define __raw_read_unlock(lock)		do { (void)(lock); } while (0)
+#define __raw_write_unlock(lock)	do { (void)(lock); } while (0)
+
+#else /* DEBUG_SPINLOCK */
+#define __raw_spin_is_locked(lock)	((void)(lock), 0)
+/* for sched.c and kernel_lock.c: */
+# define __raw_spin_lock(lock)		do { (void)(lock); } while (0)
+# define __raw_spin_unlock(lock)	do { (void)(lock); } while (0)
+# define __raw_spin_trylock(lock)	({ (void)(lock); 1; })
+#endif /* DEBUG_SPINLOCK */
+
+#define __raw_read_can_lock(lock)	(((void)(lock), 1))
+#define __raw_write_can_lock(lock)	(((void)(lock), 1))
+
+#define __raw_spin_unlock_wait(lock) \
+		do { cpu_relax(); } while (__raw_spin_is_locked(lock))
+
+#endif /* __LINUX_SPINLOCK_UP_H */
diff -puN kernel/Makefile~spinlock-consolidation kernel/Makefile
--- devel/kernel/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/kernel/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -12,6 +12,7 @@ obj-y     = sched.o fork.o exec_domain.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
+obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff -puN kernel/sched.c~spinlock-consolidation kernel/sched.c
--- devel/kernel/sched.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/kernel/sched.c	2005-09-09 12:12:31.000000000 -0700
@@ -1511,6 +1511,10 @@ static inline void finish_task_switch(ru
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
 	prev_task_flags = prev->flags;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	/* this is a valid case when another task releases the spinlock */
+	rq->lock.owner = current;
+#endif
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
 	if (mm)
diff -puN kernel/spinlock.c~spinlock-consolidation kernel/spinlock.c
--- devel/kernel/spinlock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/kernel/spinlock.c	2005-09-09 12:12:31.000000000 -0700
@@ -3,7 +3,10 @@
  *
  * Author: Zwane Mwaikambo <zwane@fsmlabs.com>
  *
- * Copyright (2004) Ingo Molnar
+ * Copyright (2004, 2005) Ingo Molnar
+ *
+ * This file contains the spinlock/rwlock implementations for the
+ * SMP and the DEBUG_SPINLOCK cases. (UP-nondebug inlines them)
  */
 
 #include <linux/config.h>
@@ -17,12 +20,12 @@
  * Generic declaration of the raw read_trylock() function,
  * architectures are supposed to optimize this:
  */
-int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
+int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
 {
-	_raw_read_lock(lock);
+	__raw_read_lock(lock);
 	return 1;
 }
-EXPORT_SYMBOL(generic_raw_read_trylock);
+EXPORT_SYMBOL(generic__raw_read_trylock);
 
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
@@ -57,7 +60,7 @@ int __lockfunc _write_trylock(rwlock_t *
 }
 EXPORT_SYMBOL(_write_trylock);
 
-#ifndef CONFIG_PREEMPT
+#if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
@@ -72,7 +75,7 @@ unsigned long __lockfunc _spin_lock_irqs
 
 	local_irq_save(flags);
 	preempt_disable();
-	_raw_spin_lock_flags(lock, flags);
+	_raw_spin_lock_flags(lock, &flags);
 	return flags;
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
diff -puN lib/dec_and_lock.c~spinlock-consolidation lib/dec_and_lock.c
--- devel/lib/dec_and_lock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/lib/dec_and_lock.c	2005-09-09 12:12:31.000000000 -0700
@@ -25,8 +25,6 @@
  * this is trivially done efficiently using a load-locked
  * store-conditional approach, for example.
  */
-
-#ifndef ATOMIC_DEC_AND_LOCK
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	spin_lock(lock);
@@ -37,4 +35,3 @@ int _atomic_dec_and_lock(atomic_t *atomi
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif
diff -puN lib/kernel_lock.c~spinlock-consolidation lib/kernel_lock.c
--- devel/lib/kernel_lock.c~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/lib/kernel_lock.c	2005-09-09 12:12:31.000000000 -0700
@@ -177,8 +177,7 @@ static inline void __lock_kernel(void)
 
 static inline void __unlock_kernel(void)
 {
-	_raw_spin_unlock(&kernel_flag);
-	preempt_enable();
+	spin_unlock(&kernel_flag);
 }
 
 /*
diff -puN lib/Makefile~spinlock-consolidation lib/Makefile
--- devel/lib/Makefile~spinlock-consolidation	2005-09-09 12:12:31.000000000 -0700
+++ devel-akpm/lib/Makefile	2005-09-09 12:12:31.000000000 -0700
@@ -16,6 +16,7 @@ CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
 endif
 
+obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
diff -puN /dev/null lib/spinlock_debug.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/lib/spinlock_debug.c	2005-09-09 12:12:31.000000000 -0700
@@ -0,0 +1,257 @@
+/*
+ * Copyright 2005, Red Hat, Inc., Ingo Molnar
+ * Released under the General Public License (GPL).
+ *
+ * This file contains the spinlock/rwlock implementations for
+ * DEBUG_SPINLOCK.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+static void spin_bug(spinlock_t *lock, const char *msg)
+{
+	static long print_once = 1;
+	struct task_struct *owner = NULL;
+
+	if (xchg(&print_once, 0)) {
+		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
+			owner = lock->owner;
+		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
+			msg, smp_processor_id(), current->comm, current->pid);
+		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
+			lock, lock->magic,
+			owner ? owner->comm : "<none>",
+			owner ? owner->pid : -1,
+			lock->owner_cpu);
+		dump_stack();
+#ifdef CONFIG_SMP
+		/*
+		 * We cannot continue on SMP:
+		 */
+//		panic("bad locking");
+#endif
+	}
+}
+
+#define SPIN_BUG_ON(cond, lock, msg) if (unlikely(cond)) spin_bug(lock, msg)
+
+static inline void debug_spin_lock_before(spinlock_t *lock)
+{
+	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
+	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+							lock, "cpu recursion");
+}
+
+static inline void debug_spin_lock_after(spinlock_t *lock)
+{
+	lock->owner_cpu = raw_smp_processor_id();
+	lock->owner = current;
+}
+
+static inline void debug_spin_unlock(spinlock_t *lock)
+{
+	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
+	SPIN_BUG_ON(!spin_is_locked(lock), lock, "already unlocked");
+	SPIN_BUG_ON(lock->owner != current, lock, "wrong owner");
+	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
+							lock, "wrong CPU");
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+}
+
+static void __spin_lock_debug(spinlock_t *lock)
+{
+	int print_once = 1;
+	u64 i;
+
+	for (;;) {
+		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+			cpu_relax();
+			if (__raw_spin_trylock(&lock->raw_lock))
+				return;
+		}
+		/* lockup suspected: */
+		if (print_once) {
+			print_once = 0;
+			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
+				smp_processor_id(), current->comm, current->pid,
+					lock);
+			dump_stack();
+		}
+	}
+}
+
+void _raw_spin_lock(spinlock_t *lock)
+{
+	debug_spin_lock_before(lock);
+	if (unlikely(!__raw_spin_trylock(&lock->raw_lock)))
+		__spin_lock_debug(lock);
+	debug_spin_lock_after(lock);
+}
+
+int _raw_spin_trylock(spinlock_t *lock)
+{
+	int ret = __raw_spin_trylock(&lock->raw_lock);
+
+	if (ret)
+		debug_spin_lock_after(lock);
+#ifndef CONFIG_SMP
+	/*
+	 * Must not happen on UP:
+	 */
+	SPIN_BUG_ON(!ret, lock, "trylock failure on UP");
+#endif
+	return ret;
+}
+
+void _raw_spin_unlock(spinlock_t *lock)
+{
+	debug_spin_unlock(lock);
+	__raw_spin_unlock(&lock->raw_lock);
+}
+
+static void rwlock_bug(rwlock_t *lock, const char *msg)
+{
+	static long print_once = 1;
+
+	if (xchg(&print_once, 0)) {
+		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
+			smp_processor_id(), current->comm, current->pid, lock);
+		dump_stack();
+#ifdef CONFIG_SMP
+		/*
+		 * We cannot continue on SMP:
+		 */
+		panic("bad locking");
+#endif
+	}
+}
+
+#define RWLOCK_BUG_ON(cond, lock, msg) if (unlikely(cond)) rwlock_bug(lock, msg)
+
+static void __read_lock_debug(rwlock_t *lock)
+{
+	int print_once = 1;
+	u64 i;
+
+	for (;;) {
+		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+			cpu_relax();
+			if (__raw_read_trylock(&lock->raw_lock))
+				return;
+		}
+		/* lockup suspected: */
+		if (print_once) {
+			print_once = 0;
+			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
+				smp_processor_id(), current->comm, current->pid,
+					lock);
+			dump_stack();
+		}
+	}
+}
+
+void _raw_read_lock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	if (unlikely(!__raw_read_trylock(&lock->raw_lock)))
+		__read_lock_debug(lock);
+}
+
+int _raw_read_trylock(rwlock_t *lock)
+{
+	int ret = __raw_read_trylock(&lock->raw_lock);
+
+#ifndef CONFIG_SMP
+	/*
+	 * Must not happen on UP:
+	 */
+	RWLOCK_BUG_ON(!ret, lock, "trylock failure on UP");
+#endif
+	return ret;
+}
+
+void _raw_read_unlock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	__raw_read_unlock(&lock->raw_lock);
+}
+
+static inline void debug_write_lock_before(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
+	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+							lock, "cpu recursion");
+}
+
+static inline void debug_write_lock_after(rwlock_t *lock)
+{
+	lock->owner_cpu = raw_smp_processor_id();
+	lock->owner = current;
+}
+
+static inline void debug_write_unlock(rwlock_t *lock)
+{
+	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
+	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
+	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
+							lock, "wrong CPU");
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+}
+
+static void __write_lock_debug(rwlock_t *lock)
+{
+	int print_once = 1;
+	u64 i;
+
+	for (;;) {
+		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+			cpu_relax();
+			if (__raw_write_trylock(&lock->raw_lock))
+				return;
+		}
+		/* lockup suspected: */
+		if (print_once) {
+			print_once = 0;
+			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
+				smp_processor_id(), current->comm, current->pid,
+					lock);
+			dump_stack();
+		}
+	}
+}
+
+void _raw_write_lock(rwlock_t *lock)
+{
+	debug_write_lock_before(lock);
+	if (unlikely(!__raw_write_trylock(&lock->raw_lock)))
+		__write_lock_debug(lock);
+	debug_write_lock_after(lock);
+}
+
+int _raw_write_trylock(rwlock_t *lock)
+{
+	int ret = __raw_write_trylock(&lock->raw_lock);
+
+	if (ret)
+		debug_write_lock_after(lock);
+#ifndef CONFIG_SMP
+	/*
+	 * Must not happen on UP:
+	 */
+	RWLOCK_BUG_ON(!ret, lock, "trylock failure on UP");
+#endif
+	return ret;
+}
+
+void _raw_write_unlock(rwlock_t *lock)
+{
+	debug_write_unlock(lock);
+	__raw_write_unlock(&lock->raw_lock);
+}
_
