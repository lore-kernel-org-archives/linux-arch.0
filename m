Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262803AbUKRRf3@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62103 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262796AbUKRReR
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Nov 2004 12:34:17 -0500
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id iAIHYGug197342
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 17:34:16 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAIHYEYl111624
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 18:34:15 +0100
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1CUqAi-0002BC-00
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 18:34:16 +0100
Date: Thu, 18 Nov 2004 18:34:16 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch] sys_stime needs a compat function.
Message-ID: <20041118173416.GA8360@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,
I got a bugzilla report about sys_stime failures on s390
(Suse bugzilla #48295 if anybody wants to have a look).

The problem is that time_t is defined as a "long" for the
64 bit architectures that do 32 bit system call emulation.
sys_stime gets a pointer to a time_t which needs to get
converted in a compat system call handler. I think that
of the seven 32/64 bit archs mips, parisc, s390, sparc64
and x68_64 need fixing. ia64 doesn't support sys_stime
and ppc64 has its own sys_stime functions.

blue skies,
  Martin.

---

[patch] sys_stime needs a compat function.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Convert compat_time_t to time_t in 32 bit emulation
for sys_stime.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat
 arch/mips/kernel/scall64-o32.S     |    2 +-
 arch/parisc/kernel/syscall_table.S |    2 +-
 arch/s390/kernel/compat_wrapper.S  |    4 ++--
 arch/sparc64/kernel/systbls.S      |    2 +-
 arch/x86_64/ia32/ia32entry.S       |    2 +-
 kernel/compat.c                    |   27 +++++++++++++++++++++++++++
 6 files changed, 33 insertions(+), 6 deletions(-)

diff -urN linux-2.6/arch/mips/kernel/scall64-o32.S linux-2.6-compat/arch/mips/kernel/scall64-o32.S
--- linux-2.6/arch/mips/kernel/scall64-o32.S	2004-10-18 23:53:05.000000000 +0200
+++ linux-2.6-compat/arch/mips/kernel/scall64-o32.S	2004-11-18 18:29:39.000000000 +0100
@@ -283,7 +283,7 @@
 	sys	sys_oldumount	1
 	sys	sys_setuid	1
 	sys	sys_getuid	0
-	sys	sys_stime	1			/* 4025 */
+	sys	compat_sys_stime	1			/* 4025 */
 	sys	sys32_ptrace	4
 	sys	sys_alarm	1
 	sys	sys_ni_syscall	0			/* was sys_fstat */
diff -urN linux-2.6/arch/parisc/kernel/syscall_table.S linux-2.6-compat/arch/parisc/kernel/syscall_table.S
--- linux-2.6/arch/parisc/kernel/syscall_table.S	2004-11-18 18:28:49.000000000 +0100
+++ linux-2.6-compat/arch/parisc/kernel/syscall_table.S	2004-11-18 18:29:39.000000000 +0100
@@ -91,7 +91,7 @@
 	ENTRY_SAME(bind)
 	ENTRY_SAME(setuid)
 	ENTRY_SAME(getuid)
-	ENTRY_SAME(stime)		/* 25 */
+	ENTRY_COMP(stime)		/* 25 */
 	ENTRY_SAME(ptrace)
 	ENTRY_SAME(alarm)
 	/* see stat comment */
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-compat/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2004-11-18 18:28:49.000000000 +0100
+++ linux-2.6-compat/arch/s390/kernel/compat_wrapper.S	2004-11-18 18:29:39.000000000 +0100
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
--- linux-2.6/arch/sparc64/kernel/systbls.S	2004-11-18 18:28:49.000000000 +0100
+++ linux-2.6-compat/arch/sparc64/kernel/systbls.S	2004-11-18 18:30:02.000000000 +0100
@@ -66,7 +66,7 @@
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys32_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_sys_statfs64
+/*230*/	.word sys32_select, sys_time, sys_nis_syscall, compat_sys_stime, compat_sys_statfs64
 	.word compat_sys_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys32_mlockall
 /*240*/	.word sys_munlockall, sys32_sched_setparam, sys32_sched_getparam, sys32_sched_setscheduler, sys32_sched_getscheduler
 	.word sys_sched_yield, sys32_sched_get_priority_max, sys32_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
diff -urN linux-2.6/arch/x86_64/ia32/ia32entry.S linux-2.6-compat/arch/x86_64/ia32/ia32entry.S
--- linux-2.6/arch/x86_64/ia32/ia32entry.S	2004-11-18 18:28:49.000000000 +0100
+++ linux-2.6-compat/arch/x86_64/ia32/ia32entry.S	2004-11-18 18:29:39.000000000 +0100
@@ -327,7 +327,7 @@
 	.quad sys_oldumount	/* old_umount  */
 	.quad sys_setuid16
 	.quad sys_getuid16
-	.quad sys_stime		/* stime */		/* 25 */
+	.quad compat_sys_stime	/* stime */		/* 25 */
 	.quad sys32_ptrace	/* ptrace */
 	.quad sys_alarm
 	.quad sys_fstat	/* (old)fstat */
diff -urN linux-2.6/kernel/compat.c linux-2.6-compat/kernel/compat.c
--- linux-2.6/kernel/compat.c	2004-11-18 18:29:02.000000000 +0100
+++ linux-2.6-compat/kernel/compat.c	2004-11-18 18:29:39.000000000 +0100
@@ -680,3 +680,30 @@
 
 	return 0;
 }
+
+#ifdef __ARCH_WANT_SYS_TIME
+
+/*
+ * sys_stime() can be implemented in user-level using
+ * sys_settimeofday().  Is this for backwards compatibility?  If so,
+ * why not move it into the appropriate arch directory (for those
+ * architectures that need it).
+ */
+ 
+asmlinkage long compat_sys_stime(compat_time_t __user *tptr)
+{
+	struct timespec tv;
+	compat_time_t time;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+	if (get_user(time, tptr))
+		return -EFAULT;
+
+	tv.tv_sec = (time_t) time;
+	tv.tv_nsec = 0;
+	do_settimeofday(&tv);
+	return 0;
+}
+
+#endif /* __ARCH_WANT_SYS_TIME */
