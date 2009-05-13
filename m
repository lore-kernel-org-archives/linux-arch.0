From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC] remove bogus CLOCK_TICK_RATE definitions
Date: Wed, 13 May 2009 15:48:14 +0200
Message-ID: <200905131548.14883.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:58487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZEMNsa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2009 09:48:30 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>

After my previous patches to convert users of CLOCK_TICK_RATE
to ARM_TICK_RATE or PIT_TICK_RATE, the only remaining user
is ACT_HZ in linux/jiffies.h.

This makes the definition of CLOCK_TICK_RATE optional
and removes it from all architectures that were using
an incorrect definition.

avr32 and ia64 have values that are entirely fabricated
in order to avoid having to define a correct rate.

frv, m68k, mips, mn10300, parisc, s390, sparc, sparc64
and xtensa were all using the PIT tick rate of
1193182 HZ despite normally not basing their timer
tick off an i8253 timer. This was correct for most
other uses in the kernel, but caused a slightly
incorrect ACTHZ value, possibly leading to clock
drift.

The remaining users seem to be correct in the sense
that the CLOCK_TICK_RATE they define is in some way
related to the actual interval timer they use for
clock ticks:

alpha:#define CLOCK_TICK_RATE  32768
arm:#define CLOCK_TICK_RATE ARM_TICK_RATE
blackfin:#define CLOCK_TICK_RATE       1000000
cris/arch-v10:#define CLOCK_TICK_RATE 25000
cris/arch-v32:#define CLOCK_TICK_RATE 100000000
h8300:#define CLOCK_TICK_RATE (CONFIG_CPU_CLOCK*1000/8192)
m32r:#define CLOCK_TICK_RATE (CONFIG_BUS_CLOCK / CONFIG_TIMER_DIVIDE)
powerpc:#define CLOCK_TICK_RATE        1024000
sh:#define CLOCK_TICK_RATE (CONFIG_SH_PCLK_FREQ / 4)
um:#define CLOCK_TICK_RATE (HZ)
x86:#define CLOCK_TICK_RATE PIT_TICK_RATE

PowerPC actually has a number of different time base values
per architecture, but maybe 1024000 is a common divisor for
all of them. Blackfin looks fabricated, but could be correct.

On x86, there is a choice between various time sources,
so using PIT_TICK_RATE may no longer be the best option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/jiffies.h           |    4 ++++
 arch/avr32/include/asm/timex.h    |   19 -------------------
 arch/frv/include/asm/timex.h      |    3 ---
 arch/ia64/include/asm/timex.h     |   18 ------------------
 arch/m32r/include/asm/timex.h     |    1 -
 arch/m68k/include/asm/timex.h     |    2 --
 arch/mips/include/asm/timex.h     |    8 --------
 arch/mn10300/include/asm/timex.h  |    3 ---
 arch/parisc/include/asm/timex.h   |    2 --
 arch/s390/include/asm/timex.h     |    2 --
 arch/sparc/include/asm/timex_32.h |    2 --
 arch/sparc/include/asm/timex_64.h |    2 --
 arch/xtensa/include/asm/timex.h   |    3 ---
 14 files changed, 6 insertions(+), 74 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1a9cf78..faa6fdb 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -55,7 +55,11 @@
                              + ((((NOM) % (DEN)) << (LSH)) + (DEN) / 2) / (DEN))
 
 /* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for accuracy) */
+#ifdef CLOCK_TICK_RATE
 #define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
+#else
+#define ACTHZ (HZ << 8)
+#endif
 
 /* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ */
 #define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))
diff --git a/arch/avr32/include/asm/timex.h b/arch/avr32/include/asm/timex.h
index 187dcf3..c51e6ee 100644
--- a/arch/avr32/include/asm/timex.h
+++ b/arch/avr32/include/asm/timex.h
@@ -8,25 +8,6 @@
 #ifndef __ASM_AVR32_TIMEX_H
 #define __ASM_AVR32_TIMEX_H
 
-/*
- * This is the frequency of the timer used for Linux's timer interrupt.
- * The value should be defined as accurate as possible or under certain
- * circumstances Linux timekeeping might become inaccurate or fail.
- *
- * For many system the exact clockrate of the timer isn't known but due to
- * the way this value is used we can get away with a wrong value as long
- * as this value is:
- *
- *  - a multiple of HZ
- *  - a divisor of the actual rate
- *
- * 500000 is a good such cheat value.
- *
- * The obscure number 1193182 is the same as used by the original i8254
- * time in legacy PC hardware; the chip is never found in AVR32 systems.
- */
-#define CLOCK_TICK_RATE		500000	/* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles (void)
diff --git a/arch/frv/include/asm/timex.h b/arch/frv/include/asm/timex.h
index a89bdde..42d5f8e 100644
--- a/arch/frv/include/asm/timex.h
+++ b/arch/frv/include/asm/timex.h
@@ -3,9 +3,6 @@
 #ifndef _ASM_TIMEX_H
 #define _ASM_TIMEX_H
 
