From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 03/11] MIPS: Remove unused task argument from prctl functions
Date: Mon, 14 May 2018 18:14:19 +0100
Message-ID: <1526318067-4964-4-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

Some MIPS-specific prctl backends take a task argument that is
redundant, since the only thing ever passed is "current".

This patch gets rid of the redundant arguments.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/mips/include/asm/processor.h |  4 ++--
 arch/mips/kernel/process.c        | 23 +++++++++++------------
 arch/mips/kernel/syscall.c        |  1 +
 kernel/sys.c                      |  8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index af34afb..8f06608 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -420,7 +420,7 @@ extern int mips_get_process_fp_mode(struct task_struct *task);
 extern int mips_set_process_fp_mode(struct task_struct *task,
 				    unsigned int value);
 
-#define GET_FP_MODE(task)		mips_get_process_fp_mode(task)
-#define SET_FP_MODE(task,value)		mips_set_process_fp_mode(task, value)
+#define GET_FP_MODE()			mips_get_process_fp_mode()
+#define SET_FP_MODE(value)		mips_set_process_fp_mode(value)
 
 #endif /* _ASM_PROCESSOR_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b9e9bf6..7db1989 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -679,13 +679,13 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 	put_cpu();
 }
 
-int mips_get_process_fp_mode(struct task_struct *task)
+int mips_get_process_fp_mode(void)
 {
 	int value = 0;
 
-	if (!test_tsk_thread_flag(task, TIF_32BIT_FPREGS))
+	if (!test_thread_flag(TIF_32BIT_FPREGS))
 		value |= PR_FP_MODE_FR;
-	if (test_tsk_thread_flag(task, TIF_HYBRID_FPREGS))
+	if (test_thread_flag(TIF_HYBRID_FPREGS))
 		value |= PR_FP_MODE_FRE;
 
 	return value;
@@ -699,14 +699,14 @@ static void prepare_for_fp_mode_switch(void *info)
 		lose_fpu(1);
 }
 
-int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
+int mips_set_process_fp_mode(unsigned int value)
 {
 	const unsigned int known_bits = PR_FP_MODE_FR | PR_FP_MODE_FRE;
 	struct task_struct *t;
 	int max_users;
 
 	/* If nothing to change, return right away, successfully.  */
-	if (value == mips_get_process_fp_mode(task))
+	if (value == mips_get_process_fp_mode())
 		return 0;
 
 	/* Only accept a mode change if 64-bit FP enabled for o32.  */
@@ -736,11 +736,10 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	preempt_disable();
 
 	/* Save FP & vector context, then disable FPU & MSA */
-	if (task->signal == current->signal)
-		lose_fpu(1);
+	lose_fpu(1);
 
 	/* Prevent any threads from obtaining live FP context */
-	atomic_set(&task->mm->context.fp_mode_switching, 1);
+	atomic_set(&current->mm->context.fp_mode_switching, 1);
 	smp_mb__after_atomic();
 
 	/*
@@ -750,7 +749,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	 */
 	if (num_online_cpus() > 1) {
 		/* No need to send an IPI for the local CPU */
-		max_users = (task->mm == current->mm) ? 1 : 0;
+		max_users = (current->mm == current->mm) ? 1 : 0;
 
 		if (atomic_read(&current->mm->mm_users) > max_users)
 			smp_call_function(prepare_for_fp_mode_switch,
@@ -761,7 +760,7 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	 * There are now no threads of the process with live FP context, so it
 	 * is safe to proceed with the FP mode switch.
 	 */
-	for_each_thread(task, t) {
+	for_each_thread(current, t) {
 		/* Update desired FP register width */
 		if (value & PR_FP_MODE_FR) {
 			clear_tsk_thread_flag(t, TIF_32BIT_FPREGS);
@@ -778,10 +777,10 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	}
 
 	/* Allow threads to use FP again */
-	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	atomic_set(&current->mm->context.fp_mode_switching, 0);
 	preempt_enable();
 
-	wake_up_var(&task->mm->context.fp_mode_switching);
+	wake_up_var(&current->mm->context.fp_mode_switching);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 69c17b5..15f33f0 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/fs.h>
 #include <linux/smp.h>
+#include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/string.h>
 #include <linux/syscalls.h>
diff --git a/kernel/sys.c b/kernel/sys.c
index f917d78..520d2e8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -108,10 +108,10 @@
 # define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
 #endif
 #ifndef GET_FP_MODE
-# define GET_FP_MODE(a)		(-EINVAL)
+# define GET_FP_MODE()		(-EINVAL)
 #endif
 #ifndef SET_FP_MODE
-# define SET_FP_MODE(a,b)	(-EINVAL)
+# define SET_FP_MODE(a)		(-EINVAL)
 #endif
 
 /*
@@ -2433,10 +2433,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = MPX_DISABLE_MANAGEMENT();
 		break;
 	case PR_SET_FP_MODE:
-		error = SET_FP_MODE(me, arg2);
+		error = SET_FP_MODE(arg2);
 		break;
 	case PR_GET_FP_MODE:
-		error = GET_FP_MODE(me);
+		error = GET_FP_MODE();
 		break;
 	default:
 		error = prctl_arch(option, arg2, arg3, arg4, arg5);
-- 
2.1.4
