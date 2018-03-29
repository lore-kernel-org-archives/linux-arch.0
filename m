From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 108/109] kernel/sys_ni: remove {sys_,sys_compat} from cond_syscall definitions
Date: Thu, 29 Mar 2018 13:24:25 +0200
Message-ID: <20180329112426.23043-109-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This keeps it in line with the SYSCALL_DEFINEx() / COMPAT_SYSCALL_DEFINEx()
calling convention.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 Documentation/process/adding-syscalls.rst |   2 +-
 kernel/sys_ni.c                           | 433 +++++++++++++++---------------
 2 files changed, 219 insertions(+), 216 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 556613744556..314c8bf6f2a2 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -222,7 +222,7 @@ your new syscall number may get adjusted to resolve conflicts.
 The file ``kernel/sys_ni.c`` provides a fallback stub implementation of each
 system call, returning ``-ENOSYS``.  Add your new system call here too::
 
-    cond_syscall(sys_xyzzy);
+    COND_SYSCALL(xyzzy);
 
 Your new kernel functionality, and the system call that controls it, should
 normally be optional, so add a ``CONFIG`` option (typically to
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0c1538f5a559..6cafc008f6db 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -17,53 +17,56 @@ asmlinkage long sys_ni_syscall(void)
 	return -ENOSYS;
 }
 
+#define COND_SYSCALL(name) cond_syscall(sys_##name)
+#define COND_SYSCALL_COMPAT(name) cond_syscall(compat_sys_##name)
+
 /*
  * This list is kept in the same order as include/uapi/asm-generic/unistd.h.
  * Architecture specific entries go below, followed by deprecated or obsolete
  * system calls.
  */
 
-cond_syscall(sys_io_setup);
-cond_syscall(compat_sys_io_setup);
-cond_syscall(sys_io_destroy);
-cond_syscall(sys_io_submit);
-cond_syscall(compat_sys_io_submit);
-cond_syscall(sys_io_cancel);
-cond_syscall(sys_io_getevents);
-cond_syscall(compat_sys_io_getevents);
+COND_SYSCALL(io_setup);
+COND_SYSCALL_COMPAT(io_setup);
+COND_SYSCALL(io_destroy);
+COND_SYSCALL(io_submit);
+COND_SYSCALL_COMPAT(io_submit);
+COND_SYSCALL(io_cancel);
+COND_SYSCALL(io_getevents);
+COND_SYSCALL_COMPAT(io_getevents);
 
 /* fs/xattr.c */
 
 /* fs/dcache.c */
 
 /* fs/cookies.c */
-cond_syscall(sys_lookup_dcookie);
-cond_syscall(compat_sys_lookup_dcookie);
+COND_SYSCALL(lookup_dcookie);
+COND_SYSCALL_COMPAT(lookup_dcookie);
 
 /* fs/eventfd.c */
-cond_syscall(sys_eventfd2);
+COND_SYSCALL(eventfd2);
 
 /* fs/eventfd.c */
-cond_syscall(sys_epoll_create1);
-cond_syscall(sys_epoll_ctl);
-cond_syscall(sys_epoll_pwait);
-cond_syscall(compat_sys_epoll_pwait);
+COND_SYSCALL(epoll_create1);
+COND_SYSCALL(epoll_ctl);
+COND_SYSCALL(epoll_pwait);
+COND_SYSCALL_COMPAT(epoll_pwait);
 
 /* fs/fcntl.c */
 
 /* fs/inotify_user.c */
-cond_syscall(sys_inotify_init1);
-cond_syscall(sys_inotify_add_watch);
-cond_syscall(sys_inotify_rm_watch);
+COND_SYSCALL(inotify_init1);
+COND_SYSCALL(inotify_add_watch);
+COND_SYSCALL(inotify_rm_watch);
 
 /* fs/ioctl.c */
 
 /* fs/ioprio.c */
-cond_syscall(sys_ioprio_set);
-cond_syscall(sys_ioprio_get);
+COND_SYSCALL(ioprio_set);
+COND_SYSCALL(ioprio_get);
 
 /* fs/locks.c */
-cond_syscall(sys_flock);
+COND_SYSCALL(flock);
 
 /* fs/namei.c */
 
