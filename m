From: tip-bot for Frederic Weisbecker <fweisbec@gmail.com>
Subject: [tip:perf/urgent] perf: Take a hot regs snapshot for trace events
Date: Wed, 10 Mar 2010 15:37:32 GMT
Message-ID: <tip-c530665c31c0140b74ca7689e7f836177796e5bd@git.kernel.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	  paulus@samba.org, acme@redhat.com, peterz@infradead.org,
	  fweisbec@gmail.com, rostedt@goodmis.org, jbaron@redhat.com,
	  tglx@linutronix.de, mhiramat@redhat.com,
	  linux-arch@vger.kernel.org, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48159 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682Ab0CJPiU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Mar 2010 10:38:20 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: acme@redhat.com, paulus@samba.org, hpa@zytor.com, mingo@redhat.com, peterz@infradead.org, fweisbec@gmail.com, rostedt@goodmis.org, jbaron@redhat.com, tglx@linutronix.de, linux-arch@vger.kernel.org, mhiramat@redhat.com, mingo@elte.hu

Commit-ID:  c530665c31c0140b74ca7689e7f836177796e5bd
Gitweb:     http://git.kernel.org/tip/c530665c31c0140b74ca7689e7f836177796e5bd
Author:     Frederic Weisbecker <fweisbec@gmail.com>
AuthorDate: Wed, 3 Mar 2010 07:16:16 +0100
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Wed, 10 Mar 2010 14:40:38 +0100

perf: Take a hot regs snapshot for trace events

We are taking a wrong regs snapshot when a trace event triggers.
Either we use get_irq_regs(), which gives us the interrupted
registers if we are in an interrupt, or we use task_pt_regs()
which gives us the state before we entered the kernel, assuming
we are lucky enough to be no kernel thread, in which case
task_pt_regs() returns the initial set of regs when the kernel
thread was started.

What we want is different. We need a hot snapshot of the regs,
so that we can get the instruction pointer to record in the
sample, the frame pointer for the callchain, and some other
things.

Let's use the new perf_fetch_caller_regs() for that.

Comparison with perf record -e lock: -R -a -f -g
Before:

        perf  [kernel]                   [k] __do_softirq
               |
               --- __do_softirq
                  |
                  |--55.16%-- __open
                  |
                   --44.84%-- __write_nocancel

After:

            perf  [kernel]           [k] perf_tp_event
               |
               --- perf_tp_event
                  |
                  |--41.07%-- lock_acquire
                  |          |
                  |          |--39.36%-- _raw_spin_lock
                  |          |          |
                  |          |          |--7.81%-- hrtimer_interrupt
                  |          |          |          smp_apic_timer_interrupt
                  |          |          |          apic_timer_interrupt

The old case was producing unreliable callchains. Now having
right frame and instruction pointers, we have the trace we
want.

Also syscalls and kprobe events already have the right regs,
let's use them instead of wasting a retrieval.

v2: Follow the rename perf_save_regs() -> perf_fetch_caller_regs()

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Jason Baron <jbaron@redhat.com>
Cc: Archs <linux-arch@vger.kernel.org>
---
 include/linux/ftrace_event.h       |    7 +++++--
 include/trace/ftrace.h             |    6 +++++-
 kernel/perf_event.c                |    8 ++------
 kernel/trace/trace_event_profile.c |    3 ++-
 kernel/trace/trace_kprobe.c        |    5 +++--
 kernel/trace/trace_syscalls.c      |    4 ++--
 6 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/ftrace_event.h b/include/linux/ftrace_event.h
index 6b7c444..ac424f1 100644
--- a/include/linux/ftrace_event.h
+++ b/include/linux/ftrace_event.h
@@ -187,6 +187,9 @@ do {									\
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
+
+DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
+
 extern int ftrace_profile_enable(int event_id);
 extern void ftrace_profile_disable(int event_id);
 extern int ftrace_profile_set_filter(struct perf_event *event, int event_id,
@@ -198,11 +201,11 @@ ftrace_perf_buf_prepare(int size, unsigned short type, int *rctxp,
 
 static inline void
 ftrace_perf_buf_submit(void *raw_data, int size, int rctx, u64 addr,
-		       u64 count, unsigned long irq_flags)
+		       u64 count, unsigned long irq_flags, struct pt_regs *regs)
 {
 	struct trace_entry *entry = raw_data;
 
-	perf_tp_event(entry->type, addr, count, raw_data, size);
+	perf_tp_event(entry->type, addr, count, raw_data, size, regs);
 	perf_swevent_put_recursion_context(rctx);
 	local_irq_restore(irq_flags);
 }
diff --git a/include/trace/ftrace.h b/include/trace/ftrace.h
index 0804cd5..f31bb8b 100644
--- a/include/trace/ftrace.h
+++ b/include/trace/ftrace.h
@@ -764,6 +764,7 @@ ftrace_profile_templ_##call(struct ftrace_event_call *event_call,	\
 	struct ftrace_raw_##call *entry;				\
 	u64 __addr = 0, __count = 1;					\
 	unsigned long irq_flags;					\
+	struct pt_regs *__regs;						\
 	int __entry_size;						\
 	int __data_size;						\
 	int rctx;							\
@@ -784,8 +785,11 @@ ftrace_profile_templ_##call(struct ftrace_event_call *event_call,	\
 									\
 	{ assign; }							\
 									\
+	__regs = &__get_cpu_var(perf_trace_regs);			\
+	perf_fetch_caller_regs(__regs, 2);				\
+									\
 	ftrace_perf_buf_submit(entry, __entry_size, rctx, __addr,	\
-			       __count, irq_flags);			\
+			       __count, irq_flags, __regs);		\
 }
 
 #undef DEFINE_EVENT
