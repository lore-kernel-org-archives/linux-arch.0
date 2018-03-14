From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/16] asm-generic: clean up asm/unistd.h
Date: Wed, 14 Mar 2018 21:38:57 +0100
Message-ID: <20180314203921.3949225-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Stafford Horne <shorne@gmail.com>
List-Id: linux-arch.vger.kernel.org

The score architecture used a number of old system calls for compatibility
with a traditional libc port, all architectures that got added later
skip these. With score out of the way, we can finally clean up the
syscall list to no longer provide these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 163 --------------------------------------
 1 file changed, 163 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8b87de067bc7..8bcb186c6f67 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -737,169 +737,6 @@ __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_syscalls 292
 
 /*
- * All syscalls below here should go away really,
- * these are provided for both review and as a porting
- * help for the C library version.
- *
- * Last chance: are any of these important enough to
- * enable by default?
- */
-#ifdef __ARCH_WANT_SYSCALL_NO_AT
-#define __NR_open 1024
-__SYSCALL(__NR_open, sys_open)
-#define __NR_link 1025
-__SYSCALL(__NR_link, sys_link)
-#define __NR_unlink 1026
-__SYSCALL(__NR_unlink, sys_unlink)
-#define __NR_mknod 1027
-__SYSCALL(__NR_mknod, sys_mknod)
-#define __NR_chmod 1028
-__SYSCALL(__NR_chmod, sys_chmod)
-#define __NR_chown 1029
-__SYSCALL(__NR_chown, sys_chown)
-#define __NR_mkdir 1030
-__SYSCALL(__NR_mkdir, sys_mkdir)
-#define __NR_rmdir 1031
-__SYSCALL(__NR_rmdir, sys_rmdir)
-#define __NR_lchown 1032
-__SYSCALL(__NR_lchown, sys_lchown)
-#define __NR_access 1033
-__SYSCALL(__NR_access, sys_access)
-#define __NR_rename 1034
-__SYSCALL(__NR_rename, sys_rename)
-#define __NR_readlink 1035
-__SYSCALL(__NR_readlink, sys_readlink)
-#define __NR_symlink 1036
-__SYSCALL(__NR_symlink, sys_symlink)
-#define __NR_utimes 1037
-__SYSCALL(__NR_utimes, sys_utimes)
-#define __NR3264_stat 1038
-__SC_3264(__NR3264_stat, sys_stat64, sys_newstat)
-#define __NR3264_lstat 1039
-__SC_3264(__NR3264_lstat, sys_lstat64, sys_newlstat)
-
-#undef __NR_syscalls
-#define __NR_syscalls (__NR3264_lstat+1)
-#endif /* __ARCH_WANT_SYSCALL_NO_AT */
-
-#ifdef __ARCH_WANT_SYSCALL_NO_FLAGS
-#define __NR_pipe 1040
-__SYSCALL(__NR_pipe, sys_pipe)
-#define __NR_dup2 1041
-__SYSCALL(__NR_dup2, sys_dup2)
-#define __NR_epoll_create 1042
-__SYSCALL(__NR_epoll_create, sys_epoll_create)
-#define __NR_inotify_init 1043
-__SYSCALL(__NR_inotify_init, sys_inotify_init)
-#define __NR_eventfd 1044
-__SYSCALL(__NR_eventfd, sys_eventfd)
-#define __NR_signalfd 1045
-__SYSCALL(__NR_signalfd, sys_signalfd)
-
-#undef __NR_syscalls
-#define __NR_syscalls (__NR_signalfd+1)
-#endif /* __ARCH_WANT_SYSCALL_NO_FLAGS */
-
-#if (__BITS_PER_LONG == 32 || defined(__SYSCALL_COMPAT)) && \
-     defined(__ARCH_WANT_SYSCALL_OFF_T)
-#define __NR_sendfile 1046
-__SYSCALL(__NR_sendfile, sys_sendfile)
-#define __NR_ftruncate 1047
-__SYSCALL(__NR_ftruncate, sys_ftruncate)
-#define __NR_truncate 1048
-__SYSCALL(__NR_truncate, sys_truncate)
-#define __NR_stat 1049
-__SYSCALL(__NR_stat, sys_newstat)
-#define __NR_lstat 1050
-__SYSCALL(__NR_lstat, sys_newlstat)
-#define __NR_fstat 1051
-__SYSCALL(__NR_fstat, sys_newfstat)
-#define __NR_fcntl 1052
-__SYSCALL(__NR_fcntl, sys_fcntl)
-#define __NR_fadvise64 1053
-#define __ARCH_WANT_SYS_FADVISE64
-__SYSCALL(__NR_fadvise64, sys_fadvise64)
-#define __NR_newfstatat 1054
-#define __ARCH_WANT_SYS_NEWFSTATAT
-__SYSCALL(__NR_newfstatat, sys_newfstatat)
-#define __NR_fstatfs 1055
-__SYSCALL(__NR_fstatfs, sys_fstatfs)
-#define __NR_statfs 1056
-__SYSCALL(__NR_statfs, sys_statfs)
-#define __NR_lseek 1057
-__SYSCALL(__NR_lseek, sys_lseek)
-#define __NR_mmap 1058
-__SYSCALL(__NR_mmap, sys_mmap)
-
-#undef __NR_syscalls
-#define __NR_syscalls (__NR_mmap+1)
-#endif /* 32 bit off_t syscalls */
-
-#ifdef __ARCH_WANT_SYSCALL_DEPRECATED
-#define __NR_alarm 1059
-#define __ARCH_WANT_SYS_ALARM
-__SYSCALL(__NR_alarm, sys_alarm)
-#define __NR_getpgrp 1060
-#define __ARCH_WANT_SYS_GETPGRP
-__SYSCALL(__NR_getpgrp, sys_getpgrp)
-#define __NR_pause 1061
-#define __ARCH_WANT_SYS_PAUSE
-__SYSCALL(__NR_pause, sys_pause)
-#define __NR_time 1062
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_COMPAT_SYS_TIME
-__SYSCALL(__NR_time, sys_time)
-#define __NR_utime 1063
-#define __ARCH_WANT_SYS_UTIME
-__SYSCALL(__NR_utime, sys_utime)
-
-#define __NR_creat 1064
-__SYSCALL(__NR_creat, sys_creat)
-#define __NR_getdents 1065
-#define __ARCH_WANT_SYS_GETDENTS
-__SYSCALL(__NR_getdents, sys_getdents)
-#define __NR_futimesat 1066
-__SYSCALL(__NR_futimesat, sys_futimesat)
-#define __NR_select 1067
-#define __ARCH_WANT_SYS_SELECT
-__SYSCALL(__NR_select, sys_select)
-#define __NR_poll 1068
-__SYSCALL(__NR_poll, sys_poll)
-#define __NR_epoll_wait 1069
-__SYSCALL(__NR_epoll_wait, sys_epoll_wait)
-#define __NR_ustat 1070
-__SYSCALL(__NR_ustat, sys_ustat)
-#define __NR_vfork 1071
-__SYSCALL(__NR_vfork, sys_vfork)
-#define __NR_oldwait4 1072
-__SYSCALL(__NR_oldwait4, sys_wait4)
-#define __NR_recv 1073
-__SYSCALL(__NR_recv, sys_recv)
-#define __NR_send 1074
-__SYSCALL(__NR_send, sys_send)
-#define __NR_bdflush 1075
-__SYSCALL(__NR_bdflush, sys_bdflush)
-#define __NR_umount 1076
-__SYSCALL(__NR_umount, sys_oldumount)
-#define __ARCH_WANT_SYS_OLDUMOUNT
-#define __NR_uselib 1077
-__SYSCALL(__NR_uselib, sys_uselib)
-#define __NR__sysctl 1078
-__SYSCALL(__NR__sysctl, sys_sysctl)
-
-#define __NR_fork 1079
-#ifdef CONFIG_MMU
-__SYSCALL(__NR_fork, sys_fork)
-#else
-__SYSCALL(__NR_fork, sys_ni_syscall)
-#endif /* CONFIG_MMU */
-
-#undef __NR_syscalls
-#define __NR_syscalls (__NR_fork+1)
-
-#endif /* __ARCH_WANT_SYSCALL_DEPRECATED */
-
-/*
  * 32 bit systems traditionally used different
  * syscalls for off_t and loff_t arguments, while
  * 64 bit systems only need the off_t version.
-- 
2.9.0
