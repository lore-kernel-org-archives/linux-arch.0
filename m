From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 17/27] perf,tracing: Allow function tracing when !RCU
Date: Fri, 21 Feb 2020 14:34:33 +0100
Message-ID: <20200221134216.151419321@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

Since perf is now able to deal with !rcu_is_watching() contexts,
remove the restraint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_event_perf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -477,7 +477,7 @@ static int perf_ftrace_function_register
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->flags   = FTRACE_OPS_FL_RCU;
+	ops->flags   = 0;
 	ops->func    = perf_ftrace_function_call;
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 
