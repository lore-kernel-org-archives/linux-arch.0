From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 08/18] parisc: function_graph: Simplify with function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:09 -0500
Message-ID: <20181122003332.500796758@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have parisc use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/parisc/kernel/ftrace.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 6fa8535d3cce..e46a4157a894 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -30,7 +30,6 @@ static void __hot prepare_ftrace_return(unsigned long *parent,
 					unsigned long self_addr)
 {
 	unsigned long old;
-	struct ftrace_graph_ent trace;
 	extern int parisc_return_to_handler;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -41,19 +40,9 @@ static void __hot prepare_ftrace_return(unsigned long *parent,
 
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-        if (ftrace_push_return_trace(old, self_addr, &trace.depth,
-				     0, NULL) == -EBUSY)
-                return;
-
-	/* activate parisc_return_to_handler() as return point */
-	*parent = (unsigned long) &parisc_return_to_handler;
+	if (!function_graph_enter(old, self_addr, 0, NULL))
+		/* activate parisc_return_to_handler() as return point */
+		*parent = (unsigned long) &parisc_return_to_handler;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
2.19.1
