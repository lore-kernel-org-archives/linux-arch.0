Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:46996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263234AbUCTFtq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 00:49:46 -0500
Date: Fri, 19 Mar 2004 21:49:49 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: compat-signal-noarch-2004-01-29.patch again
Message-Id: <20040319214949.6b7d50bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Carlos O'Donell <carlos@baldric.uwo.ca>
List-ID: <linux-arch.vger.kernel.org>


This patch continues to hang around at Morton manor.  last time it was
discussed Andi had issues with it and thing petered out.

Can we please wrap this up one ay or the other?



From: "Carlos O'Donell" <carlos@baldric.uwo.ca>

These changes allow 64-bit arches to copy siginfo_t to a 32-bit userspace in
a generic fashion.  All 64-bit arches with compat 32-bit tasks can take
advantage of the generic code.  hppa64 already uses this code, with ia64 and
ppc64 changes in the works.

Most arches use the asm-generic/siginfo.h definition.  For those arches with
64-bit platforms, and requiring compat with 32-bit tasks, we create a generic
layer for copying siginfo_t structures to userspace.  First we define the
required compat_ structures in include/asm-generic/compat_signal.h and in
include/linux/compat_siginfo.h.  The latter is not in asm-generic, because
doing so would require that all arches add an asm/compat_siginfo.h for the
generic code to work.

Next we implement a generic compat_copy_siginfo_to_user in
kernel/compat_signal.c.  To make use of the compat copy routine we add a
check in kernel/signal.c to determine if the task requires a compat copy, and
if so, call compat_copy_siginfo_to_user instead.



---

 25-akpm/include/asm-generic/compat_signal.h |   25 ++++
 25-akpm/include/asm-ia64/compat.h           |    1 
 25-akpm/include/asm-ppc64/compat.h          |    1 
 25-akpm/include/asm-ppc64/ppc32.h           |   64 ----------
 25-akpm/include/asm-sparc64/compat.h        |    1 
 25-akpm/include/linux/compat.h              |   18 +-
 25-akpm/include/linux/compat_siginfo.h      |  170 ++++++++++++++++++++++++++++
 25-akpm/kernel/Makefile                     |    2 
 25-akpm/kernel/compat_signal.c              |  124 ++++++++++++++++++++
 25-akpm/kernel/signal.c                     |    7 +
 10 files changed, 343 insertions(+), 70 deletions(-)

diff -puN /dev/null include/asm-generic/compat_signal.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/asm-generic/compat_signal.h	Mon Mar 15 14:25:21 2004
@@ -0,0 +1,25 @@
+#ifndef _ASM_GENERIC_COMPAT_SIGNAL_H
+#define _ASM_GENERIC_COMPAT_SIGNAL_H
+
+#ifndef __ASSEMBLY__
+#include <linux/compat.h>
+
+typedef compat_uptr_t compat_sighandler_t;
+
+typedef struct compat_sigaltstack {
+	compat_uptr_t ss_sp;
+	compat_int_t ss_flags;
+	compat_size_t ss_size;
+} compat_stack_t;
+
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+struct compat_sigaction {
+	compat_sighandler_t sa_handler;
+	compat_uint_t sa_flags;
+	compat_sigset_t sa_mask;		/* mask last for extensibility */
+};
+
+#endif /* !__ASSEMBLY__ */
+#endif /* !_ASM_GENERIC_COMPAT_SIGNAL_H */
diff -puN include/linux/compat.h~compat-signal-noarch-2004-01-29 include/linux/compat.h
--- 25/include/linux/compat.h~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/include/linux/compat.h	Mon Mar 15 14:26:44 2004
@@ -6,10 +6,16 @@
  */
 #include <linux/config.h>
 
-#ifdef CONFIG_COMPAT
+#ifndef CONFIG_COMPAT
 
+/* Non-native task requiring compat... doesn't exist */
+#define is_compat_task(x) 0
+
+#else
+
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/personality.h>  /* Conditional process compat */
 #include <linux/sem.h>
 
 #include <asm/compat.h>
@@ -17,6 +23,11 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+/* Non-native task requiring compat */
+#ifndef HAVE_ARCH_IS_COMPAT_TASK
+#define is_compat_task(x) (x->personality == PER_LINUX32)
+#endif
+
 struct compat_itimerspec { 
 	struct compat_timespec it_interval;
 	struct compat_timespec it_value;
@@ -85,11 +96,6 @@ struct compat_dirent {
 	char		d_name[256];
 };
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
 long compat_sys_semctl(int first, int second, int third, void __user *uptr);
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr);
 long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
