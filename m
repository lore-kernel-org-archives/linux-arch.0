From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 01/18] function_graph: Create function_graph_enter() to consolidate
 architecture code
Date: Wed, 21 Nov 2018 19:28:02 -0500
Message-ID: <20181122003331.479176746@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently all the architectures do basically the same thing in preparing the
function graph tracer on entry to a function. This code can be pulled into a
generic location and then this will allow the function graph tracer to be
fixed, as well as extended.

Create a new function graph helper function_graph_enter() that will call the
hook function (ftrace_graph_entry) and the shadow stack operation
(ftrace_push_return_trace), and remove the need of the architecture code to
manage the shadow stack.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               |  3 +++
 kernel/trace/trace_functions_graph.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a397907e8d72..5717e8f81c59 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -779,6 +779,9 @@ extern void return_to_handler(void);
 extern int
 ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 			 unsigned long frame_pointer, unsigned long *retp);
+extern int
+function_graph_enter(unsigned long ret, unsigned long func,
+		     unsigned long frame_pointer, unsigned long *retp);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 169b3c44ee97..28f2602435d0 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -182,6 +182,22 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 	return 0;
 }
 
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp)
+{
+	struct ftrace_graph_ent trace;
+
+	trace.func = func;
+	trace.depth = current->curr_ret_stack + 1;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		return -EBUSY;
+
+	return ftrace_push_return_trace(ret, func, &trace.depth,
+					frame_pointer, retp);
+}
+
 /* Retrieve a function return address to the trace stack on thread info.*/
 static void
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-- 
2.19.1
