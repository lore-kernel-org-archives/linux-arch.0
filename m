From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/3] s390: move thread_info into task_struct
Date: Thu, 13 Oct 2016 13:57:12 +0200
Message-ID: <20161013115712.29517-4-heiko.carstens@de.ibm.com>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40259 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754932AbcJMMZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Oct 2016 08:25:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9DBro7a093603
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:21 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 261x06c3vu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:21 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Oct 2016 12:57:19 +0100
In-Reply-To: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

This is the s390 variant of commit 15f4eae70d36 ("x86: Move
thread_info into task_struct").

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/lowcore.h     |  2 +-
 arch/s390/include/asm/thread_info.h | 11 --------
 arch/s390/kernel/asm-offsets.c      | 17 +++++--------
 arch/s390/kernel/entry.S            | 51 ++++++++++++++++++-------------------
 arch/s390/kernel/head64.S           |  5 ++--
 arch/s390/kernel/setup.c            |  3 +--
 arch/s390/kernel/smp.c              |  1 -
 8 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 426481d4cc86..a159dfc27b76 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -169,6 +169,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select VIRT_TO_BUS
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 7b93b78f423c..27402de81047 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -95,7 +95,7 @@ struct lowcore {
 
 	/* Current process. */
 	__u64	current_task;			/* 0x0310 */
-	__u64	thread_info;			/* 0x0318 */
+	__u8	pad_0x318[0x320-0x318];		/* 0x0318 */
 	__u64	kernel_stack;			/* 0x0320 */
 
 	/* Interrupt, panic and restart stack. */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index f15c0398c363..f5fc4efa9bec 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -30,10 +30,8 @@
  * - if the contents of this structure are changed, the assembly constants must also be changed
  */
 struct thread_info {
-	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		sys_call_table;	/* System call table address */
-	unsigned int		cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	unsigned int		system_call;
 	__u64			user_timer;
@@ -46,21 +44,12 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
 	.flags		= 0,			\
-	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
-#define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-/* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	return (struct thread_info *) S390_lowcore.thread_info;
-}
-
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index f3df9e0a5dec..e6969ebd0d44 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -25,7 +25,7 @@
 int main(void)
 {
 	/* task struct offsets */
-	OFFSET(__TASK_thread_info, task_struct, stack);
+	OFFSET(__TASK_stack, task_struct, stack);
 	OFFSET(__TASK_thread, task_struct, thread);
 	OFFSET(__TASK_pid, task_struct, pid);
 	BLANK();
@@ -39,14 +39,12 @@ int main(void)
 	OFFSET(__THREAD_trap_tdb, thread_struct, trap_tdb);
 	BLANK();
 	/* thread info offsets */
-	OFFSET(__TI_task, thread_info, task);
-	OFFSET(__TI_flags, thread_info, flags);
-	OFFSET(__TI_sysc_table, thread_info, sys_call_table);
-	OFFSET(__TI_cpu, thread_info, cpu);
-	OFFSET(__TI_precount, thread_info, preempt_count);
-	OFFSET(__TI_user_timer, thread_info, user_timer);
-	OFFSET(__TI_system_timer, thread_info, system_timer);
-	OFFSET(__TI_last_break, thread_info, last_break);
+	OFFSET(__TASK_TI_flags, task_struct, thread_info.flags);
+	OFFSET(__TASK_TI_sysc_table,  task_struct, thread_info.sys_call_table);
+	OFFSET(__TASK_TI_precount, task_struct, thread_info.preempt_count);
+	OFFSET(__TASK_TI_user_timer, task_struct, thread_info.user_timer);
+	OFFSET(__TASK_TI_system_timer, task_struct, thread_info.system_timer);
+	OFFSET(__TASK_TI_last_break, task_struct, thread_info.last_break);
 	BLANK();
 	/* pt_regs offsets */
 	OFFSET(__PT_ARGS, pt_regs, args);
@@ -159,7 +157,6 @@ int main(void)
 	OFFSET(__LC_INT_CLOCK, lowcore, int_clock);
 	OFFSET(__LC_MCCK_CLOCK, lowcore, mcck_clock);
 	OFFSET(__LC_CURRENT, lowcore, current_task);
-	OFFSET(__LC_THREAD_INFO, lowcore, thread_info);
 	OFFSET(__LC_KERNEL_STACK, lowcore, kernel_stack);
 	OFFSET(__LC_ASYNC_STACK, lowcore, async_stack);
 	OFFSET(__LC_PANIC_STACK, lowcore, panic_stack);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index c51650a1ed16..1becf48d914f 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -123,7 +123,7 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 	.macro	LAST_BREAK scratch
 	srag	\scratch,%r10,23
 	jz	.+10
-	stg	%r10,__TI_last_break(%r12)
+	stg	%r10,__TASK_TI_last_break(%r12)
 	.endm
 
 	.macro REENABLE_IRQS
@@ -185,14 +185,13 @@ ENTRY(__switch_to)
 	stmg	%r6,%r15,__SF_GPRS(%r15)	# store gprs of prev task
 	lgr	%r1,%r2
 	aghi	%r1,__TASK_thread		# thread_struct of prev task
-	lg	%r5,__TASK_thread_info(%r3)	# get thread_info of next
+	lg	%r5,__TASK_stack(%r3)		# start of kernel stack of next
 	stg	%r15,__THREAD_ksp(%r1)		# store kernel stack of prev
 	lgr	%r1,%r3
 	aghi	%r1,__TASK_thread		# thread_struct of next task
 	lgr	%r15,%r5
 	aghi	%r15,STACK_INIT			# end of kernel stack of next
 	stg	%r3,__LC_CURRENT		# store task struct of next
-	stg	%r5,__LC_THREAD_INFO		# store thread info of next
 	stg	%r15,__LC_KERNEL_STACK		# store end of kernel stack
 	lg	%r15,__THREAD_ksp(%r1)		# load kernel stack of next
 	/* c4 is used in guest detection: arch/s390/kernel/perf_cpum_sf.c */
@@ -271,7 +270,7 @@ ENTRY(system_call)
 .Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	lghi	%r14,_PIF_SYSCALL
 .Lsysc_per:
 	lg	%r15,__LC_KERNEL_STACK
@@ -285,7 +284,7 @@ ENTRY(system_call)
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
-	lg	%r10,__TI_sysc_table(%r12)	# address of system call table
+	lg	%r10,__TASK_TI_sysc_table(%r12)	# address of system call table
 	llgh	%r8,__PT_INT_CODE+2(%r11)
 	slag	%r8,%r8,2			# shift and test for svc 0
 	jnz	.Lsysc_nr_ok
@@ -300,7 +299,7 @@ ENTRY(system_call)
 	stg	%r2,__PT_ORIG_GPR2(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
 	lgf	%r9,0(%r8,%r10)			# get system call add.
-	TSTMSK	__TI_flags(%r12),_TIF_TRACE
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_TRACE
 	jnz	.Lsysc_tracesys
 	basr	%r14,%r9			# call sys_xxxx
 	stg	%r2,__PT_R2(%r11)		# store return value
@@ -310,7 +309,7 @@ ENTRY(system_call)
 .Lsysc_tif:
 	TSTMSK	__PT_FLAGS(%r11),_PIF_WORK
 	jnz	.Lsysc_work
-	TSTMSK	__TI_flags(%r12),_TIF_WORK
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_WORK
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
@@ -330,17 +329,17 @@ ENTRY(system_call)
 .Lsysc_work:
 	TSTMSK	__LC_CPU_FLAGS,_CIF_MCCK_PENDING
 	jo	.Lsysc_mcck_pending
-	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lsysc_reschedule
 #ifdef CONFIG_UPROBES
-	TSTMSK	__TI_flags(%r12),_TIF_UPROBE
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_UPROBE
 	jo	.Lsysc_uprobe_notify
 #endif
 	TSTMSK	__PT_FLAGS(%r11),_PIF_PER_TRAP
 	jo	.Lsysc_singlestep
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lsysc_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lsysc_notify_resume
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsysc_vxrs
@@ -386,7 +385,7 @@ ENTRY(system_call)
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL
 	jno	.Lsysc_return
 	lmg	%r2,%r7,__PT_R2(%r11)	# load svc arguments
-	lg	%r10,__TI_sysc_table(%r12)	# address of system call table
+	lg	%r10,__TASK_TI_sysc_table(%r12)	# address of system call table
 	lghi	%r8,0			# svc 0 returns -ENOSYS
 	llgh	%r1,__PT_INT_CODE+2(%r11)	# load new svc number
 	cghi	%r1,NR_syscalls
@@ -443,7 +442,7 @@ ENTRY(system_call)
 	basr	%r14,%r9		# call sys_xxx
 	stg	%r2,__PT_R2(%r11)	# store return value
 .Lsysc_tracenogo:
-	TSTMSK	__TI_flags(%r12),_TIF_TRACE
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_TRACE
 	jz	.Lsysc_return
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	larl	%r14,.Lsysc_return
@@ -454,7 +453,7 @@ ENTRY(system_call)
 #
 ENTRY(ret_from_fork)
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	brasl	%r14,schedule_tail
 	TRACE_IRQS_ON
 	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
@@ -475,7 +474,7 @@ ENTRY(pgm_check_handler)
 	stpt	__LC_SYNC_ENTER_TIMER
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_PGM_OLD_PSW
 	tmhh	%r8,0x0001		# test problem state bit
@@ -498,7 +497,7 @@ ENTRY(pgm_check_handler)
 2:	LAST_BREAK %r14
 	UPDATE_VTIME %r14,%r15,__LC_SYNC_ENTER_TIMER
 	lg	%r15,__LC_KERNEL_STACK
-	lg	%r14,__TI_task(%r12)
+	lgr	%r14,%r12
 	aghi	%r14,__TASK_thread	# pointer to thread_struct
 	lghi	%r13,__LC_PGM_TDB
 	tm	__LC_PGM_ILC+2,0x02	# check for transaction abort
@@ -564,7 +563,7 @@ ENTRY(io_int_handler)
 	stpt	__LC_ASYNC_ENTER_TIMER
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
@@ -595,7 +594,7 @@ ENTRY(io_int_handler)
 	LOCKDEP_SYS_EXIT
 	TRACE_IRQS_ON
 .Lio_tif:
-	TSTMSK	__TI_flags(%r12),_TIF_WORK
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_WORK
 	jnz	.Lio_work		# there is work to do (signals etc.)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lio_work
@@ -623,9 +622,9 @@ ENTRY(io_int_handler)
 	jo	.Lio_work_user		# yes -> do resched & signal
 #ifdef CONFIG_PREEMPT
 	# check for preemptive scheduling
-	icm	%r0,15,__TI_precount(%r12)
+	icm	%r0,15,__TASK_TI_precount(%r12)
 	jnz	.Lio_restore		# preemption is disabled
-	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_NEED_RESCHED
 	jno	.Lio_restore
 	# switch to kernel stack
 	lg	%r1,__PT_R15(%r11)
@@ -659,11 +658,11 @@ ENTRY(io_int_handler)
 .Lio_work_tif:
 	TSTMSK	__LC_CPU_FLAGS,_CIF_MCCK_PENDING
 	jo	.Lio_mcck_pending
-	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lio_reschedule
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lio_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
+	TSTMSK	__TASK_TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lio_notify_resume
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lio_vxrs
@@ -738,7 +737,7 @@ ENTRY(ext_int_handler)
 	stpt	__LC_ASYNC_ENTER_TIMER
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
@@ -883,7 +882,7 @@ ENTRY(mcck_int_handler)
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
 	lg	%r10,__LC_LAST_BREAK
-	lg	%r12,__LC_THREAD_INFO
+	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_MCK_OLD_PSW
 	TSTMSK	__LC_MCCK_CODE,MCCK_CODE_SYSTEM_DAMAGE
@@ -1100,7 +1099,7 @@ cleanup_critical:
 	lg	%r9,16(%r11)
 	srag	%r9,%r9,23
 	jz	0f
-	mvc	__TI_last_break(8,%r12),16(%r11)
+	mvc	__TASK_TI_last_break(8,%r12),16(%r11)
 0:	# set up saved register r11
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r9,STACK_FRAME_OVERHEAD(%r15)
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index 03c2b469c472..a46201d2ed07 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -32,10 +32,9 @@ ENTRY(startup_continue)
 #
 # Setup stack
 #
-	larl	%r15,init_thread_union
-	stg	%r15,__LC_THREAD_INFO	# cache thread info in lowcore
-	lg	%r14,__TI_task(%r15)	# cache current in lowcore
+	larl	%r14,init_task
 	stg	%r14,__LC_CURRENT
+	larl	%r15,init_thread_union
 	aghi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union + THREAD_SIZE
 	stg	%r15,__LC_KERNEL_STACK	# set end of kernel stack
 	aghi	%r15,-160
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 7f7ba5f23f13..6bb266003495 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -329,8 +329,7 @@ static void __init setup_lowcore(void)
 	lc->panic_stack = (unsigned long)
 		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0)
 		+ PAGE_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs);
-	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
-	lc->thread_info = (unsigned long) &init_thread_union;
+	lc->current_task = (unsigned long)&init_task;
 	lc->lpp = LPP_MAGIC;
 	lc->machine_flags = S390_lowcore.machine_flags;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35531fe1c5ea..8c7ab7bd3e10 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -263,7 +263,6 @@ static void pcpu_attach_task(struct pcpu *pcpu, struct task_struct *tsk)
 
 	lc->kernel_stack = (unsigned long) task_stack_page(tsk)
 		+ THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs);
-	lc->thread_info = (unsigned long) task_thread_info(tsk);
 	lc->current_task = (unsigned long) tsk;
 	lc->lpp = LPP_MAGIC;
 	lc->current_pid = tsk->pid;
-- 
2.8.4
