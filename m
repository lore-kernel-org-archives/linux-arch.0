Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266686AbUHMSQS@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41118 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266545AbUHMSQS
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 14:16:18 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id i7DIGGGm134174
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 18:16:16 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i7DIGGcL068862
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:16:16 +0200
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1Bvgbg-0000WI-00
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:16:48 +0200
Date: Fri, 13 Aug 2004 20:16:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] cputime (6/7): introduce timeslices timer.
Message-ID: <20040813181648.GG1862@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[PATCH] cputime (6/7): introduce timeslices timer.

From: Jan Glauber <jan.glauber@de.ibm.com>

This patch changes the scheduler to enable the architecture to 
implement time slices by a timer. 

To achieve this we change the time slice type to cputime_t,
split up scheduler_tick() into various functions and add hooks
for start/stop of the time slice timers.

There is a generic implementation that implements the old jiffies-based 
functionality and an implementation for s390 that uses virtual CPU timers
for time slices. The patch introduces no overhead for the generic 
implementation.

The patch is useful for Linux running on a virtual machines where time
slices based on real time may be completely wrong. 

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Kconfig             |    7 +
 arch/s390/kernel/Makefile     |    1 
 arch/s390/kernel/timeslice.c  |   82 ++++++++++++++
 arch/s390/kernel/vtime.c      |   38 ++++--
 include/asm-generic/cputime.h |    1 
 include/asm-s390/cputime.h    |    1 
 include/asm-s390/system.h     |    9 +
 include/asm-s390/timer.h      |    5 
 include/linux/init_task.h     |    1 
 include/linux/sched.h         |    4 
 kernel/sched.c                |  240 +++++++++++++++++++++++++++---------------
 kernel/timer.c                |    1 
 mm/oom_kill.c                 |    2 
 13 files changed, 293 insertions(+), 99 deletions(-)

diff -urN linux-2.6.8-rc4/arch/s390/Kconfig linux-2.6.8-cputime/arch/s390/Kconfig
--- linux-2.6.8-rc4/arch/s390/Kconfig	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/arch/s390/Kconfig	Fri Aug 13 19:05:31 2004
@@ -298,6 +298,13 @@
 	  Select this option to use CPU timer deltas to do user
 	  process accounting.
 
+config VIRT_CPU_TIMESLICES
+        bool "Base process time slices on virtual cpu timer"
+        depends on VIRT_TIMER
+        help
+          Select this option to use virtual CPU time for the
+          process time slices.
+
 config APPLDATA_BASE
 	bool "Linux - VM Monitor Stream, base infrastructure"
 	depends on PROC_FS && VIRT_TIMER=y
diff -urN linux-2.6.8-rc4/arch/s390/kernel/Makefile linux-2.6.8-cputime/arch/s390/kernel/Makefile
--- linux-2.6.8-rc4/arch/s390/kernel/Makefile	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/arch/s390/kernel/Makefile	Fri Aug 13 19:05:31 2004
@@ -24,6 +24,7 @@
 obj-$(CONFIG_ARCH_S390X)	+= entry64.o reipl64.o
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
+obj-$(CONFIG_VIRT_CPU_TIMESLICES) += timeslice.o
 
 #
 # This is just to get the dependencies...