diff --git a/kernel/perf_event.c b/kernel/perf_event.c
index 359d7f6..45b4b6e 100644
--- a/kernel/perf_event.c
+++ b/kernel/perf_event.c
@@ -4318,9 +4318,8 @@ static const struct pmu perf_ops_task_clock = {
 #ifdef CONFIG_EVENT_TRACING
 
 void perf_tp_event(int event_id, u64 addr, u64 count, void *record,
-			  int entry_size)
+		   int entry_size, struct pt_regs *regs)
 {
-	struct pt_regs *regs = get_irq_regs();
 	struct perf_sample_data data;
 	struct perf_raw_record raw = {
 		.size = entry_size,
@@ -4330,12 +4329,9 @@ void perf_tp_event(int event_id, u64 addr, u64 count, void *record,
 	perf_sample_data_init(&data, addr);
 	data.raw = &raw;
 
-	if (!regs)
-		regs = task_pt_regs(current);
-
 	/* Trace events already protected against recursion */
 	do_perf_sw_event(PERF_TYPE_TRACEPOINT, event_id, count, 1,
-				&data, regs);
+			 &data, regs);
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
diff --git a/kernel/trace/trace_event_profile.c b/kernel/trace/trace_event_profile.c
index f0d6930..e66d21e 100644
--- a/kernel/trace/trace_event_profile.c
+++ b/kernel/trace/trace_event_profile.c
@@ -2,13 +2,14 @@
  * trace event based perf counter profiling
  *
  * Copyright (C) 2009 Red Hat Inc, Peter Zijlstra <pzijlstr@redhat.com>
- *
+ * Copyright (C) 2009-2010 Frederic Weisbecker <fweisbec@gmail.com>
  */
 
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include "trace.h"
 
+DEFINE_PER_CPU(struct pt_regs, perf_trace_regs);
 
 static char *perf_trace_buf;
 static char *perf_trace_buf_nmi;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 505c922..f7a20a8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1240,7 +1240,7 @@ static __kprobes void kprobe_profile_func(struct kprobe *kp,
 	for (i = 0; i < tp->nr_args; i++)
 		entry->args[i] = call_fetch(&tp->args[i].fetch, regs);
 
-	ftrace_perf_buf_submit(entry, size, rctx, entry->ip, 1, irq_flags);
+	ftrace_perf_buf_submit(entry, size, rctx, entry->ip, 1, irq_flags, regs);
 }
 
 /* Kretprobe profile handler */
@@ -1271,7 +1271,8 @@ static __kprobes void kretprobe_profile_func(struct kretprobe_instance *ri,
 	for (i = 0; i < tp->nr_args; i++)
 		entry->args[i] = call_fetch(&tp->args[i].fetch, regs);
 
-	ftrace_perf_buf_submit(entry, size, rctx, entry->ret_ip, 1, irq_flags);
+	ftrace_perf_buf_submit(entry, size, rctx, entry->ret_ip, 1,
+			       irq_flags, regs);
 }
 
 static int probe_profile_enable(struct ftrace_event_call *call)
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index cba47d7..7e6e84f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -467,7 +467,7 @@ static void prof_syscall_enter(struct pt_regs *regs, long id)
 	rec->nr = syscall_nr;
 	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
 			       (unsigned long *)&rec->args);
-	ftrace_perf_buf_submit(rec, size, rctx, 0, 1, flags);
+	ftrace_perf_buf_submit(rec, size, rctx, 0, 1, flags, regs);
 }
 
 int prof_sysenter_enable(struct ftrace_event_call *call)
@@ -542,7 +542,7 @@ static void prof_syscall_exit(struct pt_regs *regs, long ret)
 	rec->nr = syscall_nr;
 	rec->ret = syscall_get_return_value(current, regs);
 
-	ftrace_perf_buf_submit(rec, size, rctx, 0, 1, flags);
+	ftrace_perf_buf_submit(rec, size, rctx, 0, 1, flags, regs);
 }
 
 int prof_sysexit_enable(struct ftrace_event_call *call)
