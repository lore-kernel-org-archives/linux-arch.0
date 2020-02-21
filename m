Return-Path: <SRS0=0XgO=4J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgBUNui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:38 -0500
Message-ID: <20200221134215.730523211@infradead.org>
Date: Fri, 21 Feb 2020 14:34:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 12/27] sched,rcu,tracing: Avoid tracing before in_nmi() is correct
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, "Steven Rostedt (VMware)" <rosted@goodmis.org>
Message-ID: <20200221133428.KbQJjwFJct00E4oveEIwWPGz5kdF9NBpg5dI7xGC184@z>

If we call into a tracer before in_nmi() becomes true, the tracer can
no longer detect it is called from NMI context and behave correctly.

Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
as the normal preempt_count_{add,sub}() have a (desired) function
trace entry.

This fixes a potential issue with current code; AFAICT when the
function-tracer has stack-tracing enabled __trace_stack() will
malfunction when it hits the preempt_count_add() function entry from
NMI context.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/hardirq.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -66,6 +66,15 @@ extern void irq_exit(void);
 #endif
 
 /*
+ * NMI vs Tracing
+ * --------------
+ *
+ * We must not land in a tracer until (or after) we've changed preempt_count
+ * such that in_nmi() becomes true. To that effect all NMI C entry points must
+ * be marked 'notrace' and call nmi_enter() as soon as possible.
+ */
+
+/*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
 #define nmi_enter()						\
@@ -75,7 +84,7 @@ extern void irq_exit(void);
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
-		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET); \
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
 	} while (0)
@@ -85,7 +94,7 @@ extern void irq_exit(void);
 		trace_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
-		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET); \
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
