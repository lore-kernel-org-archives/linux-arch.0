From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Date: Wed, 12 Feb 2020 22:01:48 +0100
Message-ID: <20200212210750.312024711@infradead.org>
References: <20200212210139.382424693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:19 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

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
 
