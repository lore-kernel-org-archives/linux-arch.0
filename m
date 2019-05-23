Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:53233 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWBdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:33:21 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:10 -0500
Message-ID: <20190523003916.20726-21-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 20/26] signal: Use force_sig_fault_to_task for the two calls that don't deliver to current
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003910._9rwSMIxowoyiGjgPrDLoqEteGh-5X-E5X3ypK1FiYI@z>

In preparation for removing the task parameter from force_sig_fault
introduce force_sig_fault_to_task and use it for the two cases where
it matters.

On mips force_fcr31_sig calls force_sig_fault and is called on either
the current task, or a task that is suspended and is being switched to
by the scheduler.  This is safe because the task being switched to by
the scheduler is guaranteed to be suspended.  This ensures that
task->sighand is stable while the signal is delivered to it.

On parisc user_enable_single_step calls force_sig_fault and is in turn
called by ptrace_request.  The function ptrace_request always calls
user_enable_single_step on a child that is stopped for tracing.  The
child being traced and not reaped ensures that child->sighand is not
NULL, and that the child will not change child->sighand.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/traps.c     |  2 +-
 arch/parisc/kernel/ptrace.c  |  6 +++---
 include/linux/sched/signal.h |  4 ++++
 kernel/signal.c              | 12 +++++++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a6031b045b95..62df48b6fb46 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -733,7 +733,7 @@ void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 	else if (fcr31 & FPU_CSR_INE_X)
 		si_code = FPE_FLTRES;
 
-	force_sig_fault(SIGFPE, si_code, fault_addr, tsk);
+	force_sig_fault_to_task(SIGFPE, si_code, fault_addr, tsk);
 }
 
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index a3d2fb4e6dd2..f642ba378ffa 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -88,9 +88,9 @@ void user_enable_single_step(struct task_struct *task)
 		ptrace_disable(task);
 		/* Don't wake up the task, but let the
 		   parent know something happened. */
-		force_sig_fault(SIGTRAP, TRAP_TRACE,
-				(void __user *) (task_regs(task)->iaoq[0] & ~3),
-				task);
+		force_sig_fault_to_task(SIGTRAP, TRAP_TRACE,
+					(void __user *) (task_regs(task)->iaoq[0] & ~3),
+					task);
 		/* notify_parent(task, SIGCHLD); */
 		return;
 	}
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 4178bb1f7709..507af66a1fc8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -307,6 +307,10 @@ static inline void kernel_signal_stop(void)
 # define ___ARCH_SI_IA64(_a1, _a2, _a3)
 #endif
 
+int force_sig_fault_to_task(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t);
 int force_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
diff --git a/kernel/signal.c b/kernel/signal.c
index 398489facf9f..e420489ac4c9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1620,7 +1620,7 @@ void force_sigsegv(int sig)
 	force_sig(SIGSEGV);
 }
 
-int force_sig_fault(int sig, int code, void __user *addr
+int force_sig_fault_to_task(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
 	, struct task_struct *t)
@@ -1643,6 +1643,16 @@ int force_sig_fault(int sig, int code, void __user *addr
 	return force_sig_info(info.si_signo, &info, t);
 }
 
+int force_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t)
+{
+	return force_sig_fault_to_task(sig, code, addr
+				       ___ARCH_SI_TRAPNO(trapno)
+				       ___ARCH_SI_IA64(imm, flags, isr), t);
+}
+
 int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-- 
2.21.0
