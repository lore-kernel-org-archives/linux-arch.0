Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLVOF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:05 -0500
Message-ID: <20200212210749.971717428@infradead.org>
Date: Wed, 12 Feb 2020 22:01:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212210142.ipRzqjRGOqEyo30N9Wp-0mgepEUZUXYiBjU_oTE4by0@z>

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
 include/linux/hardirq.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -89,4 +89,52 @@ extern void irq_exit(void);
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
+#define __TR_IRQ	1
+#define __TR_NMI	2
+
+#define trace_rcu_enter()					\
+({								\
+	unsigned long state = 0;				\
+	if (!rcu_is_watching())	{				\
+		if (in_nmi()) {					\
+			state = __TR_NMI;			\
+			rcu_nmi_enter();			\
+		} else {					\
+			state = __TR_IRQ;			\
+			rcu_irq_enter_irqsave();		\
+		}						\
+	}							\
+	state;							\
+})
+
+#define trace_rcu_exit(state)					\
+do {								\
+	switch (state) {					\
+	case __TR_IRQ:						\
+		rcu_irq_exit_irqsave();				\
+		break;						\
+	case __TR_NMI:						\
+		rcu_nmi_exit();					\
+		break;						\
+	default:						\
+		break;						\
+	}							\
+} while (0)
+
 #endif /* LINUX_HARDIRQ_H */
