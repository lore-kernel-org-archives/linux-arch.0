From: Jeff Dike <jdike-OPE4K8JWMJJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 8/19] asm/futex.h should include linux/uaccess.h
Date: Fri, 25 Apr 2008 13:56:09 -0400
Message-ID: <20080425175609.GA11186@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uml-devel <user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Lots of asm-*/futex.h call pagefault_enable and pagefault_disable,
which are declared in linux/uaccess.h, without including
linux/uaccess.h.

They all include asm/uaccess.h, so this patch replaces asm/uaccess.h
with linux/uaccess.h.

Compile-tested on sparc64, x86, ia64, mips, and powerpc.

Signed-off-by: Jeff Dike <jdike-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/asm-generic/futex.h |    2 +-
 include/asm-ia64/futex.h    |    2 +-
 include/asm-mips/futex.h    |    2 +-
 include/asm-parisc/futex.h  |    2 +-
 include/asm-powerpc/futex.h |    2 +-
 include/asm-sh/futex.h      |    2 +-
 include/asm-sparc64/futex.h |    2 +-
 include/asm-x86/futex.h     |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.22/include/asm-generic/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-generic/futex.h	2008-02-12 12:47:49.000000000 -0500
+++ linux-2.6.22/include/asm-generic/futex.h	2008-02-12 12:47:52.000000000 -0500
@@ -4,8 +4,8 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 
 static inline int
 futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
Index: linux-2.6.22/include/asm-ia64/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-ia64/futex.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-ia64/futex.h	2008-02-12 12:49:31.000000000 -0500
@@ -2,9 +2,9 @@
 #define _ASM_FUTEX_H
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg) \
 do {									\
Index: linux-2.6.22/include/asm-mips/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-mips/futex.h	2007-12-05 10:29:35.000000000 -0500
+++ linux-2.6.22/include/asm-mips/futex.h	2008-02-12 12:49:49.000000000 -0500
@@ -11,9 +11,9 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/barrier.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 #include <asm/war.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
Index: linux-2.6.22/include/asm-parisc/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-parisc/futex.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-parisc/futex.h	2008-02-12 12:50:03.000000000 -0500
@@ -4,8 +4,8 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 
 static inline int
 futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
Index: linux-2.6.22/include/asm-powerpc/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-powerpc/futex.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/include/asm-powerpc/futex.h	2008-02-12 12:50:22.000000000 -0500
@@ -4,9 +4,9 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
 #include <asm/synch.h>
-#include <asm/uaccess.h>
 #include <asm/asm-compat.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
Index: linux-2.6.22/include/asm-sh/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-sh/futex.h	2007-10-12 12:07:06.000000000 -0400
+++ linux-2.6.22/include/asm-sh/futex.h	2008-02-12 12:51:17.000000000 -0500
@@ -4,8 +4,8 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 
 /* XXX: UP variants, fix for SH-4A and SMP.. */
 #include <asm/futex-irq.h>
Index: linux-2.6.22/include/asm-sparc64/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-sparc64/futex.h	2007-11-14 10:33:41.000000000 -0500
+++ linux-2.6.22/include/asm-sparc64/futex.h	2008-02-12 12:51:35.000000000 -0500
@@ -2,9 +2,9 @@
 #define _SPARC64_FUTEX_H
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/errno.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #define __futex_cas_op(insn, ret, oldval, uaddr, oparg)	\
 	__asm__ __volatile__(				\
Index: linux-2.6.22/include/asm-x86/futex.h
===================================================================
--- linux-2.6.22.orig/include/asm-x86/futex.h	2008-02-05 12:25:21.000000000 -0500
+++ linux-2.6.22/include/asm-x86/futex.h	2008-02-12 12:51:51.000000000 -0500
@@ -4,12 +4,12 @@
 #ifdef __KERNEL__
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 
 #include <asm/asm.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg)	\
   __asm__ __volatile(						\
