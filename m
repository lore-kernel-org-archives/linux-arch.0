From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 11/15] signal/arm64: Add and use arm64_force_sig_mceerr as appropriate
Date: Mon, 24 Sep 2018 11:10:11 +0200
Message-ID: <20180924091015.4458-11-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Add arm64_force_sig_mceerr for consistency with arm64_force_sig_fault,
and use it in the one location that can take advantage of it.

This removes the fiddly filling out of siginfo before sending a signal
reporting an memory error to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h | 1 +
 arch/arm64/kernel/traps.c      | 7 +++++++
 arch/arm64/mm/fault.c          | 9 ++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 08e99901edbc..193f0b0e8ee3 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -38,6 +38,7 @@ void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
+void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
 void arm64_force_sig_info(struct siginfo *info, const char *str);
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 37a3309863e0..baa96dfffeec 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -255,6 +255,13 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
 	force_sig_fault(signo, code, addr, current);
 }
 
+void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
+			    const char *str)
+{
+	arm64_show_signal(SIGBUS, str);
+	force_sig_mceerr(code, addr, lsb, current);
+}
+
 void arm64_force_sig_info(struct siginfo *info, const char *str)
 {
 	arm64_show_signal(info->si_signo, str);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 66c295019a9a..f0ccb209d181 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -422,7 +422,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	const struct fault_info *inf;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	struct siginfo si;
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
@@ -574,12 +573,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
-		clear_siginfo(&si);
-		si.si_signo	= SIGBUS;
-		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr = (void __user *)addr;
-		si.si_addr_lsb	= lsb;
-		arm64_force_sig_info(&si, inf->name);
+		arm64_force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr, lsb,
+				       inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
-- 
2.17.1
