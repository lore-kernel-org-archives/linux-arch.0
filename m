From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface for RCU changes
Date: Wed, 12 Feb 2020 22:01:45 +0100
Message-ID: <20200212210750.142334759@infradead.org>
References: <20200212210139.382424693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, "Steven Rostedt (VMware)" <rosted@goodmis.org>
List-Id: linux-arch.vger.kernel.org

The tracepoint interface will stop providing regular RCU context; make
sure we do it ourselves, since perf makes use of regular RCU protected
data.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	unsigned long rcu_flags;
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
 
+	rcu_flags = trace_rcu_enter();
+
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
@@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
 	}
 
 	perf_swevent_put_recursion_context(rctx);
+
+	trace_rcu_exit(rcu_flags);
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
