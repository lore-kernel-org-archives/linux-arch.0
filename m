Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfC2DWz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Mar 2019 23:22:55 -0400
Message-ID: <20190329032252.898738604@goodmis.org>
Date: Thu, 28 Mar 2019 19:05:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 1/4 v2] ptrace: Remove maxargs from task_current_syscall()
References: <20190328230512.486297455@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Message-ID: <20190328230513.DUOqmQB9CDbGGV8u7ezoQqYD-pKlSD1SYSLyyF-YspU@z>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

task_current_syscall() has a single user that passes in 6 for maxargs, which
is the maximum arguments that can be used to get system calls from
syscall_get_arguments(). Instead of passing in a number of arguments to
grab, just get 6 arguments. The args argument even specifies that it's an
array of 6 items.

This will also allow changing syscall_get_arguments() to not get a variable
number of arguments, but always grab 6.

Linus also suggested not passing in a bunch of arguments to
task_current_syscall() but to instead pass in a pointer to a structure, and
just fill the structure. struct seccomp_data has almost all the parameters
that is needed except for the stack pointer (sp). As seccomp_data is part of
uapi, and I'm afraid to change it, a new structure was created
"syscall_info", which includes seccomp_data and adds the "sp" field.

Link: http://lkml.kernel.org/r/20161107213233.466776454@goodmis.org

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/proc/base.c         | 17 +++++++------
 include/linux/ptrace.h | 11 +++++---
 lib/syscall.c          | 57 ++++++++++++++++++------------------------
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..6a803a0b75df 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -616,24 +616,25 @@ static int proc_pid_limits(struct seq_file *m, struct pid_namespace *ns,
 static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *task)
 {
-	long nr;
-	unsigned long args[6], sp, pc;
+	struct syscall_info info;
+	u64 *args = &info.data.args[0];
 	int res;
 
 	res = lock_trace(task);
 	if (res)
 		return res;
 
-	if (task_current_syscall(task, &nr, args, 6, &sp, &pc))
+	if (task_current_syscall(task, &info))
 		seq_puts(m, "running\n");
-	else if (nr < 0)
-		seq_printf(m, "%ld 0x%lx 0x%lx\n", nr, sp, pc);
+	else if (info.data.nr < 0)
+		seq_printf(m, "%d 0x%llx 0x%llx\n",
+			   info.data.nr, info.sp, info.data.instruction_pointer);
 	else
 		seq_printf(m,
-		       "%ld 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       nr,
+		       "%d 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
+		       info.data.nr,
 		       args[0], args[1], args[2], args[3], args[4], args[5],
-		       sp, pc);
+		       info.sp, info.data.instruction_pointer);
 	unlock_trace(task);
 
 	return 0;
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index edb9b040c94c..d5084ebd9f03 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -9,6 +9,13 @@
 #include <linux/bug.h>			/* For BUG_ON.  */
 #include <linux/pid_namespace.h>	/* For task_active_pid_ns.  */
 #include <uapi/linux/ptrace.h>
+#include <linux/seccomp.h>
+
+/* Add sp to seccomp_data, as seccomp is user API, we don't want to modify it */
+struct syscall_info {
+	__u64			sp;
+	struct seccomp_data	data;
+};
 
 extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 			    void *buf, int len, unsigned int gup_flags);
@@ -407,9 +414,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
-extern int task_current_syscall(struct task_struct *target, long *callno,
-				unsigned long args[6], unsigned int maxargs,
-				unsigned long *sp, unsigned long *pc);
+extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
 #endif
diff --git a/lib/syscall.c b/lib/syscall.c
index 1a7077f20eae..e8467e17b9a2 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -5,16 +5,14 @@
 #include <linux/export.h>
 #include <asm/syscall.h>
 
