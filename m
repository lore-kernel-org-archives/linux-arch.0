Return-Path: <jakub@sunsite.ms.mff.cuni.cz>
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:28592 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263555AbUDODCl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Apr 2004 23:02:41 -0400
Received: from sunsite.ms.mff.cuni.cz (sunsite.mff.cuni.cz [127.0.0.1])
	by sunsite.ms.mff.cuni.cz (8.12.8/8.12.8) with ESMTP id i3F0pFI4028999
	for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2004 02:51:20 +0200
Received: (from jakub@localhost)
	by sunsite.ms.mff.cuni.cz (8.12.8/8.12.8/Submit) id i3EJvYak026826
	for linux-arch@vger.kernel.org; Wed, 14 Apr 2004 21:57:34 +0200
Date: Wed, 14 Apr 2004 21:57:33 +0200
From: Jakub Jelinek <jakub@redhat.com>
Subject: [PATCH] MQ syscall support for x86_64/sparc
Message-ID: <20040414195733.GB514@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Attached are patches for mq support on x86_64 (tested) and sparc*
(untested).
Let me know if you are interested in patches for other platforms
or if you want to handle it yourselves.

	Jakub

--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x86-64-mq.patch"

--- linux-2.6.5/include/asm-x86_64/unistd.h.jj	2004-04-04 05:37:36.000000000 +0200
+++ linux-2.6.5/include/asm-x86_64/unistd.h	2004-04-04 05:37:36.000000000 +0200
@@ -535,7 +535,20 @@ __SYSCALL(__NR_vserver, sys_ni_syscall)
 
 /* 237,238,239 reserved for NUMA API */
 
-#define __NR_syscall_max __NR_vserver
+#define __NR_mq_open		240
+__SYSCALL(__NR_mq_open, sys_mq_open)
+#define __NR_mq_unlink		241
+__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#define __NR_mq_timedsend		242
+__SYSCALL(__NR_mq_timedsend, sys_mq_timedsend)
+#define __NR_mq_timedreceive		243
+__SYSCALL(__NR_mq_timedreceive, sys_mq_timedreceive)
+#define __NR_mq_notify		244
+__SYSCALL(__NR_mq_notify, sys_mq_notify)
+#define __NR_mq_getsetattr		245
+__SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
+
+#define __NR_syscall_max __NR_mq_getsetattr
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
--- linux-2.6.5/include/asm-x86_64/ia32_unistd.h.jj	2004-04-04 05:37:36.000000000 +0200
+++ linux-2.6.5/include/asm-x86_64/ia32_unistd.h	2004-04-14 21:46:51.000000000 +0200
@@ -278,7 +278,18 @@
 #define __NR_ia32_tgkill		270
 #define __NR_ia32_utimes		271
 #define __NR_ia32_fadvise64_64		272
+#define __NR_ia32_vserver		273
+#define __NR_ia32_mbind			274
+#define __NR_ia32_get_mempolicy		275
+#define __NR_ia32_set_mempolicy		276
+#define __NR_ia32_mq_open		277
+#define __NR_ia32_mq_unlink		(__NR_ia32_mq_open+1)
+#define __NR_ia32_mq_timedsend		(__NR_ia32_mq_open+2)
+#define __NR_ia32_mq_timedreceive	(__NR_ia32_mq_open+3)
+#define __NR_ia32_mq_notify		(__NR_ia32_mq_open+4)
+#define __NR_ia32_mq_getsetattr		(__NR_ia32_mq_open+5)
 
-#define IA32_NR_syscalls 275	/* must be > than biggest syscall! */	
+
+#define IA32_NR_syscalls 283	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
--- linux-2.6.5/arch/x86_64/ia32/ia32entry.S.jj	2004-04-08 22:56:24.000000000 +0200
+++ linux-2.6.5/arch/x86_64/ia32/ia32entry.S	2004-04-14 22:03:53.000000000 +0200
@@ -578,6 +578,16 @@ ia32_sys_call_table:
 	.quad sys_tgkill
 	.quad compat_sys_utimes
 	.quad sys32_fadvise64_64
+	.quad ni_syscall	/* sys_vserver */
+	.quad ni_syscall	/* sys_mbind */
+	.quad ni_syscall	/* sys_get_mempolicy */
+	.quad ni_syscall	/* sys_set_mempolicy */
+	.quad compat_sys_mq_open
+	.quad sys_mq_unlink
+	.quad compat_sys_mq_timedsend
+	.quad compat_sys_mq_timedreceive
+	.quad compat_sys_mq_notify
+	.quad compat_sys_mq_getsetattr
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8

