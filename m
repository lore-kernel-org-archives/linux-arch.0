Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54102 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfFGVof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 17:44:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Date: Fri, 07 Jun 2019 16:44:16 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <87pnnp9ikv.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [RFC PATCH 5/5] signal: Remove the unnecessary restore_sigmask flag
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190607214416.obzh6Hi-g7uiv6wz43rk8RSvO6SbpoDC6MOT9xRvNuc@z>


__set_current_blocked already has a test to see if the new
value and the old value of the signal mask differ.  Both
real_blocked and blocked should be on the same cache line,
and are a single word compare on 64bit.

Historically real_blocked or saved_sigmask could be garbage
so a test had to be used that always tested valid bits.
Now that real_blocked is alwasy valid there is no need
to test something different.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/include/asm/thread_info.h       |  1 -
 arch/arm/include/asm/thread_info.h       |  1 -
 arch/arm64/include/asm/thread_info.h     |  1 -
 arch/c6x/include/asm/thread_info.h       |  1 -
 arch/csky/include/asm/thread_info.h      |  2 -
 arch/h8300/include/asm/thread_info.h     |  1 -
 arch/hexagon/include/asm/thread_info.h   |  1 -
 arch/m68k/include/asm/thread_info.h      |  1 -
 arch/mips/include/asm/thread_info.h      |  1 -
 arch/nds32/include/asm/thread_info.h     |  2 -
 arch/nios2/include/asm/thread_info.h     |  2 -
 arch/riscv/include/asm/thread_info.h     |  1 -
 arch/s390/include/asm/thread_info.h      |  1 -
 arch/sparc/include/asm/thread_info_32.h  |  1 -
 arch/um/include/asm/thread_info.h        |  1 -
 arch/unicore32/include/asm/thread_info.h |  1 -
 arch/xtensa/include/asm/thread_info.h    |  1 -
 include/linux/sched.h                    |  3 -
 include/linux/sched/signal.h             | 79 +-----------------------
 kernel/ptrace.c                          |  2 -
 kernel/signal.c                          |  7 ---
 21 files changed, 1 insertion(+), 110 deletions(-)

diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index c85947bac5e5..bde0f76a986b 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -77,7 +77,6 @@ static inline __attribute_const__ struct thread_info *current_thread_info(void)
  * - pending work-to-be-done flags are in LSW
  * - other flags in MSW
  */
-#define TIF_RESTORE_SIGMASK	0	/* restore sig mask in do_signal() */
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 286eb61c632b..d1ee97031c21 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -147,7 +147,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_NOHZ		12	/* in adaptive nohz mode */
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	20
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index eb3ef73e07cf..bb8fdc9f78d2 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -93,7 +93,6 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SECCOMP		11
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
-#define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* 32bit process */
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
diff --git a/arch/c6x/include/asm/thread_info.h b/arch/c6x/include/asm/thread_info.h
index 59a5697fe0f3..229d365ffa9d 100644
--- a/arch/c6x/include/asm/thread_info.h
+++ b/arch/c6x/include/asm/thread_info.h
@@ -84,7 +84,6 @@ struct thread_info *current_thread_info(void)
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 
 #define TIF_MEMDIE		17	/* OOM killer killed process */
 
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 0b546a55a8bf..f7261865e9dc 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -59,7 +59,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
 #define TIF_SECCOMP		21	/* secure computing */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -70,7 +69,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
-#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
 #endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
index 0cdaa302d3d2..8d5d5063628a 100644
--- a/arch/h8300/include/asm/thread_info.h
+++ b/arch/h8300/include/asm/thread_info.h
@@ -68,7 +68,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SINGLESTEP		3	/* singlestepping active */
 #define TIF_MEMDIE		4	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_RESUME	6	/* callback before returning to user */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SYSCALL_TRACEPOINT	8	/* for ftrace syscall instrumentation */
diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index f41f9c6f0e31..2d1183690bc5 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -107,7 +107,6 @@ register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define TIF_SIGPENDING          2       /* signal pending */
 #define TIF_NEED_RESCHED        3       /* rescheduling necessary */
 #define TIF_SINGLESTEP          4       /* restore ss @ return to usr mode */
-#define TIF_RESTORE_SIGMASK     6       /* restore sig mask in do_signal() */
 /* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE              17      /* OOM killer killed process */
 
diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 015f1ca38305..d620cb4f240e 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -66,6 +66,5 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_DELAYED_TRACE	14	/* single step a syscall */
 #define TIF_SYSCALL_TRACE	15	/* syscall trace active */
 #define TIF_MEMDIE		16	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal */
 
 #endif	/* _ASM_M68K_THREAD_INFO_H */
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 4993db40482c..b2327b51c141 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -97,7 +97,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SECCOMP		4	/* secure computing */
 #define TIF_NOTIFY_RESUME	5	/* callback before returning to user */
 #define TIF_UPROBE		6	/* breakpointed or singlestepping */
-#define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index c135111ec44e..79914ce56cd9 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -52,7 +52,6 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
 #define TIF_FREEZE		19
-#define TIF_RESTORE_SIGMASK	20
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -61,7 +60,6 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
-#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 
 /*
  * Change these and you break ASM code in entry-common.S
diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 7349a4fa635b..b17309c3a5b3 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -86,7 +86,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_MEMDIE		4	/* is terminating due to OOM killer */
 #define TIF_SECCOMP		5	/* secure computing */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