-static int collect_syscall(struct task_struct *target, long *callno,
-			   unsigned long args[6], unsigned int maxargs,
-			   unsigned long *sp, unsigned long *pc)
+static int collect_syscall(struct task_struct *target, struct syscall_info *info)
 {
 	struct pt_regs *regs;
 
 	if (!try_get_task_stack(target)) {
 		/* Task has no stack, so the task isn't in a syscall. */
-		*sp = *pc = 0;
-		*callno = -1;
+		memset(info, 0, sizeof(*info));
+		info->data.nr = -1;
 		return 0;
 	}
 
@@ -24,12 +22,13 @@ static int collect_syscall(struct task_struct *target, long *callno,
 		return -EAGAIN;
 	}
 
-	*sp = user_stack_pointer(regs);
-	*pc = instruction_pointer(regs);
+	info->sp = user_stack_pointer(regs);
+	info->data.instruction_pointer = instruction_pointer(regs);
 
-	*callno = syscall_get_nr(target, regs);
-	if (*callno != -1L && maxargs > 0)
-		syscall_get_arguments(target, regs, 0, maxargs, args);
+	info->data.nr = syscall_get_nr(target, regs);
+	if (info->data.nr != -1L)
+		syscall_get_arguments(target, regs, 0, 6,
+				      (unsigned long *)&info->data.args[0]);
 
 	put_task_stack(target);
 	return 0;
@@ -38,41 +37,35 @@ static int collect_syscall(struct task_struct *target, long *callno,
 /**
  * task_current_syscall - Discover what a blocked task is doing.
  * @target:		thread to examine
- * @callno:		filled with system call number or -1
- * @args:		filled with @maxargs system call arguments
- * @maxargs:		number of elements in @args to fill
- * @sp:			filled with user stack pointer
- * @pc:			filled with user PC
+ * @info:		structure with the following fields:
+ *			 .sp        - filled with user stack pointer
+ *			 .data.nr   - filled with system call number or -1
+ *			 .data.args - filled with @maxargs system call arguments
+ *			 .data.instruction_pointer - filled with user PC
  *
- * If @target is blocked in a system call, returns zero with *@callno
- * set to the the call's number and @args filled in with its arguments.
- * Registers not used for system call arguments may not be available and
- * it is not kosher to use &struct user_regset calls while the system
+ * If @target is blocked in a system call, returns zero with @info.data.nr
+ * set to the the call's number and @info.data.args filled in with its
+ * arguments. Registers not used for system call arguments may not be available
+ * and it is not kosher to use &struct user_regset calls while the system
  * call is still in progress.  Note we may get this result if @target
  * has finished its system call but not yet returned to user mode, such
  * as when it's stopped for signal handling or syscall exit tracing.
  *
  * If @target is blocked in the kernel during a fault or exception,
- * returns zero with *@callno set to -1 and does not fill in @args.
- * If so, it's now safe to examine @target using &struct user_regset
- * get() calls as long as we're sure @target won't return to user mode.
+ * returns zero with *@info.data.nr set to -1 and does not fill in
+ * @info.data.args. If so, it's now safe to examine @target using
+ * &struct user_regset get() calls as long as we're sure @target won't return
+ * to user mode.
  *
  * Returns -%EAGAIN if @target does not remain blocked.
- *
- * Returns -%EINVAL if @maxargs is too large (maximum is six).
  */
-int task_current_syscall(struct task_struct *target, long *callno,
-			 unsigned long args[6], unsigned int maxargs,
-			 unsigned long *sp, unsigned long *pc)
+int task_current_syscall(struct task_struct *target, struct syscall_info *info)
 {
 	long state;
 	unsigned long ncsw;
 
-	if (unlikely(maxargs > 6))
-		return -EINVAL;
-
 	if (target == current)
-		return collect_syscall(target, callno, args, maxargs, sp, pc);
+		return collect_syscall(target, info);
 
 	state = target->state;
 	if (unlikely(!state))
@@ -80,7 +73,7 @@ int task_current_syscall(struct task_struct *target, long *callno,
 
 	ncsw = wait_task_inactive(target, state);
 	if (unlikely(!ncsw) ||
-	    unlikely(collect_syscall(target, callno, args, maxargs, sp, pc)) ||
+	    unlikely(collect_syscall(target, info)) ||
 	    unlikely(wait_task_inactive(target, state) != ncsw))
 		return -EAGAIN;
 
-- 
2.20.1
