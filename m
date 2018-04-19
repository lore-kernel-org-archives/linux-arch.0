From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 1/6] thread_info: Add update_thread_flag() helpers
Date: Thu, 19 Apr 2018 11:58:43 +0100
Message-ID: <1524135528-28561-2-git-send-email-Dave.Martin@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

There are a number of bits of code sprinkled around the kernel to
set a thread flag if a certain condition is true, and clear it
otherwise.

To help make those call sites terser and less cumbersome, this
patch adds a new family of thread flag manipulators

	update*_thread_flag([...,] flag, cond)

which do the equivalent of:

	if (cond)
		set*_thread_flag([...,] flag);
	else
		clear*_thread_flag([...,] flag);

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---

Note, this patch assumes C99 _Bool semantics where casting a value to
_Bool is true is and only if the value compares != 0.  This would not
be true if bool where a typedef of unsigned char for example.

It appears that the kernel has always used the C99 semantics for bool
and relies on them elsewhere, so I don't believe this patch introduces
a new dependency.
---
 include/linux/sched.h       |  6 ++++++
 include/linux/thread_info.h | 11 +++++++++++
 include/trace/syscall.h     |  6 ++----
 kernel/ptrace.c             | 13 +++++--------
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f..c2c3051 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1578,6 +1578,12 @@ static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 	clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
+static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
+					  bool value)
+{
+	update_ti_thread_flag(task_thread_info(tsk), flag, value);
+}
+
 static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 34f053a..efd5ec4 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -64,6 +64,15 @@ static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
 	clear_bit(flag, (unsigned long *)&ti->flags);
 }
 
+static inline void update_ti_thread_flag(struct thread_info *ti, int flag,
+					 bool value)
+{
+	if (value)
+		set_ti_thread_flag(ti, flag);
+	else
+		clear_ti_thread_flag(ti, flag);
+}
+
 static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
 {
 	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
@@ -83,6 +92,8 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 	set_ti_thread_flag(current_thread_info(), flag)
 #define clear_thread_flag(flag) \
 	clear_ti_thread_flag(current_thread_info(), flag)
+#define update_thread_flag(flag, value) \
+	update_ti_thread_flag(current_thread_info(), flag, value)
 #define test_and_set_thread_flag(flag) \
 	test_and_set_ti_thread_flag(current_thread_info(), flag)
 #define test_and_clear_thread_flag(flag) \
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
