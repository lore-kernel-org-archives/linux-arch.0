From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 01/15] signal/arm64: Push siginfo generation into arm64_notify_die
Date: Mon, 24 Sep 2018 11:10:01 +0200
Message-ID: <20180924091015.4458-1-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Instead of generating a struct siginfo before calling arm64_notify_die
pass the signal number, tne sicode and the fault address into
arm64_notify_die and have it call force_sig_fault instead of
force_sig_info to let the generic code generate the struct siginfo.

This keeps code passing just the needed information into
siginfo generating code, making it easier to see what
is happening and harder to get wrong.  Further by letting
the generic code handle the generation of struct siginfo
it reduces the number of sites generating struct siginfo
making it possible to review them and verify that all
of the fiddly details for a structure passed to userspace
are handled properly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/system_misc.h |  3 +-
 arch/arm64/kernel/sys_compat.c       | 13 ++++-----
 arch/arm64/kernel/traps.c            | 24 ++++++++--------
 arch/arm64/mm/fault.c                | 41 +++++++---------------------
 4 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 28893a0b141d..0e2a0ecaf484 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -33,7 +33,8 @@ void die(const char *msg, struct pt_regs *regs, int err);
 
 struct siginfo;
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-		      struct siginfo *info, int err);
+		      int signo, int sicode, void __user *addr,
+		      int err);
 
 void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 					     struct pt_regs *),
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index a6109825eeb9..32653d156747 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -68,8 +68,8 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
  */
 long compat_arm_syscall(struct pt_regs *regs)
 {
-	siginfo_t info;
 	unsigned int no = regs->regs[7];
+	void __user *addr;
 
 	switch (no) {
 	/*
@@ -112,13 +112,10 @@ long compat_arm_syscall(struct pt_regs *regs)
 		break;
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLTRP;
-	info.si_addr  = (void __user *)instruction_pointer(regs) -
-			 (compat_thumb_mode(regs) ? 2 : 4);
+	addr  = (void __user *)instruction_pointer(regs) -
+		(compat_thumb_mode(regs) ? 2 : 4);
 
-	arm64_notify_die("Oops - bad compat syscall(2)", regs, &info, no);
+	arm64_notify_die("Oops - bad compat syscall(2)", regs,
+			 SIGILL, ILL_ILLTRP, addr, no);
 	return 0;
 }
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 039e9ff379cc..459eb6fb7158 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -257,13 +257,23 @@ void arm64_force_sig_info(struct siginfo *info, const char *str,
 }
 
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-		      struct siginfo *info, int err)
+		      int signo, int sicode, void __user *addr,
+		      int err)
 {
 	if (user_mode(regs)) {
+		struct siginfo info;
+
 		WARN_ON(regs != current_pt_regs());
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
-		arm64_force_sig_info(info, str, current);
+
+		clear_siginfo(&info);
+		info.si_signo = signo;
+		info.si_errno = 0;
+		info.si_code  = sicode;
+		info.si_addr  = addr;
+
+		arm64_force_sig_info(&info, str, current);
 	} else {
 		die(str, regs, err);
 	}
@@ -348,12 +358,9 @@ static int call_undef_hook(struct pt_regs *regs)
 
 void force_signal_inject(int signal, int code, unsigned long address)
 {
-	siginfo_t info;
 	const char *desc;
 	struct pt_regs *regs = current_pt_regs();
 
-	clear_siginfo(&info);
-
 	switch (signal) {
 	case SIGILL:
 		desc = "undefined instruction";
@@ -372,12 +379,7 @@ void force_signal_inject(int signal, int code, unsigned long address)
 		signal = SIGKILL;
 	}
 
-	info.si_signo = signal;
-	info.si_errno = 0;
-	info.si_code  = code;
-	info.si_addr  = (void __user *)address;
-
-	arm64_notify_die(desc, regs, &info, 0);
+	arm64_notify_die(desc, regs, signal, code, (void __user *)address, 0);
 }
 
 /*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 50b30ff30de4..86fe70d8722f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -625,8 +625,8 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
-	struct siginfo info;
 	const struct fault_info *inf;
+	void __user *siaddr;
 
 	inf = esr_to_fault_info(esr);
 
@@ -645,15 +645,11 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 			nmi_exit();
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
 	if (esr & ESR_ELx_FnV)
-		info.si_addr = NULL;
+		siaddr = NULL;
 	else
-		info.si_addr  = (void __user *)addr;
-	arm64_notify_die(inf->name, regs, &info, esr);
+		siaddr  = (void __user *)addr;
+	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
 }
@@ -734,7 +730,6 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 					 struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, esr, regs))
 		return;
@@ -745,12 +740,8 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 		show_pte(addr);
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
-	info.si_addr  = (void __user *)addr;
-	arm64_notify_die(inf->name, regs, &info, esr);
+	arm64_notify_die(inf->name, regs,
+			 inf->sig, inf->code, (void __user *)addr, esr);
 }
 
 asmlinkage void __exception do_el0_irq_bp_hardening(void)
@@ -780,20 +771,14 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   unsigned int esr,
 					   struct pt_regs *regs)
 {
-	struct siginfo info;
-
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
 			arm64_apply_bp_hardening();
 		local_irq_enable();
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code  = BUS_ADRALN;
-	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("SP/PC alignment exception", regs, &info, esr);
+	arm64_notify_die("SP/PC alignment exception", regs,
+			 SIGBUS, BUS_ADRALN, (void __user *)addr, esr);
 }
 
 int __init early_brk64(unsigned long addr, unsigned int esr,
@@ -847,14 +832,8 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
-		struct siginfo info;
-
-		clear_siginfo(&info);
-		info.si_signo = inf->sig;
-		info.si_errno = 0;
-		info.si_code  = inf->code;
-		info.si_addr  = (void __user *)addr;
-		arm64_notify_die(inf->name, regs, &info, esr);
+		arm64_notify_die(inf->name, regs,
+				 inf->sig, inf->code, (void __user *)addr, esr);
 		rv = 0;
 	}
 
-- 
2.17.1
