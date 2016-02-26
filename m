From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/20] cpu/hotplug: Add tracepoints
Date: Fri, 26 Feb 2016 18:43:27 -0000
Message-ID: <20160226182340.593563875@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33358 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422839AbcBZSox (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 13:44:53 -0500
Content-Disposition: inline; filename=hotplug--Add-tracepoints.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

We want to trace the hotplug machinery. Add tracepoints to track the
invocation of callbacks and their result.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/trace/events/cpuhp.h |   66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

Index: b/include/trace/events/cpuhp.h
===================================================================
--- /dev/null
+++ b/include/trace/events/cpuhp.h
@@ -0,0 +1,66 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cpuhp
+
+#if !defined(_TRACE_CPUHP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CPUHP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(cpuhp_enter,
+
+	TP_PROTO(unsigned int cpu,
+		 int target,
+		 int idx,
+		 int (*fun)(unsigned int)),
+
+	TP_ARGS(cpu, target, idx, fun),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	cpu		)
+		__field( int,		target		)
+		__field( int,		idx		)
+		__field( void *,	fun		)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->target	= target;
+		__entry->idx	= idx;
+		__entry->fun	= fun;
+	),
+
+	TP_printk("cpu: %04u target: %3d step: %3d (%pf)",
+		  __entry->cpu, __entry->target, __entry->idx, __entry->fun)
+);
+
+TRACE_EVENT(cpuhp_exit,
+
+	TP_PROTO(unsigned int cpu,
+		 int state,
+		 int idx,
+		 int ret),
+
+	TP_ARGS(cpu, state, idx, ret),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	cpu		)
+		__field( int,		state		)
+		__field( int,		idx		)
+		__field( int,		ret		)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->state	= state;
+		__entry->idx	= idx;
+		__entry->ret	= ret;
+	),
+
+	TP_printk(" cpu: %04u  state: %3d step: %3d ret: %d",
+		  __entry->cpu, __entry->state, __entry->idx,  __entry->ret)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
