Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.52)
	id 1EExMF-0004uJ-KQ
	for linux-arch@vger.kernel.org; Mon, 12 Sep 2005 16:05:03 -0700
Date: Mon, 12 Sep 2005 16:05:03 -0700 (PDT)
Message-Id: <20050912.160503.93067051.davem@davemloft.net>
Subject: Kill HAVE_DEC_LOCK
From: "David S. Miller" <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I was about to, like several other platforms, copy over the
cmpxchg() _atomic_dec_and_lock() implementation from ppc64,
but then I looked around and noticed how rediculious all of
this duplication is.

So how about we do the following.  If the platform has cmpxchg()
then we use the ppc64 C version, else we use the existing code
in lib/dec_and_lock.c

Here is my analysis of the existing implementations:

1) Alpha - is trying to define a fast path for the case where
   we don't decrement to zero, presumably to avoid setting up
   a full stack frame in that case.

   The memory operations are so much more expensive than whatever
   cycles are being saved here, that considering that and the
   maintainability gains we're getting by this change it is
   an acceptable result.

2) i386/x86_64 - similar to ppc64 C code which is now used except
   that cmpxchg() macro was open coded.  The new generic version
   should end up producing similar if not identical code.

3) ia64 - almost identical to ppc64 C code version, except the
   looping is done slightly differently.  I see no functional
   difference resulting from the new code.

4) mips - used a copy of the ppc64 C code, so no issues

5) ppc - used a copy of the ppc64 C code, so no issues

6) sparc64 - too ugly for words, in hand coded assembler and
   probably buggy, it's what led me to work on this patch

I really think this is the way to go.

Comments?

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -501,11 +501,6 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
-config HAVE_DEC_LOCK
-	bool
-	depends on SMP
-	default y
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
diff --git a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
--- a/arch/alpha/kernel/alpha_ksyms.c
+++ b/arch/alpha/kernel/alpha_ksyms.c
@@ -184,7 +184,6 @@ EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
-EXPORT_SYMBOL(_atomic_dec_and_lock);
 EXPORT_SYMBOL(cpu_present_mask);
 #endif /* CONFIG_SMP */
 
diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -40,8 +40,6 @@ lib-y =	__divqu.o __remqu.o __divlu.o __
 	fpreg.o \
 	callback_srm.o srm_puts.o srm_printk.o
 
-lib-$(CONFIG_SMP) += dec_and_lock.o
-
 # The division routines are built from single source, with different defines.
 AFLAGS___divqu.o = -DDIV
 AFLAGS___remqu.o =       -DREM
