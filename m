From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 14/18] function_graph: Make ftrace_push_return_trace() static
Date: Wed, 21 Nov 2018 19:28:15 -0500
Message-ID: <20181122003333.445140997@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As all architectures now call function_graph_enter() to do the entry work,
no architecture should ever call ftrace_push_return_trace(). Make it static.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               | 3 ---
 kernel/trace/trace_functions_graph.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 5717e8f81c59..dd16e8218db3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -776,9 +776,6 @@ struct ftrace_ret_stack {
  */
 extern void return_to_handler(void);
 
-extern int
-ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
-			 unsigned long frame_pointer, unsigned long *retp);
 extern int
 function_graph_enter(unsigned long ret, unsigned long func,
 		     unsigned long frame_pointer, unsigned long *retp);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 28f2602435d0..88ca787a1cdc 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -118,7 +118,7 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
 
 /* Add a function return address to the trace stack on thread info.*/
-int
+static int
 ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
-- 
2.19.1
