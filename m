From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 07/20] signal/x86/traps: Factor out show_signal
Date: Tue, 18 Sep 2018 02:05:33 +0200
Message-ID: <20180918000546.12552-7-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The code for conditionally printing unhanded signals is duplicated twice
in arch/x86/kernel/traps.c.  Factor it out into it's own subroutine
called show_signal to make the code clearer and easier to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2155d2c7f49b..31a689b67be3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -217,6 +217,20 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 	return -1;
 }
 
+static void show_signal(struct task_struct *tsk, int signr,
+			const char *type, const char *desc,
+			struct pt_regs *regs, long error_code)
+{
+	if (show_unhandled_signals && unhandled_signal(tsk, signr) &&
+	    printk_ratelimit()) {
+		pr_info("%s[%d] %s%s ip:%lx sp:%lx error:%lx",
+			tsk->comm, task_pid_nr(tsk), type, desc,
+			regs->ip, regs->sp, error_code);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+}
+
 static siginfo_t *fill_trap_info(struct pt_regs *regs, int signr, int trapnr,
 				siginfo_t *info)
 {
@@ -269,14 +283,7 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = trapnr;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, signr) &&
-	    printk_ratelimit()) {
-		pr_info("%s[%d] trap %s ip:%lx sp:%lx error:%lx",
-			tsk->comm, tsk->pid, str,
-			regs->ip, regs->sp, error_code);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
-	}
+	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
 	force_sig_info(signr, info ?: SEND_SIG_PRIV, tsk);
 }
@@ -542,6 +549,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
+	const char *desc = "general protection fault";
 	struct task_struct *tsk;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
@@ -565,23 +573,16 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
-		if (notify_die(DIE_GPF, "general protection fault", regs, error_code,
+		if (notify_die(DIE_GPF, desc, regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die("general protection fault", regs, error_code);
+			die(desc, regs, error_code);
 		return;
 	}
 
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
-			printk_ratelimit()) {
-		pr_info("%s[%d] general protection ip:%lx sp:%lx error:%lx",
-			tsk->comm, task_pid_nr(tsk),
-			regs->ip, regs->sp, error_code);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
-	}
+	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
 }
-- 
2.17.1