diff --git a/arch/alpha/lib/dec_and_lock.c b/arch/alpha/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/alpha/lib/dec_and_lock.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/alpha/lib/dec_and_lock.c
- *
- * ll/sc version of atomic_dec_and_lock()
- * 
- */
-
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-
-  asm (".text					\n\
-	.global _atomic_dec_and_lock		\n\
-	.ent _atomic_dec_and_lock		\n\
-	.align	4				\n\
-_atomic_dec_and_lock:				\n\
-	.prologue 0				\n\
-1:	ldl_l	$1, 0($16)			\n\
-	subl	$1, 1, $1			\n\
-	beq	$1, 2f				\n\
-	stl_c	$1, 0($16)			\n\
-	beq	$1, 4f				\n\
-	mb					\n\
-	clr	$0				\n\
-	ret					\n\
-2:	br	$29, 3f				\n\
-3:	ldgp	$29, 0($29)			\n\
-	br	$atomic_dec_and_lock_1..ng	\n\
-	.subsection 2				\n\
-4:	br	1b				\n\
-	.previous				\n\
-	.end _atomic_dec_and_lock");
-
-static int __attribute_used__
-atomic_dec_and_lock_1(atomic_t *atomic, spinlock_t *lock)
-{
-	/* Slow path */
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -908,11 +908,6 @@ config IRQBALANCE
  	  The default yes will allow the kernel to do irq load balancing.
 	  Saying no will keep the kernel from doing irq load balancing.
 
-config HAVE_DEC_LOCK
-	bool
-	depends on (SMP || PREEMPT) && X86_CMPXCHG
-	default y
-
 # turning this on wastes a bunch of space.
 # Summit needs it only when NUMA is on
 config BOOT_IOREMAP
diff --git a/arch/i386/lib/Makefile b/arch/i386/lib/Makefile
--- a/arch/i386/lib/Makefile
+++ b/arch/i386/lib/Makefile
@@ -7,4 +7,3 @@ lib-y = checksum.o delay.o usercopy.o ge
 	bitops.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
-lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff --git a/arch/i386/lib/dec_and_lock.c b/arch/i386/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/i386/lib/dec_and_lock.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * x86 version of "atomic_dec_and_lock()" using
- * the atomic "cmpxchg" instruction.
- *
- * (For CPU's lacking cmpxchg, we use the slow
- * generic version, and this one never even gets
- * compiled).
- */
-
-#include <linux/spinlock.h>
-#include <linux/module.h>
-#include <asm/atomic.h>
-
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-repeat:
-	counter = atomic_read(atomic);
-	newcount = counter-1;
-
-	if (!newcount)
-		goto slow_path;
-
-	asm volatile("lock; cmpxchgl %1,%2"
-		:"=a" (newcount)
-		:"r" (newcount), "m" (atomic->counter), "0" (counter));
-
-	/* If the above failed, "eax" will have changed */
-	if (newcount != counter)
-		goto repeat;
-	return 0;
-
-slow_path:
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -298,11 +298,6 @@ config PREEMPT
 
 source "mm/Kconfig"
 
-config HAVE_DEC_LOCK
-	bool
-	depends on (SMP || PREEMPT)
-	default y
-
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help
diff --git a/arch/ia64/lib/Makefile b/arch/ia64/lib/Makefile
--- a/arch/ia64/lib/Makefile
+++ b/arch/ia64/lib/Makefile
@@ -15,7 +15,6 @@ lib-$(CONFIG_ITANIUM)	+= copy_page.o cop
 lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.o memcpy_mck.o
 lib-$(CONFIG_PERFMON)	+= carta_random.o
 lib-$(CONFIG_MD_RAID5)	+= xor.o
-lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 
 AFLAGS___divdi3.o	=
 AFLAGS___udivdi3.o	= -DUNSIGNED
diff --git a/arch/ia64/lib/dec_and_lock.c b/arch/ia64/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/ia64/lib/dec_and_lock.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2003 Jerome Marchand, Bull S.A.
- *	Cleaned up by David Mosberger-Tang <davidm@hpl.hp.com>
- *
- * This file is released under the GPLv2, or at your option any later version.
- *
- * ia64 version of "atomic_dec_and_lock()" using the atomic "cmpxchg" instruction.  This
- * code is an adaptation of the x86 version of "atomic_dec_and_lock()".
- */
-
-#include <linux/compiler.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-
-/*
- * Decrement REFCOUNT and if the count reaches zero, acquire the spinlock.  Both of these
- * operations have to be done atomically, so that the count doesn't drop to zero without
- * acquiring the spinlock first.
- */
-int
-_atomic_dec_and_lock (atomic_t *refcount, spinlock_t *lock)
-{
-	int old, new;
-
-	do {
-		old = atomic_read(refcount);
-		new = old - 1;
-
-		if (unlikely (old == 1)) {
-			/* oops, we may be decrementing to zero, do it the slow way... */
-			spin_lock(lock);
-			if (atomic_dec_and_test(refcount))
-				return 1;
-			spin_unlock(lock);
-			return 0;
-		}
-	} while (cmpxchg(&refcount->counter, old, new) != old);
-	return 0;
-}
-
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -220,11 +220,6 @@ config PREEMPT
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
-config HAVE_DEC_LOCK
-	bool
-	depends on (SMP || PREEMPT)
-	default n
-
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1009,10 +1009,6 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
-config HAVE_DEC_LOCK
-	bool
-	default y
-
 #
 # Select some configuration options automatically based on user selections.
 #
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial_copy.o dec_and_lock.o memcpy.o promlib.o \
+lib-y	+= csum_partial_copy.o memcpy.o promlib.o \
 	   strlen_user.o strncpy_user.o strnlen_user.o
 
 obj-y	+= iomap.o
diff --git a/arch/mips/lib/dec_and_lock.c b/arch/mips/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/mips/lib/dec_and_lock.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * MIPS version of atomic_dec_and_lock() using cmpxchg
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * This is an implementation of the notion of "decrement a
- * reference count, and return locked if it decremented to zero".
- *
- * This implementation can be used on any architecture that
- * has a cmpxchg, and where atomic->value is an int holding
- * the value of the atomic (i.e. the high bits aren't used
- * for a lock or anything like that).
- */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-	for (;;) {
-		counter = atomic_read(atomic);
-		newcount = counter - 1;
-		if (!newcount)
-			break;		/* do it the slow way */
-
-		newcount = cmpxchg(&atomic->counter, counter, newcount);
-		if (newcount == counter)
-			return 0;
-	}
-
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -26,10 +26,6 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
-config HAVE_DEC_LOCK
-	bool
-	default y
-
 config PPC
 	bool
 	default y
diff --git a/arch/ppc/lib/Makefile b/arch/ppc/lib/Makefile
--- a/arch/ppc/lib/Makefile
+++ b/arch/ppc/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for ppc-specific library files..
 #
 
-obj-y			:= checksum.o string.o strcase.o dec_and_lock.o div64.o
+obj-y			:= checksum.o string.o strcase.o div64.o
 
 obj-$(CONFIG_8xx)	+= rheap.o
 obj-$(CONFIG_CPM2)	+= rheap.o
diff --git a/arch/ppc/lib/dec_and_lock.c b/arch/ppc/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/ppc/lib/dec_and_lock.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * This is an implementation of the notion of "decrement a
- * reference count, and return locked if it decremented to zero".
- *
- * This implementation can be used on any architecture that
- * has a cmpxchg, and where atomic->value is an int holding
- * the value of the atomic (i.e. the high bits aren't used
- * for a lock or anything like that).
- */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-	for (;;) {
-		counter = atomic_read(atomic);
-		newcount = counter - 1;
-		if (!newcount)
-			break;		/* do it the slow way */
-
-		newcount = cmpxchg(&atomic->counter, counter, newcount);
-		if (newcount == counter)
-			return 0;
-	}
-
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig
+++ b/arch/ppc64/Kconfig
@@ -28,10 +28,6 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
-config HAVE_DEC_LOCK
-	bool
-	default y
-
 config EARLY_PRINTK
 	bool
 	default y
diff --git a/arch/ppc64/lib/Makefile b/arch/ppc64/lib/Makefile
--- a/arch/ppc64/lib/Makefile
+++ b/arch/ppc64/lib/Makefile
@@ -2,7 +2,7 @@
 # Makefile for ppc64-specific library files..
 #
 
-lib-y := checksum.o dec_and_lock.o string.o strcase.o
+lib-y := checksum.o string.o strcase.o
 lib-y += copypage.o memcpy.o copyuser.o usercopy.o
 
 # Lock primitives are defined as no-ops in include/linux/spinlock.h
diff --git a/arch/ppc64/lib/dec_and_lock.c b/arch/ppc64/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/ppc64/lib/dec_and_lock.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * ppc64 version of atomic_dec_and_lock() using cmpxchg
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * This is an implementation of the notion of "decrement a
- * reference count, and return locked if it decremented to zero".
- *
- * This implementation can be used on any architecture that
- * has a cmpxchg, and where atomic->value is an int holding
- * the value of the atomic (i.e. the high bits aren't used
- * for a lock or anything like that).
- */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-	for (;;) {
-		counter = atomic_read(atomic);
-		newcount = counter - 1;
-		if (!newcount)
-			break;		/* do it the slow way */
-
-		newcount = cmpxchg(&atomic->counter, counter, newcount);
-		if (newcount == counter)
-			return 0;
-	}
-
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/arch/sparc64/Kconfig.debug b/arch/sparc64/Kconfig.debug
--- a/arch/sparc64/Kconfig.debug
+++ b/arch/sparc64/Kconfig.debug
@@ -33,14 +33,6 @@ config DEBUG_BOOTMEM
 	depends on DEBUG_KERNEL
 	bool "Debug BOOTMEM initialization"
 
-# We have a custom atomic_dec_and_lock() implementation but it's not
-# compatible with spinlock debugging so we need to fall back on
-# the generic version in that case.
-config HAVE_DEC_LOCK
-	bool
-	depends on SMP && !DEBUG_SPINLOCK
-	default y
-
 config MCOUNT
 	bool
 	depends on STACK_DEBUG
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -163,9 +163,6 @@ EXPORT_SYMBOL(atomic64_add);
 EXPORT_SYMBOL(atomic64_add_ret);
 EXPORT_SYMBOL(atomic64_sub);
 EXPORT_SYMBOL(atomic64_sub_ret);
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif
 
 /* Atomic bit operations. */
 EXPORT_SYMBOL(test_and_set_bit);
diff --git a/arch/sparc64/lib/Makefile b/arch/sparc64/lib/Makefile
--- a/arch/sparc64/lib/Makefile
+++ b/arch/sparc64/lib/Makefile
@@ -14,6 +14,4 @@ lib-y := PeeCeeI.o copy_page.o clear_pag
 	 copy_in_user.o user_fixup.o memmove.o \
 	 mcount.o ipcsum.o rwsem.o xor.o find_bit.o delay.o
 
-lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
-
 obj-y += iomap.o
diff --git a/arch/sparc64/lib/dec_and_lock.S b/arch/sparc64/lib/dec_and_lock.S
deleted file mode 100644
--- a/arch/sparc64/lib/dec_and_lock.S
+++ /dev/null
@@ -1,80 +0,0 @@
-/* $Id: dec_and_lock.S,v 1.5 2001/11/18 00:12:56 davem Exp $
- * dec_and_lock.S: Sparc64 version of "atomic_dec_and_lock()"
- *                 using cas and ldstub instructions.
- *
- * Copyright (C) 2000 David S. Miller (davem@redhat.com)
- */
-#include <linux/config.h>
-#include <asm/thread_info.h>
-
-	.text
-	.align	64
-
-	/* CAS basically works like this:
-	 *
-	 * void CAS(MEM, REG1, REG2)
-	 * {
-	 *   START_ATOMIC();
-	 *   if (*(MEM) == REG1) {
-	 *     TMP = *(MEM);
-	 *     *(MEM) = REG2;
-	 *     REG2 = TMP;
-	 *   } else
-	 *     REG2 = *(MEM);
-	 *   END_ATOMIC();
-	 * }
-	 */
-
-	.globl	_atomic_dec_and_lock
-_atomic_dec_and_lock:	/* %o0 = counter, %o1 = lock */
-loop1:	lduw	[%o0], %g2
-	subcc	%g2, 1, %g7
-	be,pn	%icc, start_to_zero
-	 nop
-nzero:	cas	[%o0], %g2, %g7
-	cmp	%g2, %g7
-	bne,pn	%icc, loop1
-	 mov	0, %g1
-
-out:
-	membar	#StoreLoad | #StoreStore
-	retl
-	 mov	%g1, %o0
-start_to_zero:
-#ifdef CONFIG_PREEMPT
-	ldsw	[%g6 + TI_PRE_COUNT], %g3
-	add	%g3, 1, %g3
-	stw	%g3, [%g6 + TI_PRE_COUNT]
-#endif
-to_zero:
-	ldstub	[%o1], %g3
-	membar	#StoreLoad | #StoreStore
-	brnz,pn	%g3, spin_on_lock
-	 nop
-loop2:	cas	[%o0], %g2, %g7		/* ASSERT(g7 == 0) */
-	cmp	%g2, %g7
-
-	be,pt	%icc, out
-	 mov	1, %g1
-	lduw	[%o0], %g2
-	subcc	%g2, 1, %g7
-	be,pn	%icc, loop2
-	 nop
-	membar	#StoreStore | #LoadStore
-	stb	%g0, [%o1]
-#ifdef CONFIG_PREEMPT
-	ldsw	[%g6 + TI_PRE_COUNT], %g3
-	sub	%g3, 1, %g3
-	stw	%g3, [%g6 + TI_PRE_COUNT]
-#endif
-
-	b,pt	%xcc, nzero
-	 nop
-spin_on_lock:
-	ldub	[%o1], %g3
-	membar	#LoadLoad
-	brnz,pt	%g3, spin_on_lock
-	 nop
-	ba,pt	%xcc, to_zero
-	 nop
-	nop
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -277,11 +277,6 @@ source "mm/Kconfig"
 config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 
-config HAVE_DEC_LOCK
-	bool
-	depends on SMP
-	default y
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-256)"
 	range 2 256
diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -178,10 +178,6 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
 
 EXPORT_SYMBOL(empty_zero_page);
 
-#ifdef CONFIG_HAVE_DEC_LOCK
-EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif
-
 EXPORT_SYMBOL(die_chain);
 EXPORT_SYMBOL(register_die_notifier);
 
diff --git a/arch/x86_64/lib/Makefile b/arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile
+++ b/arch/x86_64/lib/Makefile
@@ -10,5 +10,3 @@ lib-y := csum-partial.o csum-copy.o csum
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
 lib-y += memcpy.o memmove.o memset.o copy_user.o
-
-lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff --git a/arch/x86_64/lib/dec_and_lock.c b/arch/x86_64/lib/dec_and_lock.c
deleted file mode 100644
--- a/arch/x86_64/lib/dec_and_lock.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * x86 version of "atomic_dec_and_lock()" using
- * the atomic "cmpxchg" instruction.
- *
- * (For CPU's lacking cmpxchg, we use the slow
- * generic version, and this one never even gets
- * compiled).
- */
-
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-repeat:
-	counter = atomic_read(atomic);
-	newcount = counter-1;
-
-	if (!newcount)
-		goto slow_path;
-
-	asm volatile("lock; cmpxchgl %1,%2"
-		:"=a" (newcount)
-		:"r" (newcount), "m" (atomic->counter), "0" (counter));
-
-	/* If the above failed, "eax" will have changed */
-	if (newcount != counter)
-		goto repeat;
-	return 0;
-
-slow_path:
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -26,10 +26,6 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
-config HAVE_DEC_LOCK
-	bool
-	default y
-
 config GENERIC_HARDIRQS
 	bool
 	default y
