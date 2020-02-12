Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgBLVOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:14 -0500
Message-ID: <20200212210750.142334759@infradead.org>
Date: Wed, 12 Feb 2020 22:01:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface for RCU changes
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, "Steven Rostedt (VMware)" <rosted@goodmis.org>
Message-ID: <20200212210145.bjKdK83fBgc5b_yxqKFZ3Ef7skvHoAkEb3A5R74Ge5E@z>

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
 
