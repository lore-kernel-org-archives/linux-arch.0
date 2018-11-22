From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 04/18] arm64: function_graph: Simplify with
 function_graph_entry()
Date: Wed, 21 Nov 2018 19:28:05 -0500
Message-ID: <20181122003331.917870132@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Will Deacon <will.deacon@arm.com>, stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Joel Fernandes <joel@joelfernandes.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph_entry() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have arm64 use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/ftrace.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 50986e388d2b..57e962290df3 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -216,8 +216,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -229,18 +227,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-	if (err == -EBUSY)
-		return;
-	else
+	if (!function_graph_enter(old, self_addr, frame_pointer, NULL))
 		*parent = return_hooker;
 }
 
-- 
2.19.1
