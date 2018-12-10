From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
Date: Mon, 10 Dec 2018 14:30:13 -0500
Message-ID: <20181210193335.417173167@goodmis.org>
References: <20181210193007.655970639@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
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

Cc: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/perf_callchain.c |  2 +-
 arch/arm64/kernel/process.c        |  2 +-
 arch/arm64/kernel/return_address.c |  2 +-
 arch/arm64/kernel/stacktrace.c     | 12 +++++++-----
 arch/arm64/kernel/time.c           |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..1b792b46604e 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -164,7 +164,7 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, callchain_trace, entry);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d6dd8b..37a66394b07d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -459,7 +459,7 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.fp = thread_saved_fp(p);
 	frame.pc = thread_saved_pc(p);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = p->curr_ret_stack;
+	frame.graph = 0;
 #endif
 	do {
 		if (unwind_frame(p, &frame))
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 933adbc0f654..53c40196b607 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -44,7 +44,7 @@ void *return_address(unsigned int level)
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.pc = (unsigned long)return_address; /* dummy */
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, save_return_addr, &data);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 7723dadf25be..1a29f2695ff2 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -59,15 +59,17 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
-		if (WARN_ON_ONCE(frame->graph == -1))
-			return -EINVAL;
+		struct ftrace_ret_stack *ret_stack;
 		/*
 		 * This is a case where function graph tracer has
 		 * modified a return address (LR) in a stack frame
 		 * to hook a function return.
 		 * So replace it to an original value.
 		 */
-		frame->pc = tsk->ret_stack[frame->graph--].ret;
+		ret_stack = ftrace_graph_get_ret_stack(tsk, frame->graph++);
+		if (WARN_ON_ONCE(!ret_stack))
+			return -EINVAL;
+		frame->pc = ret_stack->ret;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
@@ -134,7 +136,7 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(current, &frame, save_trace, &data);
@@ -165,7 +167,7 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		frame.pc = (unsigned long)__save_stack_trace;
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	walk_stackframe(tsk, &frame, save_trace, &data);
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index f258636273c9..a777ae90044d 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -52,7 +52,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	frame.fp = regs->regs[29];
 	frame.pc = regs->pc;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
+	frame.graph = 0;
 #endif
 	do {
 		int ret = unwind_frame(NULL, &frame);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5f4d9acb32f5..49ebf3771391 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -122,7 +122,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = thread_saved_pc(tsk);
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
+	frame.graph = 0;
 #endif
 
 	skip = !!regs;
-- 
2.19.1
