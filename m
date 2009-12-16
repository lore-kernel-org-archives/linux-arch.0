From: akpm@linux-foundation.org
Subject: [patch 096/175] ptrace: x86: change syscall_trace_leave() to rely on tracehook when stepping
Date: Tue, 15 Dec 2009 16:47:21 -0800
Message-ID: <200912160047.nBG0lLLG024661@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40234 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbZLPArs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2009 19:47:48 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, oleg@redhat.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, roland@redhat.com, tglx@linutronix.de

From: Oleg Nesterov <oleg@redhat.com>

Suggested by Roland.

Unlike powepc, x86 always calls tracehook_report_syscall_exit(step) with
step = 0, and sends the trap by hand.

This results in unnecessary SIGTRAP when PTRACE_SINGLESTEP follows the
syscall-exit stop.

Change syscall_trace_leave() to pass the correct "step" argument to
tracehook and remove the send_sigtrap() logic.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Roland McGrath <roland@redhat.com>
Cc: <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/ptrace.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff -puN arch/x86/kernel/ptrace.c~ptrace-x86-change-syscall_trace_leave-to-rely-on-tracehook-when-stepping arch/x86/kernel/ptrace.c
--- a/arch/x86/kernel/ptrace.c~ptrace-x86-change-syscall_trace_leave-to-rely-on-tracehook-when-stepping
+++ a/arch/x86/kernel/ptrace.c
@@ -1767,29 +1767,22 @@ asmregparm long syscall_trace_enter(stru
 
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
_