@@ -76,7 +79,7 @@ cond_syscall(sys_flock);
 /* fs/pipe.c */
 
 /* fs/quota.c */
-cond_syscall(sys_quotactl);
+COND_SYSCALL(quotactl);
 
 /* fs/readdir.c */
 
@@ -87,8 +90,8 @@ cond_syscall(sys_quotactl);
 /* fs/select.c */
 
 /* fs/signalfd.c */
-cond_syscall(sys_signalfd4);
-cond_syscall(compat_sys_signalfd4);
+COND_SYSCALL(signalfd4);
+COND_SYSCALL_COMPAT(signalfd4);
 
 /* fs/splice.c */
 
@@ -97,20 +100,20 @@ cond_syscall(compat_sys_signalfd4);
 /* fs/sync.c */
 
 /* fs/timerfd.c */
-cond_syscall(sys_timerfd_create);
-cond_syscall(sys_timerfd_settime);
-cond_syscall(compat_sys_timerfd_settime);
-cond_syscall(sys_timerfd_gettime);
-cond_syscall(compat_sys_timerfd_gettime);
+COND_SYSCALL(timerfd_create);
+COND_SYSCALL(timerfd_settime);
+COND_SYSCALL_COMPAT(timerfd_settime);
+COND_SYSCALL(timerfd_gettime);
+COND_SYSCALL_COMPAT(timerfd_gettime);
 
 /* fs/utimes.c */
 
 /* kernel/acct.c */
-cond_syscall(sys_acct);
+COND_SYSCALL(acct);
 
 /* kernel/capability.c */
-cond_syscall(sys_capget);
-cond_syscall(sys_capset);
+COND_SYSCALL(capget);
+COND_SYSCALL(capset);
 
 /* kernel/exec_domain.c */
 
@@ -119,29 +122,29 @@ cond_syscall(sys_capset);
 /* kernel/fork.c */
 
 /* kernel/futex.c */
-cond_syscall(sys_futex);
-cond_syscall(compat_sys_futex);
-cond_syscall(sys_set_robust_list);
-cond_syscall(compat_sys_set_robust_list);
-cond_syscall(sys_get_robust_list);
-cond_syscall(compat_sys_get_robust_list);
+COND_SYSCALL(futex);
+COND_SYSCALL_COMPAT(futex);
+COND_SYSCALL(set_robust_list);
+COND_SYSCALL_COMPAT(set_robust_list);
+COND_SYSCALL(get_robust_list);
+COND_SYSCALL_COMPAT(get_robust_list);
 
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
 
 /* kernel/kexec.c */
-cond_syscall(sys_kexec_load);
-cond_syscall(compat_sys_kexec_load);
+COND_SYSCALL(kexec_load);
+COND_SYSCALL_COMPAT(kexec_load);
 
 /* kernel/module.c */
-cond_syscall(sys_init_module);
-cond_syscall(sys_delete_module);
+COND_SYSCALL(init_module);
+COND_SYSCALL(delete_module);
 
 /* kernel/posix-timers.c */
 
 /* kernel/printk.c */
-cond_syscall(sys_syslog);
+COND_SYSCALL(syslog);
 
 /* kernel/ptrace.c */
 
@@ -150,176 +153,176 @@ cond_syscall(sys_syslog);
 /* kernel/signal.c */
 
 /* kernel/sys.c */
-cond_syscall(sys_setregid);
-cond_syscall(sys_setgid);
-cond_syscall(sys_setreuid);
-cond_syscall(sys_setuid);
-cond_syscall(sys_setresuid);
-cond_syscall(sys_getresuid);
-cond_syscall(sys_setresgid);
-cond_syscall(sys_getresgid);
-cond_syscall(sys_setfsuid);
-cond_syscall(sys_setfsgid);
-cond_syscall(sys_setgroups);
-cond_syscall(sys_getgroups);
+COND_SYSCALL(setregid);
+COND_SYSCALL(setgid);
+COND_SYSCALL(setreuid);
+COND_SYSCALL(setuid);
+COND_SYSCALL(setresuid);
+COND_SYSCALL(getresuid);
+COND_SYSCALL(setresgid);
+COND_SYSCALL(getresgid);
+COND_SYSCALL(setfsuid);
+COND_SYSCALL(setfsgid);
+COND_SYSCALL(setgroups);
+COND_SYSCALL(getgroups);
 
 /* kernel/time.c */
 
 /* kernel/timer.c */
 
 /* ipc/mqueue.c */