--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sparc-mq.patch"

--- linux-2.6.5/include/asm-sparc/unistd.h.jj	2004-04-04 05:36:17.000000000 +0200
+++ linux-2.6.5/include/asm-sparc/unistd.h	2004-04-14 22:18:12.000000000 +0200
@@ -289,10 +289,17 @@
 #define __NR_io_submit		270
 #define __NR_io_cancel		271
 #define __NR_io_getevents	272
-/* WARNING: You MAY NOT add syscall numbers larger than 272, since
+#define __NR_mq_open		273
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)
+
+/* WARNING: You MAY NOT add syscall numbers larger than 282, since
  *          all of the syscall tables in the Sparc kernel are
- *          sized to have 273 entries (starting at zero).  Therefore
- *          find a free slot in the 0-272 range.
+ *          sized to have 283 entries (starting at zero).  Therefore
+ *          find a free slot in the 0-282 range.
  */
 
 #define _syscall0(type,name) \
--- linux-2.6.5/include/asm-sparc64/unistd.h.jj	2004-04-04 05:36:25.000000000 +0200
+++ linux-2.6.5/include/asm-sparc64/unistd.h	2004-04-14 22:19:27.000000000 +0200
@@ -291,10 +291,16 @@
 #define __NR_io_submit		270
 #define __NR_io_cancel		271
 #define __NR_io_getevents	272
-/* WARNING: You MAY NOT add syscall numbers larger than 272, since
+#define __NR_mq_open		273
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)
+/* WARNING: You MAY NOT add syscall numbers larger than 282, since
  *          all of the syscall tables in the Sparc kernel are
- *          sized to have 273 entries (starting at zero).  Therefore
- *          find a free slot in the 0-272 range.
+ *          sized to have 283 entries (starting at zero).  Therefore
+ *          find a free slot in the 0-282 range.
  */
 
 #define _syscall0(type,name) \
--- linux-2.6.5/arch/sparc64/kernel/sys32.S.jj	2004-04-04 05:36:26.000000000 +0200
+++ linux-2.6.5/arch/sparc64/kernel/sys32.S	2004-04-14 22:48:52.000000000 +0200
@@ -68,6 +68,17 @@ sys32_mmap2:
 	jmpl		%g1 + %lo(sys_mmap), %g0
 	 sllx		%o5, 12, %o5
 
+	.globl		sys32_mq_timedsend
+sys32_mq_timedsend:
+	sethi		%hi(compat_sys_mq_timedsend), %g1
+	jmpl		%g1 + %lo(compat_sys_mq_timedsend), %g0
+	 srl		%o4, 0, %o4
+	.globl		sys32_mq_timedreceive
+sys32_mq_timedreceive:
+	sethi		%hi(compat_sys_mq_timedreceive), %g1
+	jmpl		%g1 + %lo(compat_sys_mq_timedreceive), %g0
+	 srl		%o4, 0, %o4
+
 	.align		32
 	.globl		sys32_socketcall
 sys32_socketcall:	/* %o0=call, %o1=args */
--- linux-2.6.5/arch/sparc64/kernel/entry.S.jj	2004-04-04 05:36:10.000000000 +0200
+++ linux-2.6.5/arch/sparc64/kernel/entry.S	2004-04-14 22:31:46.000000000 +0200
@@ -26,7 +26,7 @@
 
 #define curptr      g6
 
-#define NR_SYSCALLS 273      /* Each OS is different... */
+#define NR_SYSCALLS 283      /* Each OS is different... */
 
 	.text
 	.align		32
--- linux-2.6.5/arch/sparc64/kernel/systbls.S.jj	2004-04-04 05:36:57.000000000 +0200
+++ linux-2.6.5/arch/sparc64/kernel/systbls.S	2004-04-14 22:49:41.000000000 +0200
@@ -73,7 +73,9 @@ sys_call_table32:
 	.word sys_ni_syscall, compat_clock_settime, compat_clock_gettime, compat_clock_getres, compat_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, compat_timer_settime, compat_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
