Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60234 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfEWAnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:14 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:00 -0500
Message-ID: <20190523003916.20726-11-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 10/26] signal: Remove task parameter from force_sig_mceerr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003900.LiveODZ-4C0j1aMlxqMcNYj9P_PUTLKSHOXtGiQidIs@z>

All of the callers pass current into force_sig_mceer so remove the
task parameter to make this obvious.

This also makes it clear that force_sig_mceerr passes current
into force_sig_info.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/traps.c    | 2 +-
 arch/parisc/mm/fault.c       | 2 +-
 arch/powerpc/mm/fault.c      | 3 +--
 arch/x86/mm/fault.c          | 2 +-
 include/linux/sched/signal.h | 2 +-
 kernel/signal.c              | 4 ++--
 mm/memory-failure.c          | 2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 39a391adf222..65ca953abc53 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -263,7 +263,7 @@ void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
 			    const char *str)
 {
 	arm64_show_signal(SIGBUS, str);
-	force_sig_mceerr(code, addr, lsb, current);
+	force_sig_mceerr(code, addr, lsb);
 }
 
 void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr,
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c8e8b7c05558..56ceacb3401d 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -403,7 +403,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 				lsb = PAGE_SHIFT;
 
 			force_sig_mceerr(BUS_MCEERR_AR, (void __user *) address,
-					 lsb, current);
+					 lsb);
 			return;
 		}
 #endif
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b5d3578d9f65..6ed6c341c670 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -182,8 +182,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		if (fault & VM_FAULT_HWPOISON)
 			lsb = PAGE_SHIFT;
 
-		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb,
-				 current);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 		return 0;
 	}
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aae46..c431326ee3fa 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1040,7 +1040,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 		if (fault & VM_FAULT_HWPOISON)
 			lsb = PAGE_SHIFT;
-		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 		return;
 	}
 #endif
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e9df3f0cce48..4178bb1f7709 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -316,7 +316,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
 	, struct task_struct *t);
 
-int force_sig_mceerr(int code, void __user *, short, struct task_struct *);
+int force_sig_mceerr(int code, void __user *, short);
 int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
 
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
diff --git a/kernel/signal.c b/kernel/signal.c
index 20878c4c28c2..398489facf9f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1666,7 +1666,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	return send_sig_info(info.si_signo, &info, t);
 }
 
-int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
+int force_sig_mceerr(int code, void __user *addr, short lsb)
 {
 	struct kernel_siginfo info;
 
@@ -1677,7 +1677,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
-	return force_sig_info(info.si_signo, &info, t);
+	return force_sig_info(info.si_signo, &info, current);
 }
 
 int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b51744579..bc749265a8f3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -221,7 +221,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
 		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
-				       addr_lsb, current);
+				       addr_lsb);
 	} else {
 		/*
 		 * Don't use force here, it's convenient if the signal
-- 
2.21.0
