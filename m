From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 5/6] sh: ftrace: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Date: Mon, 10 Dec 2018 14:30:12 -0500
Message-ID: <20181210193335.284057850@goodmis.org>
References: <20181210193007.655970639@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[
  Folks, I'm working on rewriting the function graph tracer. In order to
  do so, some changes need to be done that affect architecture specific
  code. I'm only able to compile test these changes. I would like to
  have folks check out my repo and give them a test.

    git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  ftrace/core

  Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4
]

The structure of the ret_stack array on the task struct is going to
change, and accessing it directly via the curr_ret_stack index will no
longer give the ret_stack entry that holds the return address. To access
that, architectures must now use ftrace_graph_get_ret_stack() to get the
associated ret_stack that matches the saved return address.

Cc: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/sh/kernel/dumpstack.c | 11 +++++++----
 arch/sh/kernel/dwarf.c     |  9 +++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index b564b1eae4ae..2c2e151bf39e 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -59,17 +59,20 @@ print_ftrace_graph_addr(unsigned long addr, void *data,
 			struct thread_info *tinfo, int *graph)
 {
 	struct task_struct *task = tinfo->task;
+	struct ftrace_ret_stack *ret_stack;
 	unsigned long ret_addr;
-	int index = task->curr_ret_stack;
 
 	if (addr != (unsigned long)return_to_handler)
 		return;
 
-	if (!task->ret_stack || index < *graph)
+	if (!task->ret_stack)
 		return;
 
-	index -= *graph;
-	ret_addr = task->ret_stack[index].ret;
+	ret_stack = ftrace_graph_get_ret_stack(task, *graph);
+	if (!ret_stack)
+		return;
+
+	ret_addr = ret_stack->ret;
 
 	ops->address(data, ret_addr, 1);
 
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bb511e2d9d68..df0fd6efe758 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -608,17 +608,18 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * expected to find the real return address.
 	 */
 	if (pc == (unsigned long)&return_to_handler) {
-		int index = current->curr_ret_stack;
+		struct ftrace_ret_stack *ret_stack;
 
+		ret_stack = ftrace_graph_get_ret_stack(current, 0);
+		if (ret_stack)
+			pc = ret_stack->ret;
 		/*
 		 * We currently have no way of tracking how many
 		 * return_to_handler()'s we've seen. If there is more
 		 * than one patched return address on our stack,
 		 * complain loudly.
 		 */
-		WARN_ON(index > 0);
-
-		pc = current->ret_stack[index].ret;
+		WARN_ON(ftrace_graph_get_ret_stack(current, 1);
 	}
 #endif
 
-- 
2.19.1
