From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][ATCH 1/3] ptrace: Remove maxargs from task_current_syscall()
Date: Mon, 07 Nov 2016 16:26:35 -0500
Message-ID: <20161107213233.466776454@goodmis.org>
References: <20161107212634.529267342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-ptrace-Remove-maxargs-from-task_current_syscall.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

task_current_syscall() has a single user that passes in 6 for maxargs, which
is the maximum arguments that can be used to get system calls from
syscall_get_arguments(). Instead of passing in a number of arguments to
grab, just get 6 arguments. The args argument even specifies that it's an
array of 6 items.

This will also allow changing syscall_get_arguments() to not get a variable
number of arguments, but always grab 6.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/proc/base.c         |  2 +-
 include/linux/ptrace.h |  4 ++--
 lib/syscall.c          | 22 ++++++++--------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8e654468ab67..25cd58bd7236 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -650,7 +650,7 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 	if (res)
 		return res;
 
-	if (task_current_syscall(task, &nr, args, 6, &sp, &pc))
+	if (task_current_syscall(task, &nr, args, &sp, &pc))
 		seq_puts(m, "running\n");
 	else if (nr < 0)
 		seq_printf(m, "%ld 0x%lx 0x%lx\n", nr, sp, pc);
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 504c98a278d4..8af5226d2ee6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -403,7 +403,7 @@ static inline void user_single_step_siginfo(struct task_struct *tsk,
 #endif
 
 extern int task_current_syscall(struct task_struct *target, long *callno,
-				unsigned long args[6], unsigned int maxargs,
-				unsigned long *sp, unsigned long *pc);
+				unsigned long args[6], unsigned long *sp,
+				unsigned long *pc);
 
 #endif
diff --git a/lib/syscall.c b/lib/syscall.c
index 63239e097b13..cbd376c66bbc 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -4,8 +4,8 @@
 #include <asm/syscall.h>
 
 static int collect_syscall(struct task_struct *target, long *callno,
-			   unsigned long args[6], unsigned int maxargs,
-			   unsigned long *sp, unsigned long *pc)
+			   unsigned long args[6], unsigned long *sp,
+			   unsigned long *pc)
 {
 	struct pt_regs *regs;
 
@@ -25,8 +25,8 @@ static int collect_syscall(struct task_struct *target, long *callno,
 	*pc = instruction_pointer(regs);
 
 	*callno = syscall_get_nr(target, regs);
-	if (*callno != -1L && maxargs > 0)
-		syscall_get_arguments(target, regs, 0, maxargs, args);
+	if (*callno != -1L)
+		syscall_get_arguments(target, regs, 0, 6, args);
 
 	put_task_stack(target);
 	return 0;
@@ -37,7 +37,6 @@ static int collect_syscall(struct task_struct *target, long *callno,
  * @target:		thread to examine
  * @callno:		filled with system call number or -1
  * @args:		filled with @maxargs system call arguments
- * @maxargs:		number of elements in @args to fill
  * @sp:			filled with user stack pointer
  * @pc:			filled with user PC
  *
@@ -55,21 +54,16 @@ static int collect_syscall(struct task_struct *target, long *callno,
  * get() calls as long as we're sure @target won't return to user mode.
  *
  * Returns -%EAGAIN if @target does not remain blocked.
- *
- * Returns -%EINVAL if @maxargs is too large (maximum is six).
  */
 int task_current_syscall(struct task_struct *target, long *callno,
-			 unsigned long args[6], unsigned int maxargs,
-			 unsigned long *sp, unsigned long *pc)
+			 unsigned long args[6], unsigned long *sp,
+			 unsigned long *pc)
 {
 	long state;
 	unsigned long ncsw;
 
-	if (unlikely(maxargs > 6))
-		return -EINVAL;
-
 	if (target == current)
-		return collect_syscall(target, callno, args, maxargs, sp, pc);
+		return collect_syscall(target, callno, args, sp, pc);
 
 	state = target->state;
 	if (unlikely(!state))
@@ -77,7 +71,7 @@ int task_current_syscall(struct task_struct *target, long *callno,
 
 	ncsw = wait_task_inactive(target, state);
 	if (unlikely(!ncsw) ||
-	    unlikely(collect_syscall(target, callno, args, maxargs, sp, pc)) ||
+	    unlikely(collect_syscall(target, callno, args, sp, pc)) ||
 	    unlikely(wait_task_inactive(target, state) != ncsw))
 		return -EAGAIN;
 
-- 
2.9.3
