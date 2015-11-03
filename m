From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 08/28] lkl: system call interface and application API
Date: Tue,  3 Nov 2015 22:20:39 +0200
Message-ID: <1446582059-17355-9-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

The LKL application API is based on the kernel system call interface
in order to offer a stable API to applications. Note that we can't
offer the full Linux system call interface due to LKL limitations such
as lack of virtual memory, signal, user processes, etc.

The host is using the LKL interrupt mechanism (lkl_trigger_irq) to
initiate a system call. The system call is executed in the context of
the init process.

To avoid collisions between the Linux API and the LKL API (e.g. struct
stat, MKNOD, etc.) we use a python script to modify the user headers
and to prefix all of the global symbols (structures, typedefs,
defines) with LKL, lkl, _LKL, _lkl, __LKL or __lkl.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/unistd.h       |  93 +++++++++++++
 arch/lkl/include/uapi/asm/unistd.h  | 256 ++++++++++++++++++++++++++++++++++++
 arch/lkl/kernel/syscalls.c          | 213 ++++++++++++++++++++++++++++++
 arch/lkl/scripts/headers_install.py | 117 ++++++++++++++++
 4 files changed, 679 insertions(+)
 create mode 100644 arch/lkl/include/asm/unistd.h
 create mode 100644 arch/lkl/include/uapi/asm/unistd.h
 create mode 100644 arch/lkl/kernel/syscalls.c
 create mode 100755 arch/lkl/scripts/headers_install.py

