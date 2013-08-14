From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 4/5] sched: Create more preempt_count accessors
Date: Wed, 14 Aug 2013 15:15:43 +0200
Message-ID: <20130814133142.809665605@chello.nl>
References: <20130814131539.790947874@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-task_preempt_count.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

We need a few special preempt_count accessors:
 - task_preempt_count() for when we're interested in the preemption
   count of another (non-running) task.
 - init_task_preempt_count() for properly initializing the preemption
   count.
 - init_idle_preempt_count() a special case of the above for the idle
   threads.

With these no generic code ever touches thread_info::preempt_count
anymore and architectures could choose to remove it.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-ko6tuved7x9y0t08qxhhnubz@git.kernel.org
---
 include/asm-generic/preempt.h |   14 ++++++++++++++
 include/trace/events/sched.h  |    2 +-
 kernel/sched/core.c           |    7 +++----
 3 files changed, 18 insertions(+), 5 deletions(-)

--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -17,4 +17,18 @@ static __always_inline int *preempt_coun
 	return &current_thread_info()->preempt_count;
 }
 
+/*
+ * must be macros to avoid header recursion hell
+ */
+#define task_preempt_count(p) \
+	(task_thread_info(p)->preempt_count & ~PREEMPT_NEED_RESCHED)
+
+#define init_task_preempt_count(p) do { \
+	task_thread_info(p)->preempt_count = 1 | PREEMPT_NEED_RESCHED; \
+} while (0)
+
+#define init_idle_preempt_count(p, cpu) do { \
+	task_thread_info(p)->preempt_count = 0; \
+} while (0)
+
 #endif /* __ASM_PREEMPT_H */
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -103,7 +103,7 @@ static inline long __trace_sched_switch_
 	/*
 	 * For all intents and purposes a preempted task is a running task.
 	 */
-	if (task_thread_info(p)->preempt_count & PREEMPT_ACTIVE)
+	if (task_preempt_count(p) & PREEMPT_ACTIVE)
 		state = TASK_RUNNING | TASK_STATE_MAX;
 #endif
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -996,7 +996,7 @@ void set_task_cpu(struct task_struct *p,
 	 * ttwu() will sort out the placement.
 	 */
 	WARN_ON_ONCE(p->state != TASK_RUNNING && p->state != TASK_WAKING &&
-			!(task_thread_info(p)->preempt_count & PREEMPT_ACTIVE));
+			!(task_preempt_count(p) & PREEMPT_ACTIVE));
 
 #ifdef CONFIG_LOCKDEP
 	/*
@@ -1737,8 +1737,7 @@ void sched_fork(struct task_struct *p)
 	p->on_cpu = 0;
 #endif
 #ifdef CONFIG_PREEMPT_COUNT
-	/* Want to start with kernel preemption disabled. */
-	task_thread_info(p)->preempt_count = 1;
+	init_task_preempt_count(p);
 #endif
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
@@ -4225,7 +4224,7 @@ void init_idle(struct task_struct *idle,
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
-	task_thread_info(idle)->preempt_count = 0;
+	init_idle_preempt_count(idle, cpu);
 
 	/*
 	 * The idle tasks have their own, simple scheduling class:
