From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
Date: Wed, 17 Aug 2016 14:46:41 +0300
Message-ID: <1471434403-25291-17-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-72574-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
List-Id: linux-arch.vger.kernel.org

Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
detection of the task type.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/unistd32.h |  2 +-
 arch/arm64/kernel/ptrace.c        | 91 ++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/sys32.c         |  1 +
 include/linux/ptrace.h            |  6 +++
 kernel/ptrace.c                   | 10 ++---
 5 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index b7e8ef1..6da7cbd 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -74,7 +74,7 @@ __SYSCALL(__NR_getuid, sys_getuid16)
 			/* 25 was sys_stime */
 __SYSCALL(25, sys_ni_syscall)
 #define __NR_ptrace 26
-__SYSCALL(__NR_ptrace, compat_sys_ptrace)
+__SYSCALL(__NR_ptrace, compat_sys_aarch32_ptrace)
 			/* 27 was sys_alarm */
 __SYSCALL(27, sys_ni_syscall)
 			/* 28 was sys_fstat */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1d075ed..4f0df07 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/user.h>
 #include <linux/seccomp.h>
 #include <linux/security.h>
+#include <linux/syscalls.h>
 #include <linux/init.h>
 #include <linux/signal.h>
 #include <linux/uaccess.h>
@@ -40,6 +41,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
+#include <asm/signal32_common.h>
 #include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
@@ -1215,7 +1217,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1292,8 +1294,95 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+
+COMPAT_SYSCALL_DEFINE4(aarch32_ptrace, compat_long_t, request, compat_long_t, pid,
+		       compat_long_t, addr, compat_long_t, data)
+{
+	struct task_struct *child;
+	long ret;
+
+	if (request == PTRACE_TRACEME) {
+		ret = ptrace_traceme();
+		goto out;
+	}
+
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		goto out;
+	}
+
+	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
+		ret = ptrace_attach(child, request, addr, data);
+		goto out_put_task_struct;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
+				  request == PTRACE_INTERRUPT);
+	if (!ret) {
+		ret = compat_a32_ptrace(child, request, addr, data);
+		if (ret || request != PTRACE_DETACH)
+			ptrace_unfreeze_traced(child);
+	}
+
+ out_put_task_struct:
+	put_task_struct(child);
+ out:
+	return ret;
+}
+
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	sigset_t new_set;
+
+	switch (request) {
+	case PTRACE_GETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		return put_sigset_t((compat_sigset_t __user *) (u64) cdata,
+					&child->blocked);
+
+	case PTRACE_SETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		if (get_sigset_t(&new_set, (compat_sigset_t __user *) (u64) cdata))
+			return -EFAULT;
+
+		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+		/*
+		 * Every thread does recalc_sigpending() after resume, so
+		 * retarget_shared_pending() and recalc_sigpending() are not
+		 * called here.
+		 */
+		spin_lock_irq(&child->sighand->siglock);
+		child->blocked = new_set;
+		spin_unlock_irq(&child->sighand->siglock);
+
+		return 0;
+
+	default:
+		return compat_ptrace_request(child, request, caddr, cdata);
+	}
+}
+
+#elif defined (CONFIG_COMPAT)
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+		compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	return 0;
+}
+
+#endif
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index a40b134..3752443 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -38,6 +38,7 @@ asmlinkage long compat_sys_fadvise64_64_wrapper(void);
 asmlinkage long compat_sys_sync_file_range2_wrapper(void);
 asmlinkage long compat_sys_fallocate_wrapper(void);
 asmlinkage long compat_sys_mmap2_wrapper(void);
+asmlinkage long compat_sys_aarch32_ptrace(void);
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 504c98a..75887a0 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -97,6 +97,12 @@ int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
 			    unsigned long data);
 int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
 			    unsigned long data);
+int ptrace_traceme(void);
+struct task_struct *ptrace_get_task_struct(pid_t pid);
+int ptrace_attach(struct task_struct *task, long request,
+			 unsigned long addr, unsigned long flags);
+int ptrace_check_attach(struct task_struct *child, bool ignore_state);
+void ptrace_unfreeze_traced(struct task_struct *task);
 
 /**
  * ptrace_parent - return the task that is tracing the given task
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1d3b766..7cfbfca 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -136,7 +136,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	return ret;
 }
 
-static void ptrace_unfreeze_traced(struct task_struct *task)
+void ptrace_unfreeze_traced(struct task_struct *task)
 {
 	if (task->state != __TASK_TRACED)
 		return;
@@ -168,7 +168,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  * RETURNS:
  * 0 on success, -ESRCH if %child is not ready.
  */
-static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
+int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
 	int ret = -ESRCH;
 
@@ -292,7 +292,7 @@ bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return !err;
 }
 
-static int ptrace_attach(struct task_struct *task, long request,
+int ptrace_attach(struct task_struct *task, long request,
 			 unsigned long addr,
 			 unsigned long flags)
 {
@@ -406,7 +406,7 @@ out:
  * Performs checks and sets PT_PTRACED.
  * Should be used by all ptrace implementations for PTRACE_TRACEME.
  */
-static int ptrace_traceme(void)
+ int ptrace_traceme(void)
 {
 	int ret = -EPERM;
 
@@ -1056,7 +1056,7 @@ int ptrace_request(struct task_struct *child, long request,
 	return ret;
 }
 
-static struct task_struct *ptrace_get_task_struct(pid_t pid)
+struct task_struct *ptrace_get_task_struct(pid_t pid)
 {
 	struct task_struct *child;
 
-- 
2.7.4
