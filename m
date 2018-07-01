From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 05/19] csky: System Call
Date: Mon,  2 Jul 2018 01:30:08 +0800
Message-ID: <1005fef6031efbee4b5041ee286c053dd97670e6.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/syscall.h     | 69 +++++++++++++++++++++++++++++++++++++
 arch/csky/include/asm/syscalls.h    | 14 ++++++++
 arch/csky/include/uapi/asm/unistd.h | 63 +++++++++++++++++++++++++++++++++
 arch/csky/kernel/syscall.c          | 63 +++++++++++++++++++++++++++++++++
 arch/csky/kernel/syscall_table.c    | 12 +++++++
 5 files changed, 221 insertions(+)
 create mode 100644 arch/csky/include/asm/syscall.h
 create mode 100644 arch/csky/include/asm/syscalls.h
 create mode 100644 arch/csky/include/uapi/asm/unistd.h
 create mode 100644 arch/csky/kernel/syscall.c
 create mode 100644 arch/csky/kernel/syscall_table.c

diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
new file mode 100644
index 0000000..8966739
--- /dev/null
+++ b/arch/csky/include/asm/syscall.h
@@ -0,0 +1,69 @@
+#ifndef __ASM_SYSCALL_H
+#define __ASM_SYSCALL_H
+
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <abi/regdef.h>
+
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs_syscallid(regs);
+}
+
+static inline void
+syscall_rollback(struct task_struct *task, struct pt_regs *regs)
+{
+	regs->a0 = regs->orig_a0;
+}
+
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	unsigned long error = regs->a0;
+
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
+static inline void
+syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			 int error, long val)
+{
+	regs->a0 = (long) error ?: val;
+}
+
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	if (i == 0) {
+		args[0] = regs->orig_a0;
+		args++;
+		i++;
+		n--;
+	}
+	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+}
+
+static inline void
+syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, const unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+        if (i == 0) {
+		regs->orig_a0 = args[0];
+		args++;
+		i++;
+		n--;
+        }
+	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+}
+
+#endif	/* __ASM_SYSCALL_H */
diff --git a/arch/csky/include/asm/syscalls.h b/arch/csky/include/asm/syscalls.h
new file mode 100644
index 0000000..c478830
--- /dev/null
+++ b/arch/csky/include/asm/syscalls.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_SYSCALLS_H
+#define __ASM_CSKY_SYSCALLS_H
+
+#include <asm-generic/syscalls.h>
+
+long sys_cacheflush(void __user *, unsigned long, int);
+
+long sys_set_thread_area(unsigned long addr);
+
+long sys_csky_fadvise64_64(int fd, int advice, loff_t offset, loff_t len);
+
+#endif /* __ASM_CSKY_SYSCALLS_H */
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..0ea9b5a
--- /dev/null
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#define __ARCH_WANT_OLD_READDIR
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_IPC
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLDUMOUNT
+#define __ARCH_WANT_SYS_PAUSE
+#define __ARCH_WANT_SYS_SIGNAL
+#define __ARCH_WANT_SYS_SIGPENDING
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_WAITPID
+
+#include <asm-generic/unistd.h>
+
+/*
+ * other define
+ */
+#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
+__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
+#define __NR_ipc		(__NR_arch_specific_syscall + 1)
+__SYSCALL(__NR_ipc, sys_ipc)
+#define __NR_socketcall		(__NR_arch_specific_syscall + 2)
+__SYSCALL(__NR_socketcall, sys_socketcall)
+#define __NR_ugetrlimit		(__NR_arch_specific_syscall + 3)
+__SYSCALL(__NR_ugetrlimit, sys_getrlimit)
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 4)
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
+#define __NR_sysfs		(__NR_arch_specific_syscall + 5)
+__SYSCALL(__NR_sysfs, sys_sysfs)
+
+__SYSCALL(__NR_fadvise64_64, sys_csky_fadvise64_64)
+
+#define __NR_setgroups32	__NR_setgroups
+#define __NR_getgid32		__NR_getgid
+#define __NR_getgroups32	__NR_getgroups
+#define __NR_setuid32		__NR_setuid
+#define __NR_setgid32		__NR_setgid
+#define __NR_getresgid32	__NR_getresgid
+#define __NR_setfsuid32		__NR_setfsuid
+#define __NR_setfsgid32		__NR_setfsgid
+#define __NR_fchown32		__NR_fchown
+#define __NR_geteuid32		__NR_geteuid
+#define __NR_getegid32		__NR_getegid
+#define __NR_getresuid32	__NR_getresuid
+#define __NR_setresuid32	__NR_setresuid
+#define __NR_setresgid32	__NR_setresgid
+#define __NR_setreuid32		__NR_setreuid
+#define __NR_setregid32		__NR_setregid
+#define __NR__llseek		__NR_llseek
+
diff --git a/arch/csky/kernel/syscall.c b/arch/csky/kernel/syscall.c
new file mode 100644
index 0000000..f0a1294
--- /dev/null
+++ b/arch/csky/kernel/syscall.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/syscalls.h>
+
+SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
+{
+	struct thread_info *ti = task_thread_info(current);
+	struct pt_regs *reg = current_pt_regs();
+
+	reg->tls = addr;
+	ti->tp_value = addr;
+
+	return 0;
+}
+
+SYSCALL_DEFINE6(mmap2,
+	unsigned long, addr,
+	unsigned long, len,
+	unsigned long, prot,
+	unsigned long, flags,
+	unsigned long, fd,
+	off_t, offset)
+{
+	if (unlikely(offset & (~PAGE_MASK >> 12)))
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+		offset >> (PAGE_SHIFT - 12));
+}
+
+struct mmap_arg_struct {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+SYSCALL_DEFINE1(mmap,
+	struct mmap_arg_struct *, arg)
+{
+	struct mmap_arg_struct a;
+
+	if (copy_from_user(&a, arg, sizeof(a)))
+		return -EINVAL;
+
+	if (unlikely(a.offset & ~PAGE_MASK))
+		return -EINVAL;
+
+	return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+}
+
+/*
+ * for abiv1 the 64bits args should be even th, So we need mov the advice forward.
+ */
+SYSCALL_DEFINE4(csky_fadvise64_64,
+	int, fd,
+	int, advice,
+	loff_t, offset,
+	loff_t, len)
+{
+	return sys_fadvise64_64(fd, offset, len, advice);
+}
diff --git a/arch/csky/kernel/syscall_table.c b/arch/csky/kernel/syscall_table.c
new file mode 100644
index 0000000..bea8558
--- /dev/null
+++ b/arch/csky/kernel/syscall_table.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/syscalls.h>
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.7.4
