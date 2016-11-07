From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][ATCH 2/3] tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
Date: Mon, 07 Nov 2016 16:26:36 -0500
Message-ID: <20161107213233.627583542@goodmis.org>
References: <20161107212634.529267342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-tracing-syscalls-Pass-in-hardcoded-6-into-syscall_ge.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

The only users that calls syscall_get_arguments() with a variable and not a
hard coded '6' is ftrace_syscall_enter(). syscall_get_arguments() can be
optimized by removing a variable input, and always grabbing 6 arguments
regardless of what the system call actually uses.

Change ftrace_syscall_enter() to pass the 6 args into a local stack array
and copy the necessary arguments into the trace event as needed.

This is needed to remove two parameters from syscall_get_arguments().

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 5e10395da88e..52c1503cedfa 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -313,6 +313,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	unsigned long irq_flags;
+	unsigned long args[6];
 	int pc;
 	int syscall_nr;
 	int size;
@@ -346,7 +347,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args, entry->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
@@ -564,6 +566,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
 	struct hlist_head *head;
+	unsigned long args[6];
 	int syscall_nr;
 	int rctx;
 	int size;
@@ -592,8 +595,9 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
-			       (unsigned long *)&rec->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
+
 	perf_trace_buf_submit(rec, size, rctx,
 			      sys_data->enter_event->event.type, 1, regs,
 			      head, NULL);
-- 
2.9.3
