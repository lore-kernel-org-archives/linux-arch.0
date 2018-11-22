From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 05/18] microblaze: function_graph: Simplify with function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:06 -0500
Message-ID: <20181122003332.061738282@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Michal Simek <monstr@monstr.eu>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have microblaze use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Michal Simek <monstr@monstr.eu>
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/microblaze/kernel/ftrace.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/microblaze/kernel/ftrace.c b/arch/microblaze/kernel/ftrace.c
index d57563c58a26..224eea40e1ee 100644
--- a/arch/microblaze/kernel/ftrace.c
+++ b/arch/microblaze/kernel/ftrace.c
@@ -22,8 +22,7 @@
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	int faulted, err;
-	struct ftrace_graph_ent trace;
+	int faulted;
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
@@ -63,18 +62,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0, NULL);
-	if (err == -EBUSY) {
+	if (function_graph_enter(old, self_addr, 0, NULL))
 		*parent = old;
-		return;
-	}
-
-	trace.func = self_addr;
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
-		*parent = old;
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
2.19.1
