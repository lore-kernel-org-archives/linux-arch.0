Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266555AbUHMSO4@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:37335 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266545AbUHMSO4
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 14:14:56 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id i7DIEs69119194
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 18:14:54 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i7DIEscL066080
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:14:54 +0200
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1BvgaM-0000Uy-00
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:15:26 +0200
Date: Fri, 13 Aug 2004 20:15:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] cputime (2/7): remove unused definitions from timex.h.
Message-ID: <20040813181526.GC1862@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[PATCH] cputime (2/7): remove unused definitions from timex.h.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The CLOCK_TICK_FACTOR and FINETUNE defines from <asm/timex.h>
are not used anywhere. Kill them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-arm/arch-lh7a40x/timex.h |    1 -
 include/asm-arm/arch-sa1100/timex.h  |    1 -
 include/asm-h8300/timex.h            |    4 ----
 include/asm-i386/timex.h             |    4 ----
 include/asm-m68k/timex.h             |    4 ----
 include/asm-ppc/timex.h              |    4 ----
 include/asm-ppc64/timex.h            |    4 ----
 include/asm-s390/timex.h             |    4 ----
 include/asm-sh/timex.h               |    4 ----
 include/asm-sparc/timex.h            |    4 ----
 include/asm-sparc64/timex.h          |    4 ----
 include/asm-v850/timex.h             |    4 ----
 include/asm-x86_64/timex.h           |    4 ----
 13 files changed, 46 deletions(-)

diff -urN linux-2.6.8-rc4/include/asm-arm/arch-lh7a40x/timex.h linux-2.6.8-cputime/include/asm-arm/arch-lh7a40x/timex.h
--- linux-2.6.8-rc4/include/asm-arm/arch-lh7a40x/timex.h	Wed Jun 16 07:18:55 2004
+++ linux-2.6.8-cputime/include/asm-arm/arch-lh7a40x/timex.h	Fri Aug 13 19:05:27 2004
@@ -14,5 +14,4 @@
 
 /*
 #define CLOCK_TICK_RATE		3686400
-#define CLOCK_TICK_FACTOR	80
 */
diff -urN linux-2.6.8-rc4/include/asm-arm/arch-sa1100/timex.h linux-2.6.8-cputime/include/asm-arm/arch-sa1100/timex.h
--- linux-2.6.8-rc4/include/asm-arm/arch-sa1100/timex.h	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-cputime/include/asm-arm/arch-sa1100/timex.h	Fri Aug 13 19:05:27 2004
@@ -10,4 +10,3 @@
  * SA1100 timer
  */
 #define CLOCK_TICK_RATE		3686400
-#define CLOCK_TICK_FACTOR	80
diff -urN linux-2.6.8-rc4/include/asm-h8300/timex.h linux-2.6.8-cputime/include/asm-h8300/timex.h
--- linux-2.6.8-rc4/include/asm-h8300/timex.h	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-cputime/include/asm-h8300/timex.h	Fri Aug 13 19:05:27 2004
@@ -7,10 +7,6 @@
 #define _ASM_H8300_TIMEX_H
 
 #define CLOCK_TICK_RATE CONFIG_CPU_CLOCK*1000/8192 /* Timer input freq. */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 extern short h8300_timer_count;
