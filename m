Return-Path: <jakub@sunsite.ms.mff.cuni.cz>
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:2756 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261347AbUDPCCp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Apr 2004 22:02:45 -0400
Received: from sunsite.ms.mff.cuni.cz (sunsite.mff.cuni.cz [127.0.0.1])
	by sunsite.ms.mff.cuni.cz (8.12.8/8.12.8) with ESMTP id i3FNpFIC015850
	for <linux-arch@vger.kernel.org>; Fri, 16 Apr 2004 01:51:22 +0200
Received: (from jakub@localhost)
	by sunsite.ms.mff.cuni.cz (8.12.8/8.12.8/Submit) id i3F6dbQF032290
	for linux-arch@vger.kernel.org; Thu, 15 Apr 2004 08:39:37 +0200
Date: Thu, 15 Apr 2004 08:39:37 +0200
From: Jakub Jelinek <jakub@redhat.com>
Subject: [PATCH] mq support for ia64
Message-ID: <20040415063937.GD514@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi!

Untested though.
glibc CVS + http://sources.redhat.com/ml/libc-hacker/2004-04/msg00028.html
+ http://sources.redhat.com/ml/libc-hacker/2004-04/msg00030.html
+ http://sources.redhat.com/ml/libc-hacker/2004-04/msg00029.html
should be a good test (with both 32-bit and 64-bit glibc make check).
On the kernel side bk + this patch
+ http://www.ussg.iu.edu/hypermail/linux/kernel/0404.1/0846.html
+ http://www.ussg.iu.edu/hypermail/linux/kernel/0404.1/0898.html
+ http://www.ussg.iu.edu/hypermail/linux/kernel/0404.1/1241.html
is needed for all the glibc tests to pass.

--- linux-2.6.5/include/asm-ia64/ia32.h.jj	2004-04-04 05:38:23.000000000 +0200
+++ linux-2.6.5/include/asm-ia64/ia32.h	2004-04-15 10:34:48.933524902 +0200
@@ -6,7 +6,7 @@
 #include <asm/ptrace.h>
 #include <asm/signal.h>
 
-#define IA32_NR_syscalls		275 /* length of syscall table */
+#define IA32_NR_syscalls		283 /* length of syscall table */
 
 #ifndef __ASSEMBLY__
 
--- linux-2.6.5/include/asm-ia64/unistd.h.jj	2004-04-08 22:56:25.000000000 +0200
+++ linux-2.6.5/include/asm-ia64/unistd.h	2004-04-15 10:26:52.524903530 +0200
@@ -251,6 +251,12 @@
 #define __NR_reserved1			1259	/* reserved for NUMA interface */
 #define __NR_reserved2			1260	/* reserved for NUMA interface */
 #define __NR_reserved3			1261	/* reserved for NUMA interface */
+#define __NR_mq_open			1262
+#define __NR_mq_unlink			1263
+#define __NR_mq_timedsend		1264
+#define __NR_mq_timedreceive		1265
+#define __NR_mq_notify			1266
+#define __NR_mq_getsetattr		1267
 
 #ifdef __KERNEL__
 
--- linux-2.6.5/arch/ia64/ia32/ia32_entry.S.jj	2004-04-04 05:37:23.000000000 +0200
+++ linux-2.6.5/arch/ia64/ia32/ia32_entry.S	2004-04-15 10:32:45.743602140 +0200
@@ -483,6 +483,14 @@ ia32_syscall_table:
  	data8 sys32_fadvise64_64
  	data8 sys_ni_syscall
   	data8 sys_ni_syscall
+ 	data8 sys_ni_syscall	/* 275 */
+  	data8 sys_ni_syscall
+  	data8 compat_sys_mq_open
+  	data8 sys_mq_unlink
+  	data8 compat_sys_mq_timedsend
+  	data8 compat_sys_mq_timedreceive	/* 280 */
+  	data8 compat_sys_mq_notify
+  	data8 compat_sys_mq_getsetattr
 
 	// guard against failures to increase IA32_NR_syscalls
 	.org ia32_syscall_table + 8*IA32_NR_syscalls
--- linux-2.6.5/arch/ia64/kernel/fsys.S.jj	2004-04-04 05:38:28.000000000 +0200
+++ linux-2.6.5/arch/ia64/kernel/fsys.S	2004-04-15 10:38:34.448109753 +0200
@@ -851,12 +851,12 @@ fsyscall_table:
 	data8 0
 	data8 0							// 1260
 	data8 0
-	data8 0
-	data8 0
-	data8 0
-	data8 0							// 1265
-	data8 0
-	data8 0
+	data8 0				// mq_open
+	data8 0				// mq_unlink
+	data8 0				// mq_timedsend
+	data8 0				// mq_timedreceive	// 1265
+	data8 0				// mq_notify
+	data8 0				// mq_getsetattr
 	data8 0
 	data8 0
 	data8 0							// 1270
--- linux-2.6.5/arch/ia64/kernel/entry.S.jj	2004-04-08 22:56:25.000000000 +0200
+++ linux-2.6.5/arch/ia64/kernel/entry.S	2004-04-15 10:29:03.361455916 +0200
@@ -1512,12 +1512,12 @@ sys_call_table:
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1260
 	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1265
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 sys_mq_open
+	data8 sys_mq_unlink
+	data8 sys_mq_timedsend
+	data8 sys_mq_timedreceive		// 1265
+	data8 sys_mq_notify
+	data8 sys_mq_getsetattr
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1270

	Jakub