-cond_syscall(sys_mq_open);
-cond_syscall(compat_sys_mq_open);
-cond_syscall(sys_mq_unlink);
-cond_syscall(sys_mq_timedsend);
-cond_syscall(compat_sys_mq_timedsend);
-cond_syscall(sys_mq_timedreceive);
-cond_syscall(compat_sys_mq_timedreceive);
-cond_syscall(sys_mq_notify);
-cond_syscall(compat_sys_mq_notify);
-cond_syscall(sys_mq_getsetattr);
-cond_syscall(compat_sys_mq_getsetattr);
+COND_SYSCALL(mq_open);
+COND_SYSCALL_COMPAT(mq_open);
+COND_SYSCALL(mq_unlink);
+COND_SYSCALL(mq_timedsend);
+COND_SYSCALL_COMPAT(mq_timedsend);
+COND_SYSCALL(mq_timedreceive);
+COND_SYSCALL_COMPAT(mq_timedreceive);
+COND_SYSCALL(mq_notify);
+COND_SYSCALL_COMPAT(mq_notify);
+COND_SYSCALL(mq_getsetattr);
+COND_SYSCALL_COMPAT(mq_getsetattr);
 
 /* ipc/msg.c */
-cond_syscall(sys_msgget);
-cond_syscall(sys_msgctl);
-cond_syscall(compat_sys_msgctl);
-cond_syscall(sys_msgrcv);
-cond_syscall(compat_sys_msgrcv);
-cond_syscall(sys_msgsnd);
-cond_syscall(compat_sys_msgsnd);
+COND_SYSCALL(msgget);
+COND_SYSCALL(msgctl);
+COND_SYSCALL_COMPAT(msgctl);
+COND_SYSCALL(msgrcv);
+COND_SYSCALL_COMPAT(msgrcv);
+COND_SYSCALL(msgsnd);
+COND_SYSCALL_COMPAT(msgsnd);
 
 /* ipc/sem.c */
-cond_syscall(sys_semget);
-cond_syscall(sys_semctl);
-cond_syscall(compat_sys_semctl);
-cond_syscall(sys_semtimedop);
-cond_syscall(compat_sys_semtimedop);
-cond_syscall(sys_semop);
+COND_SYSCALL(semget);
+COND_SYSCALL(semctl);
+COND_SYSCALL_COMPAT(semctl);
+COND_SYSCALL(semtimedop);
+COND_SYSCALL_COMPAT(semtimedop);
+COND_SYSCALL(semop);
 
 /* ipc/shm.c */
-cond_syscall(sys_shmget);
-cond_syscall(sys_shmctl);
-cond_syscall(compat_sys_shmctl);
-cond_syscall(sys_shmat);
-cond_syscall(compat_sys_shmat);
-cond_syscall(sys_shmdt);
+COND_SYSCALL(shmget);
+COND_SYSCALL(shmctl);
+COND_SYSCALL_COMPAT(shmctl);
+COND_SYSCALL(shmat);
+COND_SYSCALL_COMPAT(shmat);
+COND_SYSCALL(shmdt);
 
 /* net/socket.c */
-cond_syscall(sys_socket);
-cond_syscall(sys_socketpair);
-cond_syscall(sys_bind);
-cond_syscall(sys_listen);
-cond_syscall(sys_accept);
-cond_syscall(sys_connect);
-cond_syscall(sys_getsockname);
-cond_syscall(sys_getpeername);
-cond_syscall(sys_setsockopt);
-cond_syscall(compat_sys_setsockopt);
-cond_syscall(sys_getsockopt);
-cond_syscall(compat_sys_getsockopt);
-cond_syscall(sys_sendto);
-cond_syscall(sys_shutdown);
-cond_syscall(sys_recvfrom);
-cond_syscall(compat_sys_recvfrom);
-cond_syscall(sys_sendmsg);
-cond_syscall(compat_sys_sendmsg);
-cond_syscall(sys_recvmsg);
-cond_syscall(compat_sys_recvmsg);
+COND_SYSCALL(socket);
+COND_SYSCALL(socketpair);
+COND_SYSCALL(bind);
+COND_SYSCALL(listen);
+COND_SYSCALL(accept);
+COND_SYSCALL(connect);
+COND_SYSCALL(getsockname);
+COND_SYSCALL(getpeername);
+COND_SYSCALL(setsockopt);
+COND_SYSCALL_COMPAT(setsockopt);
+COND_SYSCALL(getsockopt);
+COND_SYSCALL_COMPAT(getsockopt);
+COND_SYSCALL(sendto);
+COND_SYSCALL(shutdown);
+COND_SYSCALL(recvfrom);
+COND_SYSCALL_COMPAT(recvfrom);
+COND_SYSCALL(sendmsg);
+COND_SYSCALL_COMPAT(sendmsg);
+COND_SYSCALL(recvmsg);
+COND_SYSCALL_COMPAT(recvmsg);
 
 /* mm/filemap.c */
 
 /* mm/nommu.c, also with MMU */