diff -puN /dev/null include/linux/compat_siginfo.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/include/linux/compat_siginfo.h	Mon Mar 15 14:25:21 2004
@@ -0,0 +1,170 @@
+#ifndef _ASM_GENERIC_COMPAT_SIGINFO_H
+#define _ASM_GENERIC_COMPAT_SIGINFO_H
+
+#include <linux/config.h>
+#include <linux/compat.h>
+
+#ifndef CONFIG_COMPAT
+
+/* No compatibility layer required, add empty definitions for the compiler */
+
+typedef struct compat_siginfo{
+} compat_siginfo_t;
+
+static inline int compat_copy_siginfo_to_user(compat_siginfo_t __user *to,
+						struct siginfo *from)
+{
+	return -1;
+}
+
+#else
+
+#include <linux/compiler.h>
+#include <asm/siginfo.h>
+
+/* compat view of sigval_t */
+typedef union compat_sigval {
+	compat_int_t sival_int;
+	compat_uptr_t sival_ptr;
+} compat_sigval_t;
+
+/*
+ * This is the size (including padding) of the part of the
+ * struct siginfo that is before the union.
+ */
+#ifndef __ARCH_SI_COMPAT_PREAMBLE_SIZE
+#define __ARCH_SI_COMPAT_PREAMBLE_SIZE	(3 * sizeof(int))
+#endif
+
+#define SI_COMPAT_MAX_SIZE	128
+#ifndef SI_COMPAT_PAD_SIZE
+#define SI_COMPAT_PAD_SIZE	((SI_COMPAT_MAX_SIZE - __ARCH_SI_COMPAT_PREAMBLE_SIZE) / sizeof(int))
+#endif
+
+/* 32-bit view of si.uid_t */
+#ifndef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T compat_uid_t
+#endif
+
+/* 32-bit view of si.band_t */
+#ifndef __ARCH_SI_COMPAT_BAND_T
+#define __ARCH_SI_COMPAT_BAND_T compat_int_t
+#endif
+
+#ifndef HAVE_ARCH_COMPAT_SIGINFO_T
+
+/* Compat view of siginfo_t */
+typedef struct compat_siginfo {
+	compat_int_t si_signo;
+	compat_int_t si_errno;
+	compat_int_t si_code;
+
+	union {
+		compat_int_t _pad[SI_COMPAT_PAD_SIZE];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			compat_timer_t _tid;	/* timer id */
+			compat_int_t _overrun;		/* overrun count */
+			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
+			compat_sigval_t _sigval;	/* same as below */
+			compat_int_t _sys_private;       /* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;		/* which child */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+			compat_int_t _status;		/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			compat_uptr_t _addr; /* faulting insn/memory ref. */
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+			compat_int_t _trapno;	/* TRAP # which caused the signal */
+#endif
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			__ARCH_SI_COMPAT_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			compat_int_t _fd;
+		} _sigpoll;
+	} _sifields;
+} compat_siginfo_t;
+#endif /* !HAVE_ARCH_COMPAT_SIGINFO_T */
+
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+#define si_trapno	_sifields._sigfault._trapno
+#endif
+
+/*
+ * sigevent definitions
+ *
+ * It seems likely that SIGEV_THREAD will have to be handled from
+ * userspace, libpthread transmuting it to SIGEV_SIGNAL, which the
+ * thread manager then catches and does the appropriate nonsense.
+ * However, everything is written out here so as to not get lost.
+ */
+
+#define SIGEV_COMPAT_MAX_SIZE	64
+#ifndef SIGEV_COMPAT_PAD_SIZE
+#define SIGEV_COMPAT_PAD_SIZE	((SIGEV_COMPAT_MAX_SIZE/sizeof(int)) - 3)
+#endif
+
+#ifndef HAVE_ARCH_COMPAT_SIGEVENT_T
+
+/* 32-bit view of sigevent_t */
+typedef struct compat_sigevent {
+	compat_sigval_t sigev_value;
+	compat_int_t sigev_signo;
+	compat_int_t sigev_notify;
+	union {
+		compat_int_t _pad[SIGEV_COMPAT_PAD_SIZE];
+		compat_int_t _tid;
+
+		struct {
+			compat_uptr_t _function;
+			compat_uptr_t _attribute;	/* really pthread_attr_t */
+		} _sigev_thread;
+	} _sigev_un;
+} compat_sigevent_t;
+
+#endif /* HAVE_ARCH_COMPAT_SIGEVENT_T */
+
+#ifndef HAVE_ARCH_COMPAT_COPY_SIGINFO
+
+#include <linux/string.h>
+
+static inline void compat_copy_siginfo(struct compat_siginfo *to, struct compat_siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, __ARCH_SI_COMPAT_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
+}
+
+#endif /* !HAVE_ARCH_COMPAT_COPY_SIGINFO */
+
+extern int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, struct siginfo *from);
+
+#endif /* CONFIG_COMPAT */
+#endif /* _ASM_GENERIC_COMPAT_SIGINFO_H */
+
diff -puN /dev/null kernel/compat_signal.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/kernel/compat_signal.c	Mon Mar 15 14:25:21 2004
@@ -0,0 +1,124 @@
+/*
+ *  Copyright (C) 2003 Carlos O'Donell
+ *
+ *  2003-12-20  Carlos O'Donell
+ *              Copied linux/kernel/compat_signal.c (copy_siginfo_to_user)
+ *              and modified to use compat_siginfo_t for thunking down to
+ *              32-bit userspace from a 64-bit kernel.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/compat_siginfo.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+#include <asm/siginfo.h>
+
+#ifndef HAVE_ARCH_COMPAT_COPY_SIGINFO_TO_USER
+
+int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, siginfo_t *from)
+{
+	int err;
+	compat_siginfo_t compat_from;
+
+	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
+		return -EFAULT;
+
+	/*
+	 * If you change compat_siginfo_t structure *or* siginfo_t,
+	 * please be sure this code is fixed accordingly.
+	 * It should never copy any pad contained in the structure
+	 * to avoid security leaks, but must copy the generic
+	 * 3 ints plus the relevant union member.
+	 */
+
+	/* Convert structure, don't leak anything in the copy */
+	memset(&compat_from,'\0',sizeof(compat_siginfo_t));
+	compat_from.si_signo = (compat_int_t)(from->si_signo);
+	compat_from.si_errno = (compat_int_t)(from->si_errno);
+	compat_from.si_code = (compat_int_t)(from->si_code);
+
+	if (from->si_code < 0)
+		return __copy_to_user(to, &compat_from, sizeof(compat_siginfo_t))
+			? -EFAULT : 0;
+
+	err = __put_user(compat_from.si_signo, &to->si_signo);
+	err |= __put_user(compat_from.si_errno, &to->si_errno);
+	err |= __put_user(compat_from.si_code, &to->si_code);
+
+	switch (from->si_code & __SI_MASK) {
+	case __SI_KILL:
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		break;
+	case __SI_TIMER:
+		compat_from.si_pid = (compat_timer_t)(from->si_tid);
+		compat_from.si_overrun = (compat_int_t)(from->si_overrun);
+		compat_from.si_ptr = (compat_uptr_t)((u64)(from->si_ptr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_tid, &to->si_tid);
+		err |= __put_user(compat_from.si_overrun, &to->si_overrun);
+		err |= __put_user(compat_from.si_ptr, &to->si_ptr);
+		break;
+	case __SI_POLL:
+		compat_from.si_band = (__ARCH_SI_COMPAT_BAND_T)(from->si_band);
+		compat_from.si_fd = (compat_int_t)(from->si_fd);
+		err |= __put_user(compat_from.si_band, &to->si_band);
+		err |= __put_user(compat_from.si_fd, &to->si_fd);
+		break;
+	case __SI_FAULT:
+		compat_from.si_addr = (compat_uptr_t)((u64)(from->si_addr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_addr, &to->si_addr);
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+		compat_from.si_trapno = (compat_int_t)(from->si_addr);
+		err |= __put_user(compat_from.si_trapno, &to->si_trapno);
+#endif
+		break;
+	case __SI_CHLD:
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		compat_from.si_status = (compat_int_t)(from->si_status);
+		compat_from.si_utime = (compat_clock_t)(from->si_utime);
+		compat_from.si_stime = (compat_clock_t)(from->si_stime);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		err |= __put_user(compat_from.si_status, &to->si_status);
+		err |= __put_user(compat_from.si_utime, &to->si_utime);
+		err |= __put_user(compat_from.si_stime, &to->si_stime);
+		break;
+	case __SI_RT: /* This is not generated by the kernel as of now. */
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		compat_from.si_int = (compat_int_t)(from->si_int);
+		compat_from.si_ptr = (compat_uptr_t)((u64)(from->si_ptr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		err |= __put_user(compat_from.si_int, &to->si_int);
+		err |= __put_user(compat_from.si_ptr, &to->si_ptr);
+		break;
+	default: /* this is just in case for now ... */
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		break;
+	}
+	return err;
+}
+
+#endif
diff -puN kernel/Makefile~compat-signal-noarch-2004-01-29 kernel/Makefile
--- 25/kernel/Makefile~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/kernel/Makefile	Mon Mar 15 14:25:21 2004
@@ -17,7 +17,7 @@ obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_COMPAT) += compat.o compat_signal.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
diff -puN kernel/signal.c~compat-signal-noarch-2004-01-29 kernel/signal.c
--- 25/kernel/signal.c~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/kernel/signal.c	Mon Mar 15 14:25:21 2004
@@ -21,6 +21,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/compat_siginfo.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -2009,6 +2010,12 @@ int copy_siginfo_to_user(siginfo_t __use
 	if (from->si_code < 0)
 		return __copy_to_user(to, from, sizeof(siginfo_t))
 			? -EFAULT : 0;
+
+	/* Use compat_siginfo_t with 32-bit signals */
+	if(is_compat_task(current)){
+		return compat_copy_siginfo_to_user((compat_siginfo_t __user *)to,from);
+	}
+
 	/*
 	 * If you change siginfo_t structure, please be sure
 	 * this code is fixed accordingly.
diff -puN include/asm-ppc64/compat.h~compat-signal-noarch-2004-01-29 include/asm-ppc64/compat.h
--- 25/include/asm-ppc64/compat.h~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/include/asm-ppc64/compat.h	Mon Mar 15 14:25:21 2004
@@ -25,6 +25,7 @@ typedef u16		compat_ipc_pid_t;
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef u32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -puN include/asm-ppc64/ppc32.h~compat-signal-noarch-2004-01-29 include/asm-ppc64/ppc32.h
--- 25/include/asm-ppc64/ppc32.h~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/include/asm-ppc64/ppc32.h	Mon Mar 15 14:25:21 2004
@@ -2,6 +2,7 @@
 #define _PPC64_PPC32_H
 
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
@@ -40,55 +41,6 @@
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			compat_uid_t _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			compat_uid_t _uid;		/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			compat_uid_t _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			unsigned int _addr; /* faulting insn/memory ref. */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
-
 #define __old_sigaction32	old_sigaction32
 
 struct __old_sigaction32 {
@@ -141,20 +93,6 @@ struct ucontext32 { 
 	struct mcontext32	uc_mcontext;
 };
 
-typedef struct compat_sigevent {
-	compat_sigval_t sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[SIGEV_PAD_SIZE];
-		int _tid;
-		struct {
-			compat_uptr_t _function;
-			compat_uptr_t _attribute;
-		} _sigev_thread;
-	} _sigev_un;
-} compat_sigevent_t;
-
 struct ipc_kludge_32 {
 	unsigned int msgp;
 	int msgtyp;
diff -puN include/asm-ia64/compat.h~compat-signal-noarch-2004-01-29 include/asm-ia64/compat.h
--- 25/include/asm-ia64/compat.h~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/include/asm-ia64/compat.h	Mon Mar 15 14:25:21 2004
@@ -27,6 +27,7 @@ typedef u16		compat_ipc_pid_t;
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef u32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -puN include/asm-sparc64/compat.h~compat-signal-noarch-2004-01-29 include/asm-sparc64/compat.h
--- 25/include/asm-sparc64/compat.h~compat-signal-noarch-2004-01-29	Mon Mar 15 14:25:21 2004
+++ 25-akpm/include/asm-sparc64/compat.h	Mon Mar 15 14:25:21 2004
@@ -29,6 +29,7 @@ typedef s32		compat_int_t;
 typedef s32		compat_long_t;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u32		compat_timer_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;

_
