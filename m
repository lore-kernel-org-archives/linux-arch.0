From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 15:47:32 +0100
Message-ID: <20200219150744.832297480@infradead.org>
References: <20200219144724.800607165@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBSPO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:28 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

To facilitate tracers that need RCU, add some helpers to wrap the
magic required.

The problem is that we can call into tracers (trace events and
function tracing) while RCU isn't watching and this can happen from
any context, including NMI.

It is this latter that is causing most of the trouble; we must make
sure in_nmi() returns true before we land in anything tracing,
otherwise we cannot recover.

These helpers are macros because of header-hell; they're placed here
because of the proximity to nmi_{enter,exit{().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/hardirq.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -89,4 +89,36 @@ extern void irq_exit(void);
 		arch_nmi_exit();				\
 	} while (0)
 
+/*
+ * Tracing vs RCU
+ * --------------
+ *
+ * tracepoints and function-tracing can happen when RCU isn't watching (idle,
+ * or early IRQ/NMI entry).
+ *
+ * When it happens during idle or early during IRQ entry, tracing will have
+ * to inform RCU that it ought to pay attention, this is done by calling
+ * rcu_irq_enter_irqsave().
+ *
+ * On NMI entry, we must be very careful that tracing only happens after we've
+ * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
+ * the special path.
+ */
+
+#define trace_rcu_enter()					\
+({								\
+	unsigned long state = 0;				\
+	if (!rcu_is_watching())	{				\
+		rcu_irq_enter_irqsave();			\
+		state = 1;					\
+	}							\
+	state;							\
+})
+
+#define trace_rcu_exit(state)					\
+do {								\
+	if (state)						\
+		rcu_irq_exit_irqsave();				\
+} while (0)
+
 #endif /* LINUX_HARDIRQ_H */
