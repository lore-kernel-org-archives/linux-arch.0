From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 18/18] function_graph: Have profiler use curr_ret_stack and not depth
Date: Wed, 21 Nov 2018 19:28:19 -0500
Message-ID: <20181122003334.014794329@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The profiler uses trace->depth to find its entry on the ret_stack, but the
depth may not match the actual location of where its entry is (if an
interrupt were to preempt the processing of the profiler for another
function, the depth and the curr_ret_stack will be different).

Have it use the curr_ret_stack as the index to find its ret_stack entry
instead of using the depth variable, as that is no longer guaranteed to be
the same.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 48513954713c..77734451cb05 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -817,7 +817,7 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
-	int index = trace->depth;
+	int index = current->curr_ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -852,7 +852,7 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	if (!fgraph_graph_time) {
 		int index;
 
-		index = trace->depth;
+		index = current->curr_ret_stack;
 
 		/* Append this call time to the parent time to subtract */
 		if (index)
-- 
2.19.1
