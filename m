Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262715AbUKXPl7@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14286 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262697AbUKXPkv
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Nov 2004 10:40:51 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id iAOFeZbP205620
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 15:40:35 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAOFef4L155598
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 16:40:41 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id iAOFeXFb020943
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 16:40:35 +0100
Date: Wed, 24 Nov 2004 16:40:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch] sys_stime needs a compat function.
Message-ID: <20041124154033.GA4832@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, ak@suse.de, ralf@linux-mips.org, matthew@wil.cx, anton@samba.org, davem@davemloft.net, jdike@addtoit.com, davidm@hpl.hp.com
List-ID: <linux-arch.vger.kernel.org>

> I'd prefer having an extra __ARCH_WANT_COMPAT_SYS_TIME flag. Mips, x86_64,
> ia64 and s390 only need compat_sys_stime, but not sys_stime for 64 bit
> kernels.

Yes, makes sense. I had a go at it and realized that the best way
to get the sys_time/sys_stime problem fixed is to make sys_time
64 bit safe by using "time_t *" instead of "int *" and to introduce
two proper compat functions compat_sys_time and compat_sys_stime.

The prototype change of sys_time is transparent for 32 bit architectures
because both "int" and "time_t" are 32 bit. For 64 bit the type change
would be wrong but luckily no 64 bit architecture uses sys_time/sys_stime
in 64 bit mode. The patch makes the following change:

ia64     : Remove sys32_time, use compat_sys_time and
           add (!!) compat_sys_stime to compat syscall table.
mips     : Use compat_sys_time/compat_sys_stime in 32 bit syscall table.
           Add #ifdef magic to compile sys_time/sys_stime and
           compat_sys_time/compat_sys_stime only if needed.
parisc   : Remove sys32_time, use compat_sys_time and compat_sys_stime.
ppc64    : remove sys32_time, ppc64_sys32_stime and ppc64_sys_stime.
           Use common compat_sys_time, compat_sys_stime and sys_stime.
s390     : Use compat_sys_stime. Add #ifdef magic to compile
           sys_time/sys_stime and compat_sys_time/compat_sys_stime only
           if needed.
sparc64  : Use compat_sys_time/compat_Sys_stime in 32 bit syscall table.
um       : Remove um_time and um_stime. Use common functions sys_time and
           sys_stime. This adds a CAP_SYS_TIME check to UMs stime call.
x86_64   : Remove sys32_time. Use compat_sys_time and compat_sys_stime
           in 32 bit syscall table.

The original stime bug is fixed for mips, parisc, s390, sparc64 and
x86_64. Can the arch-maintainers please take a look at this?

blue skies,
  Martin.

---

[patch] sys_stime needs a compat function.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Convert compat_time_t to time_t in 32 bit emulation for sys_stime and
consolidate all the different implementation of sys_time, sys_stime
and their 32-bit emulation parts.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/ia64/ia32/ia32_entry.S        |    4 +-
 arch/ia64/ia32/sys_ia32.c          |   21 --------------
 arch/mips/kernel/scall64-o32.S     |    4 +-
 arch/parisc/kernel/sys_parisc32.c  |   15 ----------
 arch/parisc/kernel/syscall_table.S |    4 +-
 arch/ppc64/kernel/misc.S           |    6 ++--
 arch/ppc64/kernel/sys_ppc32.c      |   17 -----------
 arch/ppc64/kernel/time.c           |   54 -------------------------------------
 arch/s390/kernel/compat_wrapper.S  |    4 +-
 arch/sparc64/kernel/systbls.S      |    4 +-
 arch/x86_64/ia32/ia32entry.S       |    4 +-
 arch/x86_64/ia32/sys_ia32.c        |   20 -------------
 include/asm-mips/unistd.h          |    7 ++++
 include/asm-parisc/unistd.h        |    1 
 include/asm-ppc64/unistd.h         |    1 
 include/asm-s390/unistd.h          |    5 ++-
 include/asm-sparc64/unistd.h       |    1 
 include/asm-x86_64/unistd.h        |    2 -
 kernel/compat.c                    |   39 ++++++++++++++++++++++++++
 kernel/time.c                      |    6 +---
 20 files changed, 69 insertions(+), 150 deletions(-)

diff -urN linux-2.6/arch/ia64/ia32/ia32_entry.S linux-2.6-compat/arch/ia64/ia32/ia32_entry.S
--- linux-2.6/arch/ia64/ia32/ia32_entry.S	2004-11-24 16:08:19.000000000 +0100
+++ linux-2.6-compat/arch/ia64/ia32/ia32_entry.S	2004-11-24 16:23:46.000000000 +0100
@@ -223,7 +223,7 @@
 	data8 sys_unlink	  /* 10 */
 	data8 ia32_execve
 	data8 sys_chdir
