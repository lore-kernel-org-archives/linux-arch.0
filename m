Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262180AbUJZCPX@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:19671 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262146AbUJZCLJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2004 22:11:09 -0400
Subject: [RFC] Add NO_IRQ to all architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 12:08:11 +1000
Message-Id: <1098756491.17886.18.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Hi !

Here'd a patch adding a definition of NO_IRQ to all archs include/asm-*/irq.h.

This patch currently defines it to (-1) for all archs. IRQ numbers are randomly
stored in int's, unsigned int's, or all sort of things all over the kernel, but
that shouldn't be a problem in most cases. NO_IRQ is mostly to be used within a
given driver, to identify a device for which it has no IRQ assigned. This
concerns relatively few drivers, like 8250 or IDE.

At this point, I do _not_ intend to fix the probe_irq_*() API to return NO_IRQ
instead of 0, that could be done in a second step (or x86 NO_IRQ could simply
be defined to be 0 ...), but I will fix IDE in a subsequent patch.

It would be nice though if things could slowly get fixed to deal with it in a
better way.

Index: linux-work/include/asm-ppc/irq.h
===================================================================
--- linux-work.orig/include/asm-ppc/irq.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-ppc/irq.h	2004-10-26 11:59:09.490440560 +1000
@@ -6,6 +6,8 @@
 #include <asm/machdep.h>		/* ppc_md */
 #include <asm/atomic.h>
 
+#define NO_IRQ		(-1)
+
 /*
  * These constants are used for passing information about interrupt
  * signal polarity and level/edge sensing to the low-level PIC chip
Index: linux-work/include/asm-sparc64/irq.h
===================================================================
--- linux-work.orig/include/asm-sparc64/irq.h	2004-09-24 14:36:19.000000000 +1000
+++ linux-work/include/asm-sparc64/irq.h	2004-10-26 12:01:31.954782688 +1000
@@ -16,6 +16,9 @@
 #include <asm/pil.h>
 #include <asm/ptrace.h>
 
+
+#define NO_IRQ		(-1)
+
 /* You should not mess with this directly. That's the job of irq.c.
  *
  * If you make changes here, please update hand coded assembler of
Index: linux-work/include/asm-m68k/irq.h
===================================================================
--- linux-work.orig/include/asm-m68k/irq.h	2004-09-24 14:36:00.000000000 +1000
+++ linux-work/include/asm-m68k/irq.h	2004-10-26 11:57:00.807003416 +1000
@@ -10,6 +10,8 @@
 
 #define SYS_IRQS 8
 
+#define NO_IRQ		(-1)
+
 /*
  * This should be the same as the max(NUM_X_SOURCES) for all the
  * different m68k hosts compiled into the kernel.
Index: linux-work/include/asm-sparc/irq.h
===================================================================
--- linux-work.orig/include/asm-sparc/irq.h	2004-09-24 14:36:16.000000000 +1000
+++ linux-work/include/asm-sparc/irq.h	2004-10-26 12:01:19.987601976 +1000
@@ -15,6 +15,8 @@
 #include <asm/system.h>     /* For SUN4M_NCPUS */
 #include <asm/btfixup.h>
 
+#define NO_IRQ		(-1)
+
 #define __irq_ino(irq) irq
 #define __irq_pil(irq) irq
 BTFIXUPDEF_CALL(char *, __irq_itoa, unsigned int)
Index: linux-work/include/asm-mips/irq.h
===================================================================
--- linux-work.orig/include/asm-mips/irq.h	2004-09-24 14:36:04.000000000 +1000
+++ linux-work/include/asm-mips/irq.h	2004-10-26 11:58:04.241359928 +1000
@@ -13,6 +13,8 @@
 #include <linux/linkage.h>
 #include <irq.h>
 
+#define NO_IRQ		(-1)
+
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
Index: linux-work/include/asm-s390/irq.h
===================================================================
--- linux-work.orig/include/asm-s390/irq.h	2004-09-24 14:36:15.000000000 +1000
+++ linux-work/include/asm-s390/irq.h	2004-10-26 12:00:05.727891168 +1000
@@ -4,6 +4,8 @@
 #ifdef __KERNEL__
 #include <linux/hardirq.h>
 
+#define NO_IRQ		(-1)
+
 /*
  * the definition of irqs has changed in 2.5.46:
  * NR_IRQS is no longer the number of i/o
Index: linux-work/include/asm-cris/irq.h
===================================================================
--- linux-work.orig/include/asm-cris/irq.h	2004-09-24 14:35:38.000000000 +1000
+++ linux-work/include/asm-cris/irq.h	2004-10-26 11:52:19.446776672 +1000
@@ -3,6 +3,8 @@
 
 #include <asm/arch/irq.h>
 
+#define NO_IRQ		(-1)
+
 extern __inline__ int irq_canonicalize(int irq)
 {  
   return irq; 
Index: linux-work/include/asm-v850/irq.h
===================================================================
--- linux-work.orig/include/asm-v850/irq.h	2004-09-24 14:36:24.000000000 +1000
+++ linux-work/include/asm-v850/irq.h	2004-10-26 12:02:11.338795408 +1000
@@ -16,6 +16,8 @@
 
 #include <asm/machdep.h>
 
+#define NO_IRQ		(-1)
+
 /* Default NUM_MACH_IRQS.  */
 #ifndef NUM_MACH_IRQS
 #define NUM_MACH_IRQS	NUM_CPU_IRQS