diff -urN linux-2.6.8-rc4/include/asm-i386/timex.h linux-2.6.8-cputime/include/asm-i386/timex.h
--- linux-2.6.8-rc4/include/asm-i386/timex.h	Fri Aug 13 19:05:18 2004
+++ linux-2.6.8-cputime/include/asm-i386/timex.h	Fri Aug 13 19:05:27 2004
@@ -15,10 +15,6 @@
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
 
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /*
  * Standard way to access the cycle counter on i586+ CPUs.
diff -urN linux-2.6.8-rc4/include/asm-m68k/timex.h linux-2.6.8-cputime/include/asm-m68k/timex.h
--- linux-2.6.8-rc4/include/asm-m68k/timex.h	Wed Jun 16 07:18:57 2004
+++ linux-2.6.8-cputime/include/asm-m68k/timex.h	Fri Aug 13 19:05:27 2004
@@ -7,10 +7,6 @@
 #define _ASMm68k_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-ppc/timex.h linux-2.6.8-cputime/include/asm-ppc/timex.h
--- linux-2.6.8-rc4/include/asm-ppc/timex.h	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-cputime/include/asm-ppc/timex.h	Fri Aug 13 19:05:27 2004
@@ -11,10 +11,6 @@
 #include <asm/cputable.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-ppc64/timex.h linux-2.6.8-cputime/include/asm-ppc64/timex.h
--- linux-2.6.8-rc4/include/asm-ppc64/timex.h	Wed Jun 16 07:20:26 2004
+++ linux-2.6.8-cputime/include/asm-ppc64/timex.h	Fri Aug 13 19:05:27 2004
@@ -12,10 +12,6 @@
 #define _ASMPPC64_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-s390/timex.h linux-2.6.8-cputime/include/asm-s390/timex.h
--- linux-2.6.8-rc4/include/asm-s390/timex.h	Wed Jun 16 07:18:52 2004
+++ linux-2.6.8-cputime/include/asm-s390/timex.h	Fri Aug 13 19:05:27 2004
@@ -12,10 +12,6 @@
 #define _ASM_S390_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-sh/timex.h linux-2.6.8-cputime/include/asm-sh/timex.h
--- linux-2.6.8-rc4/include/asm-sh/timex.h	Wed Jun 16 07:18:37 2004
+++ linux-2.6.8-cputime/include/asm-sh/timex.h	Fri Aug 13 19:05:27 2004
@@ -7,10 +7,6 @@
 #define __ASM_SH_TIMEX_H
 
 #define CLOCK_TICK_RATE		(CONFIG_SH_PCLK_FREQ / 4) /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-sparc/timex.h linux-2.6.8-cputime/include/asm-sparc/timex.h
--- linux-2.6.8-rc4/include/asm-sparc/timex.h	Wed Jun 16 07:19:42 2004
+++ linux-2.6.8-cputime/include/asm-sparc/timex.h	Fri Aug 13 19:05:27 2004
@@ -7,10 +7,6 @@
 #define _ASMsparc_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /* XXX Maybe do something better at some point... -DaveM */
 typedef unsigned long cycles_t;
diff -urN linux-2.6.8-rc4/include/asm-sparc64/timex.h linux-2.6.8-cputime/include/asm-sparc64/timex.h
--- linux-2.6.8-rc4/include/asm-sparc64/timex.h	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-cputime/include/asm-sparc64/timex.h	Fri Aug 13 19:05:27 2004
@@ -9,10 +9,6 @@
 #include <asm/timer.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /* Getting on the cycle counter on sparc64. */
 typedef unsigned long cycles_t;
diff -urN linux-2.6.8-rc4/include/asm-v850/timex.h linux-2.6.8-cputime/include/asm-v850/timex.h
--- linux-2.6.8-rc4/include/asm-v850/timex.h	Wed Jun 16 07:20:03 2004
+++ linux-2.6.8-cputime/include/asm-v850/timex.h	Fri Aug 13 19:05:27 2004
@@ -7,10 +7,6 @@
 #define __V850_TIMEX_H__
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6.8-rc4/include/asm-x86_64/timex.h linux-2.6.8-cputime/include/asm-x86_64/timex.h
--- linux-2.6.8-rc4/include/asm-x86_64/timex.h	Wed Jun 16 07:19:36 2004
+++ linux-2.6.8-cputime/include/asm-x86_64/timex.h	Fri Aug 13 19:05:27 2004
@@ -13,10 +13,6 @@
 #include <asm/hpet.h>
 
 #define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
