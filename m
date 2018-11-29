From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Date: Wed, 28 Nov 2018 23:24:30 -0500
Message-ID: <20181128232430.425f8b12@vmware.local.home>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
        <20181128160021.09acd1af@gandalf.local.home>
        <20181128222936.74da7f54@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128222936.74da7f54@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Nov 2018 22:29:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Does this patch fix it for you?

Take 2. I realized that the reason for the interrupts being traced is
because it is more likely to interrupt when the depth is already 0,
setting it to 1 causing the interrupt to think it's already in a
function  that wants to be traced (when that wasn't decided yet).

The fix uses a bit that gets set when we want to trace (and will trace
till that bit is cleared). That bit gets cleared on the return
function when depth is zero. But if we are tracing something in a
interrupt that happened to interrupt the beginning of a function that
already set the depth to 0, then we need to clear the bit at depth of 1
not zero (and 2 if we want to trace a function that interrupted a
softirq, that interrupted a start of normal function. and 3 if we want
to trace an NMI function that had the very unlikely case of
interrupting a start of a interrupt function, that interrupted the
start of a softirq function, that interrupted a start of a normal
context function!).

If that happens then we will continue to trace functions when we don't
want to. To solve that, I need to record the depth (0-3) when the bit
is set, and clear it when the return function is at that same depth
(0-3).

-- Steve

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b8c0e24ab30..447bd96ee658 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -512,12 +512,44 @@ enum {
  * can only be modified by current, we can reuse trace_recursion.
  */
 	TRACE_IRQ_BIT,
+
+	/* Set if the function is in the set_graph_function file */
+	TRACE_GRAPH_BIT,
+
+	/*
+	 * In the very unlikely case that an interrupt came in
+	 * at a start of graph tracing, and we want to trace
+	 * the function in that interrupt, the depth can be greater
+	 * than zero, because of the preempted start of a previous
+	 * trace. In an even more unlikely case, depth could be 2
+	 * if a softirq interrupted the start of graph tracing,
+	 * followed by an interrupt preempting a start of graph
+	 * tracing in the softirq, and depth can even be 3
+	 * if an NMI came in at the start of an interrupt function
+	 * that preempted a softirq start of a function that
+	 * preempted normal context!!!! Luckily, it can't be
+	 * greater than 3, so the next two bits are a mask
+	 * of what the depth is when we set TRACE_GRAPH_BIT
+	 */
+
+	TRACE_GRAPH_DEPTH_START_BIT,
+	TRACE_GRAPH_DEPTH_END_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
 #define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
 #define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
 
+#define trace_recursion_depth() \
+	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
+#define trace_recursion_set_depth(depth) \
+	do {								\
+		current->trace_recursion &=				\
+			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
+		current->trace_recursion |=				\
+			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
+	} while (0)
+
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
@@ -843,8 +875,9 @@ extern void __trace_graph_return(struct trace_array *tr,
 extern struct ftrace_hash *ftrace_graph_hash;
 extern struct ftrace_hash *ftrace_graph_notrace_hash;
 
-static inline int ftrace_graph_addr(unsigned long addr)
+static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
+	unsigned long addr = trace->func;
 	int ret = 0;
 
 	preempt_disable_notrace();
@@ -855,6 +888,14 @@ static inline int ftrace_graph_addr(unsigned long addr)
 	}
 
 	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+
+		/*
+		 * This needs to be cleared on the return functions
+		 * when the depth is zero.
+		 */
+		trace_recursion_set(TRACE_GRAPH_BIT);
+		trace_recursion_set_depth(trace->depth);
+
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
 		 * is set, and called by an interrupt handler, we still
@@ -872,6 +913,13 @@ static inline int ftrace_graph_addr(unsigned long addr)
 	return ret;
 }
 
+static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+{
+	if (trace_recursion_test(TRACE_GRAPH_BIT) &&
+	    trace->depth == trace_recursion_depth())
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+}
+
 static inline int ftrace_graph_notrace_addr(unsigned long addr)
 {
 	int ret = 0;
@@ -885,7 +933,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 	return ret;
 }
 #else
-static inline int ftrace_graph_addr(unsigned long addr)
+static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
 	return 1;
 }
@@ -894,6 +942,8 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 {
 	return 0;
 }
+static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
+{ }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 extern unsigned int fgraph_max_depth;
@@ -901,7 +951,8 @@ extern unsigned int fgraph_max_depth;
 static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 {
 	/* trace it when it is-nested-in or is a function enabled. */
-	return !(trace->depth || ftrace_graph_addr(trace->func)) ||
+	return !(trace_recursion_test(TRACE_GRAPH_BIT) ||
+		 ftrace_graph_addr(trace)) ||
 		(trace->depth < 0) ||
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2561460d7baf..086af4f5c3e8 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -509,6 +509,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	int cpu;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -532,6 +534,8 @@ void set_graph_array(struct trace_array *tr)
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 {
+	ftrace_graph_addr_finish(trace);
+
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index b7357f9f82a3..98ea6d28df15 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,6 +208,8 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index a86b303e6c67..7d04b9890755 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -270,6 +270,8 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	ftrace_graph_addr_finish(trace);
+
 	if (!func_prolog_preempt_disable(tr, &data, &pc))
 		return;
 