-#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
diff --git a/arch/ia64/include/asm/timex.h b/arch/ia64/include/asm/timex.h
index 86c7db8..876d465 100644
--- a/arch/ia64/include/asm/timex.h
+++ b/arch/ia64/include/asm/timex.h
@@ -5,11 +5,6 @@
  * Copyright (C) 1998-2001, 2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
-/*
- * 2001/01/18 davidm	Removed CLOCK_TICK_RATE.  It makes no sense on IA-64.
- *			Also removed cacheflush_time as it's entirely unused.
- */
-
 #include <asm/intrinsics.h>
 #include <asm/processor.h>
 
@@ -17,19 +12,6 @@ typedef unsigned long cycles_t;
 
 extern void (*ia64_udelay)(unsigned long usecs);
 
-/*
- * For performance reasons, we don't want to define CLOCK_TICK_TRATE as
- * local_cpu_data->itc_rate.  Fortunately, we don't have to, either: according to George
- * Anzinger, 1/CLOCK_TICK_RATE is taken as the resolution of the timer clock.  The time
- * calculation assumes that you will use enough of these so that your tick size <= 1/HZ.
- * If the calculation shows that your CLOCK_TICK_RATE can not supply exactly 1/HZ ticks,
- * the actual value is calculated and used to update the wall clock each jiffie.  Setting
- * the CLOCK_TICK_RATE to x*HZ insures that the calculation will find no errors.  Hence we
- * pick a multiple of HZ which gives us a (totally virtual) CLOCK_TICK_RATE of about
- * 100MHz.
- */
-#define CLOCK_TICK_RATE		(HZ * 100000UL)
-
 static inline cycles_t
 get_cycles (void)
 {
diff --git a/arch/m32r/include/asm/timex.h b/arch/m32r/include/asm/timex.h
index bb9fe4f..8bdc405 100644
--- a/arch/m32r/include/asm/timex.h
+++ b/arch/m32r/include/asm/timex.h
@@ -8,7 +8,6 @@
  */
 
 #define CLOCK_TICK_RATE	(CONFIG_BUS_CLOCK / CONFIG_TIMER_DIVIDE)
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 
 #ifdef __KERNEL__
 /*
diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
index b87f2f2..d020183 100644
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -6,8 +6,6 @@
 #ifndef _ASMm68k_TIMEX_H
 #define _ASMm68k_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index 6529704..9b6ba38 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -13,14 +13,6 @@
 #include <asm/mipsregs.h>
 
 /*
- * This is the clock rate of the i8253 PIT.  A MIPS system may not have
- * a PIT by the symbol is used all over the kernel including some APIs.
- * So keeping it defined to the number for the PIT is the only sane thing
- * for now.
- */
-#define CLOCK_TICK_RATE 1193182
-
-/*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
  *
diff --git a/arch/mn10300/include/asm/timex.h b/arch/mn10300/include/asm/timex.h
index 8d031f9..2e356d7 100644
--- a/arch/mn10300/include/asm/timex.h
+++ b/arch/mn10300/include/asm/timex.h
@@ -16,9 +16,6 @@
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-#define CLOCK_TICK_RATE 1193180 /* Underlying HZ - this should probably be set
-				 * to something appropriate, but what? */
-
 extern cycles_t cacheflush_time;
 
 #ifdef __KERNEL__
diff --git a/arch/parisc/include/asm/timex.h b/arch/parisc/include/asm/timex.h
index 3b68d77..eab4289 100644
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -8,8 +8,6 @@
 
 #include <asm/system.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles (void)
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index cc21e3e..b30e2fc 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -49,8 +49,6 @@ static inline void store_clock_comparator(__u64 *time)
 	asm volatile("stckc 0(%1)" : "=m" (*time) : "a" (time));
 }
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 typedef unsigned long long cycles_t;
 
 static inline unsigned long long get_clock (void)
diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/timex_32.h
index b6ccdb0..230a6bd 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -6,8 +6,6 @@
 #ifndef _ASMsparc_TIMEX_H
 #define _ASMsparc_TIMEX_H
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 /* XXX Maybe do something better at some point... -DaveM */
 typedef unsigned long cycles_t;
 #define get_cycles()	(0)
diff --git a/arch/sparc/include/asm/timex_64.h b/arch/sparc/include/asm/timex_64.h
index 18b30bc..15c6c5a 100644
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -8,8 +8,6 @@
 
 #include <asm/timer.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 /* Getting on the cycle counter on sparc64. */
 typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
diff --git a/arch/xtensa/include/asm/timex.h b/arch/xtensa/include/asm/timex.h
index b83a818..990ebfe 100644
--- a/arch/xtensa/include/asm/timex.h
+++ b/arch/xtensa/include/asm/timex.h
@@ -34,9 +34,6 @@
 
 #define LINUX_TIMER_MASK        (1L << LINUX_TIMER_INT)
 
-#define CLOCK_TICK_RATE 	1193180	/* (everyone is using this value) */
-#define CLOCK_TICK_FACTOR       20 /* Factor of both 10^6 and CLOCK_TICK_RATE */
-
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 extern unsigned long ccount_per_jiffy;
 extern unsigned long ccount_nsec;
-- 
1.5.6.3