diff --git a/arch/lkl/include/asm/unistd.h b/arch/lkl/include/asm/unistd.h
new file mode 100644
index 0000000..73c1e70
--- /dev/null
+++ b/arch/lkl/include/asm/unistd.h
@@ -0,0 +1,93 @@
+#ifndef _ASM_LKL_UNISTD_H
+#define _ASM_LKL_UNISTD_H
+
+#include <uapi/asm/unistd.h>
+
+/*
+ * Unsupported system calls due to lack of support in LKL (e.g. related to
+ * virtual memory, signal, user processes). We also only support 64bit version
+ * of system calls where we have two version to keep the same APi across 32 and
+ * 64 bit hosts.
+ */
+#define __NR_restart_syscall 0
+#define __NR_exit 0
+#define __NR_fork 0
+#define __NR_execve 0
+#define __NR_ptrace 0
+#define __NR_alarm 0
+#define __NR_pause 0
+#define __NR_kill 0
+#define __NR_brk 0
+#define __NR_uselib 0
+#define __NR_swapon 0
+#define __NR_mmap 0
+#define __NR_munmap 0
+#define __NR_swapoff 0
+#define __NR_clone 0
+#define __NR_mprotect 0
+#define __NR_init_module 0
+#define __NR_quotactl 0
+#define __NR_msync 0
+#define __NR_mlock 0
+#define __NR_munlock 0
+#define __NR_mlockall 0
+#define __NR_munlockall 0
+#define __NR_mremap 0
+#define __NR_rt_sigreturn 0
+#define __NR_rt_sigaction 0
+#define __NR_rt_sigprocmask 0
+#define __NR_rt_sigpending 0
+#define __NR_rt_sigtimedwait 0
+#define __NR_rt_sigqueueinfo 0
+#define __NR_rt_sigsuspend 0
+#define __NR_sigaltstack 0
+#define __NR_vfork 0
+#define __NR_mincore 0
+#define __NR_madvise 0
+#define __NR_getdents 0 /* we use the 64 bit counter part instead */
+#define __NR_tkill 0
+#define __NR_exit_group 0
+#define __NR_remap_file_pages 0
+#define __NR_statfs 0 /* we use the 64 bit counter part instead */
+#define __NR_fstatfs 0 /* we use the 64 bit counter part instead */
+#define __NR_fstat 0 /* we use the 64 bit counter part instead */
+#define __NR_fadvise64_64 0
+#define __NR_mbind 0
+#define __NR_get_mempolicy 0
+#define __NR_set_mempolicy 0
+#define __NR_mq_open 0
+#define __NR_mq_unlink 0
+#define __NR_mq_timedsend 0
+#define __NR_mq_timedreceive 0
+#define __NR_mq_0
+#define __NR_mq_getsetattr 0
+#define __NR_kexec_load 0
+#define __NR_migrate_pages 0
+#define __NR_unshare 0
+#define __NR_set_robust_list 0
+#define __NR_get_robust_list 0
+#define __NR_sync_file_range 0
+#define __NR_vmsplice 0
+#define __NR_move_pages 0
+#define __NR_mq_notify 0
+#define __NR_umount2 0
+#define __NR_delete_module 0
+#define __NR_signalfd4 0
+#define __NR_preadv 0 /* we use the 64 bit counter part instead */
+#define __NR_pwritev 0 /* we use the 64 bit counter part instead */
+#define __NR_rt_tgsigqueueinfo 0
+#define __NR_perf_event_open 0
+#define __NR_setns 0
+#define __NR_process_vm_readv 0
+#define __NR_process_vm_writev 0
+#define __NR_kcmp 0
+#define __NR_finit_module 0
+#define __NR_seccomp 0
+#define __NR_memfd_create 0
+#define __NR_bpf 0
+#define __NR_execveat 0
+#define __NR_lseek 0 /* we use the 64 bit counter part instead */
+
+int run_syscalls(void);
+
+#endif
diff --git a/arch/lkl/include/uapi/asm/unistd.h b/arch/lkl/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..68b5423
--- /dev/null
+++ b/arch/lkl/include/uapi/asm/unistd.h
@@ -0,0 +1,256 @@
+#ifndef _ASM_UAPI_LKL_UNISTD_H
+#define _ASM_UAPI_LKL_UNISTD_H
+
+#ifdef __KERNEL__
+#define __NR_ni_syscall		0
+#define __NR_reboot		1
+#endif
+#define __NR_getpid		2
+#define __NR_write		3
+#define __NR_close		4
+#define __NR_unlink		5
+#define __NR_open		6
+#define __NR_poll		7
+#define __NR_read		8
+#define __NR_rename		10
+#define __NR_flock		11
+#define __NR_newfstat		12
+#define __NR_chmod		13
+#define __NR_newlstat		14
+#define __NR_mkdir		15
+#define __NR_rmdir		16
+#define __NR_getdents64		17
+#define __NR_newstat		18
+#define __NR_utimes		19
+#define __NR_utime		20
+#define __NR_nanosleep		21
+#define __NR_mknod		22
+#define __NR_mount		23
+#define __NR_umount		24
+#define __NR_chdir		25
+#define __NR_chroot		26
+#define __NR_getcwd		27
+#define __NR_chown		28
+#define __NR_umask		29
+#define __NR_getuid		30
+#define __NR_getgid		31
+#define __NR_socketcall		32
+#define __NR_ioctl		33
+#define __NR_readlink		34
+#define __NR_access		35
+#define __NR_truncate		36
+#define __NR_sync		37
+#define __NR_creat		38
+#define __NR_llseek		39
+#define __NR_stat64		40
+#define __NR_lstat64		41
+#define __NR_fstat64		42
+#define __NR_fstatat64		43
+#define __NR_statfs64		44
+#define __NR_fstatfs64		45
+#define __NR_listxattr		46
+#define __NR_llistxattr		47
+#define __NR_flistxattr		48
+#define __NR_getxattr		49
+#define __NR_lgetxattr		50
+#define __NR_fgetxattr		51
+#define __NR_setxattr		52
+#define __NR_lsetxattr		53
+#define __NR_fsetxattr		54
+#ifdef __KERNEL__
+#define NR_syscalls		55
+#endif
+
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_LLSEEK
+
+long lkl_syscall(long no, long *params);
+
+#ifndef __KERNEL__
+
+#define LKL_SYSCALL0(_syscall)						\
+	static inline							\
+	long lkl_sys_##_syscall(void)					\
+	{								\
+		long params[6];						\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL1(_syscall, arg1_t, arg1)				\
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1)				\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL2(_syscall, arg1_t, arg1, arg2_t, arg2)		\
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1, arg2_t arg2)		\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		params[1] = (long)arg2;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL3(_syscall, arg1_t, arg1, arg2_t, arg2, arg3_t, arg3) \
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1, arg2_t arg2, arg3_t arg3)	\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		params[1] = (long)arg2;					\
+		params[2] = (long)arg3;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL4(_syscall, arg1_t, arg1, arg2_t, arg2, arg3_t, arg3, \
+		      arg4_t, arg4)					\
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1, arg2_t arg2, arg3_t arg3,	\
+				arg4_t arg4)				\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		params[1] = (long)arg2;					\
+		params[2] = (long)arg3;					\
+		params[3] = (long)arg4;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL5(_syscall, arg1_t, arg1, arg2_t, arg2, arg3_t, arg3, \
+		     arg4_t, arg4, arg5_t, arg5)			\
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1, arg2_t arg2, arg3_t arg3,	\
+				arg4_t arg4, arg5_t arg5)		\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		params[1] = (long)arg2;					\
+		params[2] = (long)arg3;					\
+		params[3] = (long)arg4;					\
+		params[4] = (long)arg5;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#define LKL_SYSCALL6(_syscall, arg1_t, arg1, arg2_t, arg2, arg3_t, arg3, \
+		     arg4_t, arg4, arg5_t, arg5, arg6_t, arg6)		\
+	static inline							\
+	long lkl_sys_##_syscall(arg1_t arg1, arg2_t arg2, arg3_t arg3,	\
+				arg4_t arg4, arg5_t arg5, arg6_t arg6)	\
+	{								\
+		long params[6];						\
+		params[0] = (long)arg1;					\
+		params[1] = (long)arg2;					\
+		params[2] = (long)arg3;					\
+		params[3] = (long)arg4;					\
+		params[4] = (long)arg5;					\
+		params[5] = (long)arg6;					\
+		return lkl_syscall(__lkl__NR_##_syscall, params);	\
+	}
+
+#include <autoconf.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/time.h>
+#include <linux/utime.h>
+#include <asm/stat.h>
+#include <asm/statfs.h>
+#define __KERNEL__ /* to pull in S_ definitions */
+#include <linux/stat.h>
+#undef __KERNEL__
+#include <linux/errno.h>
+#include <linux/fcntl.h>
+#include <asm/irq.h>
+#include <linux/kdev_t.h>
+
+/* these types are not exported to userspace so we have to do it here */
+typedef unsigned short lkl_umode_t;
+
+struct lkl_dirent64 {
+	unsigned long long	d_ino;
+	long long		d_off;
+	unsigned short		d_reclen;
+	unsigned char		d_type;
+	char			d_name[0];
+};
+
+#define LKL_DT_UNKNOWN		0
+#define LKL_DT_FIFO		1
+#define LKL_DT_CHR		2
+#define LKL_DT_DIR		4
+#define LKL_DT_BLK		6
+#define LKL_DT_REG		8
+#define LKL_DT_LNK		10
+#define LKL_DT_SOCK		12
+#define LKL_DT_WHT		14
+
+LKL_SYSCALL0(getpid);
+LKL_SYSCALL3(write, unsigned int, fd, const char *, buf,
+	     __lkl__kernel_size_t, count);
+LKL_SYSCALL1(close, unsigned int, fd);
+LKL_SYSCALL1(unlink, const char *, pathname);
+LKL_SYSCALL3(open, const char *, filename, int, flags, lkl_umode_t, mode);
+LKL_SYSCALL2(creat, const char *, filename, lkl_umode_t, mode);
+LKL_SYSCALL3(poll, struct lkl_pollfd *, ufds, unsigned int, nfds, int, timeout);
+LKL_SYSCALL3(read, unsigned int, fd, char *, buf, __lkl__kernel_size_t, count);
+LKL_SYSCALL2(rename, const char *, oldname, const char *, newname);
+LKL_SYSCALL2(flock, unsigned int, fd, unsigned int, cmd);
+LKL_SYSCALL2(chmod, const char *, filename, lkl_umode_t, mode);
+
+LKL_SYSCALL2(mkdir, const char *, pathname, lkl_umode_t, mode);
+LKL_SYSCALL1(rmdir, const char *, pathname);
+LKL_SYSCALL3(getdents64, unsigned int, fd, void *, dirent, unsigned int, size);
+LKL_SYSCALL2(utimes, const char *, filename, struct lkl_timeval *, utimes);
+LKL_SYSCALL2(nanosleep, struct lkl_timespec *, rqtp,
+	     struct lkl_timespec *, rmtp);
+LKL_SYSCALL3(mknod, const char *, filename, lkl_umode_t, mode,
+	     unsigned int, dev);
+LKL_SYSCALL5(mount, const char *, dev_name, const char *, dir_name,
+	     const char *, type, unsigned long,	 flags, void *, data);
+LKL_SYSCALL2(umount, const char *, name, int, flags);
+LKL_SYSCALL1(chdir, const char *, filename);
+LKL_SYSCALL1(chroot, const char *, filename);
+LKL_SYSCALL2(getcwd, char *, buf, unsigned long, size);
+LKL_SYSCALL2(utime, const char *, filename, const struct lkl_utimbuf *, buf);
+LKL_SYSCALL3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg);
+LKL_SYSCALL1(umask, int, mask);
+LKL_SYSCALL0(getuid);
+LKL_SYSCALL0(getgid);
+LKL_SYSCALL2(access, const char *, filename, int, mode);
+LKL_SYSCALL2(truncate, const char *, path, long, length);
+LKL_SYSCALL0(sync);
+LKL_SYSCALL5(llseek, unsigned int, fd, unsigned long, offset_high,
+	     unsigned long, offset_low, __lkl__kernel_loff_t *, result,
+	     unsigned int, whence);
+LKL_SYSCALL2(fstat64, unsigned int, fd, struct lkl_stat64 *, statbuf);
+LKL_SYSCALL4(fstatat64, unsigned int, dfd, const char *, filname,
+	     struct lkl_stat64 *, statbuf, int, flag);
+LKL_SYSCALL2(stat64, const char *, filename, struct lkl_stat64 *, statbuf);
+LKL_SYSCALL2(lstat64, const char *, filename, struct lkl_stat64 *, statbuf);
+LKL_SYSCALL2(statfs64, const char *, path, struct lkl_statfs64 *, buf);
+LKL_SYSCALL3(readlink, const char *, path, char *, buf, int, bufsiz);
+LKL_SYSCALL3(listxattr, const char *, path, char *, list, int, bufsiz);
+LKL_SYSCALL3(llistxattr, const char *, path, char *, list, int, bufsiz);
+LKL_SYSCALL3(flistxattr, int, fd, char *, list, int, bufsiz);
+LKL_SYSCALL4(getxattr, const char *, path, const char *, name, void *, value,
+	     __lkl__kernel_size_t, size);
+LKL_SYSCALL4(lgetxattr, const char *, path, const char *, name, void *, value,
+	     __lkl__kernel_size_t, size);
+LKL_SYSCALL4(fgetxattr, int, fd, const char *, name, void *, value,
+	     __lkl__kernel_size_t, size);
+LKL_SYSCALL5(setxattr, const char *, path, const char *, name,
+	     const void *, value, __lkl__kernel_size_t, size, int, flags);
+LKL_SYSCALL5(lsetxattr, const char *, path, const char *, name,
+	     const void *, value, __lkl__kernel_size_t, size, int, flags);
+LKL_SYSCALL5(fsetxattr, int, fd, const char *, name, const void *, value,
+	     __lkl__kernel_size_t, size, int, flags);
+
+long lkl_sys_halt(void);
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_UAPI_LKL_UNISTD_H */
diff --git a/arch/lkl/kernel/syscalls.c b/arch/lkl/kernel/syscalls.c
new file mode 100644
index 0000000..48b1296
--- /dev/null
+++ b/arch/lkl/kernel/syscalls.c
@@ -0,0 +1,213 @@
+#include <linux/syscalls.h>
+#include <linux/stat.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/syscalls.h>
+#include <linux/net.h>
+#include <linux/task_work.h>
+#include <asm/unistd.h>
+#include <asm/host_ops.h>
+
+typedef long (*syscall_handler_t)(long arg1, ...);
+
+syscall_handler_t syscall_table[NR_syscalls];
+
+static struct syscall_queue {
+	struct list_head list;
+	wait_queue_head_t wqh;
+} syscall_queue;
+
+struct syscall {
+	long no, *params, ret;
+	void *sem;
+	struct list_head lh;
+};
+
+static struct syscall *dequeue_syscall(struct syscall_queue *sq)
+{
+	struct syscall *s = NULL;
+
+	if (!list_empty(&sq->list)) {
+		s = list_first_entry(&sq->list, typeof(*s), lh);
+		list_del(&s->lh);
+	}
+
+	return s;
+}
+
+static long run_syscall(struct syscall *s)
+{
+	int ret;
+
+	if (s->no < 0 || s->no >= NR_syscalls || !syscall_table[s->no])
+		ret = -ENOSYS;
+	else
+		ret = syscall_table[s->no](s->params[0], s->params[1],
+					   s->params[2], s->params[3],
+					   s->params[4], s->params[5]);
+	s->ret = ret;
+
+	task_work_run();
+
+	if (s->sem)
+		lkl_ops->sem_up(s->sem);
+	return ret;
+}
+
+int run_syscalls(void)
+{
+	struct syscall_queue *sq = &syscall_queue;
+	struct syscall *s;
+
+	current->flags &= ~PF_KTHREAD;
+
+	snprintf(current->comm, sizeof(current->comm), "init");
+
+	while (1) {
+		wait_event(sq->wqh, (s = dequeue_syscall(sq)) != NULL);
+
+		if (s->no == __NR_reboot)
+			break;
+
+		run_syscall(s);
+	}
+
+	s->ret = 0;
+	lkl_ops->sem_up(s->sem);
+
+	return 0;
+}
+
+static irqreturn_t syscall_irq_handler(int irq, void *dev_id)
+{
+	struct pt_regs *regs = get_irq_regs();
+	struct syscall *s = regs->irq_data;
+
+	list_add_tail(&s->lh, &syscall_queue.list);
+	wake_up(&syscall_queue.wqh);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction syscall_irqaction  = {
+	.handler = syscall_irq_handler,
+	.flags = IRQF_NOBALANCING,
+	.dev_id = &syscall_irqaction,
+	.name = "syscall"
+};
+
+static int syscall_irq;
+
+long lkl_syscall(long no, long *params)
+{
+	struct syscall s;
+
+	s.no = no;
+	s.params = params;
+
+	s.sem = lkl_ops->sem_alloc(0);
+	if (!s.sem)
+		return -ENOMEM;
+
+	lkl_trigger_irq(syscall_irq, &s);
+
+	lkl_ops->sem_down(s.sem);
+	lkl_ops->sem_free(s.sem);
+
+	return s.ret;
+}
+
+asmlinkage
+ssize_t sys_lkl_pwrite64(unsigned int fd, const char *buf, size_t count,
+			 off_t pos_hi, off_t pos_lo)
+{
+	return sys_pwrite64(fd, buf, count, ((loff_t)pos_hi << 32) + pos_lo);
+}
+
+asmlinkage
+ssize_t sys_lkl_pread64(unsigned int fd, char *buf, size_t count,
+			off_t pos_hi, off_t pos_lo)
+{
+	return sys_pread64(fd, buf, count, ((loff_t)pos_hi << 32) + pos_lo);
+}
+
+#define INIT_STE(x) syscall_table[__NR_##x] = (syscall_handler_t)sys_##x
+
+void init_syscall_table(void)
+{
+	int i;
+
+	for (i = 0; i < NR_syscalls; i++)
+		syscall_table[i] = (syscall_handler_t)sys_ni_syscall;
+
+	INIT_STE(sync);
+	INIT_STE(reboot);
+	INIT_STE(write);
+	INIT_STE(close);
+	INIT_STE(unlink);
+	INIT_STE(open);
+	INIT_STE(poll);
+	INIT_STE(read);
+	INIT_STE(rename);
+	INIT_STE(chmod);
+	INIT_STE(llseek);
+	INIT_STE(lstat64);
+	INIT_STE(fstat64);
+	INIT_STE(fstatat64);
+	INIT_STE(stat64);
+	INIT_STE(mkdir);
+	INIT_STE(rmdir);
+	INIT_STE(getdents64);
+	INIT_STE(utimes);
+	INIT_STE(utime);
+	INIT_STE(nanosleep);
+	INIT_STE(mknod);
+	INIT_STE(mount);
+	INIT_STE(umount);
+	INIT_STE(chdir);
+	INIT_STE(statfs64);
+	INIT_STE(chroot);
+	INIT_STE(getcwd);
+	INIT_STE(chown);
+	INIT_STE(umask);
+	INIT_STE(getuid);
+	INIT_STE(getgid);
+#ifdef CONFIG_NET
+	INIT_STE(socketcall);
+#endif
+	INIT_STE(ioctl);
+	INIT_STE(access);
+	INIT_STE(truncate);
+	INIT_STE(getpid);
+	INIT_STE(creat);
+	INIT_STE(llseek);
+	INIT_STE(readlink);
+	INIT_STE(listxattr);
+	INIT_STE(llistxattr);
+	INIT_STE(flistxattr);
+	INIT_STE(getxattr);
+	INIT_STE(lgetxattr);
+	INIT_STE(fgetxattr);
+	INIT_STE(setxattr);
+	INIT_STE(lsetxattr);
+	INIT_STE(fsetxattr);
+}
+
+int __init syscall_init(void)
+{
+	init_syscall_table();
+
+	INIT_LIST_HEAD(&syscall_queue.list);
+	init_waitqueue_head(&syscall_queue.wqh);
+
+	syscall_irq = lkl_get_free_irq("syscall");
+	setup_irq(syscall_irq, &syscall_irqaction);
+
+	pr_info("lkl: syscall interface initialized\n");
+	return 0;
+}
+late_initcall(syscall_init);
diff --git a/arch/lkl/scripts/headers_install.py b/arch/lkl/scripts/headers_install.py
new file mode 100755
index 0000000..eb69a5e
--- /dev/null
+++ b/arch/lkl/scripts/headers_install.py
@@ -0,0 +1,117 @@
+#!/usr/bin/python
+import re, os, sys, argparse, multiprocessing
+
+header_paths = [ "include/uapi/", "arch/lkl/include/uapi/",
+                 "arch/lkl/include/generated/uapi/", "include/generated/" ]
+
+headers = set()
+
+def find_headers(path):
+    headers.add(path)
+    f = open(path)
+    for l in f.readlines():
+        m = re.search("#include <(.*)>", l)
+        try:
+            i = m.group(1)
+            for p in header_paths:
+                if os.access(p + i, os.R_OK):
+                    if p + i not in headers:
+                        headers.add(p + i)
+                        find_headers(p + i)
+        except:
+            pass
+    f.close()
+
+def has_lkl_prefix(w):
+    return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("LKL") or \
+        w.startswith("_LKL")
+
+def find_symbols(regexp, store):
+    for h in headers:
+        f = open(h)
+        for l in f.readlines():
+            m = re.search(regexp, l)
+            try:
+                e = m.group(1)
+                if not has_lkl_prefix(e):
+                    store.add(e)
+            except:
+                pass
+        f.close()
+
+def find_ml_symbols(regexp, store):
+    for h in headers:
+        for i in re.finditer(regexp, open(h).read(), re.MULTILINE|re.DOTALL):
+            for j in i.groups():
+                store.add(j)
+
+def lkl_prefix(w):
+    r = ""
+
+    if w.startswith("__"):
+        r = "__"
+    elif w.startswith("_"):
+        r = "_"
+
+    if w.isupper():
+        r += "LKL"
+    else:
+        r += "lkl"
+
+    if not w.startswith("_"):
+        r += "_"
+
+    r += w
+
+    return r
+
+def replace(h):
+    content = open(h).read()
+    content = re.sub("(#[ \t]*include[ \t]<)(.*>)", "\\1lkl/\\2", content,
+                     flags = re.MULTILINE)
+    for d in defines:
+        search_str = "([^_a-zA-Z0-9]+)" + d + "([^_a-zA-Z0-9]+)"
+        replace_str = "\\1" + lkl_prefix(d) + "\\2"
+        content = re.sub(search_str, replace_str, content, flags = re.MULTILINE)
+    for s in structs:
+        search_str = "([^_a-zA-Z0-9]*struct\s+)" + s + "([^_a-zA-Z0-9]+)"
+        replace_str = "\\1" + lkl_prefix(s) + "\\2"
+        content = re.sub(search_str, replace_str, content, flags = re.MULTILINE)
+    open(h, 'w').write(content)
+
+parser = argparse.ArgumentParser(description='install lkl headers')
+parser.add_argument('path', help='path to install to', )
+parser.add_argument('-j', '--jobs', help='number of parallel jobs', default=1, type=int)
+args = parser.parse_args()
+
+find_headers("arch/lkl/include/uapi/asm/unistd.h")
+headers.add("arch/lkl/include/uapi/asm/host_ops.h")
+
+defines = set()
+structs = set()
+
+find_symbols("#[ \t]*define[ \t]*([_a-zA-Z]+[_a-zA-Z0-9]*)[^_a-zA-Z0-9]", defines)
+find_symbols("typedef.*\s+([_a-zA-Z]+[_a-zA-Z0-9]*)\s*;", defines)
+find_ml_symbols("typedef\s+struct\s*\{.*\}\s*([_a-zA-Z]+[_a-zA-Z0-9]*)\s*;", defines)
+find_symbols("struct\s+([_a-zA-Z]+[_a-zA-Z0-9]*)\s*\{", structs)
+
+def process_header(h):
+    dir = os.path.dirname(h)
+    out_dir = args.path + "/" + re.sub("(arch/lkl/include/uapi/|arch/lkl/include/generated/uapi/|include/uapi/|include/generated/uapi/|include/generated)(.*)", "lkl/\\2", dir)
+    try:
+        os.makedirs(out_dir)
+    except:
+        pass
+    print "  INSTALL\t%s" % (out_dir + "/" + os.path.basename(h))
+    os.system("scripts/headers_install.sh %s %s %s" % (out_dir, dir,
+                                                       os.path.basename(h)))
+    replace(out_dir + "/" + os.path.basename(h))
+
+p = multiprocessing.Pool(args.jobs)
+try:
+    p.map_async(process_header, headers).wait(999999)
+    p.close()
+except:
+    p.terminate()
+finally:
+    p.join()
-- 
2.1.0
