Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfC2DWz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Mar 2019 23:22:55 -0400
Message-ID: <20190329032253.106797533@goodmis.org>
Date: Thu, 28 Mar 2019 19:05:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH 2/4 v2] tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
References: <20190328230512.486297455@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20190328230514.e2SgSVofgcNxB8etvLHih2YvCYkthZ1IVfkMH9t-m4s@z>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The only users that calls syscall_get_arguments() with a variable and not a
hard coded '6' is ftrace_syscall_enter(). syscall_get_arguments() can be
optimized by removing a variable input, and always grabbing 6 arguments
regardless of what the system call actually uses.

Change ftrace_syscall_enter() to pass the 6 args into a local stack array
and copy the necessary arguments into the trace event as needed.

This is needed to remove two parameters from syscall_get_arguments().

Link: http://lkml.kernel.org/r/20161107213233.627583542@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d2db27..e9f5bbbad6d9 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -314,6 +314,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	unsigned long irq_flags;
+	unsigned long args[6];
 	int pc;
 	int syscall_nr;
 	int size;
@@ -347,7 +348,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args, entry->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
@@ -583,6 +585,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
 	struct hlist_head *head;
+	unsigned long args[6];
 	bool valid_prog_array;
 	int syscall_nr;
 	int rctx;
@@ -613,8 +616,8 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
-			       (unsigned long *)&rec->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
-- 
2.20.1
