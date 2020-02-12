From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/8] rcu: Rename rcu_irq_{enter,exit}_irqson()
Date: Wed, 12 Feb 2020 10:32:11 +0100
Message-ID: <20200212094107.667649246@infradead.org>
References: <20200212093210.468391728@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgBLJnp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

The functions do in fact use local_irq_{save,restore}() and can
therefore be used when IRQs are in fact disabled. Worse, they are
already used in places where IRQs are disabled, leading to great
confusion when reading the code.

Rename them to fix this confusion.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rcupdate.h   |    4 ++--
 include/linux/rcutiny.h    |    4 ++--
 include/linux/rcutree.h    |    4 ++--
 include/linux/tracepoint.h |    4 ++--
 kernel/cpu_pm.c            |    4 ++--
 kernel/rcu/tree.c          |    8 ++++----
 kernel/trace/trace.c       |    4 ++--
 7 files changed, 16 insertions(+), 16 deletions(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -120,9 +120,9 @@ static inline void rcu_init_nohz(void) {
  */
 #define RCU_NONIDLE(a) \
 	do { \
-		rcu_irq_enter_irqson(); \
+		rcu_irq_enter_irqsave(); \
 		do { a; } while (0); \
-		rcu_irq_exit_irqson(); \
+		rcu_irq_exit_irqsave(); \
 	} while (0)
 
 /*
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -68,8 +68,8 @@ static inline int rcu_jiffies_till_stall
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
 static inline void rcu_irq_enter(void) { }
-static inline void rcu_irq_exit_irqson(void) { }
-static inline void rcu_irq_enter_irqson(void) { }
+static inline void rcu_irq_exit_irqsave(void) { }
+static inline void rcu_irq_enter_irqsave(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -46,8 +46,8 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
-void rcu_irq_enter_irqson(void);
-void rcu_irq_exit_irqson(void);
+void rcu_irq_enter_irqsave(void);
+void rcu_irq_exit_irqsave(void);
 
 void exit_rcu(void);
 
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -181,7 +181,7 @@ static inline struct tracepoint *tracepo
 		 */							\
 		if (rcuidle) {						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
+			rcu_irq_enter_irqsave();			\
 		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
@@ -195,7 +195,7 @@ static inline struct tracepoint *tracepo
 		}							\
 									\
 		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
+			rcu_irq_exit_irqsave();				\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -24,10 +24,10 @@ static int cpu_pm_notify(enum cpu_pm_eve
 	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
 	 * RCU know this.
 	 */
-	rcu_irq_enter_irqson();
+	rcu_irq_enter_irqsave();
 	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
 		nr_to_call, nr_calls);
-	rcu_irq_exit_irqson();
+	rcu_irq_exit_irqsave();
 
 	return notifier_to_errno(ret);
 }
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -699,10 +699,10 @@ void rcu_irq_exit(void)
 /*
  * Wrapper for rcu_irq_exit() where interrupts are enabled.
  *
- * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
+ * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_exit_irqson(void)
+void rcu_irq_exit_irqsave(void)
 {
 	unsigned long flags;
 
@@ -875,10 +875,10 @@ void rcu_irq_enter(void)
 /*
  * Wrapper for rcu_irq_enter() where interrupts are enabled.
  *
- * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
+ * If you add or remove a call to rcu_irq_enter_irqsave(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_enter_irqson(void)
+void rcu_irq_enter_irqsave(void)
 {
 	unsigned long flags;
 
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3004,9 +3004,9 @@ void __trace_stack(struct trace_array *t
 	if (unlikely(in_nmi()))
 		return;
 
-	rcu_irq_enter_irqson();
+	rcu_irq_enter_irqsave();
 	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
-	rcu_irq_exit_irqson();
+	rcu_irq_exit_irqsave();
 }
 
 /**