-cond_syscall(sys_mremap);
+COND_SYSCALL(mremap);
 
 /* security/keys/keyctl.c */
-cond_syscall(sys_add_key);
-cond_syscall(sys_request_key);
-cond_syscall(sys_keyctl);
-cond_syscall(compat_sys_keyctl);
+COND_SYSCALL(add_key);
+COND_SYSCALL(request_key);
+COND_SYSCALL(keyctl);
+COND_SYSCALL_COMPAT(keyctl);
 
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
-cond_syscall(sys_fadvise64_64);
+COND_SYSCALL(fadvise64_64);
 
 /* mm/, CONFIG_MMU only */
-cond_syscall(sys_swapon);
-cond_syscall(sys_swapoff);
-cond_syscall(sys_mprotect);
-cond_syscall(sys_msync);
-cond_syscall(sys_mlock);
-cond_syscall(sys_munlock);
-cond_syscall(sys_mlockall);
-cond_syscall(sys_munlockall);
-cond_syscall(sys_mincore);
-cond_syscall(sys_madvise);
-cond_syscall(sys_remap_file_pages);
-cond_syscall(sys_mbind);
-cond_syscall(compat_sys_mbind);
-cond_syscall(sys_get_mempolicy);
-cond_syscall(compat_sys_get_mempolicy);
-cond_syscall(sys_set_mempolicy);
-cond_syscall(compat_sys_set_mempolicy);
-cond_syscall(sys_migrate_pages);
-cond_syscall(compat_sys_migrate_pages);
-cond_syscall(sys_move_pages);
-cond_syscall(compat_sys_move_pages);
-
-cond_syscall(sys_perf_event_open);
-cond_syscall(sys_accept4);
-cond_syscall(sys_recvmmsg);
-cond_syscall(compat_sys_recvmmsg);
+COND_SYSCALL(swapon);
+COND_SYSCALL(swapoff);
+COND_SYSCALL(mprotect);
+COND_SYSCALL(msync);
+COND_SYSCALL(mlock);
+COND_SYSCALL(munlock);
+COND_SYSCALL(mlockall);
+COND_SYSCALL(munlockall);
+COND_SYSCALL(mincore);
+COND_SYSCALL(madvise);
+COND_SYSCALL(remap_file_pages);
+COND_SYSCALL(mbind);
+COND_SYSCALL_COMPAT(mbind);
+COND_SYSCALL(get_mempolicy);
+COND_SYSCALL_COMPAT(get_mempolicy);
+COND_SYSCALL(set_mempolicy);
+COND_SYSCALL_COMPAT(set_mempolicy);
+COND_SYSCALL(migrate_pages);
+COND_SYSCALL_COMPAT(migrate_pages);
+COND_SYSCALL(move_pages);
+COND_SYSCALL_COMPAT(move_pages);
+
+COND_SYSCALL(perf_event_open);
+COND_SYSCALL(accept4);
+COND_SYSCALL(recvmmsg);
+COND_SYSCALL_COMPAT(recvmmsg);
 
 /*
  * Architecture specific syscalls: see further below
  */
 
 /* fanotify */
-cond_syscall(sys_fanotify_init);
-cond_syscall(sys_fanotify_mark);
+COND_SYSCALL(fanotify_init);
+COND_SYSCALL(fanotify_mark);
 
 /* open by handle */