diff --git a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o dec_and_lock.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
@@ -24,10 +24,6 @@ lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += f
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
-ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
-  lib-y += dec_and_lock.o
-endif
-
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -1,7 +1,41 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
+#include <asm/system.h>
 
+#ifdef __HAVE_ARCH_CMPXCHG
+/*
+ * This is an implementation of the notion of "decrement a
+ * reference count, and return locked if it decremented to zero".
+ *
+ * This implementation can be used on any architecture that
+ * has a cmpxchg, and where atomic->value is an int holding
+ * the value of the atomic (i.e. the high bits aren't used
+ * for a lock or anything like that).
+ */
+int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	int counter;
+	int newcount;
+
+	for (;;) {
+		counter = atomic_read(atomic);
+		newcount = counter - 1;
+		if (!newcount)
+			break;		/* do it the slow way */
+
+		newcount = cmpxchg(&atomic->counter, counter, newcount);
+		if (newcount == counter)
+			return 0;
+	}
+
+	spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	spin_unlock(lock);
+	return 0;
+}
+#else
 /*
  * This is an architecture-neutral, but slow,
  * implementation of the notion of "decrement
@@ -33,5 +67,6 @@ int _atomic_dec_and_lock(atomic_t *atomi
 	spin_unlock(lock);
 	return 0;
 }
+#endif
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
