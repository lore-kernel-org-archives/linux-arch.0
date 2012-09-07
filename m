Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34502 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2IGQ1z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:55 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 17/31] arm64: System calls handling
Date: Fri,  7 Sep 2012 17:26:52 +0100
Message-ID: <1347035226-18649-18-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162652.oaL4lWAcuNRYEpmPd-8eAtKyDUqhQNlV5JBUr3RxwpM@z>

This patch adds support for system calls coming from 64-bit
applications. It uses the asm-generic/unistd.h definitions with the
canonical set of system calls. The private system calls are only used
for 32-bit (compat) applications as 64-bit ones can set the TLS and
flush the caches entirely from user space.

The sys_call_table is just an array defined in a C file and it contains
pointers to the syscall functions. The array is 4KB aligned to allow the
use of the ADRP instruction (longer range ADR) in entry.S.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/stat.h     |   62 +++++++++++++++++
 arch/arm64/include/asm/statfs.h   |   23 ++++++
 arch/arm64/include/asm/syscalls.h |   40 +++++++++++
 arch/arm64/include/asm/unistd.h   |   27 +++++++
 arch/arm64/kernel/sys.c           |  138 +++++++++++++++++++++++++++++++++=
++++
 5 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/stat.h
 create mode 100644 arch/arm64/include/asm/statfs.h
 create mode 100644 arch/arm64/include/asm/syscalls.h
 create mode 100644 arch/arm64/include/asm/unistd.h
 create mode 100644 arch/arm64/kernel/sys.c

diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
new file mode 100644
index 0000000..d87225c
--- /dev/null
+++ b/arch/arm64/include/asm/stat.h
@@ -0,0 +1,62 @@
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
+#ifndef __ASM_STAT_H
+#define __ASM_STAT_H
+
+#include <asm-generic/stat.h>
+
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+
+#include <asm/compat.h>
+
+/*
+ * struct stat64 is needed for compat tasks only. Its definition is differ=
ent
+ * from the generic struct stat64.
+ */
+struct stat64 {
+=09compat_u64=09st_dev;
+=09unsigned char   __pad0[4];
+
+#define STAT64_HAS_BROKEN_ST_INO=091
+=09compat_ulong_t=09__st_ino;
+=09compat_uint_t=09st_mode;
+=09compat_uint_t=09st_nlink;
+
+=09compat_ulong_t=09st_uid;
+=09compat_ulong_t=09st_gid;
+
+=09compat_u64=09st_rdev;
+=09unsigned char   __pad3[4];
+
+=09compat_s64=09st_size;
+=09compat_ulong_t=09st_blksize;
+=09compat_u64=09st_blocks;=09/* Number of 512-byte blocks allocated. */
+
+=09compat_ulong_t=09st_atime;
+=09compat_ulong_t=09st_atime_nsec;
+
+=09compat_ulong_t=09st_mtime;
+=09compat_ulong_t=09st_mtime_nsec;
+
+=09compat_ulong_t=09st_ctime;
+=09compat_ulong_t=09st_ctime_nsec;
+
+=09compat_u64=09st_ino;
+};
+
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/statfs.h b/arch/arm64/include/asm/statf=
s.h
new file mode 100644
index 0000000..6f62190
--- /dev/null
+++ b/arch/arm64/include/asm/statfs.h
@@ -0,0 +1,23 @@
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
+#ifndef __ASM_STATFS_H
+#define __ASM_STATFS_H
+
+#define ARCH_PACK_COMPAT_STATFS64 __attribute__((packed,aligned(4)))
+
+#include <asm-generic/statfs.h>
+
+#endif
diff --git a/arch/arm64/include/asm/syscalls.h b/arch/arm64/include/asm/sys=
calls.h
new file mode 100644
index 0000000..09ff335
--- /dev/null
+++ b/arch/arm64/include/asm/syscalls.h
@@ -0,0 +1,40 @@
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
+#ifndef __ASM_SYSCALLS_H
+#define __ASM_SYSCALLS_H
+
+#include <linux/linkage.h>
+#include <linux/compiler.h>
+#include <linux/signal.h>
+
+/*
+ * System call wrappers implemented in kernel/entry.S.
+ */
+asmlinkage long sys_execve_wrapper(const char __user *filename,
+=09=09=09=09   const char __user *const __user *argv,
+=09=09=09=09   const char __user *const __user *envp);
+asmlinkage long sys_clone_wrapper(unsigned long clone_flags,
+=09=09=09=09  unsigned long newsp,
+=09=09=09=09  void __user *parent_tid,
+=09=09=09=09  unsigned long tls_val,
+=09=09=09=09  void __user *child_tid);
+asmlinkage long sys_rt_sigreturn_wrapper(void);
+asmlinkage long sys_sigaltstack_wrapper(const stack_t __user *uss,
+=09=09=09=09=09stack_t __user *uoss);
+
+#include <asm-generic/syscalls.h>
+
+#endif=09/* __ASM_SYSCALLS_H */
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unist=
d.h
new file mode 100644
index 0000000..fe18a68
--- /dev/null
+++ b/arch/arm64/include/asm/unistd.h
@@ -0,0 +1,27 @@
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
+#if !defined(__ASM_UNISTD_H) || defined(__SYSCALL)
+#define __ASM_UNISTD_H
+
+#ifndef __SYSCALL_COMPAT
+#include <asm-generic/unistd.h>
+#endif
+
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+#include <asm/unistd32.h>
+#endif
+
+#endif /* __ASM_UNISTD_H */
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
new file mode 100644
index 0000000..905fcfb
--- /dev/null
+++ b/arch/arm64/kernel/sys.c
@@ -0,0 +1,138 @@
+/*
+ * AArch64-specific system calls implementation
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
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
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+
+/*
+ * Clone a task - this clones the calling program thread.
+ */
+asmlinkage long sys_clone(unsigned long clone_flags, unsigned long newsp,
+=09=09=09  int __user *parent_tidptr, unsigned long tls_val,
+=09=09=09  int __user *child_tidptr, struct pt_regs *regs)
+{
+=09if (!newsp)
+=09=09newsp =3D regs->sp;
+=09/* 16-byte aligned stack mandatory on AArch64 */
+=09if (newsp & 15)
+=09=09return -EINVAL;
+=09return do_fork(clone_flags, newsp, regs, 0, parent_tidptr, child_tidptr=
);
+}
+
+/*
+ * sys_execve() executes a new program.
+ */
+asmlinkage long sys_execve(const char __user *filenamei,
+=09=09=09   const char __user *const __user *argv,
+=09=09=09   const char __user *const __user *envp,
+=09=09=09   struct pt_regs *regs)
+{
+=09long error;
+=09char * filename;
+
+=09filename =3D getname(filenamei);
+=09error =3D PTR_ERR(filename);
+=09if (IS_ERR(filename))
+=09=09goto out;
+=09error =3D do_execve(filename, argv, envp, regs);
+=09putname(filename);
+out:
+=09return error;
+}
+
+int kernel_execve(const char *filename,
+=09=09  const char *const argv[],
+=09=09  const char *const envp[])
+{
+=09struct pt_regs regs;
+=09int ret;
+
+=09memset(&regs, 0, sizeof(struct pt_regs));
+=09ret =3D do_execve(filename,
+=09=09=09(const char __user *const __user *)argv,
+=09=09=09(const char __user *const __user *)envp, &regs);
+=09if (ret < 0)
+=09=09goto out;
+
+=09/*
+=09 * Save argc to the register structure for userspace.
+=09 */
+=09regs.regs[0] =3D ret;
+
+=09/*
+=09 * We were successful.  We won't be returning to our caller, but
+=09 * instead to user space by manipulating the kernel stack.
+=09 */
+=09asm(=09"add=09x0, %0, %1\n\t"
+=09=09"mov=09x1, %2\n\t"
+=09=09"mov=09x2, %3\n\t"
+=09=09"bl=09memmove\n\t"=09/* copy regs to top of stack */
+=09=09"mov=09x27, #0\n\t"=09/* not a syscall */
+=09=09"mov=09x28, %0\n\t"=09/* thread structure */
+=09=09"mov=09sp, x0\n\t"=09/* reposition stack pointer */
+=09=09"b=09ret_to_user"
+=09=09:
+=09=09: "r" (current_thread_info()),
+=09=09  "Ir" (THREAD_START_SP - sizeof(regs)),
+=09=09  "r" (&regs),
+=09=09  "Ir" (sizeof(regs))
+=09=09: "x0", "x1", "x2", "x27", "x28", "x30", "memory");
+
+ out:
+=09return ret;
+}
+EXPORT_SYMBOL(kernel_execve);
+
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
+=09=09=09 unsigned long prot, unsigned long flags,
+=09=09=09 unsigned long fd, off_t off)
+{
+=09if (offset_in_page(off) !=3D 0)
+=09=09return -EINVAL;
+
+=09return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
+
+/*
+ * Wrappers to pass the pt_regs argument.
+ */
+#define sys_execve=09=09sys_execve_wrapper
+#define sys_clone=09=09sys_clone_wrapper
+#define sys_rt_sigreturn=09sys_rt_sigreturn_wrapper
+#define sys_sigaltstack=09=09sys_sigaltstack_wrapper
+
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)=09[nr] =3D sym,
+
+/*
+ * The sys_call_table array must be 4K aligned to be accessible from
+ * kernel/entry.S.
+ */
+void *sys_call_table[__NR_syscalls] __aligned(4096) =3D {
+=09[0 ... __NR_syscalls - 1] =3D sys_ni_syscall,
+#include <asm/unistd.h>
+};