-#define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
@@ -97,7 +96,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 9c039870019b..6a1e393b4b5f 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -79,7 +79,6 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index ce4e17c9aad6..6a1d1636016b 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -71,7 +71,6 @@ void arch_setup_new_exec(void);
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal() */
 #define TIF_SINGLE_STEP		19	/* This task is single stepped */
 #define TIF_BLOCK_STEP		20	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 548b366165dd..567f472c730b 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -103,7 +103,6 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		8	/* FPU was used by this task
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 4eecd960ee8c..565b7db73083 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -60,7 +60,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTART_BLOCK	4
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_SYSCALL_AUDIT	6
-#define TIF_RESTORE_SIGMASK	7
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
 
diff --git a/arch/unicore32/include/asm/thread_info.h b/arch/unicore32/include/asm/thread_info.h
index 5fb728f3b49a..0f38f6072839 100644
--- a/arch/unicore32/include/asm/thread_info.h
+++ b/arch/unicore32/include/asm/thread_info.h
@@ -119,7 +119,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_MEMDIE		18
-#define TIF_RESTORE_SIGMASK	20
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index f092cc3f4e66..27350241615c 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -108,7 +108,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		3	/* restore singlestep on return to user mode */
 #define TIF_SYSCALL_TRACEPOINT	4	/* syscall tracepoint instrumentation */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_DB_DISABLED		8	/* debug trap disabled for syscall */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 520efbd355be..a5284f5ccb7c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -713,9 +713,6 @@ struct task_struct {
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
-#ifndef TIF_RESTORE_SIGMASK
-	unsigned			restore_sigmask:1;
-#endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
 #endif
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 78678de45278..ac34566e762f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -400,86 +400,9 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 
 void task_join_group_stop(struct task_struct *task);
 
-#ifdef TIF_RESTORE_SIGMASK
-/*
- * Legacy restore_sigmask accessors.  These are inefficient on
- * SMP architectures because they require atomic operations.
- */
-
-/**
- * set_restore_sigmask() - make sure real_sigmask processing gets done
- *
- * This sets TIF_RESTORE_SIGMASK and ensures that the arch signal code
- * will run before returning to user mode, to process the flag.  For
- * all callers, TIF_SIGPENDING is already set or it's no harm to set
- * it.  TIF_RESTORE_SIGMASK need not be in the set of bits that the
- * arch code will notice on return to user mode, in case those bits
- * are scarce.  We set TIF_SIGPENDING here to ensure that the arch
- * signal code always gets run when TIF_RESTORE_SIGMASK is set.
- */
-static inline void set_restore_sigmask(void)
-{
-	set_thread_flag(TIF_RESTORE_SIGMASK);
-}
-
-static inline void clear_tsk_restore_sigmask(struct task_struct *task)
-{
-	clear_tsk_thread_flag(task, TIF_RESTORE_SIGMASK);
-}
-
-static inline void clear_restore_sigmask(void)
-{
-	clear_thread_flag(TIF_RESTORE_SIGMASK);
-}
-static inline bool test_tsk_restore_sigmask(struct task_struct *task)
-{
-	return test_tsk_thread_flag(task, TIF_RESTORE_SIGMASK);
-}
-static inline bool test_restore_sigmask(void)
-{
-	return test_thread_flag(TIF_RESTORE_SIGMASK);
-}
-static inline bool test_and_clear_restore_sigmask(void)
-{
-	return test_and_clear_thread_flag(TIF_RESTORE_SIGMASK);
-}
-
-#else	/* TIF_RESTORE_SIGMASK */
-
-/* Higher-quality implementation, used if TIF_RESTORE_SIGMASK doesn't exist. */
-static inline void set_restore_sigmask(void)
-{
-	current->restore_sigmask = true;
-}
-static inline void clear_tsk_restore_sigmask(struct task_struct *task)
-{
-	task->restore_sigmask = false;
-}
-static inline void clear_restore_sigmask(void)
-{
-	current->restore_sigmask = false;
-}
-static inline bool test_restore_sigmask(void)
-{
-	return current->restore_sigmask;
-}
-static inline bool test_tsk_restore_sigmask(struct task_struct *task)
-{
-	return task->restore_sigmask;
-}
-static inline bool test_and_clear_restore_sigmask(void)
-{
-	if (!current->restore_sigmask)
-		return false;
-	current->restore_sigmask = false;
-	return true;
-}
-#endif
-
 static inline void restore_saved_sigmask(void)
 {
-	if (test_and_clear_restore_sigmask())
-		__set_current_blocked(&current->real_blocked);
+	__set_current_blocked(&current->real_blocked);
 }
 
 extern int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 5ed6126e1cc5..08e25bbb04f4 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -963,8 +963,6 @@ int ptrace_request(struct task_struct *child, long request,
 		child->real_blocked = new_set;
 		spin_unlock_irq(&child->sighand->siglock);
 
-		clear_tsk_restore_sigmask(child);
-
 		ret = 0;
 		break;
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index c37d4f209699..1358e6bf02d3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2734,12 +2734,6 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 {
 	sigset_t blocked;
 
-	/* A signal was successfully delivered, and the
-	   saved sigmask was stored on the signal frame,
-	   and will be restored by sigreturn.  So we can
-	   simply clear the restore sigmask flag.  */
-	clear_restore_sigmask();
-
 	sigorsets(&blocked, &current->blocked, &ksig->ka.sa.sa_mask);
 	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&blocked, ksig->sig);
@@ -2940,7 +2934,6 @@ EXPORT_SYMBOL(sigprocmask);
 
 static int set_sigmask(sigset_t *newset)
 {
-	set_restore_sigmask();
 	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	__set_current_blocked(newset);
 
-- 
2.21.0.dirty