-	data8 sys32_time
+	data8 compat_sys_time
 	data8 sys_mknod
 	data8 sys_chmod		  /* 15 */
 	data8 sys_lchown	/* 16-bit version */
@@ -235,7 +235,7 @@
 	data8 sys_oldumount
 	data8 sys_setuid	/* 16-bit version */
 	data8 sys_getuid	/* 16-bit version */
-	data8 sys_ni_syscall	/* sys_stime is not supported on IA64 */  /* 25 */
+	data8 compat_sys_stime    /* 25 */
 	data8 sys32_ptrace
 	data8 sys32_alarm
 	data8 sys_ni_syscall
diff -urN linux-2.6/arch/ia64/ia32/sys_ia32.c linux-2.6-compat/arch/ia64/ia32/sys_ia32.c
--- linux-2.6/arch/ia64/ia32/sys_ia32.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6-compat/arch/ia64/ia32/sys_ia32.c	2004-11-24 16:23:46.000000000 +0100
@@ -1425,27 +1425,6 @@
 	return -EINVAL;
 }
 
-/*
- * sys_time() can be implemented in user-level using
- * sys_gettimeofday().  IA64 did this but i386 Linux did not
- * so we have to implement this system call here.
- */
-asmlinkage long
-sys32_time (int __user *tloc)
-{
-	int i;
-	struct timeval tv;
-
-	do_gettimeofday(&tv);
-	i = tv.tv_sec;
-
-	if (tloc) {
-		if (put_user(i, tloc))
-			i = -EFAULT;
-	}
-	return i;
-}
-
 asmlinkage long
 compat_sys_wait4 (compat_pid_t pid, compat_uint_t * stat_addr, int options,
 		 struct compat_rusage *ru);
diff -urN linux-2.6/arch/mips/kernel/scall64-o32.S linux-2.6-compat/arch/mips/kernel/scall64-o32.S
--- linux-2.6/arch/mips/kernel/scall64-o32.S	2004-10-18 23:53:05.000000000 +0200
+++ linux-2.6-compat/arch/mips/kernel/scall64-o32.S	2004-11-24 16:23:46.000000000 +0100
@@ -271,7 +271,7 @@
 	sys	sys_unlink	1			/* 4010 */
 	sys	sys32_execve	0
 	sys	sys_chdir	1
-	sys	sys_time	1
+	sys	compat_sys_time	1
 	sys	sys_mknod	3
 	sys	sys_chmod	2			/* 4015 */
 	sys	sys_lchown	3
@@ -283,7 +283,7 @@
 	sys	sys_oldumount	1
 	sys	sys_setuid	1
 	sys	sys_getuid	0
-	sys	sys_stime	1			/* 4025 */
+	sys	compat_sys_stime	1		/* 4025 */
 	sys	sys32_ptrace	4
 	sys	sys_alarm	1
 	sys	sys_ni_syscall	0			/* was sys_fstat */
diff -urN linux-2.6/arch/parisc/kernel/syscall_table.S linux-2.6-compat/arch/parisc/kernel/syscall_table.S
--- linux-2.6/arch/parisc/kernel/syscall_table.S	2004-11-24 16:08:19.000000000 +0100
+++ linux-2.6-compat/arch/parisc/kernel/syscall_table.S	2004-11-24 16:23:46.000000000 +0100
@@ -74,7 +74,7 @@
 	ENTRY_DIFF(execve_wrapper)
 	ENTRY_SAME(chdir)
 	/* See comments in kernel/time.c!!! Maybe we don't need this? */
-	ENTRY_DIFF(time)
+	ENTRY_COMP(time)
 	ENTRY_SAME(mknod)
 	ENTRY_SAME(chmod)		/* 15 */
 	ENTRY_SAME(lchown)
@@ -91,7 +91,7 @@
 	ENTRY_SAME(bind)
 	ENTRY_SAME(setuid)
 	ENTRY_SAME(getuid)
-	ENTRY_SAME(stime)		/* 25 */
+	ENTRY_COMP(stime)		/* 25 */
 	ENTRY_SAME(ptrace)
 	ENTRY_SAME(alarm)
 	/* see stat comment */
diff -urN linux-2.6/arch/parisc/kernel/sys_parisc32.c linux-2.6-compat/arch/parisc/kernel/sys_parisc32.c
--- linux-2.6/arch/parisc/kernel/sys_parisc32.c	2004-11-24 16:08:19.000000000 +0100
+++ linux-2.6-compat/arch/parisc/kernel/sys_parisc32.c	2004-11-24 16:23:46.000000000 +0100
@@ -206,21 +206,6 @@
 	return 0;
 }
 
