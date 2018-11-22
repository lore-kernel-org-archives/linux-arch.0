From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 09/18] powerpc/function_graph: Simplify with function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:10 -0500
Message-ID: <20181122003332.643482042@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have powerpc use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/kernel/trace/ftrace.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4bf051d3e21e..b65c8a34ad6e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -950,7 +950,6 @@ int ftrace_disable_ftrace_graph_caller(void)
  */
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 {
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -961,18 +960,8 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	trace.func = ip;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-
-	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
-				     NULL) == -EBUSY)
-		goto out;
-
-	parent = return_hooker;
+	if (!function_graph_enter(parent, ip, 0, NULL))
+		parent = return_hooker;
 out:
 	return parent;
 }
-- 
2.19.1
