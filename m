From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/8] kernel: move arches that use the generic_le/be helpers
Date: Thu, 10 Apr 2008 12:44:08 -0700
Message-ID: <1207856648.22001.28.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org" <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, wli <wli-tGiaVUSOoeej7qYf8Sx8sA@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony.luck" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Roman Zippel <zippel-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>

Generic le:
alpha, blackfin, ia64,

Generic be:
parisc, sparc, sparc64

Chooses endianness based on compiler settings, either generic_le or be:
mips, sh

m86knommu is generic_be for Coldfire, otherwise unaligned access is ok.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-alpha/unaligned.h     |    2 +-
 include/asm-avr32/unaligned.h     |    2 +-
 include/asm-blackfin/unaligned.h  |    2 +-
 include/asm-ia64/unaligned.h      |    2 +-
 include/asm-m68knommu/unaligned.h |   10 ++--------
 include/asm-mips/unaligned.h      |   29 ++++++++++-------------------
 include/asm-parisc/unaligned.h    |    2 +-
 include/asm-sh/unaligned.h        |    6 +++++-
 include/asm-sparc/unaligned.h     |    2 +-
 include/asm-sparc64/unaligned.h   |    2 +-
 10 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/include/asm-alpha/unaligned.h b/include/asm-alpha/unaligned.h
index a1d7284..18acc19 100644
--- a/include/asm-alpha/unaligned.h
+++ b/include/asm-alpha/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef __ALPHA_UNALIGNED_H
 #define __ALPHA_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif
diff --git a/include/asm-avr32/unaligned.h b/include/asm-avr32/unaligned.h
index 36f5fd4..28fa20e 100644
--- a/include/asm-avr32/unaligned.h
+++ b/include/asm-avr32/unaligned.h
@@ -11,6 +11,6 @@
  * optimize word loads in general.
  */
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* __ASM_AVR32_UNALIGNED_H */
diff --git a/include/asm-blackfin/unaligned.h b/include/asm-blackfin/unaligned.h
index 10081dc..25861cd 100644
--- a/include/asm-blackfin/unaligned.h
+++ b/include/asm-blackfin/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef __BFIN_UNALIGNED_H
 #define __BFIN_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif				/* __BFIN_UNALIGNED_H */
diff --git a/include/asm-ia64/unaligned.h b/include/asm-ia64/unaligned.h
index bb85598..2134205 100644
--- a/include/asm-ia64/unaligned.h
+++ b/include/asm-ia64/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_IA64_UNALIGNED_H
 #define _ASM_IA64_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif /* _ASM_IA64_UNALIGNED_H */
diff --git a/include/asm-m68knommu/unaligned.h b/include/asm-m68knommu/unaligned.h
index 869e9dd..6b5c7a2 100644
--- a/include/asm-m68knommu/unaligned.h
+++ b/include/asm-m68knommu/unaligned.h
@@ -4,19 +4,13 @@
 
 #ifdef CONFIG_COLDFIRE
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #else
 /*
  * The m68k can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
 
diff --git a/include/asm-mips/unaligned.h b/include/asm-mips/unaligned.h
index 3249049..471e127 100644
--- a/include/asm-mips/unaligned.h
+++ b/include/asm-mips/unaligned.h
@@ -5,25 +5,16 @@
  *
  * Copyright (C) 2007 Ralf Baechle (ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org)
  */
-#ifndef __ASM_GENERIC_UNALIGNED_H
-#define __ASM_GENERIC_UNALIGNED_H
+#ifndef __ASM_MIPS_UNALIGNED_H
+#define __ASM_MIPS_UNALIGNED_H
 
 #include <linux/compiler.h>
+#if defined(__MIPSEB__)
+#  include <linux/unaligned/generic_be.h>
+#elif defined(__MIPSEL__)
+#  include <linux/unaligned/generic_le.h>
+#else
+#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
+#endif
 
-#define get_unaligned(ptr)					\
-({								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v;						\
-})
-
-#define put_unaligned(val, ptr)					\
-do {								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v = (val);					\
-} while(0)
-
-#endif /* __ASM_GENERIC_UNALIGNED_H */
+#endif /* __ASM_MIPS_UNALIGNED_H */
diff --git a/include/asm-parisc/unaligned.h b/include/asm-parisc/unaligned.h
index 53c9058..865867c 100644
--- a/include/asm-parisc/unaligned.h
+++ b/include/asm-parisc/unaligned.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
diff --git a/include/asm-sh/unaligned.h b/include/asm-sh/unaligned.h
index 5250e30..391da8d 100644
--- a/include/asm-sh/unaligned.h
+++ b/include/asm-sh/unaligned.h
@@ -2,6 +2,10 @@
 #define __ASM_SH_UNALIGNED_H
 
 /* SH can't handle unaligned accesses. */
-#include <asm-generic/unaligned.h>
+#ifdef __LITTLE_ENDIAN__
+#include <linux/unaligned/generic_le.h>
+#else
+#include <linux/unaligned/generic_be.h>
+#endif
 
 #endif /* __ASM_SH_UNALIGNED_H */
diff --git a/include/asm-sparc/unaligned.h b/include/asm-sparc/unaligned.h
index b6f8edd..9f1bb56 100644
--- a/include/asm-sparc/unaligned.h
+++ b/include/asm-sparc/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_SPARC_UNALIGNED_H_
 #define _ASM_SPARC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* _ASM_SPARC_UNALIGNED_H */
diff --git a/include/asm-sparc64/unaligned.h b/include/asm-sparc64/unaligned.h
index 1ed3ba5..faa18cd 100644
--- a/include/asm-sparc64/unaligned.h
+++ b/include/asm-sparc64/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_SPARC64_UNALIGNED_H_
 #define _ASM_SPARC64_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* _ASM_SPARC64_UNALIGNED_H */
-- 
1.5.5.144.g3e42