diff -urN linux-2.6.8-rc4/arch/s390/kernel/timeslice.c linux-2.6.8-cputime/arch/s390/kernel/timeslice.c
--- linux-2.6.8-rc4/arch/s390/kernel/timeslice.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-cputime/arch/s390/kernel/timeslice.c	Fri Aug 13 19:05:31 2004
@@ -0,0 +1,82 @@
+/*
+ *  arch/s390/kernel/timelice.c
+ *    Architecture specific task timeslice handling.
+ *
+ *  S390 version
+ *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Jan Glauber <jan.glauber@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <asm/timer.h>
+
+DEFINE_PER_CPU(struct vtimer_list, cpu_timeslice);
+
+/**
+ * Stop the virtual time slice timer of the current process.
+ */
+void arch_stop_timeslice(void)
+{
+        struct vtimer_list *vtimer;
+
+	/**
+	 * No timer is running for idle.
+	 */
+	if (idle_cpu(smp_processor_id()))
+		return;
+
+        vtimer =  &__get_cpu_var(cpu_timeslice);
+
+	/**
+	 * Delete the virtual timer, get the remaining time slice
+	 * and store it into the time_slice field.
+	 */
+	del_virt_timer(vtimer);
+	current->time_slice = vtimer->expires >> 12;
+}
+
+/**
+ * Start the virtual time slice timer of the current process.
+ */
+void arch_start_timeslice(void)
+{
+        struct vtimer_list *vtimer;
+
+	/**
+	 * Don't start a timer for idle.
+	 */
+	if (idle_cpu(smp_processor_id()))
+		return;
+
+        vtimer =  &__get_cpu_var(cpu_timeslice);
+	if (current->time_slice)
+		vtimer->expires = current->time_slice << 12;
+	else
+		vtimer->expires = jiffies_to_cputime(1) << 12;
+	add_virt_timer(vtimer);
+}
+
+void virtual_timeslice_callback(unsigned long data, struct pt_regs *regs)
+{
+        /* idle should never expire */
+        BUG_ON(idle_cpu(smp_processor_id()));
+	
+	/* we can use the p->time_slice value because we didn't decrement
+	 * it, so the programmed time_slice is still in there 
+	 */
+	reduce_timeslice(current, current->time_slice);	
+}
+
+void init_cpu_timeslice(void)
+{
+	struct vtimer_list *vtimer;
+
+	vtimer = &__get_cpu_var(cpu_timeslice);
+	init_virt_timer(vtimer);
+	vtimer->function = virtual_timeslice_callback;
+}
diff -urN linux-2.6.8-rc4/arch/s390/kernel/vtime.c linux-2.6.8-cputime/arch/s390/kernel/vtime.c
--- linux-2.6.8-rc4/arch/s390/kernel/vtime.c	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/arch/s390/kernel/vtime.c	Fri Aug 13 19:05:31 2004
@@ -243,6 +243,8 @@
 		/* re-charge interval timer, we have to add the offset */
 		if (event->interval)
 			event->expires = event->interval + vt_list->offset;
+		else
+			event->expires = 0; 
 
 		/* move expired timer to the callback queue */
 		list_move_tail(&event->entry, &cb_list);
@@ -288,11 +290,6 @@
 	return 0;
 }
 
-static inline int vtimer_pending(struct vtimer_list *timer)
-{
-	return (!list_empty(&timer->entry));
-}
-
 /*
  * this function should only run on the specified CPU
  */
@@ -477,33 +474,49 @@
 {
 	unsigned long flags;
 	struct vtimer_queue *vt_list;
+        __u64 temp;
+	int rc;
 
 	if (check_vtimer(timer)) {
 		printk("del_virt_timer: timer not initialized\n");
 		return -EINVAL;
 	}
 
-	/* check if timer is pending */
-	if (!vtimer_pending(timer))
-		return 0;
-
 	vt_list = &per_cpu(virt_cpu_timer, timer->cpu);
 	spin_lock_irqsave(&vt_list->lock, flags);
 
+	/* check if timer is pending */
+	if (!vtimer_pending(timer)) {
+		rc = 0;
+		goto out;
+	}
+
 	/* we don't interrupt a running timer, just let it expire! */
 	list_del_init(&timer->entry);
 
+        /* save progress */
+        asm volatile ("STPT %0" : "=m" (temp));
+
+	temp = (vt_list->to_expire - temp) + vt_list->offset;
+	if (timer->expires > temp)
+		timer->expires -= temp;
+	else
+		timer->expires = 0;
+
 	/* last timer removed */
 	if (list_empty(&vt_list->list)) {
 		vt_list->to_expire = 0;
 		vt_list->offset = 0;
 	}
-
+	rc = 1;
+out:
 	spin_unlock_irqrestore(&vt_list->lock, flags);
-	return 1;
+	return rc;
 }
 EXPORT_SYMBOL(del_virt_timer);
 
+extern void init_cpu_timeslice(void);
+
 /*
  * Start the virtual CPU timer on the current CPU.
  */
@@ -528,6 +541,9 @@
 	vt_list->offset = 0;
 	vt_list->idle = 0;
 
