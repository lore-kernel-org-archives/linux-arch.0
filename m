From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 06/18] MIPS: function_graph: Simplify with function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:07 -0500
Message-ID: <20181122003332.209589047@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have MIPS use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/mips/kernel/ftrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdbc3657..b122cbb4aad1 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -322,7 +322,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 			   unsigned long fp)
 {
 	unsigned long old_parent_ra;
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
 	int faulted, insns;
@@ -369,12 +368,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	if (unlikely(faulted))
 		goto out;
 
-	if (ftrace_push_return_trace(old_parent_ra, self_ra, &trace.depth, fp,
-				     NULL) == -EBUSY) {
-		*parent_ra_addr = old_parent_ra;
-		return;
-	}
-
 	/*
 	 * Get the recorded ip of the current mcount calling site in the
 	 * __mcount_loc section, which will be used to filter the function
@@ -382,13 +375,10 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	 */
 
 	insns = core_kernel_text(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
-	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
+	self_ra -= (MCOUNT_INSN_SIZE * insns);
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
+	if (function_graph_enter(old_parent_ra, self_ra, fp, NULL))
 		*parent_ra_addr = old_parent_ra;
-	}
 	return;
 out:
 	ftrace_graph_stop();
-- 
2.19.1
