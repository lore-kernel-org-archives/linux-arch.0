Return-Path: <ink@jurassic.park.msu.ru>
Received: from jurassic.park.msu.ru ([195.208.223.243]:7552 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263740AbUFDJT2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jun 2004 05:19:28 -0400
Date: Fri, 4 Jun 2004 13:19:26 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: [patch 2.6] __ARCH_WANT_SYS_RT_SIGACTION
Message-ID: <20040604131926.A791@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Recent syscall stubs cleanup broke alpha, as it has its own
version of sys_rt_sigaction().
This defines __ARCH_WANT_SYS_RT_SIGACTION for all architectures
except alpha, sparc and sparc64.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

diff -urpN 2.6-bk/include/asm-arm/unistd.h linux/include/asm-arm/unistd.h
--- 2.6-bk/include/asm-arm/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-arm/unistd.h	Fri Jun  4 11:23:29 2004
@@ -466,6 +466,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-arm26/unistd.h linux/include/asm-arm26/unistd.h
--- 2.6-bk/include/asm-arm26/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-arm26/unistd.h	Fri Jun  4 11:22:04 2004
@@ -397,6 +397,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-cris/unistd.h linux/include/asm-cris/unistd.h
--- 2.6-bk/include/asm-cris/unistd.h	Fri Jun  4 11:17:43 2004
+++ linux/include/asm-cris/unistd.h	Fri Jun  4 11:22:28 2004
@@ -314,6 +314,7 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-h8300/unistd.h linux/include/asm-h8300/unistd.h
--- 2.6-bk/include/asm-h8300/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-h8300/unistd.h	Fri Jun  4 11:23:02 2004
@@ -468,6 +468,7 @@ type name(atype a, btype b, ctype c, dty
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- 2.6-bk/include/asm-i386/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-i386/unistd.h	Fri Jun  4 11:20:42 2004
@@ -403,6 +403,7 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-ia64/unistd.h linux/include/asm-ia64/unistd.h
--- 2.6-bk/include/asm-ia64/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-ia64/unistd.h	Fri Jun  4 11:24:08 2004
@@ -274,6 +274,7 @@
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_SIGPENDING
 # define __ARCH_WANT_SYS_SIGPROCMASK
+# define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
diff -urpN 2.6-bk/include/asm-m68k/unistd.h linux/include/asm-m68k/unistd.h
--- 2.6-bk/include/asm-m68k/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-m68k/unistd.h	Fri Jun  4 11:23:50 2004
@@ -359,6 +359,7 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-m68knommu/unistd.h linux/include/asm-m68knommu/unistd.h
--- 2.6-bk/include/asm-m68knommu/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-m68knommu/unistd.h	Fri Jun  4 11:23:43 2004
@@ -394,6 +394,7 @@ type name(atype a, btype b, ctype c, dty
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-mips/unistd.h linux/include/asm-mips/unistd.h
--- 2.6-bk/include/asm-mips/unistd.h	Fri Jun  4 11:16:34 2004
+++ linux/include/asm-mips/unistd.h	Fri Jun  4 11:24:18 2004
@@ -1091,6 +1091,7 @@ type name (atype a,btype b,ctype c,dtype
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 # ifndef __mips64
 #  define __ARCH_WANT_STAT64
 # endif
diff -urpN 2.6-bk/include/asm-parisc/unistd.h linux/include/asm-parisc/unistd.h
--- 2.6-bk/include/asm-parisc/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-parisc/unistd.h	Fri Jun  4 11:24:25 2004
@@ -899,6 +899,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 /* mmap & mmap2 take 6 arguments */
diff -urpN 2.6-bk/include/asm-ppc/unistd.h linux/include/asm-ppc/unistd.h
--- 2.6-bk/include/asm-ppc/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-ppc/unistd.h	Fri Jun  4 11:24:52 2004
@@ -402,6 +402,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 
 /*
  * Forking from kernel space will result in the child getting a new,
diff -urpN 2.6-bk/include/asm-ppc64/unistd.h linux/include/asm-ppc64/unistd.h
--- 2.6-bk/include/asm-ppc64/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-ppc64/unistd.h	Fri Jun  4 11:24:34 2004
@@ -439,6 +439,7 @@ static inline _syscall3(int, execve, __c
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 
 unsigned long sys_mmap(unsigned long addr, size_t len, unsigned long prot,
 		       unsigned long flags, unsigned long fd, off_t offset);
diff -urpN 2.6-bk/include/asm-s390/unistd.h linux/include/asm-s390/unistd.h
--- 2.6-bk/include/asm-s390/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-s390/unistd.h	Fri Jun  4 11:23:12 2004
@@ -530,6 +530,7 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 # ifndef CONFIG_ARCH_S390X
 #   define __ARCH_WANT_STAT64
 # endif
diff -urpN 2.6-bk/include/asm-sh/unistd.h linux/include/asm-sh/unistd.h
--- 2.6-bk/include/asm-sh/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-sh/unistd.h	Fri Jun  4 11:21:34 2004
@@ -422,6 +422,7 @@ __syscall_return(type,__sc0); \
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-um/unistd.h linux/include/asm-um/unistd.h
--- 2.6-bk/include/asm-um/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-um/unistd.h	Fri Jun  4 11:23:36 2004
@@ -34,6 +34,7 @@ extern int um_execve(const char *file, c
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-v850/unistd.h linux/include/asm-v850/unistd.h
--- 2.6-bk/include/asm-v850/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-v850/unistd.h	Fri Jun  4 11:21:53 2004
@@ -408,6 +408,7 @@ type name (atype a, btype b, ctype c, dt
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/include/asm-x86_64/unistd.h linux/include/asm-x86_64/unistd.h
--- 2.6-bk/include/asm-x86_64/unistd.h	Fri Jun  4 11:16:35 2004
+++ linux/include/asm-x86_64/unistd.h	Fri Jun  4 11:24:43 2004
@@ -591,6 +591,7 @@ do { \
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
 #ifndef __KERNEL_SYSCALLS__
diff -urpN 2.6-bk/kernel/signal.c linux/kernel/signal.c
--- 2.6-bk/kernel/signal.c	Fri Jun  4 11:17:44 2004
+++ linux/kernel/signal.c	Fri Jun  4 11:20:42 2004
@@ -2477,7 +2477,7 @@ out:
 }
 #endif /* __ARCH_WANT_SYS_SIGPROCMASK */
 
-#ifndef __sparc__
+#ifdef __ARCH_WANT_SYS_RT_SIGACTION
 asmlinkage long
 sys_rt_sigaction(int sig,
 		 const struct sigaction __user *act,
@@ -2505,7 +2505,7 @@ sys_rt_sigaction(int sig,
 out:
 	return ret;
 }
-#endif /* __sparc__ */
+#endif /* __ARCH_WANT_SYS_RT_SIGACTION */
 
 #ifdef __ARCH_WANT_SYS_SGETMASK
 
