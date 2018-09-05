From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V3 05/26] csky: System Call
Date: Wed,  5 Sep 2018 20:07:44 +0800
Message-ID: <bff609c9d2c5f0085448cc7d4227614ab7b7116a.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536138304.git.ren_guo@c-sky.com>
References: <cover.1536138304.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/syscall.h     | 69 +++++++++++++++++++++++++++++++++++++
 arch/csky/include/asm/syscalls.h    | 14 ++++++++
 arch/csky/include/uapi/asm/unistd.h | 10 ++++++
 arch/csky/kernel/syscall.c          | 63 +++++++++++++++++++++++++++++++++
 arch/csky/kernel/syscall_table.c    | 13 +++++++
 5 files changed, 169 insertions(+)
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
index 0000000..6fc1448
--- /dev/null
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#define __ARCH_WANT_SYS_CLONE
+#include <asm-generic/unistd.h>
+
+#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
+__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 4)
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
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
index 0000000..79dfb52
--- /dev/null
+++ b/arch/csky/kernel/syscall_table.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/syscalls.h>
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+#define sys_fadvise64_64 sys_csky_fadvise64_64
+void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.7.4
