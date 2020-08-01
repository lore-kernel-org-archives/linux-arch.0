From: guoren@kernel.org
Subject: [PATCH 02/13] csky: Add SECCOMP_FILTER supported
Date: Sat,  1 Aug 2020 01:14:02 +0000
Message-ID: <1596244453-98575-3-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

secure_computing() is called first in syscall_trace_enter() so that
a system call will be aborted quickly without doing succeeding syscall
tracing if seccomp rules want to deny that system call.

TODO:
 - Update https://github.com/seccomp/libseccomp csky support

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                             | 14 ++++++++++++++
 arch/csky/include/asm/Kbuild                  |  1 +
 arch/csky/include/asm/thread_info.h           |  2 +-
 arch/csky/kernel/entry.S                      |  3 +++
 arch/csky/kernel/ptrace.c                     |  8 ++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 13 ++++++++++++-
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bd31ab1..822362d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -38,6 +38,7 @@ config CSKY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
@@ -296,3 +297,16 @@ endmenu
 source "arch/csky/Kconfig.platforms"
 
 source "kernel/Kconfig.hz"
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 9337225..64876e59 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -4,5 +4,6 @@ generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += qrwlock.h
+generic-y += seccomp.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 8980e4e..68e7a12 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -85,6 +85,6 @@ static inline struct thread_info *current_thread_info(void)
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
 
 #endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index f138003..efd2e69 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -168,6 +168,8 @@ ENTRY(csky_systemcall)
 csky_syscall_trace:
 	mov	a0, sp                  /* sp = pt_regs pointer */
 	jbsr	syscall_trace_enter
+	cmpnei	a0, 0
+	bt	1f
 	/* Prepare args before do system call */
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
@@ -188,6 +190,7 @@ csky_syscall_trace:
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
+1:
 #ifdef CONFIG_DEBUG_RSEQ
 	mov	a0, sp
 	jbsr	rseq_syscall
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 944ca2f..0de10f7 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -320,16 +320,20 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-asmlinkage void syscall_trace_enter(struct pt_regs *regs)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		if (tracehook_report_syscall_entry(regs))
-			syscall_set_nr(current, regs, -1);
+			return -1;
+
+	if (secure_computing() == -1)
+		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
 	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2, regs->a3);
+	return 0;
 }
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a..8d18a0d 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -116,6 +116,8 @@ struct seccomp_data {
 #  define __NR_seccomp 277
 # elif defined(__riscv)
 #  define __NR_seccomp 277
+# elif defined(__csky__)
+#  define __NR_seccomp 277
 # elif defined(__hppa__)
 #  define __NR_seccomp 338
 # elif defined(__powerpc__)
@@ -1603,6 +1605,14 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS	struct user_regs_struct
 # define SYSCALL_NUM	a7
 # define SYSCALL_RET	a0
+#elif defined(__csky__)
+# define ARCH_REGS	struct pt_regs
+#if defined(__CSKYABIV2__)
+# define SYSCALL_NUM	regs[3]
+#else
+# define SYSCALL_NUM	regs[9]
+#endif
+# define SYSCALL_RET	a0
 #elif defined(__hppa__)
 # define ARCH_REGS	struct user_regs_struct
 # define SYSCALL_NUM	gr[20]
@@ -1693,7 +1703,8 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret) {}
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
-	defined(__s390__) || defined(__hppa__) || defined(__riscv)
+	defined(__s390__) || defined(__hppa__) || defined(__riscv) || \
+	defined(__csky__)
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
-- 
2.7.4