-cond_syscall(sys_name_to_handle_at);
-cond_syscall(sys_open_by_handle_at);
-cond_syscall(compat_sys_open_by_handle_at);
+COND_SYSCALL(name_to_handle_at);
+COND_SYSCALL(open_by_handle_at);
+COND_SYSCALL_COMPAT(open_by_handle_at);
 
-cond_syscall(sys_sendmmsg);
-cond_syscall(compat_sys_sendmmsg);
-cond_syscall(sys_process_vm_readv);
-cond_syscall(compat_sys_process_vm_readv);
-cond_syscall(sys_process_vm_writev);
-cond_syscall(compat_sys_process_vm_writev);
+COND_SYSCALL(sendmmsg);
+COND_SYSCALL_COMPAT(sendmmsg);
+COND_SYSCALL(process_vm_readv);
+COND_SYSCALL_COMPAT(process_vm_readv);
+COND_SYSCALL(process_vm_writev);
+COND_SYSCALL_COMPAT(process_vm_writev);
 
 /* compare kernel pointers */
-cond_syscall(sys_kcmp);
+COND_SYSCALL(kcmp);
 
-cond_syscall(sys_finit_module);
+COND_SYSCALL(finit_module);
 
 /* operate on Secure Computing state */
-cond_syscall(sys_seccomp);
+COND_SYSCALL(seccomp);
 
-cond_syscall(sys_memfd_create);
+COND_SYSCALL(memfd_create);
 
 /* access BPF programs and maps */
-cond_syscall(sys_bpf);
+COND_SYSCALL(bpf);
 
 /* execveat */
-cond_syscall(sys_execveat);
+COND_SYSCALL(execveat);
 
-cond_syscall(sys_userfaultfd);
+COND_SYSCALL(userfaultfd);
 
 /* membarrier */
-cond_syscall(sys_membarrier);
+COND_SYSCALL(membarrier);
 
-cond_syscall(sys_mlock2);
+COND_SYSCALL(mlock2);
 
-cond_syscall(sys_copy_file_range);
+COND_SYSCALL(copy_file_range);
 
 /* memory protection keys */
-cond_syscall(sys_pkey_mprotect);
-cond_syscall(sys_pkey_alloc);
-cond_syscall(sys_pkey_free);
+COND_SYSCALL(pkey_mprotect);
+COND_SYSCALL(pkey_alloc);
+COND_SYSCALL(pkey_free);
 
 
 /*
@@ -327,35 +330,35 @@ cond_syscall(sys_pkey_free);
  */
 
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
-cond_syscall(sys_pciconfig_read);
-cond_syscall(sys_pciconfig_write);
-cond_syscall(sys_pciconfig_iobase);
+COND_SYSCALL(pciconfig_read);
+COND_SYSCALL(pciconfig_write);
+COND_SYSCALL(pciconfig_iobase);
 
 /* sys_socketcall: arm, mips, x86, ... */
-cond_syscall(sys_socketcall);
-cond_syscall(compat_sys_socketcall);
+COND_SYSCALL(socketcall);
+COND_SYSCALL_COMPAT(socketcall);
 
 /* compat syscalls for arm64, x86, ... */
-cond_syscall(compat_sys_sysctl);
-cond_syscall(compat_sys_fanotify_mark);
+COND_SYSCALL_COMPAT(sysctl);
+COND_SYSCALL_COMPAT(fanotify_mark);
 
 /* x86 */
-cond_syscall(sys_vm86old);
-cond_syscall(sys_modify_ldt);
-cond_syscall(compat_sys_quotactl32);
-cond_syscall(sys_vm86);
-cond_syscall(sys_kexec_file_load);
+COND_SYSCALL(vm86old);
+COND_SYSCALL(modify_ldt);
+COND_SYSCALL_COMPAT(quotactl32);
+COND_SYSCALL(vm86);
+COND_SYSCALL(kexec_file_load);
 
 /* s390 */
-cond_syscall(sys_s390_pci_mmio_read);
-cond_syscall(sys_s390_pci_mmio_write);
-cond_syscall(compat_sys_s390_ipc);
+COND_SYSCALL(s390_pci_mmio_read);
+COND_SYSCALL(s390_pci_mmio_write);
+COND_SYSCALL_COMPAT(s390_ipc);
 
 /* powerpc */
 cond_syscall(ppc_rtas);
