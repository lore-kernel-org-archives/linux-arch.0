From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 03/15] signal/arm64: Factor out arm64_show_signal from arm64_force_sig_info
Date: Mon, 24 Sep 2018 11:10:03 +0200
Message-ID: <20180924091015.4458-3-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Filling in siginfo is error prone and so it is wise to use more
specialized helpers to do that work.  Factor out the arm specific
unhandled signal reporting from the work of delivering a signal so
the code can be modified to use functions that take the information
to fill out siginfo as parameters.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/traps.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 24035d124608..daee8c2ca561 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -224,24 +224,19 @@ void die(const char *str, struct pt_regs *regs, int err)
 		do_exit(SIGSEGV);
 }
 
-static bool show_unhandled_signals_ratelimited(void)
+static void arm64_show_signal(int signo, const char *str)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	return show_unhandled_signals && __ratelimit(&rs);
-}
-
-void arm64_force_sig_info(struct siginfo *info, const char *str)
-{
 	struct task_struct *tsk = current;
 	unsigned int esr = tsk->thread.fault_code;
 	struct pt_regs *regs = task_pt_regs(tsk);
 
-	if (!unhandled_signal(tsk, info->si_signo))
-		goto send_sig;
-
-	if (!show_unhandled_signals_ratelimited())
-		goto send_sig;
+	/* Leave if the signal won't be shown */
+	if (!show_unhandled_signals ||
+	    !unhandled_signal(tsk, signo) ||
+	    !__ratelimit(&rs))
+		return;
 
 	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
 	if (esr)
@@ -251,9 +246,12 @@ void arm64_force_sig_info(struct siginfo *info, const char *str)
 	print_vma_addr(KERN_CONT " in ", regs->pc);
 	pr_cont("\n");
 	__show_regs(regs);
+}
 
-send_sig:
-	force_sig_info(info->si_signo, info, tsk);
+void arm64_force_sig_info(struct siginfo *info, const char *str)
+{
+	arm64_show_signal(info->si_signo, str);
+	force_sig_info(info->si_signo, info, current);
 }
 
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-- 
2.17.1
