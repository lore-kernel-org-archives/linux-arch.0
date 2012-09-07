Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34570 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab2IGQ16 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:58 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 21/31] arm64: 32-bit (compat) applications support
Date: Fri,  7 Sep 2012 17:26:56 +0100
Message-ID: <1347035226-18649-22-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162656.1-cvvQpwJqleN3hF8UCBwuxxHrfsqXRsxmL6Gl7zmXU@z>

From: Will Deacon <will.deacon@arm.com>

This patch adds support for 32-bit applications. The vectors page is a
binary blob mapped into the application user space at 0xffff0000 (the
AArch64 toolchain does not support compilation of AArch32 code). Full
compatibility with ARMv7 user space is supported. The use of deprecated
ARMv7 functionality (SWP, CP15 barriers) has been disabled by default on
AArch64 kernels and unaligned LDM/STM is not supported.

Please note that only the ARM 32-bit EABI is supported, so no OABI
compatibility.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/compat.h   |  242 ++++++++++
 arch/arm64/include/asm/signal32.h |   53 +++
 arch/arm64/include/asm/unistd32.h |  758 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kuser32.S       |   77 ++++
 arch/arm64/kernel/signal32.c      |  876 +++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/sys32.S         |  282 ++++++++++++
 arch/arm64/kernel/sys_compat.c    |  164 +++++++
 7 files changed, 2452 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/compat.h
 create mode 100644 arch/arm64/include/asm/signal32.h
 create mode 100644 arch/arm64/include/asm/unistd32.h
 create mode 100644 arch/arm64/kernel/kuser32.S
 create mode 100644 arch/arm64/kernel/signal32.c
 create mode 100644 arch/arm64/kernel/sys32.S
 create mode 100644 arch/arm64/kernel/sys_compat.c

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compa=
t.h
new file mode 100644
index 0000000..a670a33
--- /dev/null
+++ b/arch/arm64/include/asm/compat.h
@@ -0,0 +1,242 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_COMPAT_H
+#define __ASM_COMPAT_H
+#ifdef __KERNEL__
+#ifdef CONFIG_COMPAT
+
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+
+#define COMPAT_USER_HZ=09=09100
+#define COMPAT_UTS_MACHINE=09"armv8l\0\0"
+
+typedef u32=09=09compat_size_t;
+typedef s32=09=09compat_ssize_t;
+typedef s32=09=09compat_time_t;
+typedef s32=09=09compat_clock_t;
+typedef s32=09=09compat_pid_t;
+typedef u32=09=09__compat_uid_t;
+typedef u32=09=09__compat_gid_t;
+typedef u32=09=09__compat_uid32_t;
+typedef u32=09=09__compat_gid32_t;
+typedef u32=09=09compat_mode_t;
+typedef u32=09=09compat_ino_t;
+typedef u32=09=09compat_dev_t;
+typedef s32=09=09compat_off_t;
+typedef s64=09=09compat_loff_t;
+typedef s16=09=09compat_nlink_t;
+typedef u16=09=09compat_ipc_pid_t;
+typedef s32=09=09compat_daddr_t;
+typedef u32=09=09compat_caddr_t;
+typedef __kernel_fsid_t=09compat_fsid_t;
+typedef s32=09=09compat_key_t;
+typedef s32=09=09compat_timer_t;
+
+typedef s32=09=09compat_int_t;
+typedef s32=09=09compat_long_t;
+typedef s64=09=09compat_s64;
+typedef u32=09=09compat_uint_t;
+typedef u32=09=09compat_ulong_t;
+typedef u64=09=09compat_u64;
+
+struct compat_timespec {
+=09compat_time_t=09tv_sec;
+=09s32=09=09tv_nsec;
+};
+
+struct compat_timeval {
+=09compat_time_t=09tv_sec;
+=09s32=09=09tv_usec;
+};
+
+struct compat_stat {
+=09compat_dev_t=09st_dev;
+=09compat_ino_t=09st_ino;
+=09compat_mode_t=09st_mode;
+=09compat_nlink_t=09st_nlink;
+=09__compat_uid32_t=09st_uid;
+=09__compat_gid32_t=09st_gid;
+=09compat_dev_t=09st_rdev;
+=09compat_off_t=09st_size;
+=09compat_off_t=09st_blksize;
+=09compat_off_t=09st_blocks;
+=09compat_time_t=09st_atime;
+=09u32=09=09st_atime_nsec;
+=09compat_time_t=09st_mtime;
+=09u32=09=09st_mtime_nsec;
+=09compat_time_t=09st_ctime;
+=09u32=09=09st_ctime_nsec;
+=09u32=09=09__unused4[2];
+};
+
+struct compat_flock {
+=09short=09=09l_type;
+=09short=09=09l_whence;
+=09compat_off_t=09l_start;
+=09compat_off_t=09l_len;
+=09compat_pid_t=09l_pid;
+};
+
+#define F_GETLK64=0912=09/*  using 'struct flock64' */
+#define F_SETLK64=0913
+#define F_SETLKW64=0914
+
+struct compat_flock64 {
+=09short=09=09l_type;
+=09short=09=09l_whence;
+=09compat_loff_t=09l_start;
+=09compat_loff_t=09l_len;
+=09compat_pid_t=09l_pid;
+};
+
+struct compat_statfs {
+=09int=09=09f_type;
+=09int=09=09f_bsize;
+=09int=09=09f_blocks;
+=09int=09=09f_bfree;
+=09int=09=09f_bavail;
+=09int=09=09f_files;
+=09int=09=09f_ffree;
+=09compat_fsid_t=09f_fsid;
+=09int=09=09f_namelen;=09/* SunOS ignores this field. */
+=09int=09=09f_frsize;
+=09int=09=09f_flags;
+=09int=09=09f_spare[4];
+};
+
+#define COMPAT_RLIM_INFINITY=09=090xffffffff
+
+typedef u32=09=09compat_old_sigset_t;
+
+#define _COMPAT_NSIG=09=0964
+#define _COMPAT_NSIG_BPW=0932
+
+typedef u32=09=09compat_sigset_word;
+
+#define COMPAT_OFF_T_MAX=090x7fffffff
+#define COMPAT_LOFF_T_MAX=090x7fffffffffffffffL
+
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately converted them already.
+ */
+typedef=09u32=09=09compat_uptr_t;
+
+static inline void __user *compat_ptr(compat_uptr_t uptr)
+{
+=09return (void __user *)(unsigned long)uptr;
+}
+
+static inline compat_uptr_t ptr_to_compat(void __user *uptr)
+{
+=09return (u32)(unsigned long)uptr;
+}
+
+static inline void __user *arch_compat_alloc_user_space(long len)
+{
+=09struct pt_regs *regs =3D task_pt_regs(current);
+=09return (void __user *)regs->compat_sp - len;
+}
+
+struct compat_ipc64_perm {
+=09compat_key_t key;
+=09__compat_uid32_t uid;
+=09__compat_gid32_t gid;
+=09__compat_uid32_t cuid;
+=09__compat_gid32_t cgid;
+=09unsigned short mode;
+=09unsigned short __pad1;
+=09unsigned short seq;
+=09unsigned short __pad2;
+=09compat_ulong_t unused1;
+=09compat_ulong_t unused2;
+};
+
+struct compat_semid64_ds {
+=09struct compat_ipc64_perm sem_perm;
+=09compat_time_t  sem_otime;
+=09compat_ulong_t __unused1;
+=09compat_time_t  sem_ctime;
+=09compat_ulong_t __unused2;
+=09compat_ulong_t sem_nsems;
+=09compat_ulong_t __unused3;
+=09compat_ulong_t __unused4;
+};
+
+struct compat_msqid64_ds {
+=09struct compat_ipc64_perm msg_perm;
+=09compat_time_t  msg_stime;
+=09compat_ulong_t __unused1;
+=09compat_time_t  msg_rtime;
+=09compat_ulong_t __unused2;
+=09compat_time_t  msg_ctime;
+=09compat_ulong_t __unused3;
+=09compat_ulong_t msg_cbytes;
+=09compat_ulong_t msg_qnum;
+=09compat_ulong_t msg_qbytes;
+=09compat_pid_t   msg_lspid;
+=09compat_pid_t   msg_lrpid;
+=09compat_ulong_t __unused4;
+=09compat_ulong_t __unused5;
+};
+
+struct compat_shmid64_ds {
+=09struct compat_ipc64_perm shm_perm;
+=09compat_size_t  shm_segsz;
+=09compat_time_t  shm_atime;
+=09compat_ulong_t __unused1;
+=09compat_time_t  shm_dtime;
+=09compat_ulong_t __unused2;
+=09compat_time_t  shm_ctime;
+=09compat_ulong_t __unused3;
+=09compat_pid_t   shm_cpid;
+=09compat_pid_t   shm_lpid;
+=09compat_ulong_t shm_nattch;
+=09compat_ulong_t __unused4;
+=09compat_ulong_t __unused5;
+};
+
+static inline int is_compat_task(void)
+{
+=09return test_thread_flag(TIF_32BIT);
+}
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+=09return test_ti_thread_flag(thread, TIF_32BIT);
+}
+
+#else /* !CONFIG_COMPAT */
+
+static inline int is_compat_task(void)
+{
+=09return 0;
+}
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+=09return 0;
+}
+
+#endif /* CONFIG_COMPAT */
+#endif /* __KERNEL__ */
+#endif /* __ASM_COMPAT_H */
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/sig=
nal32.h
new file mode 100644
index 0000000..7c275e3
--- /dev/null
+++ b/arch/arm64/include/asm/signal32.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SIGNAL32_H
+#define __ASM_SIGNAL32_H
+
+#ifdef __KERNEL__
+#ifdef CONFIG_COMPAT
+#include <linux/compat.h>
+
+#define AARCH32_KERN_SIGRET_CODE_OFFSET=090x500
+
+extern const compat_ulong_t aarch32_sigret_code[6];
+
+int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
+=09=09       struct pt_regs *regs);
+int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *inf=
o,
+=09=09=09  sigset_t *set, struct pt_regs *regs);
+
+void compat_setup_restart_syscall(struct pt_regs *regs);
+#else
+
+static inline int compat_setup_frame(int usid, struct k_sigaction *ka,
+=09=09=09=09     sigset_t *set, struct pt_regs *regs)
+{
+=09return -ENOSYS;
+}
+
+static inline int compat_setup_rt_frame(int usig, struct k_sigaction *ka,
+=09=09=09=09=09siginfo_t *info, sigset_t *set,
+=09=09=09=09=09struct pt_regs *regs)
+{
+=09return -ENOSYS;
+}
+
+static inline void compat_setup_restart_syscall(struct pt_regs *regs)
+{
+}
+#endif /* CONFIG_COMPAT */
+#endif /* __KERNEL__ */
+#endif /* __ASM_SIGNAL32_H */
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/uni=
std32.h
new file mode 100644
index 0000000..a50405f
--- /dev/null
+++ b/arch/arm64/include/asm/unistd32.h
@@ -0,0 +1,758 @@
+/*
+ * Based on arch/arm/include/asm/unistd.h
+ *
+ * Copyright (C) 2001-2005 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#if !defined(__ASM_UNISTD32_H) || defined(__SYSCALL)
+#define __ASM_UNISTD32_H
+
+#ifndef __SYSCALL
+#define __SYSCALL(x, y)
+#endif
+
+/*
+ * This file contains the system call numbers.
+ */
+
+#ifdef __SYSCALL_COMPAT
+
+#define __NR_restart_syscall=09=090
+__SYSCALL(__NR_restart_syscall, sys_restart_syscall)
+#define __NR_exit=09=09=091
+__SYSCALL(__NR_exit, sys_exit)
+#define __NR_fork=09=09=092
+__SYSCALL(__NR_fork, sys_fork)
+#define __NR_read=09=09=093
+__SYSCALL(__NR_read, sys_read)
+#define __NR_write=09=09=094
+__SYSCALL(__NR_write, sys_write)
+#define __NR_open=09=09=095
+__SYSCALL(__NR_open, sys_open)
+#define __NR_close=09=09=096
+__SYSCALL(__NR_close, sys_close)
+__SYSCALL(7, sys_ni_syscall)=09=09/* 7 was sys_waitpid */
+#define __NR_creat=09=09=098
+__SYSCALL(__NR_creat, sys_creat)
+#define __NR_link=09=09=099
+__SYSCALL(__NR_link, sys_link)
+#define __NR_unlink=09=09=0910
+__SYSCALL(__NR_unlink, sys_unlink)
+#define __NR_execve=09=09=0911
+__SYSCALL(__NR_execve, sys_execve)
+#define __NR_chdir=09=09=0912
+__SYSCALL(__NR_chdir, sys_chdir)
+__SYSCALL(13, sys_ni_syscall)=09=09/* 13 was sys_time */
+#define __NR_mknod=09=09=0914
+__SYSCALL(__NR_mknod, sys_mknod)
+#define __NR_chmod=09=09=0915
+__SYSCALL(__NR_chmod, sys_chmod)
+#define __NR_lchown=09=09=0916
+__SYSCALL(__NR_lchown, sys_lchown16)
+__SYSCALL(17, sys_ni_syscall)=09=09/* 17 was sys_break */
+__SYSCALL(18, sys_ni_syscall)=09=09/* 18 was sys_stat */
+#define __NR_lseek=09=09=0919
+__SYSCALL(__NR_lseek, sys_lseek)
+#define __NR_getpid=09=09=0920
+__SYSCALL(__NR_getpid, sys_getpid)
+#define __NR_mount=09=09=0921
+__SYSCALL(__NR_mount, sys_mount)
+__SYSCALL(22, sys_ni_syscall)=09=09/* 22 was sys_umount */
+#define __NR_setuid=09=09=0923
+__SYSCALL(__NR_setuid, sys_setuid16)
+#define __NR_getuid=09=09=0924
+__SYSCALL(__NR_getuid, sys_getuid16)
+__SYSCALL(25, sys_ni_syscall)=09=09/* 25 was sys_stime */
+#define __NR_ptrace=09=09=0926
+__SYSCALL(__NR_ptrace, sys_ptrace)
+__SYSCALL(27, sys_ni_syscall)=09=09/* 27 was sys_alarm */
+__SYSCALL(28, sys_ni_syscall)=09=09/* 28 was sys_fstat */
+#define __NR_pause=09=09=0929
+__SYSCALL(__NR_pause, sys_pause)
+__SYSCALL(30, sys_ni_syscall)=09=09/* 30 was sys_utime */
+__SYSCALL(31, sys_ni_syscall)=09=09/* 31 was sys_stty */
+__SYSCALL(32, sys_ni_syscall)=09=09/* 32 was sys_gtty */
+#define __NR_access=09=09=0933
+__SYSCALL(__NR_access, sys_access)
+#define __NR_nice=09=09=0934
+__SYSCALL(__NR_nice, sys_nice)
+__SYSCALL(35, sys_ni_syscall)=09=09/* 35 was sys_ftime */
+#define __NR_sync=09=09=0936
+__SYSCALL(__NR_sync, sys_sync)
+#define __NR_kill=09=09=0937
+__SYSCALL(__NR_kill, sys_kill)
+#define __NR_rename=09=09=0938
+__SYSCALL(__NR_rename, sys_rename)
+#define __NR_mkdir=09=09=0939
+__SYSCALL(__NR_mkdir, sys_mkdir)
+#define __NR_rmdir=09=09=0940
+__SYSCALL(__NR_rmdir, sys_rmdir)
+#define __NR_dup=09=09=0941
+__SYSCALL(__NR_dup, sys_dup)
+#define __NR_pipe=09=09=0942
+__SYSCALL(__NR_pipe, sys_pipe)
+#define __NR_times=09=09=0943
+__SYSCALL(__NR_times, sys_times)
+__SYSCALL(44, sys_ni_syscall)=09=09/* 44 was sys_prof */
+#define __NR_brk=09=09=0945
+__SYSCALL(__NR_brk, sys_brk)
+#define __NR_setgid=09=09=0946
+__SYSCALL(__NR_setgid, sys_setgid16)
+#define __NR_getgid=09=09=0947
+__SYSCALL(__NR_getgid, sys_getgid16)
+__SYSCALL(48, sys_ni_syscall)=09=09/* 48 was sys_signal */
+#define __NR_geteuid=09=09=0949
+__SYSCALL(__NR_geteuid, sys_geteuid16)
+#define __NR_getegid=09=09=0950
+__SYSCALL(__NR_getegid, sys_getegid16)
+#define __NR_acct=09=09=0951
+__SYSCALL(__NR_acct, sys_acct)
+#define __NR_umount2=09=09=0952
+__SYSCALL(__NR_umount2, sys_umount)
+__SYSCALL(53, sys_ni_syscall)=09=09/* 53 was sys_lock */
+#define __NR_ioctl=09=09=0954
+__SYSCALL(__NR_ioctl, sys_ioctl)
+#define __NR_fcntl=09=09=0955
+__SYSCALL(__NR_fcntl, sys_fcntl)
+__SYSCALL(56, sys_ni_syscall)=09=09/* 56 was sys_mpx */
+#define __NR_setpgid=09=09=0957
+__SYSCALL(__NR_setpgid, sys_setpgid)
+__SYSCALL(58, sys_ni_syscall)=09=09/* 58 was sys_ulimit */
+__SYSCALL(59, sys_ni_syscall)=09=09/* 59 was sys_olduname */
+#define __NR_umask=09=09=0960
+__SYSCALL(__NR_umask, sys_umask)
+#define __NR_chroot=09=09=0961
+__SYSCALL(__NR_chroot, sys_chroot)
+#define __NR_ustat=09=09=0962
+__SYSCALL(__NR_ustat, sys_ustat)
+#define __NR_dup2=09=09=0963
+__SYSCALL(__NR_dup2, sys_dup2)
+#define __NR_getppid=09=09=0964
+__SYSCALL(__NR_getppid, sys_getppid)
+#define __NR_getpgrp=09=09=0965
+__SYSCALL(__NR_getpgrp, sys_getpgrp)
+#define __NR_setsid=09=09=0966
+__SYSCALL(__NR_setsid, sys_setsid)
+#define __NR_sigaction=09=09=0967
+__SYSCALL(__NR_sigaction, sys_sigaction)
+__SYSCALL(68, sys_ni_syscall)=09=09/* 68 was sys_sgetmask */
+__SYSCALL(69, sys_ni_syscall)=09=09/* 69 was sys_ssetmask */
+#define __NR_setreuid=09=09=0970
+__SYSCALL(__NR_setreuid, sys_setreuid16)
+#define __NR_setregid=09=09=0971
+__SYSCALL(__NR_setregid, sys_setregid16)
+#define __NR_sigsuspend=09=09=0972
+__SYSCALL(__NR_sigsuspend, sys_sigsuspend)
+#define __NR_sigpending=09=09=0973
+__SYSCALL(__NR_sigpending, sys_sigpending)
+#define __NR_sethostname=09=0974
+__SYSCALL(__NR_sethostname, sys_sethostname)
+#define __NR_setrlimit=09=09=0975
+__SYSCALL(__NR_setrlimit, sys_setrlimit)
+__SYSCALL(76, sys_ni_syscall)=09=09/* 76 was sys_getrlimit */
+#define __NR_getrusage=09=09=0977
+__SYSCALL(__NR_getrusage, sys_getrusage)
+#define __NR_gettimeofday=09=0978
+__SYSCALL(__NR_gettimeofday, sys_gettimeofday)
+#define __NR_settimeofday=09=0979
+__SYSCALL(__NR_settimeofday, sys_settimeofday)
+#define __NR_getgroups=09=09=0980
+__SYSCALL(__NR_getgroups, sys_getgroups16)
+#define __NR_setgroups=09=09=0981
+__SYSCALL(__NR_setgroups, sys_setgroups16)
+__SYSCALL(82, sys_ni_syscall)=09=09/* 82 was sys_select */
+#define __NR_symlink=09=09=0983
+__SYSCALL(__NR_symlink, sys_symlink)
+__SYSCALL(84, sys_ni_syscall)=09=09/* 84 was sys_lstat */
+#define __NR_readlink=09=09=0985
+__SYSCALL(__NR_readlink, sys_readlink)
+#define __NR_uselib=09=09=0986
+__SYSCALL(__NR_uselib, sys_uselib)
+#define __NR_swapon=09=09=0987
+__SYSCALL(__NR_swapon, sys_swapon)
+#define __NR_reboot=09=09=0988
+__SYSCALL(__NR_reboot, sys_reboot)
+__SYSCALL(89, sys_ni_syscall)=09=09/* 89 was sys_readdir */
+__SYSCALL(90, sys_ni_syscall)=09=09/* 90 was sys_mmap */
+#define __NR_munmap=09=09=0991
+__SYSCALL(__NR_munmap, sys_munmap)
+#define __NR_truncate=09=09=0992
+__SYSCALL(__NR_truncate, sys_truncate)
+#define __NR_ftruncate=09=09=0993
+__SYSCALL(__NR_ftruncate, sys_ftruncate)
+#define __NR_fchmod=09=09=0994
+__SYSCALL(__NR_fchmod, sys_fchmod)
+#define __NR_fchown=09=09=0995
+__SYSCALL(__NR_fchown, sys_fchown16)
+#define __NR_getpriority=09=0996
+__SYSCALL(__NR_getpriority, sys_getpriority)
+#define __NR_setpriority=09=0997
+__SYSCALL(__NR_setpriority, sys_setpriority)
+__SYSCALL(98, sys_ni_syscall)=09=09/* 98 was sys_profil */
+#define __NR_statfs=09=09=0999
+__SYSCALL(__NR_statfs, sys_statfs)
+#define __NR_fstatfs=09=09=09100
+__SYSCALL(__NR_fstatfs, sys_fstatfs)
+__SYSCALL(101, sys_ni_syscall)=09=09/* 101 was sys_ioperm */
+__SYSCALL(102, sys_ni_syscall)=09=09/* 102 was sys_socketcall */
+#define __NR_syslog=09=09=09103
+__SYSCALL(__NR_syslog, sys_syslog)
+#define __NR_setitimer=09=09=09104
+__SYSCALL(__NR_setitimer, sys_setitimer)
+#define __NR_getitimer=09=09=09105
+__SYSCALL(__NR_getitimer, sys_getitimer)
+#define __NR_stat=09=09=09106
+__SYSCALL(__NR_stat, sys_newstat)
+#define __NR_lstat=09=09=09107
+__SYSCALL(__NR_lstat, sys_newlstat)
+#define __NR_fstat=09=09=09108
+__SYSCALL(__NR_fstat, sys_newfstat)
+__SYSCALL(109, sys_ni_syscall)=09=09/* 109 was sys_uname */
+__SYSCALL(110, sys_ni_syscall)=09=09/* 110 was sys_iopl */
+#define __NR_vhangup=09=09=09111
+__SYSCALL(__NR_vhangup, sys_vhangup)
+__SYSCALL(112, sys_ni_syscall)=09=09/* 112 was sys_idle */
+__SYSCALL(113, sys_ni_syscall)=09=09/* 113 was sys_syscall */
+#define __NR_wait4=09=09=09114
+__SYSCALL(__NR_wait4, sys_wait4)
+#define __NR_swapoff=09=09=09115
+__SYSCALL(__NR_swapoff, sys_swapoff)
+#define __NR_sysinfo=09=09=09116
+__SYSCALL(__NR_sysinfo, sys_sysinfo)
+__SYSCALL(117, sys_ni_syscall)=09=09/* 117 was sys_ipc */
+#define __NR_fsync=09=09=09118
+__SYSCALL(__NR_fsync, sys_fsync)
+#define __NR_sigreturn=09=09=09119
+__SYSCALL(__NR_sigreturn, sys_sigreturn)
+#define __NR_clone=09=09=09120
+__SYSCALL(__NR_clone, sys_clone)
+#define __NR_setdomainname=09=09121
+__SYSCALL(__NR_setdomainname, sys_setdomainname)
+#define __NR_uname=09=09=09122
+__SYSCALL(__NR_uname, sys_newuname)
+__SYSCALL(123, sys_ni_syscall)=09=09/* 123 was sys_modify_ldt */
+#define __NR_adjtimex=09=09=09124
+__SYSCALL(__NR_adjtimex, sys_adjtimex)
+#define __NR_mprotect=09=09=09125
+__SYSCALL(__NR_mprotect, sys_mprotect)
+#define __NR_sigprocmask=09=09126
+__SYSCALL(__NR_sigprocmask, sys_sigprocmask)
+__SYSCALL(127, sys_ni_syscall)=09=09/* 127 was sys_create_module */
+#define __NR_init_module=09=09128
+__SYSCALL(__NR_init_module, sys_init_module)
+#define __NR_delete_module=09=09129
+__SYSCALL(__NR_delete_module, sys_delete_module)
+__SYSCALL(130, sys_ni_syscall)=09=09/* 130 was sys_get_kernel_syms */
+#define __NR_quotactl=09=09=09131
+__SYSCALL(__NR_quotactl, sys_quotactl)
+#define __NR_getpgid=09=09=09132
+__SYSCALL(__NR_getpgid, sys_getpgid)
+#define __NR_fchdir=09=09=09133
+__SYSCALL(__NR_fchdir, sys_fchdir)
+#define __NR_bdflush=09=09=09134
+__SYSCALL(__NR_bdflush, sys_bdflush)
+#define __NR_sysfs=09=09=09135
+__SYSCALL(__NR_sysfs, sys_sysfs)
+#define __NR_personality=09=09136
+__SYSCALL(__NR_personality, sys_personality)
+__SYSCALL(137, sys_ni_syscall)=09=09/* 137 was sys_afs_syscall */
+#define __NR_setfsuid=09=09=09138
+__SYSCALL(__NR_setfsuid, sys_setfsuid16)
+#define __NR_setfsgid=09=09=09139
+__SYSCALL(__NR_setfsgid, sys_setfsgid16)
+#define __NR__llseek=09=09=09140
+__SYSCALL(__NR__llseek, sys_llseek)
+#define __NR_getdents=09=09=09141
+__SYSCALL(__NR_getdents, sys_getdents)
+#define __NR__newselect=09=09=09142
+__SYSCALL(__NR__newselect, sys_select)
+#define __NR_flock=09=09=09143
+__SYSCALL(__NR_flock, sys_flock)
+#define __NR_msync=09=09=09144
+__SYSCALL(__NR_msync, sys_msync)
+#define __NR_readv=09=09=09145
+__SYSCALL(__NR_readv, sys_readv)
+#define __NR_writev=09=09=09146
+__SYSCALL(__NR_writev, sys_writev)
+#define __NR_getsid=09=09=09147
+__SYSCALL(__NR_getsid, sys_getsid)
+#define __NR_fdatasync=09=09=09148
+__SYSCALL(__NR_fdatasync, sys_fdatasync)
+#define __NR__sysctl=09=09=09149
+__SYSCALL(__NR__sysctl, sys_sysctl)
+#define __NR_mlock=09=09=09150
+__SYSCALL(__NR_mlock, sys_mlock)
+#define __NR_munlock=09=09=09151
+__SYSCALL(__NR_munlock, sys_munlock)
+#define __NR_mlockall=09=09=09152
+__SYSCALL(__NR_mlockall, sys_mlockall)
+#define __NR_munlockall=09=09=09153
+__SYSCALL(__NR_munlockall, sys_munlockall)
+#define __NR_sched_setparam=09=09154
+__SYSCALL(__NR_sched_setparam, sys_sched_setparam)
+#define __NR_sched_getparam=09=09155
+__SYSCALL(__NR_sched_getparam, sys_sched_getparam)
+#define __NR_sched_setscheduler=09=09156
+__SYSCALL(__NR_sched_setscheduler, sys_sched_setscheduler)
+#define __NR_sched_getscheduler=09=09157
+__SYSCALL(__NR_sched_getscheduler, sys_sched_getscheduler)
+#define __NR_sched_yield=09=09158
+__SYSCALL(__NR_sched_yield, sys_sched_yield)
+#define __NR_sched_get_priority_max=09159
+__SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
+#define __NR_sched_get_priority_min=09160
+__SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#define __NR_sched_rr_get_interval=09161
+__SYSCALL(__NR_sched_rr_get_interval, sys_sched_rr_get_interval)
+#define __NR_nanosleep=09=09=09162
+__SYSCALL(__NR_nanosleep, sys_nanosleep)
+#define __NR_mremap=09=09=09163
+__SYSCALL(__NR_mremap, sys_mremap)
+#define __NR_setresuid=09=09=09164
+__SYSCALL(__NR_setresuid, sys_setresuid16)
+#define __NR_getresuid=09=09=09165
+__SYSCALL(__NR_getresuid, sys_getresuid16)
+__SYSCALL(166, sys_ni_syscall)=09=09/* 166 was sys_vm86 */
+__SYSCALL(167, sys_ni_syscall)=09=09/* 167 was sys_query_module */
+#define __NR_poll=09=09=09168
+__SYSCALL(__NR_poll, sys_poll)
+#define __NR_nfsservctl=09=09=09169
+__SYSCALL(__NR_nfsservctl, sys_ni_syscall)
+#define __NR_setresgid=09=09=09170
+__SYSCALL(__NR_setresgid, sys_setresgid16)
+#define __NR_getresgid=09=09=09171
+__SYSCALL(__NR_getresgid, sys_getresgid16)
+#define __NR_prctl=09=09=09172
+__SYSCALL(__NR_prctl, sys_prctl)
+#define __NR_rt_sigreturn=09=09173
+__SYSCALL(__NR_rt_sigreturn, sys_rt_sigreturn)
+#define __NR_rt_sigaction=09=09174
+__SYSCALL(__NR_rt_sigaction, sys_rt_sigaction)
+#define __NR_rt_sigprocmask=09=09175
+__SYSCALL(__NR_rt_sigprocmask, sys_rt_sigprocmask)
+#define __NR_rt_sigpending=09=09176
+__SYSCALL(__NR_rt_sigpending, sys_rt_sigpending)
+#define __NR_rt_sigtimedwait=09=09177
+__SYSCALL(__NR_rt_sigtimedwait, sys_rt_sigtimedwait)
+#define __NR_rt_sigqueueinfo=09=09178
+__SYSCALL(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo)
+#define __NR_rt_sigsuspend=09=09179
+__SYSCALL(__NR_rt_sigsuspend, sys_rt_sigsuspend)
+#define __NR_pread64=09=09=09180
+__SYSCALL(__NR_pread64, sys_pread64)
+#define __NR_pwrite64=09=09=09181
+__SYSCALL(__NR_pwrite64, sys_pwrite64)
+#define __NR_chown=09=09=09182
+__SYSCALL(__NR_chown, sys_chown16)
+#define __NR_getcwd=09=09=09183
+__SYSCALL(__NR_getcwd, sys_getcwd)
+#define __NR_capget=09=09=09184
+__SYSCALL(__NR_capget, sys_capget)
+#define __NR_capset=09=09=09185
+__SYSCALL(__NR_capset, sys_capset)
+#define __NR_sigaltstack=09=09186
+__SYSCALL(__NR_sigaltstack, sys_sigaltstack)
+#define __NR_sendfile=09=09=09187
+__SYSCALL(__NR_sendfile, sys_sendfile)
+__SYSCALL(188, sys_ni_syscall)=09=09/* 188 reserved */
+__SYSCALL(189, sys_ni_syscall)=09=09/* 189 reserved */
+#define __NR_vfork=09=09=09190
+__SYSCALL(__NR_vfork, sys_vfork)
+#define __NR_ugetrlimit=09=09=09191=09/* SuS compliant getrlimit */
+__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
+#define __NR_mmap2=09=09=09192
+__SYSCALL(__NR_mmap2, sys_mmap2)
+#define __NR_truncate64=09=09=09193
+__SYSCALL(__NR_truncate64, sys_truncate64)
+#define __NR_ftruncate64=09=09194
+__SYSCALL(__NR_ftruncate64, sys_ftruncate64)
+#define __NR_stat64=09=09=09195
+__SYSCALL(__NR_stat64, sys_stat64)
+#define __NR_lstat64=09=09=09196
+__SYSCALL(__NR_lstat64, sys_lstat64)
+#define __NR_fstat64=09=09=09197
+__SYSCALL(__NR_fstat64, sys_fstat64)
+#define __NR_lchown32=09=09=09198
+__SYSCALL(__NR_lchown32, sys_lchown)
+#define __NR_getuid32=09=09=09199
+__SYSCALL(__NR_getuid32, sys_getuid)
+#define __NR_getgid32=09=09=09200
+__SYSCALL(__NR_getgid32, sys_getgid)
+#define __NR_geteuid32=09=09=09201
+__SYSCALL(__NR_geteuid32, sys_geteuid)
+#define __NR_getegid32=09=09=09202
+__SYSCALL(__NR_getegid32, sys_getegid)
+#define __NR_setreuid32=09=09=09203
+__SYSCALL(__NR_setreuid32, sys_setreuid)
+#define __NR_setregid32=09=09=09204
+__SYSCALL(__NR_setregid32, sys_setregid)
+#define __NR_getgroups32=09=09205
+__SYSCALL(__NR_getgroups32, sys_getgroups)
+#define __NR_setgroups32=09=09206
+__SYSCALL(__NR_setgroups32, sys_setgroups)
+#define __NR_fchown32=09=09=09207
+__SYSCALL(__NR_fchown32, sys_fchown)
+#define __NR_setresuid32=09=09208
+__SYSCALL(__NR_setresuid32, sys_setresuid)
+#define __NR_getresuid32=09=09209
+__SYSCALL(__NR_getresuid32, sys_getresuid)
+#define __NR_setresgid32=09=09210
+__SYSCALL(__NR_setresgid32, sys_setresgid)
+#define __NR_getresgid32=09=09211
+__SYSCALL(__NR_getresgid32, sys_getresgid)
+#define __NR_chown32=09=09=09212
+__SYSCALL(__NR_chown32, sys_chown)
+#define __NR_setuid32=09=09=09213
+__SYSCALL(__NR_setuid32, sys_setuid)
+#define __NR_setgid32=09=09=09214
+__SYSCALL(__NR_setgid32, sys_setgid)
+#define __NR_setfsuid32=09=09=09215
+__SYSCALL(__NR_setfsuid32, sys_setfsuid)
+#define __NR_setfsgid32=09=09=09216
+__SYSCALL(__NR_setfsgid32, sys_setfsgid)
+#define __NR_getdents64=09=09=09217
+__SYSCALL(__NR_getdents64, sys_getdents64)
+#define __NR_pivot_root=09=09=09218
+__SYSCALL(__NR_pivot_root, sys_pivot_root)
+#define __NR_mincore=09=09=09219
+__SYSCALL(__NR_mincore, sys_mincore)
+#define __NR_madvise=09=09=09220
+__SYSCALL(__NR_madvise, sys_madvise)
+#define __NR_fcntl64=09=09=09221
+__SYSCALL(__NR_fcntl64, sys_fcntl64)
+__SYSCALL(222, sys_ni_syscall)=09=09/* 222 for tux */
+__SYSCALL(223, sys_ni_syscall)=09=09/* 223 is unused */
+#define __NR_gettid=09=09=09224
+__SYSCALL(__NR_gettid, sys_gettid)
+#define __NR_readahead=09=09=09225
+__SYSCALL(__NR_readahead, sys_readahead)
+#define __NR_setxattr=09=09=09226
+__SYSCALL(__NR_setxattr, sys_setxattr)
+#define __NR_lsetxattr=09=09=09227
+__SYSCALL(__NR_lsetxattr, sys_lsetxattr)
+#define __NR_fsetxattr=09=09=09228
+__SYSCALL(__NR_fsetxattr, sys_fsetxattr)
+#define __NR_getxattr=09=09=09229
+__SYSCALL(__NR_getxattr, sys_getxattr)
+#define __NR_lgetxattr=09=09=09230
+__SYSCALL(__NR_lgetxattr, sys_lgetxattr)
+#define __NR_fgetxattr=09=09=09231
+__SYSCALL(__NR_fgetxattr, sys_fgetxattr)
+#define __NR_listxattr=09=09=09232
+__SYSCALL(__NR_listxattr, sys_listxattr)
+#define __NR_llistxattr=09=09=09233
+__SYSCALL(__NR_llistxattr, sys_llistxattr)
+#define __NR_flistxattr=09=09=09234
+__SYSCALL(__NR_flistxattr, sys_flistxattr)
+#define __NR_removexattr=09=09235
+__SYSCALL(__NR_removexattr, sys_removexattr)
+#define __NR_lremovexattr=09=09236
+__SYSCALL(__NR_lremovexattr, sys_lremovexattr)
+#define __NR_fremovexattr=09=09237
+__SYSCALL(__NR_fremovexattr, sys_fremovexattr)
+#define __NR_tkill=09=09=09238
+__SYSCALL(__NR_tkill, sys_tkill)
+#define __NR_sendfile64=09=09=09239
+__SYSCALL(__NR_sendfile64, sys_sendfile64)
+#define __NR_futex=09=09=09240
+__SYSCALL(__NR_futex, sys_futex)
+#define __NR_sched_setaffinity=09=09241
+__SYSCALL(__NR_sched_setaffinity, sys_sched_setaffinity)
+#define __NR_sched_getaffinity=09=09242
+__SYSCALL(__NR_sched_getaffinity, sys_sched_getaffinity)
+#define __NR_io_setup=09=09=09243
+__SYSCALL(__NR_io_setup, sys_io_setup)
+#define __NR_io_destroy=09=09=09244
+__SYSCALL(__NR_io_destroy, sys_io_destroy)
+#define __NR_io_getevents=09=09245
+__SYSCALL(__NR_io_getevents, sys_io_getevents)
+#define __NR_io_submit=09=09=09246
+__SYSCALL(__NR_io_submit, sys_io_submit)
+#define __NR_io_cancel=09=09=09247
+__SYSCALL(__NR_io_cancel, sys_io_cancel)
+#define __NR_exit_group=09=09=09248
+__SYSCALL(__NR_exit_group, sys_exit_group)
+#define __NR_lookup_dcookie=09=09249
+__SYSCALL(__NR_lookup_dcookie, sys_lookup_dcookie)
+#define __NR_epoll_create=09=09250
+__SYSCALL(__NR_epoll_create, sys_epoll_create)
+#define __NR_epoll_ctl=09=09=09251
+__SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
+#define __NR_epoll_wait=09=09=09252
+__SYSCALL(__NR_epoll_wait, sys_epoll_wait)
+#define __NR_remap_file_pages=09=09253
+__SYSCALL(__NR_remap_file_pages, sys_remap_file_pages)
+__SYSCALL(254, sys_ni_syscall)=09=09/* 254 for set_thread_area */
+__SYSCALL(255, sys_ni_syscall)=09=09/* 255 for get_thread_area */
+#define __NR_set_tid_address=09=09256
+__SYSCALL(__NR_set_tid_address, sys_set_tid_address)
+#define __NR_timer_create=09=09257
+__SYSCALL(__NR_timer_create, sys_timer_create)
+#define __NR_timer_settime=09=09258
+__SYSCALL(__NR_timer_settime, sys_timer_settime)
+#define __NR_timer_gettime=09=09259
+__SYSCALL(__NR_timer_gettime, sys_timer_gettime)
+#define __NR_timer_getoverrun=09=09260
+__SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#define __NR_timer_delete=09=09261
+__SYSCALL(__NR_timer_delete, sys_timer_delete)
+#define __NR_clock_settime=09=09262
+__SYSCALL(__NR_clock_settime, sys_clock_settime)
+#define __NR_clock_gettime=09=09263
+__SYSCALL(__NR_clock_gettime, sys_clock_gettime)
+#define __NR_clock_getres=09=09264
+__SYSCALL(__NR_clock_getres, sys_clock_getres)
+#define __NR_clock_nanosleep=09=09265
+__SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep)
+#define __NR_statfs64=09=09=09266
+__SYSCALL(__NR_statfs64, sys_statfs64)
+#define __NR_fstatfs64=09=09=09267
+__SYSCALL(__NR_fstatfs64, sys_fstatfs64)
+#define __NR_tgkill=09=09=09268
+__SYSCALL(__NR_tgkill, sys_tgkill)
+#define __NR_utimes=09=09=09269
+__SYSCALL(__NR_utimes, sys_utimes)
+#define __NR_fadvise64=09=09=09270
+__SYSCALL(__NR_fadvise64, sys_fadvise64_64)
+#define __NR_pciconfig_iobase=09=09271
+__SYSCALL(__NR_pciconfig_iobase, sys_pciconfig_iobase)
+#define __NR_pciconfig_read=09=09272
+__SYSCALL(__NR_pciconfig_read, sys_pciconfig_read)
+#define __NR_pciconfig_write=09=09273
+__SYSCALL(__NR_pciconfig_write, sys_pciconfig_write)
+#define __NR_mq_open=09=09=09274
+__SYSCALL(__NR_mq_open, sys_mq_open)
+#define __NR_mq_unlink=09=09=09275
+__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#define __NR_mq_timedsend=09=09276
+__SYSCALL(__NR_mq_timedsend, sys_mq_timedsend)
+#define __NR_mq_timedreceive=09=09277
+__SYSCALL(__NR_mq_timedreceive, sys_mq_timedreceive)
+#define __NR_mq_notify=09=09=09278
+__SYSCALL(__NR_mq_notify, sys_mq_notify)
+#define __NR_mq_getsetattr=09=09279
+__SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
+#define __NR_waitid=09=09=09280
+__SYSCALL(__NR_waitid, sys_waitid)
+#define __NR_socket=09=09=09281
+__SYSCALL(__NR_socket, sys_socket)
+#define __NR_bind=09=09=09282
+__SYSCALL(__NR_bind, sys_bind)
+#define __NR_connect=09=09=09283
+__SYSCALL(__NR_connect, sys_connect)
+#define __NR_listen=09=09=09284
+__SYSCALL(__NR_listen, sys_listen)
+#define __NR_accept=09=09=09285
+__SYSCALL(__NR_accept, sys_accept)
+#define __NR_getsockname=09=09286
+__SYSCALL(__NR_getsockname, sys_getsockname)
+#define __NR_getpeername=09=09287
+__SYSCALL(__NR_getpeername, sys_getpeername)
+#define __NR_socketpair=09=09=09288
+__SYSCALL(__NR_socketpair, sys_socketpair)
+#define __NR_send=09=09=09289
+__SYSCALL(__NR_send, sys_send)
+#define __NR_sendto=09=09=09290
+__SYSCALL(__NR_sendto, sys_sendto)
+#define __NR_recv=09=09=09291
+__SYSCALL(__NR_recv, sys_recv)
+#define __NR_recvfrom=09=09=09292
+__SYSCALL(__NR_recvfrom, sys_recvfrom)
+#define __NR_shutdown=09=09=09293
+__SYSCALL(__NR_shutdown, sys_shutdown)
+#define __NR_setsockopt=09=09=09294
+__SYSCALL(__NR_setsockopt, sys_setsockopt)
+#define __NR_getsockopt=09=09=09295
+__SYSCALL(__NR_getsockopt, sys_getsockopt)
+#define __NR_sendmsg=09=09=09296
+__SYSCALL(__NR_sendmsg, sys_sendmsg)
+#define __NR_recvmsg=09=09=09297
+__SYSCALL(__NR_recvmsg, sys_recvmsg)
+#define __NR_semop=09=09=09298
+__SYSCALL(__NR_semop, sys_semop)
+#define __NR_semget=09=09=09299
+__SYSCALL(__NR_semget, sys_semget)
+#define __NR_semctl=09=09=09300
+__SYSCALL(__NR_semctl, sys_semctl)
+#define __NR_msgsnd=09=09=09301
+__SYSCALL(__NR_msgsnd, sys_msgsnd)
+#define __NR_msgrcv=09=09=09302
+__SYSCALL(__NR_msgrcv, sys_msgrcv)
+#define __NR_msgget=09=09=09303
+__SYSCALL(__NR_msgget, sys_msgget)
+#define __NR_msgctl=09=09=09304
+__SYSCALL(__NR_msgctl, sys_msgctl)
+#define __NR_shmat=09=09=09305
+__SYSCALL(__NR_shmat, sys_shmat)
+#define __NR_shmdt=09=09=09306
+__SYSCALL(__NR_shmdt, sys_shmdt)
+#define __NR_shmget=09=09=09307
+__SYSCALL(__NR_shmget, sys_shmget)
+#define __NR_shmctl=09=09=09308
+__SYSCALL(__NR_shmctl, sys_shmctl)
+#define __NR_add_key=09=09=09309
+__SYSCALL(__NR_add_key, sys_add_key)
+#define __NR_request_key=09=09310
+__SYSCALL(__NR_request_key, sys_request_key)
+#define __NR_keyctl=09=09=09311
+__SYSCALL(__NR_keyctl, sys_keyctl)
+#define __NR_semtimedop=09=09=09312
+__SYSCALL(__NR_semtimedop, sys_semtimedop)
+#define __NR_vserver=09=09=09313
+__SYSCALL(__NR_vserver, sys_ni_syscall)
+#define __NR_ioprio_set=09=09=09314
+__SYSCALL(__NR_ioprio_set, sys_ioprio_set)
+#define __NR_ioprio_get=09=09=09315
+__SYSCALL(__NR_ioprio_get, sys_ioprio_get)
+#define __NR_inotify_init=09=09316
+__SYSCALL(__NR_inotify_init, sys_inotify_init)
+#define __NR_inotify_add_watch=09=09317
+__SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
+#define __NR_inotify_rm_watch=09=09318
+__SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
+#define __NR_mbind=09=09=09319
+__SYSCALL(__NR_mbind, sys_mbind)
+#define __NR_get_mempolicy=09=09320
+__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
+#define __NR_set_mempolicy=09=09321
+__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
+#define __NR_openat=09=09=09322
+__SYSCALL(__NR_openat, sys_openat)
+#define __NR_mkdirat=09=09=09323
+__SYSCALL(__NR_mkdirat, sys_mkdirat)
+#define __NR_mknodat=09=09=09324
+__SYSCALL(__NR_mknodat, sys_mknodat)
+#define __NR_fchownat=09=09=09325
+__SYSCALL(__NR_fchownat, sys_fchownat)
+#define __NR_futimesat=09=09=09326
+__SYSCALL(__NR_futimesat, sys_futimesat)
+#define __NR_fstatat64=09=09=09327
+__SYSCALL(__NR_fstatat64, sys_fstatat64)
+#define __NR_unlinkat=09=09=09328
+__SYSCALL(__NR_unlinkat, sys_unlinkat)
+#define __NR_renameat=09=09=09329
+__SYSCALL(__NR_renameat, sys_renameat)
+#define __NR_linkat=09=09=09330
+__SYSCALL(__NR_linkat, sys_linkat)
+#define __NR_symlinkat=09=09=09331
+__SYSCALL(__NR_symlinkat, sys_symlinkat)
+#define __NR_readlinkat=09=09=09332
+__SYSCALL(__NR_readlinkat, sys_readlinkat)
+#define __NR_fchmodat=09=09=09333
+__SYSCALL(__NR_fchmodat, sys_fchmodat)
+#define __NR_faccessat=09=09=09334
+__SYSCALL(__NR_faccessat, sys_faccessat)
+#define __NR_pselect6=09=09=09335
+__SYSCALL(__NR_pselect6, sys_pselect6)
+#define __NR_ppoll=09=09=09336
+__SYSCALL(__NR_ppoll, sys_ppoll)
+#define __NR_unshare=09=09=09337
+__SYSCALL(__NR_unshare, sys_unshare)
+#define __NR_set_robust_list=09=09338
+__SYSCALL(__NR_set_robust_list, sys_set_robust_list)
+#define __NR_get_robust_list=09=09339
+__SYSCALL(__NR_get_robust_list, sys_get_robust_list)
+#define __NR_splice=09=09=09340
+__SYSCALL(__NR_splice, sys_splice)
+#define __NR_sync_file_range2=09=09341
+__SYSCALL(__NR_sync_file_range2, sys_sync_file_range2)
+#define __NR_tee=09=09=09342
+__SYSCALL(__NR_tee, sys_tee)
+#define __NR_vmsplice=09=09=09343
+__SYSCALL(__NR_vmsplice, sys_vmsplice)
+#define __NR_move_pages=09=09=09344
+__SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_getcpu=09=09=09345
+__SYSCALL(__NR_getcpu, sys_getcpu)
+#define __NR_epoll_pwait=09=09346
+__SYSCALL(__NR_epoll_pwait, sys_epoll_pwait)
+#define __NR_kexec_load=09=09=09347
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
+#define __NR_utimensat=09=09=09348
+__SYSCALL(__NR_utimensat, sys_utimensat)
+#define __NR_signalfd=09=09=09349
+__SYSCALL(__NR_signalfd, sys_signalfd)
+#define __NR_timerfd_create=09=09350
+__SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#define __NR_eventfd=09=09=09351
+__SYSCALL(__NR_eventfd, sys_eventfd)
+#define __NR_fallocate=09=09=09352
+__SYSCALL(__NR_fallocate, sys_fallocate)
+#define __NR_timerfd_settime=09=09353
+__SYSCALL(__NR_timerfd_settime, sys_timerfd_settime)
+#define __NR_timerfd_gettime=09=09354
+__SYSCALL(__NR_timerfd_gettime, sys_timerfd_gettime)
+#define __NR_signalfd4=09=09=09355
+__SYSCALL(__NR_signalfd4, sys_signalfd4)
+#define __NR_eventfd2=09=09=09356
+__SYSCALL(__NR_eventfd2, sys_eventfd2)
+#define __NR_epoll_create1=09=09357
+__SYSCALL(__NR_epoll_create1, sys_epoll_create1)
+#define __NR_dup3=09=09=09358
+__SYSCALL(__NR_dup3, sys_dup3)
+#define __NR_pipe2=09=09=09359
+__SYSCALL(__NR_pipe2, sys_pipe2)
+#define __NR_inotify_init1=09=09360
+__SYSCALL(__NR_inotify_init1, sys_inotify_init1)
+#define __NR_preadv=09=09=09361
+__SYSCALL(__NR_preadv, sys_preadv)
+#define __NR_pwritev=09=09=09362
+__SYSCALL(__NR_pwritev, sys_pwritev)
+#define __NR_rt_tgsigqueueinfo=09=09363
+__SYSCALL(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo)
+#define __NR_perf_event_open=09=09364
+__SYSCALL(__NR_perf_event_open, sys_perf_event_open)
+#define __NR_recvmmsg=09=09=09365
+__SYSCALL(__NR_recvmmsg, sys_recvmmsg)
+#define __NR_accept4=09=09=09366
+__SYSCALL(__NR_accept4, sys_accept4)
+#define __NR_fanotify_init=09=09367
+__SYSCALL(__NR_fanotify_init, sys_fanotify_init)
+#define __NR_fanotify_mark=09=09368
+__SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
+#define __NR_prlimit64=09=09=09369
+__SYSCALL(__NR_prlimit64, sys_prlimit64)
+#define __NR_name_to_handle_at=09=09370
+__SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
+#define __NR_open_by_handle_at=09=09371
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+#define __NR_clock_adjtime=09=09372
+__SYSCALL(__NR_clock_adjtime, sys_clock_adjtime)
+#define __NR_syncfs=09=09=09373
+__SYSCALL(__NR_syncfs, sys_syncfs)
+
+/*
+ * The following SVCs are ARM private.
+ */
+#define __ARM_NR_COMPAT_BASE=09=090x0f0000
+#define __ARM_NR_compat_cacheflush=09(__ARM_NR_COMPAT_BASE+2)
+#define __ARM_NR_compat_set_tls=09=09(__ARM_NR_COMPAT_BASE+5)
+
+#endif=09/* __SYSCALL_COMPAT */
+
+#define __NR_compat_syscalls=09=09374
+
+#define __ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+#define __ARCH_WANT_COMPAT_STAT64
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+
+#endif /* __ASM_UNISTD32_H */
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
new file mode 100644
index 0000000..7557737
--- /dev/null
+++ b/arch/arm64/kernel/kuser32.S
@@ -0,0 +1,77 @@
+/*
+ * Low-level user helpers placed in the vectors page for AArch32.
+ * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
+ *
+ * Copyright (C) 2005-2011 Nicolas Pitre <nico@cam.org>
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *
+ * AArch32 user helpers.
+ *
+ * Each segment is 32-byte aligned and will be moved to the top of the hig=
h
+ * vector page.  New segments (if ever needed) must be added in front of
+ * existing ones.  This mechanism should be used only for things that are
+ * really small and justified, and not be abused freely.
+ *
+ * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
+ */
+=09.align=095
+=09.globl=09__kuser_helper_start
+__kuser_helper_start:
+
+__kuser_cmpxchg64:=09=09=09// 0xffff0f60
+=09.inst=090xe92d00f0=09=09//=09push=09=09{r4, r5, r6, r7}
+=09.inst=090xe1c040d0=09=09//=09ldrd=09=09r4, r5, [r0]
+=09.inst=090xe1c160d0=09=09//=09ldrd=09=09r6, r7, [r1]
+=09.inst=090xf57ff05f=09=09//=09dmb=09=09sy
+=09.inst=090xe1b20f9f=09=09// 1:=09ldrexd=09=09r0, r1, [r2]
+=09.inst=090xe0303004=09=09//=09eors=09=09r3, r0, r4
+=09.inst=090x00313005=09=09//=09eoreqs=09=09r3, r1, r5
+=09.inst=090x01a23f96=09=09//=09strexdeq=09r3, r6, [r2]
+=09.inst=090x03330001=09=09//=09teqeq=09=09r3, #1
+=09.inst=090x0afffff9=09=09//=09beq=09=091b
+=09.inst=090xf57ff05f=09=09//=09dmb=09=09sy
+=09.inst=090xe2730000=09=09//=09rsbs=09=09r0, r3, #0
+=09.inst=090xe8bd00f0=09=09//=09pop=09=09{r4, r5, r6, r7}
+=09.inst=090xe12fff1e=09=09//=09bx=09=09lr
+
+=09.align=095
+__kuser_memory_barrier:=09=09=09// 0xffff0fa0
+=09.inst=090xf57ff05f=09=09//=09dmb=09=09sy
+=09.inst=090xe12fff1e=09=09//=09bx=09=09lr
+
+=09.align=095
+__kuser_cmpxchg:=09=09=09// 0xffff0fc0
+=09.inst=090xf57ff05f=09=09//=09dmb=09=09sy
+=09.inst=090xe1923f9f=09=09// 1:=09ldrex=09=09r3, [r2]
+=09.inst=090xe0533000=09=09//=09subs=09=09r3, r3, r0
+=09.inst=090x01823f91=09=09//=09strexeq=09r3, r1, [r2]
+=09.inst=090x03330001=09=09//=09teqeq=09=09r3, #1
+=09.inst=090x0afffffa=09=09//=09beq=09=091b
+=09.inst=090xe2730000=09=09//=09rsbs=09=09r0, r3, #0
+=09.inst=090xeaffffef=09=09//=09b=09=09<__kuser_memory_barrier>
+
+=09.align=095
+__kuser_get_tls:=09=09=09// 0xffff0fe0
+=09.inst=090xee1d0f70=09=09//=09mrc=09=09p15, 0, r0, c13, c0, 3
+=09.inst=090xe12fff1e=09=09//=09bx=09=09lr
+=09.rep=095
+=09.word=090
+=09.endr
+
+__kuser_helper_version:=09=09=09// 0xffff0ffc
+=09.word=09((__kuser_helper_end - __kuser_helper_start) >> 5)
+=09.globl=09__kuser_helper_end
+__kuser_helper_end:
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
new file mode 100644
index 0000000..ac74c2f
--- /dev/null
+++ b/arch/arm64/kernel/signal32.c
@@ -0,0 +1,876 @@
+/*
+ * Based on arch/arm/kernel/signal.c
+ *
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Modified by Will Deacon <will.deacon@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define __SYSCALL_COMPAT
+
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/ratelimit.h>
+
+#include <asm/fpsimd.h>
+#include <asm/signal32.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+
+typedef struct compat_siginfo {
+=09int si_signo;
+=09int si_errno;
+=09int si_code;
+
+=09union {
+=09=09/* The padding is the same size as AArch64. */
+=09=09int _pad[SI_PAD_SIZE];
+
+=09=09/* kill() */
+=09=09struct {
+=09=09=09compat_pid_t _pid;=09/* sender's pid */
+=09=09=09__compat_uid32_t _uid;=09/* sender's uid */
+=09=09} _kill;
+
+=09=09/* POSIX.1b timers */
+=09=09struct {
+=09=09=09compat_timer_t _tid;=09/* timer id */
+=09=09=09int _overrun;=09=09/* overrun count */
+=09=09=09compat_sigval_t _sigval;=09/* same as below */
+=09=09=09int _sys_private;       /* not to be passed to user */
+=09=09} _timer;
+
+=09=09/* POSIX.1b signals */
+=09=09struct {
+=09=09=09compat_pid_t _pid;=09/* sender's pid */
+=09=09=09__compat_uid32_t _uid;=09/* sender's uid */
+=09=09=09compat_sigval_t _sigval;
+=09=09} _rt;
+
+=09=09/* SIGCHLD */
+=09=09struct {
+=09=09=09compat_pid_t _pid;=09/* which child */
+=09=09=09__compat_uid32_t _uid;=09/* sender's uid */
+=09=09=09int _status;=09=09/* exit code */
+=09=09=09compat_clock_t _utime;
+=09=09=09compat_clock_t _stime;
+=09=09} _sigchld;
+
+=09=09/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+=09=09struct {
+=09=09=09compat_uptr_t _addr; /* faulting insn/memory ref. */
+=09=09=09short _addr_lsb; /* LSB of the reported address */
+=09=09} _sigfault;
+
+=09=09/* SIGPOLL */
+=09=09struct {
+=09=09=09compat_long_t _band;=09/* POLL_IN, POLL_OUT, POLL_MSG */
+=09=09=09int _fd;
+=09=09} _sigpoll;
+=09} _sifields;
+} compat_siginfo_t;
+
+struct compat_sigaction {
+=09compat_uptr_t=09=09=09sa_handler;
+=09compat_ulong_t=09=09=09sa_flags;
+=09compat_uptr_t=09=09=09sa_restorer;
+=09compat_sigset_t=09=09=09sa_mask;
+};
+
+struct compat_old_sigaction {
+=09compat_uptr_t=09=09=09sa_handler;
+=09compat_old_sigset_t=09=09sa_mask;
+=09compat_ulong_t=09=09=09sa_flags;
+=09compat_uptr_t=09=09=09sa_restorer;
+};
+
+typedef struct compat_sigaltstack {
+=09compat_uptr_t=09=09=09ss_sp;
+=09int=09=09=09=09ss_flags;
+=09compat_size_t=09=09=09ss_size;
+} compat_stack_t;
+
+struct compat_sigcontext {
+=09/* We always set these two fields to 0 */
+=09compat_ulong_t=09=09=09trap_no;
+=09compat_ulong_t=09=09=09error_code;
+
+=09compat_ulong_t=09=09=09oldmask;
+=09compat_ulong_t=09=09=09arm_r0;
+=09compat_ulong_t=09=09=09arm_r1;
+=09compat_ulong_t=09=09=09arm_r2;
+=09compat_ulong_t=09=09=09arm_r3;
+=09compat_ulong_t=09=09=09arm_r4;
+=09compat_ulong_t=09=09=09arm_r5;
+=09compat_ulong_t=09=09=09arm_r6;
+=09compat_ulong_t=09=09=09arm_r7;
+=09compat_ulong_t=09=09=09arm_r8;
+=09compat_ulong_t=09=09=09arm_r9;
+=09compat_ulong_t=09=09=09arm_r10;
+=09compat_ulong_t=09=09=09arm_fp;
+=09compat_ulong_t=09=09=09arm_ip;
+=09compat_ulong_t=09=09=09arm_sp;
+=09compat_ulong_t=09=09=09arm_lr;
+=09compat_ulong_t=09=09=09arm_pc;
+=09compat_ulong_t=09=09=09arm_cpsr;
+=09compat_ulong_t=09=09=09fault_address;
+};
+
+struct compat_ucontext {
+=09compat_ulong_t=09=09=09uc_flags;
+=09struct compat_ucontext=09=09*uc_link;
+=09compat_stack_t=09=09=09uc_stack;
+=09struct compat_sigcontext=09uc_mcontext;
+=09compat_sigset_t=09=09=09uc_sigmask;
+=09int=09=09__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
+=09compat_ulong_t=09uc_regspace[128] __attribute__((__aligned__(8)));
+};
+
+struct compat_vfp_sigframe {
+=09compat_ulong_t=09magic;
+=09compat_ulong_t=09size;
+=09struct compat_user_vfp {
+=09=09compat_u64=09fpregs[32];
+=09=09compat_ulong_t=09fpscr;
+=09} ufp;
+=09struct compat_user_vfp_exc {
+=09=09compat_ulong_t=09fpexc;
+=09=09compat_ulong_t=09fpinst;
+=09=09compat_ulong_t=09fpinst2;
+=09} ufp_exc;
+} __attribute__((__aligned__(8)));
+
+#define VFP_MAGIC=09=090x56465001
+#define VFP_STORAGE_SIZE=09sizeof(struct compat_vfp_sigframe)
+
+struct compat_aux_sigframe {
+=09struct compat_vfp_sigframe=09vfp;
+
+=09/* Something that isn't a valid magic number for any coprocessor.  */
+=09unsigned long=09=09=09end_magic;
+} __attribute__((__aligned__(8)));
+
+struct compat_sigframe {
+=09struct compat_ucontext=09uc;
+=09compat_ulong_t=09=09retcode[2];
+};
+
+struct compat_rt_sigframe {
+=09struct compat_siginfo info;
+=09struct compat_sigframe sig;
+};
+
+#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
+/*
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ */
+#define MOV_R7_NR_SIGRETURN=09(0xe3a07000 | __NR_sigreturn)
+#define SVC_SYS_SIGRETURN=09(0xef000000 | __NR_sigreturn)
+#define MOV_R7_NR_RT_SIGRETURN=09(0xe3a07000 | __NR_rt_sigreturn)
+#define SVC_SYS_RT_SIGRETURN=09(0xef000000 | __NR_rt_sigreturn)
+
+/*
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefor=
e
+ * need two 16-bit instructions.
+ */
+#define SVC_THUMB_SIGRETURN=09(((0xdf00 | __NR_sigreturn) << 16) | \
+=09=09=09=09   0x2700 | __NR_sigreturn)
+#define SVC_THUMB_RT_SIGRETURN=09(((0xdf00 | __NR_rt_sigreturn) << 16) | \
+=09=09=09=09   0x2700 | __NR_rt_sigreturn)
+
+const compat_ulong_t aarch32_sigret_code[6] =3D {
+=09/*
+=09 * AArch32 sigreturn code.
+=09 * We don't construct an OABI SWI - instead we just set the imm24 field
+=09 * to the EABI syscall number so that we create a sane disassembly.
+=09 */
+=09MOV_R7_NR_SIGRETURN,    SVC_SYS_SIGRETURN,    SVC_THUMB_SIGRETURN,
+=09MOV_R7_NR_RT_SIGRETURN, SVC_SYS_RT_SIGRETURN, SVC_THUMB_RT_SIGRETURN,
+};
+
+static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set=
)
+{
+=09compat_sigset_t=09cset;
+
+=09cset.sig[0] =3D set->sig[0] & 0xffffffffull;
+=09cset.sig[1] =3D set->sig[0] >> 32;
+
+=09return copy_to_user(uset, &cset, sizeof(*uset));
+}
+
+static inline int get_sigset_t(sigset_t *set,
+=09=09=09       const compat_sigset_t __user *uset)
+{
+=09compat_sigset_t s32;
+
+=09if (copy_from_user(&s32, uset, sizeof(*uset)))
+=09=09return -EFAULT;
+
+=09set->sig[0] =3D s32.sig[0] | (((long)s32.sig[1]) << 32);
+=09return 0;
+}
+
+int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
+{
+=09int err;
+
+=09if (!access_ok(VERIFY_WRITE, to, sizeof(*to)))
+=09=09return -EFAULT;
+
+=09/* If you change siginfo_t structure, please be sure
+=09 * this code is fixed accordingly.
+=09 * It should never copy any pad contained in the structure
+=09 * to avoid security leaks, but must copy the generic
+=09 * 3 ints plus the relevant union member.
+=09 * This routine must convert siginfo from 64bit to 32bit as well
+=09 * at the same time.
+=09 */
+=09err =3D __put_user(from->si_signo, &to->si_signo);
+=09err |=3D __put_user(from->si_errno, &to->si_errno);
+=09err |=3D __put_user((short)from->si_code, &to->si_code);
+=09if (from->si_code < 0)
+=09=09err |=3D __copy_to_user(&to->_sifields._pad, &from->_sifields._pad,
+=09=09=09=09      SI_PAD_SIZE);
+=09else switch (from->si_code & __SI_MASK) {
+=09case __SI_KILL:
+=09=09err |=3D __put_user(from->si_pid, &to->si_pid);
+=09=09err |=3D __put_user(from->si_uid, &to->si_uid);
+=09=09break;
+=09case __SI_TIMER:
+=09=09 err |=3D __put_user(from->si_tid, &to->si_tid);
+=09=09 err |=3D __put_user(from->si_overrun, &to->si_overrun);
+=09=09 err |=3D __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
+=09=09=09=09   &to->si_ptr);
+=09=09break;
+=09case __SI_POLL:
+=09=09err |=3D __put_user(from->si_band, &to->si_band);
+=09=09err |=3D __put_user(from->si_fd, &to->si_fd);
+=09=09break;
+=09case __SI_FAULT:
+=09=09err |=3D __put_user((compat_uptr_t)(unsigned long)from->si_addr,
+=09=09=09=09  &to->si_addr);
+#ifdef BUS_MCEERR_AO
+=09=09/*
+=09=09 * Other callers might not initialize the si_lsb field,
+=09=09 * so check explicitely for the right codes here.
+=09=09 */
+=09=09if (from->si_code =3D=3D BUS_MCEERR_AR || from->si_code =3D=3D BUS_M=
CEERR_AO)
+=09=09=09err |=3D __put_user(from->si_addr_lsb, &to->si_addr_lsb);
+#endif
+=09=09break;
+=09case __SI_CHLD:
+=09=09err |=3D __put_user(from->si_pid, &to->si_pid);
+=09=09err |=3D __put_user(from->si_uid, &to->si_uid);
+=09=09err |=3D __put_user(from->si_status, &to->si_status);
+=09=09err |=3D __put_user(from->si_utime, &to->si_utime);
+=09=09err |=3D __put_user(from->si_stime, &to->si_stime);
+=09=09break;
+=09case __SI_RT: /* This is not generated by the kernel as of now. */
+=09case __SI_MESGQ: /* But this is */
+=09=09err |=3D __put_user(from->si_pid, &to->si_pid);
+=09=09err |=3D __put_user(from->si_uid, &to->si_uid);
+=09=09err |=3D __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to-=
>si_ptr);
+=09=09break;
+=09default: /* this is just in case for now ... */
+=09=09err |=3D __put_user(from->si_pid, &to->si_pid);
+=09=09err |=3D __put_user(from->si_uid, &to->si_uid);
+=09=09break;
+=09}
+=09return err;
+}
+
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
+{
+=09memset(to, 0, sizeof *to);
+
+=09if (copy_from_user(to, from, __ARCH_SI_PREAMBLE_SIZE) ||
+=09    copy_from_user(to->_sifields._pad,
+=09=09=09   from->_sifields._pad, SI_PAD_SIZE))
+=09=09return -EFAULT;
+
+=09return 0;
+}
+
+/*
+ * VFP save/restore code.
+ */
+static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *=
frame)
+{
+=09struct fpsimd_state *fpsimd =3D &current->thread.fpsimd_state;
+=09compat_ulong_t magic =3D VFP_MAGIC;
+=09compat_ulong_t size =3D VFP_STORAGE_SIZE;
+=09compat_ulong_t fpscr, fpexc;
+=09int err =3D 0;
+
+=09/*
+=09 * Save the hardware registers to the fpsimd_state structure.
+=09 * Note that this also saves V16-31, which aren't visible
+=09 * in AArch32.
+=09 */
+=09fpsimd_save_state(fpsimd);
+
+=09/* Place structure header on the stack */
+=09__put_user_error(magic, &frame->magic, err);
+=09__put_user_error(size, &frame->size, err);
+
+=09/*
+=09 * Now copy the FP registers. Since the registers are packed,
+=09 * we can copy the prefix we want (V0-V15) as it is.
+=09 * FIXME: Won't work if big endian.
+=09 */
+=09err |=3D __copy_to_user(&frame->ufp.fpregs, fpsimd->vregs,
+=09=09=09      sizeof(frame->ufp.fpregs));
+
+=09/* Create an AArch32 fpscr from the fpsr and the fpcr. */
+=09fpscr =3D (fpsimd->fpsr & VFP_FPSCR_STAT_MASK) |
+=09=09(fpsimd->fpcr & VFP_FPSCR_CTRL_MASK);
+=09__put_user_error(fpscr, &frame->ufp.fpscr, err);
+
+=09/*
+=09 * The exception register aren't available so we fake up a
+=09 * basic FPEXC and zero everything else.
+=09 */
+=09fpexc =3D (1 << 30);
+=09__put_user_error(fpexc, &frame->ufp_exc.fpexc, err);
+=09__put_user_error(0, &frame->ufp_exc.fpinst, err);
+=09__put_user_error(0, &frame->ufp_exc.fpinst2, err);
+
+=09return err ? -EFAULT : 0;
+}
+
+static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *f=
rame)
+{
+=09struct fpsimd_state fpsimd;
+=09compat_ulong_t magic =3D VFP_MAGIC;
+=09compat_ulong_t size =3D VFP_STORAGE_SIZE;
+=09compat_ulong_t fpscr;
+=09int err =3D 0;
+
+=09__get_user_error(magic, &frame->magic, err);
+=09__get_user_error(size, &frame->size, err);
+
+=09if (err)
+=09=09return -EFAULT;
+=09if (magic !=3D VFP_MAGIC || size !=3D VFP_STORAGE_SIZE)
+=09=09return -EINVAL;
+
+=09/*
+=09 * Copy the FP registers into the start of the fpsimd_state.
+=09 * FIXME: Won't work if big endian.
+=09 */
+=09err |=3D __copy_from_user(fpsimd.vregs, frame->ufp.fpregs,
+=09=09=09=09sizeof(frame->ufp.fpregs));
+
+=09/* Extract the fpsr and the fpcr from the fpscr */
+=09__get_user_error(fpscr, &frame->ufp.fpscr, err);
+=09fpsimd.fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
+=09fpsimd.fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+
+=09/*
+=09 * We don't need to touch the exception register, so
+=09 * reload the hardware state.
+=09 */
+=09if (!err) {
+=09=09preempt_disable();
+=09=09fpsimd_load_state(&fpsimd);
+=09=09preempt_enable();
+=09}
+
+=09return err ? -EFAULT : 0;
+}
+
+/*
+ * atomically swap in the new signal mask, and wait for a signal.
+ */
+asmlinkage int compat_sys_sigsuspend(int restart, compat_ulong_t oldmask,
+=09=09=09=09     compat_old_sigset_t mask)
+{
+=09sigset_t blocked;
+
+=09siginitset(&current->blocked, mask);
+=09return sigsuspend(&blocked);
+}
+
+asmlinkage int compat_sys_sigaction(int sig,
+=09=09=09=09    const struct compat_old_sigaction __user *act,
+=09=09=09=09    struct compat_old_sigaction __user *oact)
+{
+=09struct k_sigaction new_ka, old_ka;
+=09int ret;
+=09compat_old_sigset_t mask;
+=09compat_uptr_t handler, restorer;
+
+=09if (act) {
+=09=09if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
+=09=09    __get_user(handler, &act->sa_handler) ||
+=09=09    __get_user(restorer, &act->sa_restorer) ||
+=09=09    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
+=09=09    __get_user(mask, &act->sa_mask))
+=09=09=09return -EFAULT;
+
+=09=09new_ka.sa.sa_handler =3D compat_ptr(handler);
+=09=09new_ka.sa.sa_restorer =3D compat_ptr(restorer);
+=09=09siginitset(&new_ka.sa.sa_mask, mask);
+=09}
+
+=09ret =3D do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
+
+=09if (!ret && oact) {
+=09=09if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
+=09=09    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
+=09=09=09       &oact->sa_handler) ||
+=09=09    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
+=09=09=09       &oact->sa_restorer) ||
+=09=09    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
+=09=09    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
+=09=09=09return -EFAULT;
+=09}
+
+=09return ret;
+}
+
+asmlinkage int compat_sys_rt_sigaction(int sig,
+=09=09=09=09       const struct compat_sigaction __user *act,
+=09=09=09=09       struct compat_sigaction __user *oact,
+=09=09=09=09       compat_size_t sigsetsize)
+{
+=09struct k_sigaction new_ka, old_ka;
+=09int ret;
+
+=09/* XXX: Don't preclude handling different sized sigset_t's.  */
+=09if (sigsetsize !=3D sizeof(compat_sigset_t))
+=09=09return -EINVAL;
+
+=09if (act) {
+=09=09compat_uptr_t handler, restorer;
+
+=09=09ret =3D get_user(handler, &act->sa_handler);
+=09=09new_ka.sa.sa_handler =3D compat_ptr(handler);
+=09=09ret |=3D get_user(restorer, &act->sa_restorer);
+=09=09new_ka.sa.sa_restorer =3D compat_ptr(restorer);
+=09=09ret |=3D get_sigset_t(&new_ka.sa.sa_mask, &act->sa_mask);
+=09=09ret |=3D __get_user(new_ka.sa.sa_flags, &act->sa_flags);
+=09=09if (ret)
+=09=09=09return -EFAULT;
+=09}
+
+=09ret =3D do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
+=09if (!ret && oact) {
+=09=09ret =3D put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_hand=
ler);
+=09=09ret |=3D put_sigset_t(&oact->sa_mask, &old_ka.sa.sa_mask);
+=09=09ret |=3D __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
+=09}
+=09return ret;
+}
+
+int compat_do_sigaltstack(compat_uptr_t compat_uss, compat_uptr_t compat_u=
oss,
+=09=09=09  compat_ulong_t sp)
+{
+=09compat_stack_t __user *newstack =3D compat_ptr(compat_uss);
+=09compat_stack_t __user *oldstack =3D compat_ptr(compat_uoss);
+=09compat_uptr_t ss_sp;
+=09int ret;
+=09mm_segment_t old_fs;
+=09stack_t uss, uoss;
+
+=09/* Marshall the compat new stack into a stack_t */
+=09if (newstack) {
+=09=09if (get_user(ss_sp, &newstack->ss_sp) ||
+=09=09    __get_user(uss.ss_flags, &newstack->ss_flags) ||
+=09=09    __get_user(uss.ss_size, &newstack->ss_size))
+=09=09=09return -EFAULT;
+=09=09uss.ss_sp =3D compat_ptr(ss_sp);
+=09}
+
+=09old_fs =3D get_fs();
+=09set_fs(KERNEL_DS);
+=09/* The __user pointer casts are valid because of the set_fs() */
+=09ret =3D do_sigaltstack(
+=09=09newstack ? (stack_t __user *) &uss : NULL,
+=09=09oldstack ? (stack_t __user *) &uoss : NULL,
+=09=09(unsigned long)sp);
+=09set_fs(old_fs);
+
+=09/* Convert the old stack_t into a compat stack. */
+=09if (!ret && oldstack &&
+=09=09(put_user(ptr_to_compat(uoss.ss_sp), &oldstack->ss_sp) ||
+=09=09 __put_user(uoss.ss_flags, &oldstack->ss_flags) ||
+=09=09 __put_user(uoss.ss_size, &oldstack->ss_size)))
+=09=09return -EFAULT;
+=09return ret;
+}
+
+static int compat_restore_sigframe(struct pt_regs *regs,
+=09=09=09=09   struct compat_sigframe __user *sf)
+{
+=09int err;
+=09sigset_t set;
+=09struct compat_aux_sigframe __user *aux;
+
+=09err =3D get_sigset_t(&set, &sf->uc.uc_sigmask);
+=09if (err =3D=3D 0) {
+=09=09sigdelsetmask(&set, ~_BLOCKABLE);
+=09=09set_current_blocked(&set);
+=09}
+
+=09__get_user_error(regs->regs[0], &sf->uc.uc_mcontext.arm_r0, err);
+=09__get_user_error(regs->regs[1], &sf->uc.uc_mcontext.arm_r1, err);
+=09__get_user_error(regs->regs[2], &sf->uc.uc_mcontext.arm_r2, err);
+=09__get_user_error(regs->regs[3], &sf->uc.uc_mcontext.arm_r3, err);
+=09__get_user_error(regs->regs[4], &sf->uc.uc_mcontext.arm_r4, err);
+=09__get_user_error(regs->regs[5], &sf->uc.uc_mcontext.arm_r5, err);
+=09__get_user_error(regs->regs[6], &sf->uc.uc_mcontext.arm_r6, err);
+=09__get_user_error(regs->regs[7], &sf->uc.uc_mcontext.arm_r7, err);
+=09__get_user_error(regs->regs[8], &sf->uc.uc_mcontext.arm_r8, err);
+=09__get_user_error(regs->regs[9], &sf->uc.uc_mcontext.arm_r9, err);
+=09__get_user_error(regs->regs[10], &sf->uc.uc_mcontext.arm_r10, err);
+=09__get_user_error(regs->regs[11], &sf->uc.uc_mcontext.arm_fp, err);
+=09__get_user_error(regs->regs[12], &sf->uc.uc_mcontext.arm_ip, err);
+=09__get_user_error(regs->compat_sp, &sf->uc.uc_mcontext.arm_sp, err);
+=09__get_user_error(regs->compat_lr, &sf->uc.uc_mcontext.arm_lr, err);
+=09__get_user_error(regs->pc, &sf->uc.uc_mcontext.arm_pc, err);
+=09__get_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
+
+=09/*
+=09 * Avoid compat_sys_sigreturn() restarting.
+=09 */
+=09regs->syscallno =3D ~0UL;
+
+=09err |=3D !valid_user_regs(&regs->user_regs);
+
+=09aux =3D (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
+=09if (err =3D=3D 0)
+=09=09err |=3D compat_restore_vfp_context(&aux->vfp);
+
+=09return err;
+}
+
+asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
+{
+=09struct compat_sigframe __user *frame;
+
+=09/* Always make any pending restarted system calls return -EINTR */
+=09current_thread_info()->restart_block.fn =3D do_no_restart_syscall;
+
+=09/*
+=09 * Since we stacked the signal on a 64-bit boundary,
+=09 * then 'sp' should be word aligned here.  If it's
+=09 * not, then the user is trying to mess with us.
+=09 */
+=09if (regs->compat_sp & 7)
+=09=09goto badframe;
+
+=09frame =3D (struct compat_sigframe __user *)regs->compat_sp;
+
+=09if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
+=09=09goto badframe;
+
+=09if (compat_restore_sigframe(regs, frame))
+=09=09goto badframe;
+
+=09return regs->regs[0];
+
+badframe:
+=09if (show_unhandled_signals)
+=09=09pr_info_ratelimited("%s[%d]: bad frame in %s: pc=3D%08llx sp=3D%08ll=
x\n",
+=09=09=09=09    current->comm, task_pid_nr(current), __func__,
+=09=09=09=09    regs->pc, regs->sp);
+=09force_sig(SIGSEGV, current);
+=09return 0;
+}
+
+asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
+{
+=09struct compat_rt_sigframe __user *frame;
+
+=09/* Always make any pending restarted system calls return -EINTR */
+=09current_thread_info()->restart_block.fn =3D do_no_restart_syscall;
+
+=09/*
+=09 * Since we stacked the signal on a 64-bit boundary,
+=09 * then 'sp' should be word aligned here.  If it's
+=09 * not, then the user is trying to mess with us.
+=09 */
+=09if (regs->compat_sp & 7)
+=09=09goto badframe;
+
+=09frame =3D (struct compat_rt_sigframe __user *)regs->compat_sp;
+
+=09if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
+=09=09goto badframe;
+
+=09if (compat_restore_sigframe(regs, &frame->sig))
+=09=09goto badframe;
+
+=09if (compat_do_sigaltstack(ptr_to_compat(&frame->sig.uc.uc_stack),
+=09=09=09=09 ptr_to_compat((void __user *)NULL),
+=09=09=09=09 regs->compat_sp) =3D=3D -EFAULT)
+=09=09goto badframe;
+
+=09return regs->regs[0];
+
+badframe:
+=09if (show_unhandled_signals)
+=09=09pr_info_ratelimited("%s[%d]: bad frame in %s: pc=3D%08llx sp=3D%08ll=
x\n",
+=09=09=09=09    current->comm, task_pid_nr(current), __func__,
+=09=09=09=09    regs->pc, regs->sp);
+=09force_sig(SIGSEGV, current);
+=09return 0;
+}
+
+static inline void __user *compat_get_sigframe(struct k_sigaction *ka,
+=09=09=09=09=09       struct pt_regs *regs,
+=09=09=09=09=09       int framesize)
+{
+=09compat_ulong_t sp =3D regs->compat_sp;
+=09void __user *frame;
+
+=09/*
+=09 * This is the X/Open sanctioned signal stack switching.
+=09 */
+=09if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(sp))
+=09=09sp =3D current->sas_ss_sp + current->sas_ss_size;
+
+=09/*
+=09 * ATPCS B01 mandates 8-byte alignment
+=09 */
+=09frame =3D compat_ptr((compat_uptr_t)((sp - framesize) & ~7));
+
+=09/*
+=09 * Check that we can actually write to the signal frame.
+=09 */
+=09if (!access_ok(VERIFY_WRITE, frame, framesize))
+=09=09frame =3D NULL;
+
+=09return frame;
+}
+
+static int compat_setup_return(struct pt_regs *regs, struct k_sigaction *k=
a,
+=09=09=09       compat_ulong_t __user *rc, void __user *frame,
+=09=09=09       int usig)
+{
+=09compat_ulong_t handler =3D ptr_to_compat(ka->sa.sa_handler);
+=09compat_ulong_t retcode;
+=09compat_ulong_t spsr =3D regs->pstate & ~PSR_f;
+=09int thumb;
+
+=09/* Check if the handler is written for ARM or Thumb */
+=09thumb =3D handler & 1;
+
+=09if (thumb) {
+=09=09spsr |=3D COMPAT_PSR_T_BIT;
+=09=09spsr &=3D ~COMPAT_PSR_IT_MASK;
+=09} else {
+=09=09spsr &=3D ~COMPAT_PSR_T_BIT;
+=09}
+
+=09if (ka->sa.sa_flags & SA_RESTORER) {
+=09=09retcode =3D ptr_to_compat(ka->sa.sa_restorer);
+=09} else {
+=09=09/* Set up sigreturn pointer */
+=09=09unsigned int idx =3D thumb << 1;
+
+=09=09if (ka->sa.sa_flags & SA_SIGINFO)
+=09=09=09idx +=3D 3;
+
+=09=09retcode =3D AARCH32_VECTORS_BASE +
+=09=09=09  AARCH32_KERN_SIGRET_CODE_OFFSET +
+=09=09=09  (idx << 2) + thumb;
+=09}
+
+=09regs->regs[0]=09=3D usig;
+=09regs->compat_sp=09=3D ptr_to_compat(frame);
+=09regs->compat_lr=09=3D retcode;
+=09regs->pc=09=3D handler;
+=09regs->pstate=09=3D spsr;
+
+=09return 0;
+}
+
+static int compat_setup_sigframe(struct compat_sigframe __user *sf,
+=09=09=09=09 struct pt_regs *regs, sigset_t *set)
+{
+=09struct compat_aux_sigframe __user *aux;
+=09int err =3D 0;
+
+=09__put_user_error(regs->regs[0], &sf->uc.uc_mcontext.arm_r0, err);
+=09__put_user_error(regs->regs[1], &sf->uc.uc_mcontext.arm_r1, err);
+=09__put_user_error(regs->regs[2], &sf->uc.uc_mcontext.arm_r2, err);
+=09__put_user_error(regs->regs[3], &sf->uc.uc_mcontext.arm_r3, err);
+=09__put_user_error(regs->regs[4], &sf->uc.uc_mcontext.arm_r4, err);
+=09__put_user_error(regs->regs[5], &sf->uc.uc_mcontext.arm_r5, err);
+=09__put_user_error(regs->regs[6], &sf->uc.uc_mcontext.arm_r6, err);
+=09__put_user_error(regs->regs[7], &sf->uc.uc_mcontext.arm_r7, err);
+=09__put_user_error(regs->regs[8], &sf->uc.uc_mcontext.arm_r8, err);
+=09__put_user_error(regs->regs[9], &sf->uc.uc_mcontext.arm_r9, err);
+=09__put_user_error(regs->regs[10], &sf->uc.uc_mcontext.arm_r10, err);
+=09__put_user_error(regs->regs[11], &sf->uc.uc_mcontext.arm_fp, err);
+=09__put_user_error(regs->regs[12], &sf->uc.uc_mcontext.arm_ip, err);
+=09__put_user_error(regs->compat_sp, &sf->uc.uc_mcontext.arm_sp, err);
+=09__put_user_error(regs->compat_lr, &sf->uc.uc_mcontext.arm_lr, err);
+=09__put_user_error(regs->pc, &sf->uc.uc_mcontext.arm_pc, err);
+=09__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
+
+=09__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
+=09__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.error_code, err=
);
+=09__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fau=
lt_address, err);
+=09__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
+
+=09err |=3D put_sigset_t(&sf->uc.uc_sigmask, set);
+
+=09aux =3D (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
+
+=09if (err =3D=3D 0)
+=09=09err |=3D compat_preserve_vfp_context(&aux->vfp);
+=09__put_user_error(0, &aux->end_magic, err);
+
+=09return err;
+}
+
+/*
+ * 32-bit signal handling routines called from signal.c
+ */
+int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *inf=
o,
+=09=09=09  sigset_t *set, struct pt_regs *regs)
+{
+=09struct compat_rt_sigframe __user *frame;
+=09compat_stack_t stack;
+=09int err =3D 0;
+
+=09frame =3D compat_get_sigframe(ka, regs, sizeof(*frame));
+
+=09if (!frame)
+=09=09return 1;
+
+=09err |=3D copy_siginfo_to_user32(&frame->info, info);
+
+=09__put_user_error(0, &frame->sig.uc.uc_flags, err);
+=09__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+
+=09memset(&stack, 0, sizeof(stack));
+=09stack.ss_sp =3D (compat_uptr_t)current->sas_ss_sp;
+=09stack.ss_flags =3D sas_ss_flags(regs->compat_sp);
+=09stack.ss_size =3D current->sas_ss_size;
+=09err |=3D __copy_to_user(&frame->sig.uc.uc_stack, &stack, sizeof(stack))=
;
+
+=09err |=3D compat_setup_sigframe(&frame->sig, regs, set);
+=09if (err =3D=3D 0)
+=09=09err =3D compat_setup_return(regs, ka, frame->sig.retcode, frame,
+=09=09=09=09=09  usig);
+
+=09if (err =3D=3D 0) {
+=09=09regs->regs[1] =3D (compat_ulong_t)(unsigned long)&frame->info;
+=09=09regs->regs[2] =3D (compat_ulong_t)(unsigned long)&frame->sig.uc;
+=09}
+
+=09return err;
+}
+
+int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
+=09=09       struct pt_regs *regs)
+{
+=09struct compat_sigframe __user *frame;
+=09int err =3D 0;
+
+=09frame =3D compat_get_sigframe(ka, regs, sizeof(*frame));
+
+=09if (!frame)
+=09=09return 1;
+
+=09__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
+
+=09err |=3D compat_setup_sigframe(frame, regs, set);
+=09if (err =3D=3D 0)
+=09=09err =3D compat_setup_return(regs, ka, frame->retcode, frame, usig);
+
+=09return err;
+}
+
+/*
+ * RT signals don't have generic compat wrappers.
+ * See arch/powerpc/kernel/signal_32.c
+ */
+asmlinkage int compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *=
set,
+=09=09=09=09=09 compat_sigset_t __user *oset,
+=09=09=09=09=09 compat_size_t sigsetsize)
+{
+=09sigset_t s;
+=09sigset_t __user *up;
+=09int ret;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09if (set) {
+=09=09if (get_sigset_t(&s, set))
+=09=09=09return -EFAULT;
+=09}
+
+=09set_fs(KERNEL_DS);
+=09/* This is valid because of the set_fs() */
+=09up =3D (sigset_t __user *) &s;
+=09ret =3D sys_rt_sigprocmask(how, set ? up : NULL, oset ? up : NULL,
+=09=09=09=09 sigsetsize);
+=09set_fs(old_fs);
+=09if (ret)
+=09=09return ret;
+=09if (oset) {
+=09=09if (put_sigset_t(oset, &s))
+=09=09=09return -EFAULT;
+=09}
+=09return 0;
+}
+
+asmlinkage int compat_sys_rt_sigpending(compat_sigset_t __user *set,
+=09=09=09=09=09compat_size_t sigsetsize)
+{
+=09sigset_t s;
+=09int ret;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09set_fs(KERNEL_DS);
+=09/* The __user pointer cast is valid because of the set_fs() */
+=09ret =3D sys_rt_sigpending((sigset_t __user *) &s, sigsetsize);
+=09set_fs(old_fs);
+=09if (!ret) {
+=09=09if (put_sigset_t(set, &s))
+=09=09=09return -EFAULT;
+=09}
+=09return ret;
+}
+
+asmlinkage int compat_sys_rt_sigqueueinfo(int pid, int sig,
+=09=09=09=09=09  compat_siginfo_t __user *uinfo)
+{
+=09siginfo_t info;
+=09int ret;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09ret =3D copy_siginfo_from_user32(&info, uinfo);
+=09if (unlikely(ret))
+=09=09return ret;
+
+=09set_fs (KERNEL_DS);
+=09/* The __user pointer cast is valid because of the set_fs() */
+=09ret =3D sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
+=09set_fs (old_fs);
+=09return ret;
+}
+
+void compat_setup_restart_syscall(struct pt_regs *regs)
+{
+       regs->regs[7] =3D __NR_restart_syscall;
+}
diff --git a/arch/arm64/kernel/sys32.S b/arch/arm64/kernel/sys32.S
new file mode 100644
index 0000000..5e4dc93
--- /dev/null
+++ b/arch/arm64/kernel/sys32.S
@@ -0,0 +1,282 @@
+/*
+ * Compat system call wrappers
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Authors: Will Deacon <will.deacon@arm.com>
+ *=09    Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * System call wrappers for the AArch32 compatibility layer.
+ */
+compat_sys_fork_wrapper:
+=09mov=09x0, sp
+=09b=09compat_sys_fork
+ENDPROC(compat_sys_fork_wrapper)
+
+compat_sys_vfork_wrapper:
+=09mov=09x0, sp
+=09b=09compat_sys_vfork
+ENDPROC(compat_sys_vfork_wrapper)
+
+compat_sys_execve_wrapper:
+=09mov=09x3, sp
+=09b=09compat_sys_execve
+ENDPROC(compat_sys_execve_wrapper)
+
+compat_sys_clone_wrapper:
+=09mov=09x5, sp
+=09b=09compat_sys_clone
+ENDPROC(compat_sys_clone_wrapper)
+
+compat_sys_sigreturn_wrapper:
+=09mov=09x0, sp
+=09mov=09x27, #0=09=09// prevent syscall restart handling (why)
+=09b=09compat_sys_sigreturn
+ENDPROC(compat_sys_sigreturn_wrapper)
+
+compat_sys_rt_sigreturn_wrapper:
+=09mov=09x0, sp
+=09mov=09x27, #0=09=09// prevent syscall restart handling (why)
+=09b=09compat_sys_rt_sigreturn
+ENDPROC(compat_sys_rt_sigreturn_wrapper)
+
+compat_sys_sigaltstack_wrapper:
+=09ldr=09x2, [sp, #S_COMPAT_SP]
+=09b=09compat_do_sigaltstack
+ENDPROC(compat_sys_sigaltstack_wrapper)
+
+compat_sys_statfs64_wrapper:
+=09mov=09w3, #84
+=09cmp=09w1, #88
+=09csel=09w1, w3, w1, eq
+=09b=09compat_sys_statfs64
+ENDPROC(compat_sys_statfs64_wrapper)
+
+compat_sys_fstatfs64_wrapper:
+=09mov=09w3, #84
+=09cmp=09w1, #88
+=09csel=09w1, w3, w1, eq
+=09b=09compat_sys_fstatfs64
+ENDPROC(compat_sys_fstatfs64_wrapper)
+
+/*
+ * Wrappers for AArch32 syscalls that either take 64-bit parameters
+ * in registers or that take 32-bit parameters which require sign
+ * extension.
+ */
+compat_sys_lseek_wrapper:
+=09sxtw=09x1, w1
+=09b=09sys_lseek
+ENDPROC(compat_sys_lseek_wrapper)
+
+compat_sys_pread64_wrapper:
+=09orr=09x3, x4, x5, lsl #32
+=09b=09sys_pread64
+ENDPROC(compat_sys_pread64_wrapper)
+
+compat_sys_pwrite64_wrapper:
+=09orr=09x3, x4, x5, lsl #32
+=09b=09sys_pwrite64
+ENDPROC(compat_sys_pwrite64_wrapper)
+
+compat_sys_truncate64_wrapper:
+=09orr=09x1, x2, x3, lsl #32
+=09b=09sys_truncate
+ENDPROC(compat_sys_truncate64_wrapper)
+
+compat_sys_ftruncate64_wrapper:
+=09orr=09x1, x2, x3, lsl #32
+=09b=09sys_ftruncate
+ENDPROC(compat_sys_ftruncate64_wrapper)
+
+compat_sys_readahead_wrapper:
+=09orr=09x1, x2, x3, lsl #32
+=09mov=09w2, w4
+=09b=09sys_readahead
+ENDPROC(compat_sys_readahead_wrapper)
+
+compat_sys_lookup_dcookie:
+=09orr=09x0, x0, x1, lsl #32
+=09mov=09w1, w2
+=09mov=09w2, w3
+=09b=09sys_lookup_dcookie
+ENDPROC(compat_sys_lookup_dcookie)
+
+compat_sys_fadvise64_64_wrapper:
+=09mov=09w6, w1
+=09orr=09x1, x2, x3, lsl #32
+=09orr=09x2, x4, x5, lsl #32
+=09mov=09w3, w6
+=09b=09sys_fadvise64_64
+ENDPROC(compat_sys_fadvise64_64_wrapper)
+
+compat_sys_sync_file_range2_wrapper:
+=09orr=09x2, x2, x3, lsl #32
+=09orr=09x3, x4, x5, lsl #32
+=09b=09sys_sync_file_range2
+ENDPROC(compat_sys_sync_file_range2_wrapper)
+
+compat_sys_fallocate_wrapper:
+=09orr=09x2, x2, x3, lsl #32
+=09orr=09x3, x4, x5, lsl #32
+=09b=09sys_fallocate
+ENDPROC(compat_sys_fallocate_wrapper)
+
+compat_sys_fanotify_mark_wrapper:
+=09orr=09x2, x2, x3, lsl #32
+=09mov=09w3, w4
+=09mov=09w4, w5
+=09b=09sys_fanotify_mark
+ENDPROC(compat_sys_fanotify_mark_wrapper)
+
+/*
+ * Use the compat system call wrappers.
+ */
+#define sys_fork=09=09compat_sys_fork_wrapper
+#define sys_open=09=09compat_sys_open
+#define sys_execve=09=09compat_sys_execve_wrapper
+#define sys_lseek=09=09compat_sys_lseek_wrapper
+#define sys_mount=09=09compat_sys_mount
+#define sys_ptrace=09=09compat_sys_ptrace
+#define sys_times=09=09compat_sys_times
+#define sys_ioctl=09=09compat_sys_ioctl
+#define sys_fcntl=09=09compat_sys_fcntl
+#define sys_ustat=09=09compat_sys_ustat
+#define sys_sigaction=09=09compat_sys_sigaction
+#define sys_sigsuspend=09=09compat_sys_sigsuspend
+#define sys_sigpending=09=09compat_sys_sigpending
+#define sys_setrlimit=09=09compat_sys_setrlimit
+#define sys_getrusage=09=09compat_sys_getrusage
+#define sys_gettimeofday=09compat_sys_gettimeofday
+#define sys_settimeofday=09compat_sys_settimeofday
+#define sys_statfs=09=09compat_sys_statfs
+#define sys_fstatfs=09=09compat_sys_fstatfs
+#define sys_setitimer=09=09compat_sys_setitimer
+#define sys_getitimer=09=09compat_sys_getitimer
+#define sys_newstat=09=09compat_sys_newstat
+#define sys_newlstat=09=09compat_sys_newlstat
+#define sys_newfstat=09=09compat_sys_newfstat
+#define sys_wait4=09=09compat_sys_wait4
+#define sys_sysinfo=09=09compat_sys_sysinfo
+#define sys_sigreturn=09=09compat_sys_sigreturn_wrapper
+#define sys_clone=09=09compat_sys_clone_wrapper
+#define sys_adjtimex=09=09compat_sys_adjtimex
+#define sys_sigprocmask=09=09compat_sys_sigprocmask
+#define sys_getdents=09=09compat_sys_getdents
+#define sys_select=09=09compat_sys_select
+#define sys_readv=09=09compat_sys_readv
+#define sys_writev=09=09compat_sys_writev
+#define sys_sysctl=09=09compat_sys_sysctl
+#define sys_sched_rr_get_interval compat_sys_sched_rr_get_interval
+#define sys_nanosleep=09=09compat_sys_nanosleep
+#define sys_rt_sigreturn=09compat_sys_rt_sigreturn_wrapper
+#define sys_rt_sigaction=09compat_sys_rt_sigaction
+#define sys_rt_sigprocmask=09compat_sys_rt_sigprocmask
+#define sys_rt_sigpending=09compat_sys_rt_sigpending
+#define sys_rt_sigtimedwait=09compat_sys_rt_sigtimedwait
+#define sys_rt_sigqueueinfo=09compat_sys_rt_sigqueueinfo
+#define sys_rt_sigsuspend=09compat_sys_rt_sigsuspend
+#define sys_pread64=09=09compat_sys_pread64_wrapper
+#define sys_pwrite64=09=09compat_sys_pwrite64_wrapper
+#define sys_sigaltstack=09=09compat_sys_sigaltstack_wrapper
+#define sys_sendfile=09=09compat_sys_sendfile
+#define sys_vfork=09=09compat_sys_vfork_wrapper
+#define sys_getrlimit=09=09compat_sys_getrlimit
+#define sys_mmap2=09=09sys_mmap_pgoff
+#define sys_truncate64=09=09compat_sys_truncate64_wrapper
+#define sys_ftruncate64=09=09compat_sys_ftruncate64_wrapper
+#define sys_getdents64=09=09compat_sys_getdents64
+#define sys_fcntl64=09=09compat_sys_fcntl64
+#define sys_readahead=09=09compat_sys_readahead_wrapper
+#define sys_futex=09=09compat_sys_futex
+#define sys_sched_setaffinity=09compat_sys_sched_setaffinity
+#define sys_sched_getaffinity=09compat_sys_sched_getaffinity
+#define sys_io_setup=09=09compat_sys_io_setup
+#define sys_io_getevents=09compat_sys_io_getevents
+#define sys_io_submit=09=09compat_sys_io_submit
+#define sys_lookup_dcookie=09compat_sys_lookup_dcookie
+#define sys_timer_create=09compat_sys_timer_create
+#define sys_timer_settime=09compat_sys_timer_settime
+#define sys_timer_gettime=09compat_sys_timer_gettime
+#define sys_clock_settime=09compat_sys_clock_settime
+#define sys_clock_gettime=09compat_sys_clock_gettime
+#define sys_clock_getres=09compat_sys_clock_getres
+#define sys_clock_nanosleep=09compat_sys_clock_nanosleep
+#define sys_statfs64=09=09compat_sys_statfs64_wrapper
+#define sys_fstatfs64=09=09compat_sys_fstatfs64_wrapper
+#define sys_utimes=09=09compat_sys_utimes
+#define sys_fadvise64_64=09compat_sys_fadvise64_64_wrapper
+#define sys_mq_open=09=09compat_sys_mq_open
+#define sys_mq_timedsend=09compat_sys_mq_timedsend
+#define sys_mq_timedreceive=09compat_sys_mq_timedreceive
+#define sys_mq_notify=09=09compat_sys_mq_notify
+#define sys_mq_getsetattr=09compat_sys_mq_getsetattr
+#define sys_waitid=09=09compat_sys_waitid
+#define sys_recv=09=09compat_sys_recv
+#define sys_recvfrom=09=09compat_sys_recvfrom
+#define sys_setsockopt=09=09compat_sys_setsockopt
+#define sys_getsockopt=09=09compat_sys_getsockopt
+#define sys_sendmsg=09=09compat_sys_sendmsg
+#define sys_recvmsg=09=09compat_sys_recvmsg
+#define sys_semctl=09=09compat_sys_semctl
+#define sys_msgsnd=09=09compat_sys_msgsnd
+#define sys_msgrcv=09=09compat_sys_msgrcv
+#define sys_msgctl=09=09compat_sys_msgctl
+#define sys_shmat=09=09compat_sys_shmat
+#define sys_shmctl=09=09compat_sys_shmctl
+#define sys_keyctl=09=09compat_sys_keyctl
+#define sys_semtimedop=09=09compat_sys_semtimedop
+#define sys_mbind=09=09compat_sys_mbind
+#define sys_get_mempolicy=09compat_sys_get_mempolicy
+#define sys_set_mempolicy=09compat_sys_set_mempolicy
+#define sys_openat=09=09compat_sys_openat
+#define sys_futimesat=09=09compat_sys_futimesat
+#define sys_pselect6=09=09compat_sys_pselect6
+#define sys_ppoll=09=09compat_sys_ppoll
+#define sys_set_robust_list=09compat_sys_set_robust_list
+#define sys_get_robust_list=09compat_sys_get_robust_list
+#define sys_sync_file_range2=09compat_sys_sync_file_range2_wrapper
+#define sys_vmsplice=09=09compat_sys_vmsplice
+#define sys_move_pages=09=09compat_sys_move_pages
+#define sys_epoll_pwait=09=09compat_sys_epoll_pwait
+#define sys_kexec_load=09=09compat_sys_kexec_load
+#define sys_utimensat=09=09compat_sys_utimensat
+#define sys_signalfd=09=09compat_sys_signalfd
+#define sys_fallocate=09=09compat_sys_fallocate_wrapper
+#define sys_timerfd_settime=09compat_sys_timerfd_settime
+#define sys_timerfd_gettime=09compat_sys_timerfd_gettime
+#define sys_signalfd4=09=09compat_sys_signalfd4
+#define sys_preadv=09=09compat_sys_preadv
+#define sys_pwritev=09=09compat_sys_pwritev
+#define sys_rt_tgsigqueueinfo=09compat_sys_rt_tgsigqueueinfo
+#define sys_recvmmsg=09=09compat_sys_recvmmsg
+#define sys_fanotify_mark=09compat_sys_fanotify_mark_wrapper
+
+#undef __SYSCALL
+#define __SYSCALL(x, y)=09=09.quad=09y=09// x
+#define __SYSCALL_COMPAT
+
+/*
+ * The system calls table must be 4KB aligned.
+ */
+=09.align=0912
+ENTRY(compat_sys_call_table)
+#include <asm/unistd.h>
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.=
c
new file mode 100644
index 0000000..967e92f
--- /dev/null
+++ b/arch/arm64/kernel/sys_compat.c
@@ -0,0 +1,164 @@
+/*
+ * Based on arch/arm/kernel/sys_arm.c
+ *
+ * Copyright (C) People who wrote linux/arch/i386/kernel/sys_i386.c
+ * Copyright (C) 1995, 1996 Russell King.
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define __SYSCALL_COMPAT
+
+#include <linux/compat.h>
+#include <linux/personality.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/unistd.h>
+
+asmlinkage int compat_sys_fork(struct pt_regs *regs)
+{
+=09return do_fork(SIGCHLD, regs->compat_sp, regs, 0, NULL, NULL);
+}
+
+asmlinkage int compat_sys_clone(unsigned long clone_flags, unsigned long n=
ewsp,
+=09=09=09  int __user *parent_tidptr, int tls_val,
+=09=09=09  int __user *child_tidptr, struct pt_regs *regs)
+{
+=09if (!newsp)
+=09=09newsp =3D regs->compat_sp;
+
+=09return do_fork(clone_flags, newsp, regs, 0, parent_tidptr, child_tidptr=
);
+}
+
+asmlinkage int compat_sys_vfork(struct pt_regs *regs)
+{
+=09return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->compat_sp,
+=09=09       regs, 0, NULL, NULL);
+}
+
+asmlinkage int compat_sys_execve(const char __user *filenamei,
+=09=09=09=09 compat_uptr_t argv, compat_uptr_t envp,
+=09=09=09=09 struct pt_regs *regs)
+{
+=09int error;
+=09char * filename;
+
+=09filename =3D getname(filenamei);
+=09error =3D PTR_ERR(filename);
+=09if (IS_ERR(filename))
+=09=09goto out;
+=09error =3D compat_do_execve(filename, compat_ptr(argv), compat_ptr(envp)=
,
+=09=09=09=09 regs);
+=09putname(filename);
+out:
+=09return error;
+}
+
+asmlinkage int compat_sys_sched_rr_get_interval(compat_pid_t pid,
+=09=09=09=09=09=09struct compat_timespec __user *interval)
+{
+=09struct timespec t;
+=09int ret;
+=09mm_segment_t old_fs =3D get_fs();
+
+=09set_fs(KERNEL_DS);
+=09ret =3D sys_sched_rr_get_interval(pid, (struct timespec __user *)&t);
+=09set_fs(old_fs);
+=09if (put_compat_timespec(&t, interval))
+=09=09return -EFAULT;
+=09return ret;
+}
+
+asmlinkage int compat_sys_sendfile(int out_fd, int in_fd,
+=09=09=09=09   compat_off_t __user *offset, s32 count)
+{
+=09mm_segment_t old_fs =3D get_fs();
+=09int ret;
+=09off_t of;
+
+=09if (offset && get_user(of, offset))
+=09=09return -EFAULT;
+
+=09set_fs(KERNEL_DS);
+=09ret =3D sys_sendfile(out_fd, in_fd, offset ? (off_t __user *)&of : NULL=
,
+=09=09=09   count);
+=09set_fs(old_fs);
+
+=09if (offset && put_user(of, offset))
+=09=09return -EFAULT;
+=09return ret;
+}
+
+static inline void
+do_compat_cache_op(unsigned long start, unsigned long end, int flags)
+{
+=09struct mm_struct *mm =3D current->active_mm;
+=09struct vm_area_struct *vma;
+
+=09if (end < start || flags)
+=09=09return;
+
+=09down_read(&mm->mmap_sem);
+=09vma =3D find_vma(mm, start);
+=09if (vma && vma->vm_start < end) {
+=09=09if (start < vma->vm_start)
+=09=09=09start =3D vma->vm_start;
+=09=09if (end > vma->vm_end)
+=09=09=09end =3D vma->vm_end;
+=09=09up_read(&mm->mmap_sem);
+=09=09__flush_cache_user_range(start & PAGE_MASK, PAGE_ALIGN(end));
+=09=09return;
+=09}
+=09up_read(&mm->mmap_sem);
+}
+
+/*
+ * Handle all unrecognised system calls.
+ */
+long compat_arm_syscall(struct pt_regs *regs)
+{
+=09unsigned int no =3D regs->regs[7];
+
+=09switch (no) {
+=09/*
+=09 * Flush a region from virtual address 'r0' to virtual address 'r1'
+=09 * _exclusive_.  There is no alignment requirement on either address;
+=09 * user space does not need to know the hardware cache layout.
+=09 *
+=09 * r2 contains flags.  It should ALWAYS be passed as ZERO until it
+=09 * is defined to be something else.  For now we ignore it, but may
+=09 * the fires of hell burn in your belly if you break this rule. ;)
+=09 *
+=09 * (at a later date, we may want to allow this call to not flush
+=09 * various aspects of the cache.  Passing '0' will guarantee that
+=09 * everything necessary gets flushed to maintain consistency in
+=09 * the specified region).
+=09 */
+=09case __ARM_NR_compat_cacheflush:
+=09=09do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
+=09=09return 0;
+
+=09case __ARM_NR_compat_set_tls:
+=09=09current->thread.tp_value =3D regs->regs[0];
+=09=09asm ("msr tpidrro_el0, %0" : : "r" (regs->regs[0]));
+=09=09return 0;
+
+=09default:
+=09=09return -ENOSYS;
+=09}
+}