+#ifdef CONFIG_VIRT_CPU_TIMESLICES
+	init_cpu_timeslice();
+#endif
 }
 
 static int vtimer_idle_notify(struct notifier_block *self,
diff -urN linux-2.6.8-rc4/include/asm-generic/cputime.h linux-2.6.8-cputime/include/asm-generic/cputime.h
--- linux-2.6.8-rc4/include/asm-generic/cputime.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/asm-generic/cputime.h	Fri Aug 13 19:05:31 2004
@@ -10,6 +10,7 @@
 #define cputime_max			((~0UL >> 1) - 1)
 #define cputime_add(__a, __b)		((__a) +  (__b))
 #define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_halve(__a)		((__a) >> 1)
 #define cputime_eq(__a, __b)		((__a) == (__b))
 #define cputime_gt(__a, __b)		((__a) >  (__b))
 #define cputime_ge(__a, __b)		((__a) >= (__b))
diff -urN linux-2.6.8-rc4/include/asm-s390/cputime.h linux-2.6.8-cputime/include/asm-s390/cputime.h
--- linux-2.6.8-rc4/include/asm-s390/cputime.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/asm-s390/cputime.h	Fri Aug 13 19:05:31 2004
@@ -40,6 +40,7 @@
 #define cputime_max			((~0UL >> 1) - 1)
 #define cputime_add(__a, __b)		((__a) +  (__b))
 #define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_halve(__a)		((__a) >> 1)
 #define cputime_eq(__a, __b)		((__a) == (__b))
 #define cputime_gt(__a, __b)		((__a) >  (__b))
 #define cputime_ge(__a, __b)		((__a) >= (__b))
diff -urN linux-2.6.8-rc4/include/asm-s390/system.h linux-2.6.8-cputime/include/asm-s390/system.h
--- linux-2.6.8-rc4/include/asm-s390/system.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/asm-s390/system.h	Fri Aug 13 19:05:31 2004
@@ -128,6 +128,15 @@
 
 #endif
 
+#ifdef CONFIG_VIRT_CPU_TIMESLICES
+
+#define __ARCH_HAS_TIMESLICE_TIMER
+
+extern void arch_stop_timeslice(void);
+extern void arch_start_timeslice(void);
+
+#endif
+
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
diff -urN linux-2.6.8-rc4/include/asm-s390/timer.h linux-2.6.8-cputime/include/asm-s390/timer.h
--- linux-2.6.8-rc4/include/asm-s390/timer.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/asm-s390/timer.h	Fri Aug 13 19:05:31 2004
@@ -43,6 +43,9 @@
 extern int mod_virt_timer(struct vtimer_list *timer, __u64 expires);
 extern int del_virt_timer(struct vtimer_list *timer);
 
-int stop_timers(void);
+static inline int vtimer_pending(struct vtimer_list *timer)
+{
+	return (!list_empty(&timer->entry));
+}
 
 #endif
diff -urN linux-2.6.8-rc4/include/linux/init_task.h linux-2.6.8-cputime/include/linux/init_task.h
--- linux-2.6.8-rc4/include/linux/init_task.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/linux/init_task.h	Fri Aug 13 19:05:31 2004
@@ -78,7 +78,6 @@
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
-	.time_slice	= HZ,						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
diff -urN linux-2.6.8-rc4/include/linux/sched.h linux-2.6.8-cputime/include/linux/sched.h
--- linux-2.6.8-rc4/include/linux/sched.h	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/include/linux/sched.h	Fri Aug 13 19:05:31 2004
@@ -170,6 +170,7 @@
 extern void trap_init(void);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
+extern void reduce_timeslice(struct task_struct *p, cputime_t elapsed);
 extern unsigned long cache_decay_ticks;
 
 /* Attach to any functions which should be ignored in wchan output. */
@@ -408,7 +409,8 @@
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
+	cputime_t time_slice, child_time_slice; 
+	unsigned int first_time_slice;
 
 	struct list_head tasks;
 	/*
diff -urN linux-2.6.8-rc4/kernel/sched.c linux-2.6.8-cputime/kernel/sched.c
--- linux-2.6.8-rc4/kernel/sched.c	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/kernel/sched.c	Fri Aug 13 19:06:17 2004
@@ -254,6 +254,13 @@
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+#ifndef __ARCH_HAS_TIMESLICE_TIMER
+
+#define arch_stop_timeslice()	do { } while (0)
+#define arch_start_timeslice()	do { } while (0)
+
+#endif
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -871,6 +878,8 @@
  */
 void fastcall sched_fork(task_t *p)
 {
+	cputime_t split;
+
 	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
@@ -896,27 +905,33 @@
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-	p->time_slice = (current->time_slice + 1) >> 1;
+	arch_stop_timeslice();
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
+	split = cputime_halve(current->time_slice);
 	p->first_time_slice = 1;
-	current->time_slice >>= 1;
+	p->time_slice = cputime_sub(current->time_slice, split);
+	current->time_slice = split;
+	arch_start_timeslice();
 	p->timestamp = sched_clock();
-	if (!current->time_slice) {
+#ifndef __ARCH_HAS_TIMESLICE_TIMER
+	if (unlikely(cputime_eq(current->time_slice, cputime_zero))) {
 		/*
 		 * This case is rare, it happens when the parent has only
 		 * a single jiffy left from its timeslice. Taking the
 		 * runqueue lock is not a problem.
 		 */
-		current->time_slice = 1;
 		preempt_disable();
-		scheduler_tick();
+		reduce_timeslice(p, cputime_zero);
 		local_irq_enable();
 		preempt_enable();
 	} else
 		local_irq_enable();
+#else
+	local_irq_enable();
+#endif
 }
 
 /*
@@ -975,11 +990,12 @@
 	runqueue_t *rq;
 
 	local_irq_save(flags);
-	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
-	}
+	if (p == current)
+		arch_stop_timeslice();
+	if (p->first_time_slice)
+		p->parent->child_time_slice =
+			cputime_add(p->parent->child_time_slice,
+				    p->time_slice);
 	local_irq_restore(flags);
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
@@ -1027,6 +1043,7 @@
 	 */
 	prev_task_flags = prev->flags;
 	finish_arch_switch(rq, prev);
+	arch_start_timeslice();
 	if (mm)
 		mmdrop(mm);
 	if (unlikely(prev_task_flags & PF_DEAD))
@@ -1955,6 +1972,24 @@
 
 EXPORT_PER_CPU_SYMBOL(kstat);
 
+static inline void reload_timeslice(struct task_struct *p)
+{
+        int ts; 
+                        
+        ts = task_timeslice(p);
+ 
+        p->time_slice = jiffies_to_cputime(ts);
+	if (!cputime_eq(p->child_time_slice, cputime_zero)) {
+		cputime_t max_slice = jiffies_to_cputime(MAX_TIMESLICE);
+		p->time_slice = cputime_add(p->time_slice,
+					    p->child_time_slice);
+		if (unlikely(cputime_gt(p->time_slice, max_slice)))
+			p->time_slice = max_slice;
+		p->child_time_slice = cputime_zero;
+	}
+        p->first_time_slice = 0;
+}
+
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -1972,6 +2007,110 @@
 			((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
+ * Timeslice is expired (either after a tick or after a timer). 
+ * Reload it. We don't need to add it here, this is done later 
+ * by schedule().
+ */
+static inline void timeslice_expired(struct task_struct *p, struct runqueue *rq)
+{               
+        /*
+         * The task was running during this tick - update the
+         * time slice counter. Note: we do not update a thread's
+         * priority until it either goes to sleep or uses up its
+         * timeslice. This makes it possible for interactive tasks
+         * to use up their timeslices at their highest priority levels.
+         */
+        if (unlikely(rt_task(p))) {
+                /*
+                 * RR tasks need a special form of timeslice management.
+                 * FIFO tasks have no timeslices.
+                 */
+                if (p->policy == SCHED_RR) {
+                        reload_timeslice(p);
+                        set_tsk_need_resched(p);
+
+                        /* put it at the end of the queue: */
+                        dequeue_task(p, rq->active);
+                        enqueue_task(p, rq->active);
+                }
+                return;
+        }
+
+        dequeue_task(p, rq->active);
+        set_tsk_need_resched(p);
+        p->prio = effective_prio(p);
+	reload_timeslice(p);
+
+        if (!rq->expired_timestamp)
+        	rq->expired_timestamp = jiffies;
+        if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+        	enqueue_task(p, rq->expired);
+                if (p->static_prio < rq->best_expired_prio)
+                	rq->best_expired_prio = p->static_prio;
+        } else
+        	enqueue_task(p, rq->active);
+}
+
+void reduce_timeslice(struct task_struct *p, cputime_t elapsed)
+{
+        struct runqueue *rq;
+
+        rq = this_rq();
+	if (p == rq->idle)
+		return;
+        spin_lock(&rq->lock);
+
+        /* Task might have expired already, but not scheduled off yet */
+        if (p->array != rq->active) {
+                set_tsk_need_resched(p);
+                goto out_unlock;
+        }
+
+        if (rt_task(p) && (p->policy == SCHED_FIFO))
+                goto out_unlock;
+
+        if (cputime_ge(elapsed, p->time_slice)) {
+                p->time_slice = cputime_zero;
+                timeslice_expired(p, rq);
+        } else
+                p->time_slice = cputime_sub(p->time_slice, elapsed);
+
+        /* XXX interactive stuff makes no sense for virtual timeslices */
+#ifndef __ARCH_HAS_TIMESLICE_TIMER
+	/*
+	 * Prevent a too long timeslice allowing a task to monopolize
+	 * the CPU. We do this by splitting up the timeslice into
+	 * smaller pieces.
+	 *
+	 * Note: this does not mean the task's timeslices expire or
+	 * get lost in any way, they just might be preempted by
+	 * another task of equal priority. (one with higher
+	 * priority would have preempted this task already.) We
+	 * requeue this task to the end of the list on this priority
+	 * level, which is in essence a round-robin of tasks with
+	 * equal priority.
+	 *
+	 * This only applies to tasks in the interactive
+	 * delta range with at least TIMESLICE_GRANULARITY to requeue.
+	 */
+	if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+		cputime_to_jiffies(p->time_slice)) % 
+		TIMESLICE_GRANULARITY(p)) &&
+		(cputime_to_jiffies(p->time_slice) >= 
+		TIMESLICE_GRANULARITY(p)) &&
+		(p->array == rq->active)) {
+
+		dequeue_task(p, rq->active);
+		set_tsk_need_resched(p);
+		p->prio = effective_prio(p);
+		enqueue_task(p, rq->active);
+	}
+#endif
+out_unlock:
+        spin_unlock(&rq->lock);
+}
+
+/*
  * Do the virtual cpu time signal calculations.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user space since the last update
@@ -2136,79 +2275,8 @@
 	}
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
-		set_tsk_need_resched(p);
-		goto out;
-	}
-	spin_lock(&rq->lock);
-	/*
-	 * The task was running during this tick - update the
-	 * time slice counter. Note: we do not update a thread's
-	 * priority until it either goes to sleep or uses up its
-	 * timeslice. This makes it possible for interactive tasks
-	 * to use up their timeslices at their highest priority levels.
-	 */
-	if (unlikely(rt_task(p))) {
-		/*
-		 * RR tasks need a special form of timeslice management.
-		 * FIFO tasks have no timeslices.
-		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
-			set_tsk_need_resched(p);
-
-			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
-		}
-		goto out_unlock;
-	}
-	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+	if (p->array != rq->active)
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
-
-		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
-		} else
-			enqueue_task(p, rq->active);
-	} else {
-		/*
-		 * Prevent a too long timeslice allowing a task to monopolize
-		 * the CPU. We do this by splitting up the timeslice into
-		 * smaller pieces.
-		 *
-		 * Note: this does not mean the task's timeslices expire or
-		 * get lost in any way, they just might be preempted by
-		 * another task of equal priority. (one with higher
-		 * priority would have preempted this task already.) We
-		 * requeue this task to the end of the list on this priority
-		 * level, which is in essence a round-robin of tasks with
-		 * equal priority.
-		 *
-		 * This only applies to tasks in the interactive
-		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
-		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
-
-			dequeue_task(p, rq->active);
-			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
-		}
-	}
-out_unlock:
-	spin_unlock(&rq->lock);
 out:
 	rebalance_tick(cpu, rq, NOT_IDLE);
 }
@@ -2269,7 +2337,8 @@
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
+		if (((cputime_to_jiffies(smt_curr->time_slice) * 
+			(100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(p) || rt_task(smt_curr)) &&
 			p->mm && smt_curr->mm && !rt_task(p))
 				ret = 1;
@@ -2279,7 +2348,8 @@
 		 * or wake it up if it has been put to sleep for priority
 		 * reasons.
 		 */
-		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
+		if ((((cputime_to_jiffies(p->time_slice) * 
+			(100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(smt_curr) || rt_task(p)) &&
 			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
@@ -2418,6 +2488,7 @@
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
+		arch_stop_timeslice();
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3410,6 +3481,7 @@
 #else
 	idle->thread_info->preempt_count = 0;
 #endif
+	idle->time_slice = jiffies_to_cputime(HZ);
 }
 
 /*
diff -urN linux-2.6.8-rc4/kernel/timer.c linux-2.6.8-cputime/kernel/timer.c
--- linux-2.6.8-rc4/kernel/timer.c	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/kernel/timer.c	Fri Aug 13 19:05:31 2004
@@ -803,6 +803,7 @@
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_tick);
 	scheduler_tick();
+	reduce_timeslice(current, jiffies_to_cputime(1));
 }
 
 /*
diff -urN linux-2.6.8-rc4/mm/oom_kill.c linux-2.6.8-cputime/mm/oom_kill.c
--- linux-2.6.8-rc4/mm/oom_kill.c	Fri Aug 13 19:05:52 2004
+++ linux-2.6.8-cputime/mm/oom_kill.c	Fri Aug 13 19:05:31 2004
@@ -149,7 +149,7 @@
 	 * all the memory it needs. That way it should be able to
 	 * exit() and clear out its resources quickly...
 	 */
-	p->time_slice = HZ;
+	p->time_slice = jiffies_to_cputime(HZ);
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
