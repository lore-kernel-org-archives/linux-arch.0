From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST 1/5] thread_info: Port core code to use update_thread_flag() helpers
Date: Fri, 11 May 2018 16:05:00 +0100
Message-ID: <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This patch ports a couple of relevant bits of the core kernel to
use the new update_thread_flag() helpers.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/trace/syscall.h |  6 ++----
 kernel/ptrace.c         | 13 +++++--------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index dc8ac27..dcc9bdf 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -37,10 +37,8 @@ struct syscall_metadata {
 #if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
 static inline void syscall_tracepoint_update(struct task_struct *p)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
-	else
-		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+	update_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT,
+			       test_thread_flag(TIF_SYSCALL_TRACEPOINT));
 }
 #else
 static inline void syscall_tracepoint_update(struct task_struct *p)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73..7a2bd8d 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -785,16 +785,13 @@ static int ptrace_resume(struct task_struct *child, long request,
 	if (!valid_signal(data))
 		return -EIO;
 
-	if (request == PTRACE_SYSCALL)
-		set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	update_tsk_thread_flag(child, TIF_SYSCALL_TRACE,
+			       request == PTRACE_SYSCALL);
 
 #ifdef TIF_SYSCALL_EMU
-	if (request == PTRACE_SYSEMU || request == PTRACE_SYSEMU_SINGLESTEP)
-		set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-	else
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+	update_tsk_thread_flag(child, TIF_SYSCALL_EMU,
+			       request == PTRACE_SYSEMU ||
+			       request == PTRACE_SYSEMU_SINGLESTEP);
 #endif
 
 	if (is_singleblock(request)) {
-- 
2.1.4