-cond_syscall(sys_spu_run);
-cond_syscall(sys_spu_create);
-cond_syscall(sys_subpage_prot);
+COND_SYSCALL(spu_run);
+COND_SYSCALL(spu_create);
+COND_SYSCALL(subpage_prot);
 
 
 /*
@@ -364,22 +367,22 @@ cond_syscall(sys_subpage_prot);
  */
 
 /* __ARCH_WANT_SYSCALL_NO_FLAGS */
-cond_syscall(sys_epoll_create);
-cond_syscall(sys_inotify_init);
-cond_syscall(sys_eventfd);
-cond_syscall(sys_signalfd);
-cond_syscall(compat_sys_signalfd);
+COND_SYSCALL(epoll_create);
+COND_SYSCALL(inotify_init);
+COND_SYSCALL(eventfd);
+COND_SYSCALL(signalfd);
+COND_SYSCALL_COMPAT(signalfd);
 
 /* __ARCH_WANT_SYSCALL_OFF_T */
-cond_syscall(sys_fadvise64);
+COND_SYSCALL(fadvise64);
 
 /* __ARCH_WANT_SYSCALL_DEPRECATED */
-cond_syscall(sys_epoll_wait);
-cond_syscall(sys_recv);
-cond_syscall(compat_sys_recv);
-cond_syscall(sys_send);
-cond_syscall(sys_bdflush);
-cond_syscall(sys_uselib);
+COND_SYSCALL(epoll_wait);
+COND_SYSCALL(recv);
+COND_SYSCALL_COMPAT(recv);
+COND_SYSCALL(send);
+COND_SYSCALL(bdflush);
+COND_SYSCALL(uselib);
 
 
 /*
@@ -387,33 +390,33 @@ cond_syscall(sys_uselib);
  */
 
 /* obsolete: SGETMASK_SYSCALL */
-cond_syscall(sys_sgetmask);
-cond_syscall(sys_ssetmask);
+COND_SYSCALL(sgetmask);
+COND_SYSCALL(ssetmask);
 
 /* obsolete: SYSFS_SYSCALL */
-cond_syscall(sys_sysfs);
+COND_SYSCALL(sysfs);
 
 /* obsolete: __ARCH_WANT_SYS_IPC */
-cond_syscall(sys_ipc);
-cond_syscall(compat_sys_ipc);
+COND_SYSCALL(ipc);
+COND_SYSCALL_COMPAT(ipc);
 
 /* obsolete: UID16 */
-cond_syscall(sys_chown16);
-cond_syscall(sys_fchown16);
-cond_syscall(sys_getegid16);
-cond_syscall(sys_geteuid16);
-cond_syscall(sys_getgid16);
-cond_syscall(sys_getgroups16);
-cond_syscall(sys_getresgid16);
-cond_syscall(sys_getresuid16);
-cond_syscall(sys_getuid16);
-cond_syscall(sys_lchown16);
-cond_syscall(sys_setfsgid16);
-cond_syscall(sys_setfsuid16);
-cond_syscall(sys_setgid16);
-cond_syscall(sys_setgroups16);
-cond_syscall(sys_setregid16);
-cond_syscall(sys_setresgid16);
-cond_syscall(sys_setresuid16);
-cond_syscall(sys_setreuid16);
-cond_syscall(sys_setuid16);
+COND_SYSCALL(chown16);
+COND_SYSCALL(fchown16);
+COND_SYSCALL(getegid16);
+COND_SYSCALL(geteuid16);
+COND_SYSCALL(getgid16);
+COND_SYSCALL(getgroups16);
+COND_SYSCALL(getresgid16);
+COND_SYSCALL(getresuid16);
+COND_SYSCALL(getuid16);
+COND_SYSCALL(lchown16);
+COND_SYSCALL(setfsgid16);
+COND_SYSCALL(setfsuid16);
+COND_SYSCALL(setgid16);
+COND_SYSCALL(setgroups16);
+COND_SYSCALL(setregid16);
+COND_SYSCALL(setresgid16);
+COND_SYSCALL(setresuid16);
+COND_SYSCALL(setreuid16);
+COND_SYSCALL(setuid16);
-- 
2.16.3
