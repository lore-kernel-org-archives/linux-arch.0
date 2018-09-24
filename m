From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 1/4] signal/arm: Push siginfo generation into arm_notify_die
Date: Mon, 24 Sep 2018 14:11:25 +0200
Message-ID: <20180924121128.5983-1-ebiederm@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

In arm_notify_die call force_sig_fault to let the generic
code handle siginfo generation.

This removes some boiler plate making the code easier to
maintain in the long run.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/include/asm/bug.h    |  4 +--
 arch/arm/kernel/swp_emulate.c | 16 ++++-----
 arch/arm/kernel/traps.c       | 63 ++++++++++-------------------------
 arch/arm/mm/fault.c           | 18 +++-------
 4 files changed, 30 insertions(+), 71 deletions(-)

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 237aa52d8733..36c951dd23b8 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -62,8 +62,8 @@ do {								\
 struct pt_regs;
 void die(const char *msg, struct pt_regs *regs, int err);
 
-struct siginfo;
-void arm_notify_die(const char *str, struct pt_regs *regs, struct siginfo *info,
+void arm_notify_die(const char *str, struct pt_regs *regs,
+		int signo, int si_code, void __user *addr,
 		unsigned long err, unsigned long trap);
 
 #ifdef CONFIG_ARM_LPAE
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 80517f293eb9..a188d5e8ab7f 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -98,22 +98,20 @@ static int proc_status_show(struct seq_file *m, void *v)
  */
 static void set_segfault(struct pt_regs *regs, unsigned long addr)
 {
-	siginfo_t info;
+	int si_code;
 
-	clear_siginfo(&info);
 	down_read(&current->mm->mmap_sem);
 	if (find_vma(current->mm, addr) == NULL)
-		info.si_code = SEGV_MAPERR;
+		si_code = SEGV_MAPERR;
 	else
-		info.si_code = SEGV_ACCERR;
+		si_code = SEGV_ACCERR;
 	up_read(&current->mm->mmap_sem);
 
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_addr  = (void *) instruction_pointer(regs);
-
 	pr_debug("SWP{B} emulation: access caused memory abort!\n");
-	arm_notify_die("Illegal memory access", regs, &info, 0, 0);
+	arm_notify_die("Illegal memory access", regs,
+		       SIGSEGV, si_code,
+		       (void __user *)instruction_pointer(regs),
+		       0, 0);
 
 	abtcounter++;
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index badf02ca3693..2d668cff8ef4 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -365,13 +365,14 @@ void die(const char *str, struct pt_regs *regs, int err)
 }
 
 void arm_notify_die(const char *str, struct pt_regs *regs,
-		struct siginfo *info, unsigned long err, unsigned long trap)
+		int signo, int si_code, void __user *addr,
+		unsigned long err, unsigned long trap)
 {
 	if (user_mode(regs)) {
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-		force_sig_info(info->si_signo, info, current);
+		force_sig_fault(signo, si_code, addr, current);
 	} else {
 		die(str, regs, err);
 	}
@@ -438,10 +439,8 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 asmlinkage void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
-	siginfo_t info;
 	void __user *pc;
 
-	clear_siginfo(&info);
 	pc = (void __user *)instruction_pointer(regs);
 
 	if (processor_mode(regs) == SVC_MODE) {
@@ -485,13 +484,8 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 		dump_instr(KERN_INFO, regs);
 	}
 #endif
-
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLOPC;
-	info.si_addr  = pc;
-
-	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
+	arm_notify_die("Oops - undefined instruction", regs,
+		       SIGILL, ILL_ILLOPC, pc, 0, 6);
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
@@ -539,9 +533,6 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason)
 
 static int bad_syscall(int n, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
 	if ((current->personality & PER_MASK) != PER_LINUX) {
 		send_sig(SIGSEGV, current, 1);
 		return regs->ARM_r0;
@@ -555,13 +546,10 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	}
 #endif
 
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLTRP;
-	info.si_addr  = (void __user *)instruction_pointer(regs) -
-			 (thumb_mode(regs) ? 2 : 4);
-
-	arm_notify_die("Oops - bad syscall", regs, &info, n, 0);
+	arm_notify_die("Oops - bad syscall", regs, SIGILL, ILL_ILLTRP,
+		       (void __user *)instruction_pointer(regs) -
+			 (thumb_mode(regs) ? 2 : 4),
+		       n, 0);
 
 	return regs->ARM_r0;
 }
@@ -607,20 +595,13 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 #define NR(x) ((__ARM_NR_##x) - __ARM_NR_BASE)
 asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
 	if ((no >> 16) != (__ARM_NR_BASE>> 16))
 		return bad_syscall(no, regs);
 
 	switch (no & 0xffff) {
 	case 0: /* branch through 0 */
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code  = SEGV_MAPERR;
-		info.si_addr  = NULL;
-
-		arm_notify_die("branch through zero", regs, &info, 0, 0);
+		arm_notify_die("branch through zero", regs,
+			       SIGSEGV, SEGV_MAPERR, NULL, 0, 0);
 		return 0;
 
 	case NR(breakpoint): /* SWI BREAK_POINT */
@@ -688,13 +669,10 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 		}
 	}
 #endif
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLTRP;
-	info.si_addr  = (void __user *)instruction_pointer(regs) -
-			 (thumb_mode(regs) ? 2 : 4);
-
-	arm_notify_die("Oops - bad syscall(2)", regs, &info, no, 0);
+	arm_notify_die("Oops - bad syscall(2)", regs, SIGILL, ILL_ILLTRP,
+		       (void __user *)instruction_pointer(regs) -
+			 (thumb_mode(regs) ? 2 : 4),
+		       no, 0);
 	return 0;
 }
 
@@ -744,9 +722,6 @@ asmlinkage void
 baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
-	siginfo_t info;
-
-	clear_siginfo(&info);
 
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_BADABORT) {
@@ -757,12 +732,8 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 	}
 #endif
 
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code  = ILL_ILLOPC;
-	info.si_addr  = (void __user *)addr;
-
-	arm_notify_die("unknown data abort code", regs, &info, instr, 0);
+	arm_notify_die("unknown data abort code", regs,
+		       SIGILL, ILL_ILLOPC, (void __user *)addr, instr, 0);
 }
 
 void __readwrite_bug(const char *fn)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3232afb6fdc0..544d2c8c2775 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -554,7 +554,6 @@ asmlinkage void
 do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
@@ -563,12 +562,8 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		inf->name, fsr, addr);
 	show_pte(current->mm, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
-	info.si_addr  = (void __user *)addr;
-	arm_notify_die("", regs, &info, fsr, 0);
+	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+		       fsr, 0);
 }
 
 void __init
@@ -588,7 +583,6 @@ asmlinkage void
 do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = ifsr_info + fsr_fs(ifsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
@@ -596,12 +590,8 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
-	info.si_addr  = (void __user *)addr;
-	arm_notify_die("", regs, &info, ifsr, 0);
+	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+		       ifsr, 0);
 }
 
 /*
-- 
2.17.1