-asmlinkage long sys32_time(compat_time_t *tloc)
-{
-	struct timeval tv;
-	compat_time_t now32;
-
-	do_gettimeofday(&tv);
-	now32 = tv.tv_sec;
-
-	if (tloc)
-		if (put_user(now32, tloc))
-			now32 = -EFAULT;
-
-	return now32;
-}
-
 asmlinkage int
 sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
diff -urN linux-2.6/arch/ppc64/kernel/misc.S linux-2.6-compat/arch/ppc64/kernel/misc.S
--- linux-2.6/arch/ppc64/kernel/misc.S	2004-11-24 16:08:19.000000000 +0100
+++ linux-2.6-compat/arch/ppc64/kernel/misc.S	2004-11-24 16:23:46.000000000 +0100
@@ -707,7 +707,7 @@
 	.llong .sys_unlink      	/* 10 */
 	.llong .sys32_execve
 	.llong .sys_chdir
-	.llong .sys32_time
+	.llong .compat_sys_time
 	.llong .sys_mknod
 	.llong .sys_chmod		/* 15 */
 	.llong .sys_lchown
@@ -719,7 +719,7 @@
 	.llong .sys_oldumount
 	.llong .sys_setuid
 	.llong .sys_getuid
-	.llong .ppc64_sys32_stime       /* 25 */
+	.llong .compat_sys_stime	/* 25 */
 	.llong .sys32_ptrace
 	.llong .sys_alarm
 	.llong .sys_ni_syscall		/* old fstat syscall */
@@ -994,7 +994,7 @@
 	.llong .sys_ni_syscall		/* old umount syscall */
 	.llong .sys_setuid
 	.llong .sys_getuid
-	.llong .ppc64_sys_stime		/* 25 */
+	.llong .sys_stime		/* 25 */
 	.llong .sys_ptrace
 	.llong .sys_alarm
 	.llong .sys_ni_syscall		/* old fstat syscall */
diff -urN linux-2.6/arch/ppc64/kernel/sys_ppc32.c linux-2.6-compat/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.6/arch/ppc64/kernel/sys_ppc32.c	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/ppc64/kernel/sys_ppc32.c	2004-11-24 16:23:46.000000000 +0100
@@ -1153,23 +1153,6 @@
 	return error;
 }
 
