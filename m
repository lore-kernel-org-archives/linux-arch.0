Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:53119 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeIRFm3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:42:29 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:46 +0200
Message-ID: <20180918000546.12552-20-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 20/20] signal/x86: Use force_sig_fault where appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000546.gDJ7VNUX8EWEx6DL-kcu_lx7qvff7zlAL-kyYD9U3qQ@z>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c |  9 +--------
 arch/x86/kernel/ptrace.c              | 10 ++--------
 arch/x86/kernel/traps.c               | 14 +++++---------
 arch/x86/kernel/umip.c                |  8 +-------
 4 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 82ed001e8909..85fd85d52ffd 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -100,20 +100,13 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	 */
 
 	if (!access_ok(VERIFY_WRITE, (void __user *)ptr, size)) {
-		siginfo_t info;
 		struct thread_struct *thread = &current->thread;
 
 		thread->error_code	= 6;  /* user fault, no page, write */
 		thread->cr2		= ptr;
 		thread->trap_nr		= X86_TRAP_PF;
 
-		clear_siginfo(&info);
-		info.si_signo		= SIGSEGV;
-		info.si_errno		= 0;
-		info.si_code		= SEGV_MAPERR;
-		info.si_addr		= (void __user *)ptr;
-
-		force_sig_info(SIGSEGV, &info, current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)ptr, current);
 		return false;
 	} else {
 		return true;
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 511ea0f16078..a78fff5b3384 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1372,18 +1372,12 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 					 int error_code, int si_code)
 {
-	struct siginfo info;
-
-	clear_siginfo(&info);
 	tsk->thread.trap_nr = X86_TRAP_DB;
 	tsk->thread.error_code = error_code;
 
-	info.si_signo = SIGTRAP;
-	info.si_code = si_code;
-	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
-
 	/* Send us the fake SIGTRAP */
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, si_code,
+			user_mode(regs) ? (void __user *)regs->ip : NULL, tsk);
 }
 
 void user_single_step_report(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index eb54f1964252..b3c5708b6d31 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -809,7 +809,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 {
 	struct task_struct *task = current;
 	struct fpu *fpu = &task->thread.fpu;
-	siginfo_t info;
+	int si_code;
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
@@ -835,18 +835,14 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 
 	task->thread.trap_nr	= trapnr;
 	task->thread.error_code = error_code;
-	clear_siginfo(&info);
-	info.si_signo		= SIGFPE;
-	info.si_errno		= 0;
-	info.si_addr		= (void __user *)uprobe_get_trap_addr(regs);
-
-	info.si_code = fpu__exception_code(fpu, trapnr);
 
+	si_code = fpu__exception_code(fpu, trapnr);
 	/* Retry when we get spurious exceptions: */
-	if (!info.si_code)
+	if (!si_code)
 		return;
 
-	force_sig_info(SIGFPE, &info, task);
+	force_sig_fault(SIGFPE, si_code,
+			(void __user *)uprobe_get_trap_addr(regs), task);
 }
 
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index ff20b35e98dd..f8f3cfda01ae 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -271,19 +271,13 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
  */
 static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
 {
-	siginfo_t info;
 	struct task_struct *tsk = current;
 
 	tsk->thread.cr2		= (unsigned long)addr;
 	tsk->thread.error_code	= X86_PF_USER | X86_PF_WRITE;
 	tsk->thread.trap_nr	= X86_TRAP_PF;
 
-	clear_siginfo(&info);
-	info.si_signo	= SIGSEGV;
-	info.si_errno	= 0;
-	info.si_code	= SEGV_MAPERR;
-	info.si_addr	= addr;
-	force_sig_info(SIGSEGV, &info, tsk);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, addr, tsk);
 
 	if (!(show_unhandled_signals && unhandled_signal(tsk, SIGSEGV)))
 		return;
-- 
2.17.1
