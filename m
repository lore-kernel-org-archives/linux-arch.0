From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 17/18] function_graph: Reverse the order of pushing the ret_stack and the
 callback
Date: Wed, 21 Nov 2018 19:28:18 -0500
Message-ID: <20181122003333.880108256@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function graph profiler uses the ret_stack to store the "subtime" and
reuse it by nested functions and also on the return. But the current logic
has the profiler callback called before the ret_stack is updated, and it is
just modifying the ret_stack that will later be allocated (it's just lucky
that the "subtime" is not touched when it is allocated).

This could also cause a crash if we are at the end of the ret_stack when
this happens.

By reversing the order of the allocating the ret_stack and then calling the
callbacks attached to a function being traced, the ret_stack entry is no
longer used before it is allocated.

Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4f0d72ae6362..2561460d7baf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -188,15 +188,17 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-
 	if (ftrace_push_return_trace(ret, func,
 				     frame_pointer, retp))
 		goto out;
 
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		goto out_ret;
+
 	return 0;
+ out_ret:
+	current->curr_ret_stack--;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
-- 
2.19.1
