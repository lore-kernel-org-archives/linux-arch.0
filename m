Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:60467 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWBdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:33:43 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:16 -0500
Message-ID: <20190523003916.20726-27-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 26/26] signal: Remove the signal number and task parameters from force_sig_info
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003916.xOcKIIASHW-3BiAGWrfj6KwYI3u51nHTvKdEt7V8pKY@z>

force_sig_info always delivers to the current task and the signal
parameter always matches info.si_signo.  So remove those parameters to
make it a simpler less error prone interface, and to make it clear
that none of the callers are doing anything clever.

This guarantees that force_sig_info will not grow any new buggy
callers that attempt to call force_sig on a non-current task, or that
pass an signal number that does not match info.si_signo.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h       |  2 +-
 include/linux/sched/signal.h |  2 +-
 kernel/seccomp.c             |  2 +-
 kernel/signal.c              | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index d5084ebd9f03..2a9df80ea887 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -355,7 +355,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 	info.si_code = SI_USER;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 #endif
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f872506e1de..532458698bde 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -329,7 +329,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig);
-extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
+extern int force_sig_info(struct kernel_siginfo *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
 extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 811b4a86cdf6..dba52a7db5e8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -609,7 +609,7 @@ static void seccomp_send_sigsys(int syscall, int reason)
 {
 	struct kernel_siginfo info;
 	seccomp_init_siginfo(&info, syscall, reason);
-	force_sig_info(SIGSYS, &info, current);
+	force_sig_info(&info);
 }
 #endif	/* CONFIG_SECCOMP_FILTER */
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 0984158cd41a..ff6944e4964e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1325,9 +1325,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	return ret;
 }
 
-int force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+int force_sig_info(struct kernel_siginfo *info)
 {
-	return force_sig_info_to_task(info, t);
+	return force_sig_info_to_task(info, current);
 }
 
 /*
@@ -1619,7 +1619,7 @@ void force_sig(int sig)
 	info.si_code = SI_KERNEL;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 EXPORT_SYMBOL(force_sig);
 
@@ -1708,7 +1708,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
@@ -1737,7 +1737,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	info.si_addr  = addr;
 	info.si_lower = lower;
 	info.si_upper = upper;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 #ifdef SEGV_PKUERR
@@ -1751,7 +1751,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 	info.si_code  = SEGV_PKUERR;
 	info.si_addr  = addr;
 	info.si_pkey  = pkey;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 #endif
 
@@ -1767,7 +1767,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	info.si_errno = errno;
 	info.si_code  = TRAP_HWBKPT;
 	info.si_addr  = addr;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int kill_pgrp(struct pid *pid, int sig, int priv)
-- 
2.21.0
