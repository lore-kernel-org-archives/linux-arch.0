From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 08/10] signal/ptrace: Add force_sig_ptrace_errno_trap and use it where needed
Date: Tue, 23 Jan 2018 15:07:17 -0600
Message-ID: <20180123210719.10456-8-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

There are so many places that build struct siginfo by hand that at
least one of them is bound to get it wrong.  A handful of cases in the
kernel arguably did just that when using the errno field of siginfo to
pass no errno values to userspace.  The usage is limited to a single
si_code so at least does not mess up anything else.

Encapsulate this questionable pattern in a helper function so
that the userspace ABI is preserved.

Update all of the places that use this pattern to use the new helper
function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/ptrace.c      |  8 +-------
 arch/arm64/kernel/ptrace.c    |  6 ++++--
 arch/powerpc/kernel/process.c |  9 ++-------
 arch/xtensa/kernel/ptrace.c   |  8 +-------
 include/linux/sched/signal.h  |  2 ++
 kernel/signal.c               | 15 +++++++++++++++
 6 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 58e3771e4c5b..7724b0f661b3 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -390,7 +390,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 	long num;
 	int i;
-	siginfo_t info;
 
 	for (i = 0; i < ARM_MAX_HBP_SLOTS; ++i)
 		if (current->thread.debug.hbp[i] == bp)
@@ -398,12 +397,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 
 	num = (i == ARM_MAX_HBP_SLOTS) ? 0 : ptrace_hbp_idx_to_num(i);
 
-	info.si_signo	= SIGTRAP;
-	info.si_errno	= (int)num;
-	info.si_code	= TRAP_HWBKPT;
-	info.si_addr	= (void __user *)(bkpt->trigger);
-
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_ptrace_errno_trap((int)num, (void __user *)(bkpt->trigger));
 }
 
 /*
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 95daa1478a7c..6618036ae6d4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -190,21 +190,23 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
+		int si_errno = 0;
 		int i;
 
 		for (i = 0; i < ARM_MAX_BRP; ++i) {
 			if (current->thread.debug.hbp_break[i] == bp) {
-				info.si_errno = (i << 1) + 1;
+				si_errno = (i << 1) + 1;
 				break;
 			}
 		}
 
 		for (i = 0; i < ARM_MAX_WRP; ++i) {
 			if (current->thread.debug.hbp_watch[i] == bp) {
-				info.si_errno = -((i << 1) + 1);
+				si_errno = -((i << 1) + 1);
 				break;
 			}
 		}
+		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
 	}
 #endif
 	force_sig_info(SIGTRAP, &info, current);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bfb48cf56bc3..4208cbe2fb7f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -603,19 +603,14 @@ EXPORT_SYMBOL(flush_all_to_thread);
 void do_send_trap(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code, int breakpt)
 {
-	siginfo_t info;
-
 	current->thread.trap_nr = TRAP_HWBKPT;
 	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
 
 	/* Deliver the signal to userspace */
-	info.si_signo = SIGTRAP;
-	info.si_errno = breakpt;	/* breakpoint or watchpoint id */
-	info.si_code = TRAP_HWBKPT;
-	info.si_addr = (void __user *)address;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_ptrace_errno_trap(breakpt, /* breakpoint or watchpoint id */
+				    (void __user *)address);
 }
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
 void do_break (struct pt_regs *regs, unsigned long address,
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index e2461968efb2..c0845cb1cbb9 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -278,7 +278,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				struct pt_regs *regs)
 {
 	int i;
-	siginfo_t info;
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 
 	if (bp->attr.bp_type & HW_BREAKPOINT_X) {
@@ -293,12 +292,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		i = (i << 1) | 1;
 	}
 
-	info.si_signo = SIGTRAP;
-	info.si_errno = i;
-	info.si_code = TRAP_HWBKPT;
-	info.si_addr = (void __user *)bkpt->address;
-
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_ptrace_errno_trap(i, (void __user *)bkpt->address);
 }
 
 static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 944fe6356f4a..23b4f9cb82db 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -311,6 +311,8 @@ int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
 int force_sig_pkuerr(void __user *addr, u32 pkey);
 
+int force_sig_ptrace_errno_trap(int errno, void __user *addr);
+
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 4f6300ef8062..e549174c0831 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1599,6 +1599,21 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 }
 #endif
 
+/* For the crazy architectures that include trap information in
+ * the errno field, instead of an actual errno value.
+ */
+int force_sig_ptrace_errno_trap(int errno, void __user *addr)
+{
+	struct siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_errno = errno;
+	info.si_code  = TRAP_HWBKPT;
+	info.si_addr  = addr;
+	return force_sig_info(info.si_signo, &info, current);
+}
+
 int kill_pgrp(struct pid *pid, int sig, int priv)
 {
 	int ret;
-- 
2.14.1
