From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 10/15] signal/arm64: Add and use arm64_force_sig_fault where appropriate
Date: Mon, 24 Sep 2018 11:10:10 +0200
Message-ID: <20180924091015.4458-10-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Wrap force_sig_fault with a helper that calls arm64_show_signal
and call arm64_force_sig_fault where appropraite.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h     |  1 +
 arch/arm64/kernel/debug-monitors.c | 11 +++--------
 arch/arm64/kernel/ptrace.c         | 11 +++--------
 arch/arm64/kernel/traps.c          | 27 ++++++++++-----------------
 arch/arm64/mm/fault.c              | 26 ++++++++------------------
 5 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index cd3a2ca9c179..08e99901edbc 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,6 +37,7 @@ void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
+void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
 void arm64_force_sig_info(struct siginfo *info, const char *str);
 
 /*
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index e0d9502be5bf..d7bb6aefae0a 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -210,13 +210,6 @@ NOKPROBE_SYMBOL(call_step_hook);
 static void send_user_sigtrap(int si_code)
 {
 	struct pt_regs *regs = current_pt_regs();
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= SIGTRAP;
-	info.si_errno	= 0;
-	info.si_code	= si_code;
-	info.si_addr	= (void __user *)instruction_pointer(regs);
 
 	if (WARN_ON(!user_mode(regs)))
 		return;
@@ -224,7 +217,9 @@ static void send_user_sigtrap(int si_code)
 	if (interrupts_enabled(regs))
 		local_irq_enable();
 
-	arm64_force_sig_info(&info, "User debug trap");
+	arm64_force_sig_fault(SIGTRAP, si_code,
+			     (void __user *)instruction_pointer(regs),
+			     "User debug trap");
 }
 
 static int single_step_handler(unsigned long addr, unsigned int esr,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 20b68cb31ecb..7ab75e78aa08 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -182,13 +182,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				struct pt_regs *regs)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= SIGTRAP;
-	info.si_errno	= 0;
-	info.si_code	= TRAP_HWBKPT;
-	info.si_addr	= (void __user *)(bkpt->trigger);
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
@@ -211,7 +204,9 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
 	}
 #endif
-	arm64_force_sig_info(&info, "Hardware breakpoint trap (ptrace)");
+	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
+			      (void __user *)(bkpt->trigger),
+			      "Hardware breakpoint trap (ptrace)");
 }
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index daee8c2ca561..37a3309863e0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -248,6 +248,13 @@ static void arm64_show_signal(int signo, const char *str)
 	__show_regs(regs);
 }
 
+void arm64_force_sig_fault(int signo, int code, void __user *addr,
+			   const char *str)
+{
+	arm64_show_signal(signo, str);
+	force_sig_fault(signo, code, addr, current);
+}
+
 void arm64_force_sig_info(struct siginfo *info, const char *str)
 {
 	arm64_show_signal(info->si_signo, str);
@@ -259,19 +266,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      int err)
 {
 	if (user_mode(regs)) {
-		struct siginfo info;
-
 		WARN_ON(regs != current_pt_regs());
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
 
-		clear_siginfo(&info);
-		info.si_signo = signo;
-		info.si_errno = 0;
-		info.si_code  = sicode;
-		info.si_addr  = addr;
-
-		arm64_force_sig_info(&info, str);
+		arm64_force_sig_fault(signo, sicode, addr, str);
 	} else {
 		die(str, regs, err);
 	}
@@ -616,19 +615,13 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
  */
 asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 {
-	siginfo_t info;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLOPC;
-	info.si_addr  = pc;
-
 	current->thread.fault_address = 0;
 	current->thread.fault_code = esr;
 
-	arm64_force_sig_info(&info, "Bad EL0 synchronous exception");
+	arm64_force_sig_fault(SIGILL, ILL_ILLOPC, pc,
+			      "Bad EL0 synchronous exception");
 }
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 959c4a565c8e..66c295019a9a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -362,15 +362,10 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	 */
 	if (user_mode(regs)) {
 		const struct fault_info *inf = esr_to_fault_info(esr);
-		struct siginfo si;
-
-		clear_siginfo(&si);
-		si.si_signo	= inf->sig;
-		si.si_code	= inf->code;
-		si.si_addr	= (void __user *)addr;
 
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, inf->name);
+		arm64_force_sig_fault(inf->sig, inf->code, (void __user *)addr,
+				      inf->name);
 	} else {
 		__do_kernel_fault(addr, esr, regs);
 	}
@@ -570,11 +565,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * We had some memory, but were unable to successfully fix up
 		 * this page fault.
 		 */
-		clear_siginfo(&si);
-		si.si_signo	= SIGBUS;
-		si.si_code	= BUS_ADRERR;
-		si.si_addr = (void __user *)addr;
-		arm64_force_sig_info(&si, inf->name);
+		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr,
+				      inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -593,12 +585,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * Something tried to access memory that isn't in our memory
 		 * map.
 		 */
-		clear_siginfo(&si);
-		si.si_signo	= SIGSEGV;
-		si.si_code	= fault == VM_FAULT_BADACCESS ?
-				  SEGV_ACCERR : SEGV_MAPERR;
-		si.si_addr = (void __user *)addr;
-		arm64_force_sig_info(&si, inf->name);
+		arm64_force_sig_fault(SIGSEGV,
+				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
+				      (void __user *)addr,
+				      inf->name);
 	}
 
 	return 0;
-- 
2.17.1
