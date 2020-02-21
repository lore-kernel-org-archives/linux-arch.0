From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 11/27] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Fri, 21 Feb 2020 14:34:27 +0100
Message-ID: <20200221134215.673793889@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgBUNup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

To facilitate tracers that need RCU, add some helpers to wrap the
magic required.

The problem is that we can call into tracers (trace events and
function tracing) while RCU isn't watching and this can happen from
any context, including NMI.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -175,6 +175,35 @@ do { \
 #error "Unknown RCU implementation specified to kernel configuration"
 #endif
 
+/**
+ * trace_rcu_enter - Force RCU to be active, for code that needs RCU readers
+ *
+ * Very similar to RCU_NONIDLE() above.
+ *
+ * Tracing can happen while RCU isn't active yet, for instance in the idle loop
+ * between rcu_idle_enter() and rcu_idle_exit(), or early in exception entry.
+ * RCU will happily ignore any read-side critical sections in this case.
+ *
+ * This function ensures that RCU is aware hereafter and the code can readily
+ * rely on RCU read-side critical sections working as expected.
+ *
+ * This function is NMI safe -- provided in_nmi() is correct and will nest up-to
+ * INT_MAX/2 times.
+ */
+static inline int trace_rcu_enter(void)
+{
+	int state = !rcu_is_watching();
+	if (state)
+		rcu_irq_enter_irqsave();
+	return state;
+}
+
+static inline void trace_rcu_exit(int state)
+{
+	if (state)
+		rcu_irq_exit_irqsave();
+}
+
 /*
  * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
  * are needed for dynamic initialization and destruction of rcu_head
