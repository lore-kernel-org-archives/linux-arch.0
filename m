From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 12/18] arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Wed, 17 Aug 2016 14:46:37 +0300
Message-ID: <1471434403-25291-13-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-72571-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

From: Andrew Pinski <apinski@cavium.com>

Add a separate syscall-table for ILP32, which dispatches either to native
LP64 system call implementation or to compat-syscalls, as appropriate.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/unistd.h |  6 ++-
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/entry.S       | 28 +++++++++++++-
 arch/arm64/kernel/sys_ilp32.c   | 86 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kernel/sys_ilp32.c

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index fe9d6c1..250654c 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,13 +13,17 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#ifdef CONFIG_COMPAT
+#define __ARCH_WANT_SYS_LLSEEK
+#endif
+
 #ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4a81d93..36257b7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,7 +27,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9e18747..4c44312 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -255,6 +255,23 @@ tsk	.req	x28		// current thread_info
 
 	.text
 
+#ifdef CONFIG_ARM64_ILP32
+/*
+ * AARCH64/ILP32. Zero top halves of x0-x7
+ * registers as userspace may put garbage there.
+ */
+	.macro	delouse_input_regs
+	mov w0, w0
+	mov w1, w1
+	mov w2, w2
+	mov w3, w3
+	mov w4, w4
+	mov w5, w5
+	mov w6, w6
+	mov w7, w7
+	.endm
+#endif
+
 /*
  * Exception vectors.
  */
@@ -523,6 +540,7 @@ el0_svc_compat:
 	 * AArch32 syscall handling
 	 */
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
+	ldr     x16, [tsk, #TI_FLAGS]
 	uxtw	scno, w7			// syscall number in w7 (r7)
 	mov     sc_nr, #__NR_compat_syscalls
 	b	el0_svc_naked
@@ -749,15 +767,21 @@ ENDPROC(ret_from_fork)
 	.align	6
 el0_svc:
 	adrp	stbl, sys_call_table		// load syscall table pointer
+	ldr	x16, [tsk, #TI_FLAGS]
 	uxtw	scno, w8			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
+#ifdef CONFIG_ARM64_ILP32
+	tst	x16, #_TIF_32BIT_AARCH64
+	b.eq	el0_svc_naked			// We are using LP64  syscall table
+	adrp	stbl, sys_call_ilp32_table	// load ilp32 syscall table pointer
+	delouse_input_regs
+#endif
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
 
-	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
-	tst	x16, #_TIF_SYSCALL_WORK
+	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
new file mode 100644
index 0000000..10fc0ca
--- /dev/null
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -0,0 +1,86 @@
+/*
+ * AArch64- ILP32 specific system calls implementation
+ *
+ * Copyright (C) 2016 Cavium Inc.
+ * Author: Andrew Pinski <apinski@cavium.com>
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
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/msg.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+#include <asm-generic/syscalls.h>
+
+/*
+ * Using aarch32 syscall handlerss where off_t is passed.
+ */
+#define compat_sys_fadvise64_64		compat_sys_fadvise64_64_wrapper
+#define compat_sys_fallocate		compat_sys_fallocate_wrapper
+#define compat_sys_fcntl64		sys_fcntl
+#define compat_sys_ftruncate64		compat_sys_ftruncate64_wrapper
+#define compat_sys_pread64		compat_sys_pread64_wrapper
+#define compat_sys_pwrite64		compat_sys_pwrite64_wrapper
+#define compat_sys_readahead		compat_sys_readahead_wrapper
+#define compat_sys_shmat		sys_shmat
+#define compat_sys_sync_file_range	compat_sys_sync_file_range2_wrapper
+#define compat_sys_truncate64		compat_sys_truncate64_wrapper
+#define sys_mmap2			compat_sys_mmap2_wrapper
+#define sys_ptrace			compat_sys_ptrace
+
+/*
+ * Use non-compat syscall handlers where rlimit, stat and statfs
+ * structure pointers are passed, as their layout is identical to LP64.
+ */
+#define compat_sys_fstatfs64		sys_fstatfs
+#define compat_sys_statfs64		sys_statfs
+#define sys_fstat64			sys_newfstat
+#define sys_fstatat64			sys_newfstatat
+#define compat_sys_getrlimit		sys_getrlimit
+#define compat_sys_setrlimit		sys_setrlimit
+
+asmlinkage long compat_sys_fadvise64_64_wrapper(void);
+asmlinkage long compat_sys_fallocate_wrapper(void);
+asmlinkage long compat_sys_ftruncate64_wrapper(void);
+asmlinkage long compat_sys_mmap2_wrapper(void);
+asmlinkage long compat_sys_pread64_wrapper(void);
+asmlinkage long compat_sys_pwrite64_wrapper(void);
+asmlinkage long compat_sys_readahead_wrapper(void);
+asmlinkage long compat_sys_sync_file_range2_wrapper(void);
+asmlinkage long compat_sys_truncate64_wrapper(void);
+
+asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
+#define compat_sys_rt_sigreturn        ilp32_sys_rt_sigreturn_wrapper
+
+#include <asm/syscall.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, sym)	[nr] = sym,
+
+/*
+ * The sys_call_ilp32_table array must be 4K aligned to be accessible from
+ * kernel/entry.S.
+ */
+void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.7.4