-asmlinkage long sys32_time(compat_time_t __user * tloc)
-{
-	compat_time_t secs;
-
-	struct timeval tv;
-
-	do_gettimeofday( &tv );
-	secs = tv.tv_sec;
-
-	if (tloc) {
-		if (put_user(secs,tloc))
-			secs = -EFAULT;
-	}
-
-	return secs;
-}
-
 asmlinkage int sys32_olduname(struct oldold_utsname __user * name)
 {
 	int error;
diff -urN linux-2.6/arch/ppc64/kernel/time.c linux-2.6-compat/arch/ppc64/kernel/time.c
--- linux-2.6/arch/ppc64/kernel/time.c	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/ppc64/kernel/time.c	2004-11-24 16:24:45.000000000 +0100
@@ -425,60 +425,6 @@
 
 EXPORT_SYMBOL(do_settimeofday);
 
-/*
- * This function is a copy of the architecture independent function
- * but which calls do_settimeofday rather than setting the xtime
- * fields itself.  This way, the fields which are used for 
- * do_settimeofday get updated too.
- */
-long ppc64_sys32_stime(int __user * tptr)
-{
-	int value;
-	struct timespec myTimeval;
-	int err;
-
-	if (get_user(value, tptr))
-		return -EFAULT;
-
-	myTimeval.tv_sec = value;
-	myTimeval.tv_nsec = 0;
-
-	err = security_settime(&myTimeval, NULL);
-	if (err)
-		return err;
-
-	do_settimeofday(&myTimeval);
-
-	return 0;
-}
-
-/*
- * This function is a copy of the architecture independent function
- * but which calls do_settimeofday rather than setting the xtime
- * fields itself.  This way, the fields which are used for 
- * do_settimeofday get updated too.
- */
-long ppc64_sys_stime(long __user * tptr)
-{
-	long value;
-	struct timespec myTimeval;
-	int err;
-
-	if (get_user(value, tptr))
-		return -EFAULT;
-
-	myTimeval.tv_sec = value;
-	myTimeval.tv_nsec = 0;
-
-	err = security_settime(&myTimeval, NULL);
-	if (err)
-		return err;
-
-	do_settimeofday(&myTimeval);
-
-	return 0;
-}
-
 void __init time_init(void)
 {
 	/* This function is only called on the boot processor */
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-compat/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/s390/kernel/compat_wrapper.S	2004-11-24 16:23:51.000000000 +0100
@@ -1076,8 +1076,8 @@
 
 	.globl	sys32_stime_wrapper
 sys32_stime_wrapper:
-	llgtr	%r2,%r2			# int *
-	jg	sys_stime		# branch to system call
+	llgtr	%r2,%r2			# long *
+	jg	compat_sys_stime	# branch to system call
 
 	.globl  sys32_sysctl_wrapper
 sys32_sysctl_wrapper:
diff -urN linux-2.6/arch/sparc64/kernel/systbls.S linux-2.6-compat/arch/sparc64/kernel/systbls.S
--- linux-2.6/arch/sparc64/kernel/systbls.S	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/sparc64/kernel/systbls.S	2004-11-24 16:25:11.000000000 +0100
@@ -25,7 +25,7 @@
 /*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys32_chown16, sys32_mknod
 /*15*/	.word sys_chmod, sys32_lchown16, sparc_brk, sys32_perfctr, sys32_lseek
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys32_setuid16, sys32_getuid16
-/*25*/	.word sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
+/*25*/	.word compat_sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
 /*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys32_access, sys32_nice
 	.word sys_chown, sys_sync, sys32_kill, compat_sys_newstat, sys32_sendfile
 /*40*/	.word compat_sys_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
@@ -66,7 +66,7 @@
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_sys_statfs64
+/*230*/	.word sys32_select, compat_sys_time, sys_nis_syscall, compat_sys_stime, compat_sys_statfs64
 	.word compat_sys_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys32_mlockall
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
diff -urN linux-2.6/arch/x86_64/ia32/ia32entry.S linux-2.6-compat/arch/x86_64/ia32/ia32entry.S
--- linux-2.6/arch/x86_64/ia32/ia32entry.S	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/x86_64/ia32/ia32entry.S	2004-11-24 16:23:51.000000000 +0100
@@ -315,7 +315,7 @@
 	.quad sys_unlink		/* 10 */
 	.quad stub32_execve
 	.quad sys_chdir
-	.quad sys32_time
+	.quad compat_sys_time
 	.quad sys_mknod
 	.quad sys_chmod		/* 15 */
 	.quad sys_lchown16
@@ -327,7 +327,7 @@
 	.quad sys_oldumount	/* old_umount  */
 	.quad sys_setuid16
 	.quad sys_getuid16
-	.quad sys_stime		/* stime */		/* 25 */
+	.quad compat_sys_stime	/* stime */		/* 25 */
 	.quad sys32_ptrace	/* ptrace */
 	.quad sys_alarm
 	.quad sys_fstat	/* (old)fstat */
diff -urN linux-2.6/arch/x86_64/ia32/sys_ia32.c linux-2.6-compat/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6/arch/x86_64/ia32/sys_ia32.c	2004-11-24 16:08:20.000000000 +0100
+++ linux-2.6-compat/arch/x86_64/ia32/sys_ia32.c	2004-11-24 16:23:51.000000000 +0100
@@ -492,26 +492,6 @@
 				 compat_ptr(a.exp), compat_ptr(a.tvp));
 }
 
-/*
- * sys_time() can be implemented in user-level using
- * sys_gettimeofday().  x86-64 did this but i386 Linux did not
- * so we have to implement this system call here.
- */
-asmlinkage long sys32_time(int __user * tloc)
-{
-	int i;
-	struct timeval tv;
-
-	do_gettimeofday(&tv);
-	i = tv.tv_sec;
-
-	if (tloc) {
-		if (put_user(i,tloc))
-			i = -EFAULT;
-	}
-	return i;
-}
-
 extern asmlinkage long
 compat_sys_wait4(compat_pid_t pid, compat_uint_t * stat_addr, int options,
 		 struct compat_rusage *ru);
diff -urN linux-2.6/include/asm-mips/unistd.h linux-2.6-compat/include/asm-mips/unistd.h
--- linux-2.6/include/asm-mips/unistd.h	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6-compat/include/asm-mips/unistd.h	2004-11-24 16:23:51.000000000 +0100
@@ -1082,7 +1082,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
-#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
@@ -1098,6 +1097,12 @@
 # ifndef __mips64
 #  define __ARCH_WANT_STAT64
 # endif