-/*270*/	.word compat_sys_io_submit, sys_io_cancel, compat_sys_io_getevents, sys_ni_syscall
+/*270*/	.word compat_sys_io_submit, sys_io_cancel, compat_sys_io_getevents, compat_sys_mq_open, sys_mq_unlink
+	.word sys32_mq_timedsend, sys32_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, sys_ni_syscall
+/*280*/	.word sys_ni_syscall, sys_ni_syscall, sys_ni_syscall
 
 	/* Now the 64-bit native Linux syscall table. */
 
@@ -135,7 +137,9 @@ sys_call_table:
 	.word sys_ni_syscall, sys_clock_settime, sys_clock_gettime, sys_clock_getres, sys_clock_nanosleep
 /*260*/	.word sys_sched_getaffinity, sys_sched_setaffinity, sys_timer_settime, sys_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys_timer_create, sys_ni_syscall, sys_io_setup, sys_io_destroy
-/*270*/	.word sys_io_submit, sys_io_cancel, sys_io_getevents, sys_ni_syscall
+/*270*/	.word sys_io_submit, sys_io_cancel, sys_io_getevents, sys_mq_open, sys_mq_unlink
+	.word sys_mq_timedsend, sys_mq_timedreceive, sys_mq_notify, sys_mq_getsetattr, sys_ni_syscall
+/*280*/	.word sys_ni_syscall, sys_ni_syscall, sys_ni_syscall
 
 #if defined(CONFIG_SUNOS_EMUL) || defined(CONFIG_SOLARIS_EMUL) || \
     defined(CONFIG_SOLARIS_EMUL_MODULE)
@@ -237,5 +241,8 @@ sunos_sys_table:
 	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_nosys
+	.word sunos_nosys, sunos_nosys, sunos_nosys
+	.word sunos_nosys, sunos_nosys, sunos_nosys
+	.word sunos_nosys, sunos_nosys, sunos_nosys
 
 #endif
--- linux-2.6.5/arch/sparc/kernel/entry.S.jj	2004-04-04 05:37:06.000000000 +0200
+++ linux-2.6.5/arch/sparc/kernel/entry.S	2004-04-14 22:20:14.000000000 +0200
@@ -38,7 +38,7 @@
 
 #define curptr      g6
 
-#define NR_SYSCALLS 273      /* Each OS is different... */
+#define NR_SYSCALLS 283      /* Each OS is different... */
 
 /* These are just handy. */
 #define _SV	save	%sp, -STACKFRAME_SZ, %sp
--- linux-2.6.5/arch/sparc/kernel/systbls.S.jj	2004-04-04 05:37:07.000000000 +0200
+++ linux-2.6.5/arch/sparc/kernel/systbls.S	2004-04-14 22:24:34.000000000 +0200
@@ -73,7 +73,9 @@ sys_call_table:
 /*255*/	.long sys_nis_syscall, sys_clock_settime, sys_clock_gettime, sys_clock_getres, sys_clock_nanosleep
 /*260*/	.long sys_sched_getaffinity, sys_sched_setaffinity, sys_timer_settime, sys_timer_gettime, sys_timer_getoverrun
 /*265*/	.long sys_timer_delete, sys_timer_create, sys_nis_syscall, sys_io_setup, sys_io_destroy
-/*270*/	.long sys_io_submit, sys_io_cancel, sys_io_getevents, sys_nis_syscall
+/*270*/	.long sys_io_submit, sys_io_cancel, sys_io_getevents, sys_mq_open, sys_mq_unlink
+/*275*/	.long sys_mq_timedsend, sys_mq_timedreceive, sys_mq_notify, sys_mq_getsetattr, sys_ni_syscall
+/*280*/	.long sys_ni_syscall, sys_ni_syscall, sys_ni_syscall
 
 #ifdef CONFIG_SUNOS_EMUL
 	/* Now the SunOS syscall table. */
@@ -175,6 +177,9 @@ sunos_sys_table:
 	.long sunos_nosys, sunos_nosys, sunos_nosys
 	.long sunos_nosys
 /*270*/	.long sunos_nosys, sunos_nosys, sunos_nosys
+	.long sunos_nosys, sunos_nosys, sunos_nosys
+	.long sunos_nosys, sunos_nosys, sunos_nosys
 	.long sunos_nosys
+/*280*/	.long sunos_nosys, sunos_nosys, sunos_nosys
 
 #endif

--BzCohdixPhurzSK4--
