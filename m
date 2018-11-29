From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Date: Wed, 28 Nov 2018 22:29:36 -0500
Message-ID: <20181128222936.74da7f54@vmware.local.home>
References: <20181122002801.501220343@goodmis.org>
        <20181128203931.ym2rkya7a6agzzy3@redhat.com>
        <20181128160021.09acd1af@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128160021.09acd1af@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Nov 2018 16:00:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Nov 2018 15:39:31 -0500
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
> > Hi Steve,
> > 
> > With your ftrace/urgent branch linked above, if I try a quick
> > function_graph test like the following:
> > 
> >   SYSFS=/sys/kernel/debug/tracing
> > 
> >   echo 0 > "$SYSFS/tracing_on"
> >   echo cmdline_proc_show > "$SYSFS/set_graph_function"
> >   echo function_graph > "$SYSFS/current_tracer"
> >   echo 1 > "$SYSFS/tracing_on"
> > 
> > I see a bunch of scheduler interrupt functions in the trace/trace_pipe
> > without even invoking cmdline_proc_show().
> > 
> > This tests works as expected with Linux 4.20-rc3 though:
> > 
> >   % cat /sys/kernel/debug/tracing/trace_pipe
> >    2)               |  cmdline_proc_show() {
> >    2)   0.320 us    |    seq_puts();
> >    2)   0.030 us    |    seq_putc();
> >    2)   1.352 us    |  }
> > 
> > Operator error, or did the patchset break something?  
> 
> Nope, that does seem to be a bug :-/
>

Does this patch fix it for you?

-- Steve

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b8c0e24ab30..1c8f4aa7020e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -512,6 +512,9 @@ enum {
  * can only be modified by current, we can reuse trace_recursion.
  */
 	TRACE_IRQ_BIT,
+
+	/* Set if the function is in the set_graph_function file */
+	TRACE_GRAPH_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
@@ -855,6 +858,8 @@ static inline int ftrace_graph_addr(unsigned long addr)
 	}
 
 	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+
+		trace_recursion_set(TRACE_GRAPH_BIT);
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
 		 * is set, and called by an interrupt handler, we still
@@ -901,7 +906,8 @@ extern unsigned int fgraph_max_depth;
 static inline bool ftrace_graph_ignore_func(struct ftrace_graph_ent *trace)
 {
 	/* trace it when it is-nested-in or is a function enabled. */
-	return !(trace->depth || ftrace_graph_addr(trace->func)) ||
+	return !(trace_recursion_test(TRACE_GRAPH_BIT) ||
+		 ftrace_graph_addr(trace->func)) ||
 		(trace->depth < 0) ||
 		(fgraph_max_depth && trace->depth >= fgraph_max_depth);
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2561460d7baf..69fbb6225637 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -509,6 +509,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	int cpu;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -532,6 +535,8 @@ void set_graph_array(struct trace_array *tr)
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace)
 {
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
 	if (tracing_thresh &&
 	    (trace->rettime - trace->calltime < tracing_thresh))
 		return;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index b7357f9f82a3..b20bf076ce7f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,6 +208,9 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index a86b303e6c67..069867f4eae6 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -270,6 +270,9 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace)
 	unsigned long flags;
 	int pc;
 
+	if (!trace->depth)
+		trace_recursion_clear(TRACE_GRAPH_BIT);
+
 	if (!func_prolog_preempt_disable(tr, &data, &pc))
 		return;
 
