From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 5/5] ptrace: x86: change syscall_trace_leave() to rely
	on tracehook when stepping
Date: Thu, 12 Nov 2009 18:39:01 +0100
Message-ID: <20091112173901.GA12289@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753986AbZKLRo1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>, Srinivasa Ds <srinivasa@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Suggested by Roland.

Unlike powepc, x86 always calls tracehook_report_syscall_exit(step)
with step = 0, and sends the trap by hand.

This results in unnecessary SIGTRAP when PTRACE_SINGLESTEP follows
the syscall-exit stop.

Change syscall_trace_leave() to pass the correct "step" argument to
tracehook and remove the send_sigtrap() logic.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
---

 arch/x86/kernel/ptrace.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- TH/arch/x86/kernel/ptrace.c~5_X86_CONVERT_SYSCALL_LEAVE	2009-11-10 22:21:42.000000000 +0100
+++ TH/arch/x86/kernel/ptrace.c	2009-11-10 22:29:54.000000000 +0100
@@ -1528,29 +1528,22 @@ asmregparm long syscall_trace_enter(stru
 
 asmregparm void syscall_trace_leave(struct pt_regs *regs)
 {
+	bool step;
+
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(AUDITSC_RESULT(regs->ax), regs->ax);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_exit(regs, regs->ax);
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, 0);
-
 	/*
 	 * If TIF_SYSCALL_EMU is set, we only get here because of
 	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
 	 * We already reported this syscall instruction in
-	 * syscall_trace_enter(), so don't do any more now.
-	 */
-	if (unlikely(test_thread_flag(TIF_SYSCALL_EMU)))
-		return;
-
-	/*
-	 * If we are single-stepping, synthesize a trap to follow the
-	 * system call instruction.
+	 * syscall_trace_enter().
 	 */
-	if (test_thread_flag(TIF_SINGLESTEP) &&
-	    tracehook_consider_fatal_signal(current, SIGTRAP))
-		send_sigtrap(current, regs, 0, TRAP_BRKPT);
+	step = unlikely(test_thread_flag(TIF_SINGLESTEP)) &&
+			!test_thread_flag(TIF_SYSCALL_EMU);
+	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, step);
 }
