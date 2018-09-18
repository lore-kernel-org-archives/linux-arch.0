Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:33451 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:36:18 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:27 +0200
Message-ID: <20180918000546.12552-1-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 01/20] signal: Simplify tracehook_report_syscall_exit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000527.1nAE2SeTde3okYozYR_MJXJH0zKzx8oAiWBZPXfTOxw@z>

Replace user_single_step_siginfo with user_single_step_report
that allocates siginfo structure on the stack and sends it.

This allows tracehook_report_syscall_exit to become a simple
if statement that calls user_single_step_report or ptrace_report_syscall
depending on the value of step.

Update the default helper function now called user_single_step_report
to explicitly set si_code to SI_USER and to set si_uid and si_pid to 0.
The default helper has always been doing this (using memset) but it
was far from obvious.

The powerpc helper can now just call force_sig_fault.
The x86 helper can now just call send_sigtrap.

Unfortunately the default implementation of user_single_step_report
can not use force_sig_fault as it does not use a SIGTRAP si_code.
So it has to carefully setup the siginfo and use use force_sig_info.

The net result is code that is easier to understand and simpler
to maintain.

Ref: 85ec7fd9f8e5 ("ptrace: introduce user_single_step_siginfo() helper")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/asm/ptrace.h |  2 +-
 arch/powerpc/kernel/traps.c       |  7 ++-----
 arch/x86/include/asm/ptrace.h     |  2 +-
 arch/x86/kernel/ptrace.c          | 11 +++++------
 include/linux/ptrace.h            | 17 +++++++++++------
 include/linux/tracehook.h         | 13 ++++---------
 6 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 447cbd1bee99..5b480e1d5909 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -149,7 +149,7 @@ do {									      \
 
 #define arch_has_single_step()	(1)
 #define arch_has_block_step()	(!cpu_has_feature(CPU_FTR_601))
-#define ARCH_HAS_USER_SINGLE_STEP_INFO
+#define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
 /*
  * kprobe-based event tracer support
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c85adb858271..f651fa91cdc9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -307,12 +307,9 @@ void die(const char *str, struct pt_regs *regs, long err)
 }
 NOKPROBE_SYMBOL(die);
 
-void user_single_step_siginfo(struct task_struct *tsk,
-				struct pt_regs *regs, siginfo_t *info)
+void user_single_step_report(struct pt_regs *regs)
 {
-	info->si_signo = SIGTRAP;
-	info->si_code = TRAP_TRACE;
-	info->si_addr = (void __user *)regs->nip;
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->nip, current);
 }
 
 static void show_signal_msg(int signr, struct pt_regs *regs, int code,
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..e353f08b7fe2 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -263,7 +263,7 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 #define arch_has_block_step()	(boot_cpu_data.x86 >= 6)
 #endif
 
-#define ARCH_HAS_USER_SINGLE_STEP_INFO
+#define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
 /*
  * When hitting ptrace_stop(), we cannot return using SYSRET because
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..94bd6e89129a 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1382,12 +1382,6 @@ static void fill_sigtrap_info(struct task_struct *tsk,
 	info->si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
 }
 
-void user_single_step_siginfo(struct task_struct *tsk,
-				struct pt_regs *regs,
-				struct siginfo *info)
-{
-	fill_sigtrap_info(tsk, regs, 0, TRAP_BRKPT, info);
-}
 
 void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 					 int error_code, int si_code)
@@ -1399,3 +1393,8 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 	/* Send us the fake SIGTRAP */
 	force_sig_info(SIGTRAP, &info, tsk);
 }
+
+void user_single_step_report(struct pt_regs *regs)
+{
+	send_sigtrap(current, regs, 0, TRAP_BRKPT);
+}
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 4f36431c380b..1de2235511c8 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -336,14 +336,19 @@ static inline void user_enable_block_step(struct task_struct *task)
 extern void user_enable_block_step(struct task_struct *);
 #endif	/* arch_has_block_step */
 
-#ifdef ARCH_HAS_USER_SINGLE_STEP_INFO
-extern void user_single_step_siginfo(struct task_struct *tsk,
-				struct pt_regs *regs, siginfo_t *info);
+#ifdef ARCH_HAS_USER_SINGLE_STEP_REPORT
+extern void user_single_step_report(struct pt_regs *regs);
 #else
-static inline void user_single_step_siginfo(struct task_struct *tsk,
-				struct pt_regs *regs, siginfo_t *info)
+static inline void user_single_step_report(struct pt_regs *regs)
 {
-	info->si_signo = SIGTRAP;
+	siginfo_t info;
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_errno = 0;
+	info.si_code = SI_USER;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 05589a3e37f4..40b0b4c1bf7b 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -123,15 +123,10 @@ static inline __must_check int tracehook_report_syscall_entry(
  */
 static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 {
-	if (step) {
-		siginfo_t info;
-		clear_siginfo(&info);
-		user_single_step_siginfo(current, regs, &info);
-		force_sig_info(SIGTRAP, &info, current);
-		return;
-	}
-
-	ptrace_report_syscall(regs);
+	if (step)
+		user_single_step_report(regs);
+	else
+		ptrace_report_syscall(regs);
 }
 
 /**
-- 
2.17.1