Index: linux-work/include/asm-m68knommu/irq.h
===================================================================
--- linux-work.orig/include/asm-m68knommu/irq.h	2004-09-24 14:36:01.000000000 +1000
+++ linux-work/include/asm-m68knommu/irq.h	2004-10-26 11:57:29.145695280 +1000
@@ -5,6 +5,8 @@
 #include <linux/interrupt.h>
 #include <asm/ptrace.h>
 
+#define NO_IRQ		(-1)
+
 #ifdef CONFIG_COLDFIRE
 /*
  * On the ColdFire we keep track of all vectors. That way drivers
Index: linux-work/include/asm-alpha/irq.h
===================================================================
--- linux-work.orig/include/asm-alpha/irq.h	2004-09-24 14:35:29.000000000 +1000
+++ linux-work/include/asm-alpha/irq.h	2004-10-26 11:51:03.978249632 +1000
@@ -10,6 +10,8 @@
 #include <linux/linkage.h>
 #include <linux/config.h>
 
+#define NO_IRQ		(-1)
+
 #if   defined(CONFIG_ALPHA_GENERIC)
 
 /* Here NR_IRQS is not exact, but rather an upper bound.  This is used
Index: linux-work/include/asm-sh/irq.h
===================================================================
--- linux-work.orig/include/asm-sh/irq.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-sh/irq.h	2004-10-26 12:00:42.009375544 +1000
@@ -15,6 +15,8 @@
 #include <asm/machvec.h>
 #include <asm/ptrace.h>		/* for pt_regs */
 
+#define NO_IRQ		(-1)
+
 #if defined(CONFIG_SH_HP600) || \
     defined(CONFIG_SH_RTS7751R2D) || \
     defined(CONFIG_SH_HS7751RVOIP)
Index: linux-work/include/asm-ia64/irq.h
===================================================================
--- linux-work.orig/include/asm-ia64/irq.h	2004-09-24 14:35:55.000000000 +1000
+++ linux-work/include/asm-ia64/irq.h	2004-10-26 11:55:58.289507520 +1000
@@ -13,6 +13,7 @@
 
 #define NR_IRQS		256
 #define NR_IRQ_VECTORS	NR_IRQS
+#define	NO_IRQ		(-1)
 
 static __inline__ int
 irq_canonicalize (int irq)
Index: linux-work/include/asm-i386/irq.h
===================================================================
--- linux-work.orig/include/asm-i386/irq.h	2004-10-20 13:01:03.000000000 +1000
+++ linux-work/include/asm-i386/irq.h	2004-10-26 11:55:10.888713536 +1000
@@ -16,6 +16,8 @@
 #include "irq_vectors.h"
 #include <asm/thread_info.h>
 
+#define NO_IRQ		(-1)
+
 static __inline__ int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
Index: linux-work/include/asm-parisc/irq.h
===================================================================
--- linux-work.orig/include/asm-parisc/irq.h	2004-09-24 14:36:10.000000000 +1000
+++ linux-work/include/asm-parisc/irq.h	2004-10-26 11:58:43.460397728 +1000
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/config.h>
 
+#define NO_IRQ		(-1)
 
 #define CPU_IRQ_REGION		1
 #define TIMER_IRQ		(IRQ_FROM_REGION(CPU_IRQ_REGION) | 0)
Index: linux-work/include/asm-x86_64/irq.h
===================================================================
--- linux-work.orig/include/asm-x86_64/irq.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-x86_64/irq.h	2004-10-26 12:02:29.283067464 +1000
@@ -10,6 +10,8 @@
  *	<tomsoft@informatik.tu-chemnitz.de>
  */
 
+#define NO_IRQ		(-1)
+
 #define TIMER_IRQ 0
 
 /*
Index: linux-work/include/asm-sh64/irq.h
===================================================================
--- linux-work.orig/include/asm-sh64/irq.h	2004-09-24 14:36:16.000000000 +1000
+++ linux-work/include/asm-sh64/irq.h	2004-10-26 12:00:54.527472504 +1000
@@ -14,6 +14,8 @@
 
 #include <linux/config.h>
 
+#define NO_IRQ		(-1)
+
 /*
  * Encoded IRQs are not considered worth to be supported.
  * Main reason is that there's no per-encoded-interrupt
Index: linux-work/include/asm-m32r/irq.h
===================================================================
--- linux-work.orig/include/asm-m32r/irq.h	2004-09-24 14:35:57.000000000 +1000
+++ linux-work/include/asm-m32r/irq.h	2004-10-26 11:56:27.109126272 +1000
@@ -5,6 +5,8 @@
 
 #include <linux/config.h>
 
+#define NO_IRQ		(-1)
+
 #if defined(CONFIG_PLAT_M32700UT_Alpha) || defined(CONFIG_PLAT_USRV)
 /*
  * IRQ definitions for M32700UT
Index: linux-work/include/asm-h8300/irq.h
===================================================================
--- linux-work.orig/include/asm-h8300/irq.h	2004-09-24 14:35:39.000000000 +1000
+++ linux-work/include/asm-h8300/irq.h	2004-10-26 11:53:21.670317256 +1000
@@ -3,6 +3,8 @@
 
 #include <asm/ptrace.h>
 
+#define NO_IRQ		(-1)
+
 #if defined(__H8300H__)
 #define NR_IRQS 64
 #define EXT_IRQ0 12
