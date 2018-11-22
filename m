From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 12/18] sh/function_graph: Simplify with function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:13 -0500
Message-ID: <20181122003333.106149216@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have superh use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sh/kernel/ftrace.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 96dd9f7da250..1b04270e5460 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -321,8 +321,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	int faulted, err;
-	struct ftrace_graph_ent trace;
+	int faulted;
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -365,18 +364,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0, NULL);
-	if (err == -EBUSY) {
+	if (function_graph_enter(old, self_addr, 0, NULL))
 		__raw_writel(old, parent);
-		return;
-	}
-
-	trace.func = self_addr;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
-		__raw_writel(old, parent);
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.19.1