+# ifdef CONFIG_MIPS32
+#  define __ARCH_WANT_SYS_TIME
+# endif
+# ifdef CONFIG_MIPS32_O32
+#  define __ARCH_WANT_COMPAT_SYS_TIME
+# endif
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urN linux-2.6/include/asm-parisc/unistd.h linux-2.6-compat/include/asm-parisc/unistd.h
--- linux-2.6/include/asm-parisc/unistd.h	2004-11-24 16:08:47.000000000 +0100
+++ linux-2.6-compat/include/asm-parisc/unistd.h	2004-11-24 16:23:51.000000000 +0100
@@ -912,6 +912,7 @@
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
 #define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
diff -urN linux-2.6/include/asm-ppc64/unistd.h linux-2.6-compat/include/asm-ppc64/unistd.h
--- linux-2.6/include/asm-ppc64/unistd.h	2004-11-24 16:08:47.000000000 +0100
+++ linux-2.6-compat/include/asm-ppc64/unistd.h	2004-11-24 16:23:51.000000000 +0100
@@ -431,6 +431,7 @@
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
 #define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
diff -urN linux-2.6/include/asm-s390/unistd.h linux-2.6-compat/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2004-10-18 23:55:43.000000000 +0200
+++ linux-2.6-compat/include/asm-s390/unistd.h	2004-11-24 16:27:11.000000000 +0100
@@ -519,7 +519,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
@@ -531,9 +530,11 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
-# ifndef CONFIG_ARCH_S390X
+# ifdef CONFIG_ARCH_S390_31
 #   define __ARCH_WANT_STAT64
+#   define __ARCH_WANT_SYS_TIME
 # endif
+# define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
 #ifdef __KERNEL_SYSCALLS__
diff -urN linux-2.6/include/asm-sparc64/unistd.h linux-2.6-compat/include/asm-sparc64/unistd.h
--- linux-2.6/include/asm-sparc64/unistd.h	2004-11-24 16:08:47.000000000 +0100
+++ linux-2.6-compat/include/asm-sparc64/unistd.h	2004-11-24 16:23:51.000000000 +0100
@@ -489,6 +489,7 @@
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
 #define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
diff -urN linux-2.6/include/asm-x86_64/unistd.h linux-2.6-compat/include/asm-x86_64/unistd.h
--- linux-2.6/include/asm-x86_64/unistd.h	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6-compat/include/asm-x86_64/unistd.h	2004-11-24 16:28:12.000000000 +0100
@@ -581,7 +581,6 @@
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
@@ -594,6 +593,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
 #ifndef __KERNEL_SYSCALLS__
diff -urN linux-2.6/kernel/compat.c linux-2.6-compat/kernel/compat.c
--- linux-2.6/kernel/compat.c	2004-11-24 16:08:48.000000000 +0100
+++ linux-2.6-compat/kernel/compat.c	2004-11-24 16:26:25.000000000 +0100
@@ -680,3 +680,42 @@
 
 	return 0;
 }
+
+#ifdef __ARCH_WANT_COMPAT_SYS_TIME
+
+/* compat_time_t is a 32 bit "long" and needs to get converted. */
+
+asmlinkage long compat_sys_time(compat_time_t __user * tloc)
+{
+	compat_time_t i;
+	struct timeval tv;
+
+	do_gettimeofday(&tv);
+	i = tv.tv_sec;
+
+	if (tloc) {
+		if (put_user(i,tloc))
+			i = -EFAULT;
+	}
+	return i;
+}
+
+asmlinkage long compat_sys_stime(compat_time_t __user *tptr)
+{
+	struct timespec tv;
+	int err;
+
+	if (get_user(tv.tv_sec, tptr))
+		return -EFAULT;
+
+	tv.tv_nsec = 0;
+
+	err = security_settime(&tv, NULL);
+	if (err)
+		return err;
+
+	do_settimeofday(&tv);
+	return 0;
+}
+
+#endif /* __ARCH_WANT_COMPAT_SYS_TIME */
diff -urN linux-2.6/kernel/time.c linux-2.6-compat/kernel/time.c
--- linux-2.6/kernel/time.c	2004-11-24 16:08:48.000000000 +0100
+++ linux-2.6-compat/kernel/time.c	2004-11-24 16:23:51.000000000 +0100
@@ -52,12 +52,10 @@
  * sys_gettimeofday().  Is this for backwards compatibility?  If so,
  * why not move it into the appropriate arch directory (for those
  * architectures that need it).
- *
- * XXX This function is NOT 64-bit clean!
  */
-asmlinkage long sys_time(int __user * tloc)
+asmlinkage long sys_time(time_t __user * tloc)
 {
-	int i;
+	time_t i;
 	struct timeval tv;
 
 	do_gettimeofday(&tv);
