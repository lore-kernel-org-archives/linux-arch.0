Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267487AbUIJPTS@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64962 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S267482AbUIJPTM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Sep 2004 11:19:12 -0400
Date: Fri, 10 Sep 2004 17:19:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] cleanup: move call to update_process_times.
Message-ID: <20040910151900.GA3645@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[PATCH] cleanup: remove unused definitions from timex.h.

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

diff -urN linux-2.6/include/asm-arm/arch-lh7a40x/timex.h linux-2.6-patched/include/asm-arm/arch-lh7a40x/timex.h
--- linux-2.6/include/asm-arm/arch-lh7a40x/timex.h	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/arch-lh7a40x/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -14,5 +14,4 @@
 
 /*
 #define CLOCK_TICK_RATE		3686400
-#define CLOCK_TICK_FACTOR	80
 */
diff -urN linux-2.6/include/asm-arm/arch-sa1100/timex.h linux-2.6-patched/include/asm-arm/arch-sa1100/timex.h
--- linux-2.6/include/asm-arm/arch-sa1100/timex.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/arch-sa1100/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -10,4 +10,3 @@
  * SA1100 timer
  */
 #define CLOCK_TICK_RATE		3686400
-#define CLOCK_TICK_FACTOR	80
diff -urN linux-2.6/include/asm-h8300/timex.h linux-2.6-patched/include/asm-h8300/timex.h
--- linux-2.6/include/asm-h8300/timex.h	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-patched/include/asm-h8300/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -7,10 +7,6 @@
 #define _ASM_H8300_TIMEX_H
 
 #define CLOCK_TICK_RATE CONFIG_CPU_CLOCK*1000/8192 /* Timer input freq. */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 extern short h8300_timer_count;
diff -urN linux-2.6/include/asm-i386/timex.h linux-2.6-patched/include/asm-i386/timex.h
--- linux-2.6/include/asm-i386/timex.h	2004-09-10 17:02:31.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -15,10 +15,6 @@
 #  define CLOCK_TICK_RATE 1193182 /* Underlying HZ */
 #endif
 
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /*
  * Standard way to access the cycle counter on i586+ CPUs.
diff -urN linux-2.6/include/asm-m68k/timex.h linux-2.6-patched/include/asm-m68k/timex.h
--- linux-2.6/include/asm-m68k/timex.h	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6-patched/include/asm-m68k/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -7,10 +7,6 @@
 #define _ASMm68k_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6/include/asm-ppc/timex.h linux-2.6-patched/include/asm-ppc/timex.h
--- linux-2.6/include/asm-ppc/timex.h	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-patched/include/asm-ppc/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -11,10 +11,6 @@
 #include <asm/cputable.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6/include/asm-ppc64/timex.h linux-2.6-patched/include/asm-ppc64/timex.h
--- linux-2.6/include/asm-ppc64/timex.h	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6-patched/include/asm-ppc64/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -12,10 +12,6 @@
 #define _ASMPPC64_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6/include/asm-s390/timex.h linux-2.6-patched/include/asm-s390/timex.h
--- linux-2.6/include/asm-s390/timex.h	2004-08-14 12:54:47.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -12,10 +12,6 @@
 #define _ASM_S390_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
diff -urN linux-2.6/include/asm-sh/timex.h linux-2.6-patched/include/asm-sh/timex.h
--- linux-2.6/include/asm-sh/timex.h	2004-08-14 12:54:46.000000000 +0200
+++ linux-2.6-patched/include/asm-sh/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -7,10 +7,6 @@
 #define __ASM_SH_TIMEX_H
 
 #define CLOCK_TICK_RATE		(CONFIG_SH_PCLK_FREQ / 4) /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
diff -urN linux-2.6/include/asm-sparc/timex.h linux-2.6-patched/include/asm-sparc/timex.h
--- linux-2.6/include/asm-sparc/timex.h	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -7,10 +7,6 @@
 #define _ASMsparc_TIMEX_H
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /* XXX Maybe do something better at some point... -DaveM */
 typedef unsigned long cycles_t;
diff -urN linux-2.6/include/asm-sparc64/timex.h linux-2.6-patched/include/asm-sparc64/timex.h
--- linux-2.6/include/asm-sparc64/timex.h	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -9,10 +9,6 @@
 #include <asm/timer.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /* Getting on the cycle counter on sparc64. */
 typedef unsigned long cycles_t;
diff -urN linux-2.6/include/asm-v850/timex.h linux-2.6-patched/include/asm-v850/timex.h
--- linux-2.6/include/asm-v850/timex.h	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6-patched/include/asm-v850/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -7,10 +7,6 @@
 #define __V850_TIMEX_H__
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long cycles_t;
 
diff -urN linux-2.6/include/asm-x86_64/timex.h linux-2.6-patched/include/asm-x86_64/timex.h
--- linux-2.6/include/asm-x86_64/timex.h	2004-08-14 12:55:33.000000000 +0200
+++ linux-2.6-patched/include/asm-x86_64/timex.h	2004-09-10 17:02:52.000000000 +0200
@@ -13,10 +13,6 @@
 #include <asm/hpet.h>
 
 #define CLOCK_TICK_RATE	PIT_TICK_RATE	/* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((int)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-	(1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 typedef unsigned long long cycles_t;
 
