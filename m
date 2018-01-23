From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 03/10] signal: Don't use structure initializers for struct siginfo
Date: Tue, 23 Jan 2018 15:07:12 -0600
Message-ID: <20180123210719.10456-3-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The siginfo structure has all manners of holes with the result that a
structure initializer is not guaranteed to initialize all of the bits.
As we have to copy the structure to userspace don't even try to use
a structure initializer.  Instead use clear_siginfo followed by initializing
selected fields.  This gives a guarantee that uninitialized kernel memory
is not copied to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/traps.c            | 14 +++++++-----
 arch/arm64/kernel/debug-monitors.c | 13 ++++++-----
 arch/arm64/kernel/ptrace.c         | 13 ++++++-----
 arch/m68k/mm/fault.c               |  3 ++-
 arch/mips/kernel/traps.c           | 29 ++++++++++++++++--------
 arch/tile/kernel/single_step.c     | 24 +++++++++++---------
 arch/tile/kernel/traps.c           |  4 +++-
 arch/tile/kernel/unaligned.c       | 46 +++++++++++++++++++++-----------------
 kernel/signal.c                    |  3 ++-
 9 files changed, 89 insertions(+), 60 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index bcd7c9fc5d0f..c7206789e9ce 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -65,12 +65,14 @@ unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
 #define DO_ERROR_INFO(signr, str, name, sicode) \
 int name(unsigned long address, struct pt_regs *regs) \
 {						\
-	siginfo_t info = {			\
-		.si_signo = signr,		\
-		.si_errno = 0,			\
-		.si_code  = sicode,		\
-		.si_addr = (void __user *)address,	\
-	};					\
+	siginfo_t info;				\
+						\
+	clear_siginfo(&info);			\
+	info.si_signo = signr;			\
+	info.si_errno = 0;			\
+	info.si_code  = sicode;			\
+	info.si_addr = (void __user *)address;	\
+						\
 	return unhandled_exception(str, regs, &info);\
 }
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index a88b6ccebbb4..53781f5687c5 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -209,12 +209,13 @@ NOKPROBE_SYMBOL(call_step_hook);
 static void send_user_sigtrap(int si_code)
 {
 	struct pt_regs *regs = current_pt_regs();
-	siginfo_t info = {
-		.si_signo	= SIGTRAP,
-		.si_errno	= 0,
-		.si_code	= si_code,
-		.si_addr	= (void __user *)instruction_pointer(regs),
-	};
+	siginfo_t info;
+
+	clear_siginfo(&info);
+	info.si_signo	= SIGTRAP;
+	info.si_errno	= 0;
+	info.si_code	= si_code;
+	info.si_addr	= (void __user *)instruction_pointer(regs);
 
 	if (WARN_ON(!user_mode(regs)))
 		return;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 0a1cf830e4b3..95daa1478a7c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -180,12 +180,13 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				struct pt_regs *regs)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
-	siginfo_t info = {
-		.si_signo	= SIGTRAP,
-		.si_errno	= 0,
-		.si_code	= TRAP_HWBKPT,
-		.si_addr	= (void __user *)(bkpt->trigger),
-	};
+	siginfo_t info;
+
+	clear_siginfo(&info);
+	info.si_signo	= SIGTRAP;
+	info.si_errno	= 0;
+	info.si_code	= TRAP_HWBKPT;
+	info.si_addr	= (void __user *)(bkpt->trigger);
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 127d7c1f2090..03253c4f8e6a 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -21,8 +21,9 @@ extern void die_if_kernel(char *, struct pt_regs *, long);
 
 int send_fault_sig(struct pt_regs *regs)
 {
-	siginfo_t siginfo = { 0, 0, 0, };
+	siginfo_t siginfo;
 
+	clear_siginfo(&siginfo);
 	siginfo.si_signo = current->thread.signo;
 	siginfo.si_code = current->thread.code;
 	siginfo.si_addr = (void *)current->thread.faddr;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5d19ed07e99d..0ae4a731cc12 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -699,11 +699,12 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 asmlinkage void do_ov(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
-	siginfo_t info = {
-		.si_signo = SIGFPE,
-		.si_code = FPE_INTOVF,
-		.si_addr = (void __user *)regs->cp0_epc,
-	};
+	siginfo_t info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGFPE;
+	info.si_code = FPE_INTOVF;
+	info.si_addr = (void __user *)regs->cp0_epc;
 
 	prev_state = exception_enter();
 	die_if_kernel("Integer overflow", regs);
@@ -721,7 +722,11 @@ asmlinkage void do_ov(struct pt_regs *regs)
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
-	struct siginfo si = { .si_addr = fault_addr, .si_signo = SIGFPE };
+	struct siginfo si;
+
+	clear_siginfo(&si);
+	si.si_addr = fault_addr;
+	si.si_signo = SIGFPE;
 
 	if (fcr31 & FPU_CSR_INV_X)
 		si.si_code = FPE_FLTINV;
@@ -739,9 +744,10 @@ void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
-	struct siginfo si = { 0 };
+	struct siginfo si;
 	struct vm_area_struct *vma;
 
+	clear_siginfo(&si);
 	switch (sig) {
 	case 0:
 		return 0;
@@ -890,9 +896,10 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	const char *str)
 {
-	siginfo_t info = { 0 };
+	siginfo_t info;
 	char b[40];
 
+	clear_siginfo(&info);
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_TRAP, str, regs, code, current->thread.trap_nr,
 			 SIGTRAP) == NOTIFY_STOP)
@@ -1499,9 +1506,13 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
  */
 asmlinkage void do_watch(struct pt_regs *regs)
 {
-	siginfo_t info = { .si_signo = SIGTRAP, .si_code = TRAP_HWBKPT };
+	siginfo_t info;
 	enum ctx_state prev_state;
 
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_HWBKPT;
+
 	prev_state = exception_enter();
 	/*
 	 * Clear WP (bit 22) bit of cause register so we don't loop
diff --git a/arch/tile/kernel/single_step.c b/arch/tile/kernel/single_step.c
index de3eae813e52..479d8033a801 100644
--- a/arch/tile/kernel/single_step.c
+++ b/arch/tile/kernel/single_step.c
@@ -163,11 +163,13 @@ static tilepro_bundle_bits rewrite_load_store_unaligned(
 	 * actual bad address in an SPR, which it doesn't.
 	 */
 	if (align_ctl == 0) {
-		siginfo_t info = {
-			.si_signo = SIGBUS,
-			.si_code = BUS_ADRALN,
-			.si_addr = addr
-		};
+		siginfo_t info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRALN;
+		info.si_addr = addr;
+
 		trace_unhandled_signal("unaligned trap", regs,
 				       (unsigned long)addr, SIGBUS);
 		force_sig_info(info.si_signo, &info, current);
@@ -210,11 +212,13 @@ static tilepro_bundle_bits rewrite_load_store_unaligned(
 	}
 
 	if (err) {
-		siginfo_t info = {
-			.si_signo = SIGBUS,
-			.si_code = BUS_ADRALN,
-			.si_addr = addr
-		};
+		siginfo_t info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRALN;
+		info.si_addr = addr;
+
 		trace_unhandled_signal("bad address for unaligned fixup", regs,
 				       (unsigned long)addr, SIGBUS);
 		force_sig_info(info.si_signo, &info, current);
diff --git a/arch/tile/kernel/traps.c b/arch/tile/kernel/traps.c
index 9b08c6055f15..83a7186198d7 100644
--- a/arch/tile/kernel/traps.c
+++ b/arch/tile/kernel/traps.c
@@ -256,12 +256,14 @@ static int do_bpt(struct pt_regs *regs)
 void __kprobes do_trap(struct pt_regs *regs, int fault_num,
 		       unsigned long reason)
 {
-	siginfo_t info = { 0 };
+	siginfo_t info;
 	int signo, code;
 	unsigned long address = 0;
 	tile_bundle_bits instr;
 	int is_kernel = !user_mode(regs);
 
+	clear_siginfo(&info);
+
 	/* Handle breakpoints, etc. */
 	if (is_kernel && fault_num == INT_ILL && do_bpt(regs))
 		return;
diff --git a/arch/tile/kernel/unaligned.c b/arch/tile/kernel/unaligned.c
index 8149c38f67b6..77a0b6b6a2a1 100644
--- a/arch/tile/kernel/unaligned.c
+++ b/arch/tile/kernel/unaligned.c
@@ -980,11 +980,13 @@ void jit_bundle_gen(struct pt_regs *regs, tilegx_bundle_bits bundle,
 	}
 
 	if ((align_ctl == 0) || unexpected) {
-		siginfo_t info = {
-			.si_signo = SIGBUS,
-			.si_code = BUS_ADRALN,
-			.si_addr = (unsigned char __user *)0
-		};
+		siginfo_t info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRALN;
+		info.si_addr = (unsigned char __user *)0;
+
 		if (unaligned_printk)
 			pr_info("Unalign bundle: unexp @%llx, %llx\n",
 				(unsigned long long)regs->pc,
@@ -1396,11 +1398,12 @@ void jit_bundle_gen(struct pt_regs *regs, tilegx_bundle_bits bundle,
 				      &frag, sizeof(frag));
 		if (status) {
 			/* Fail to copy JIT into user land. send SIGSEGV. */
-			siginfo_t info = {
-				.si_signo = SIGSEGV,
-				.si_code = SEGV_MAPERR,
-				.si_addr = (void __user *)&jit_code_area[idx]
-			};
+			siginfo_t info;
+
+			clear_siginfo(&info);
+			info.si_signo = SIGSEGV;
+			info.si_code = SEGV_MAPERR;
+			info.si_addr = (void __user *)&jit_code_area[idx];
 
 			pr_warn("Unalign fixup: pid=%d %s jit_code_area=%llx\n",
 				current->pid, current->comm,
@@ -1511,11 +1514,12 @@ void do_unaligned(struct pt_regs *regs, int vecnum)
 	 * If so, we will trigger SIGBUS.
 	 */
 	if ((regs->sp & 0x7) || (regs->ex1) || (align_ctl < 0)) {
-		siginfo_t info = {
-			.si_signo = SIGBUS,
-			.si_code = BUS_ADRALN,
-			.si_addr = (unsigned char __user *)0
-		};
+		siginfo_t info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRALN;
+		info.si_addr = (unsigned char __user *)0;
 
 		if (unaligned_printk)
 			pr_info("Unalign fixup: %d %llx @%llx\n",
@@ -1535,11 +1539,13 @@ void do_unaligned(struct pt_regs *regs, int vecnum)
 	pc = (tilegx_bundle_bits __user *)(regs->pc);
 	if (get_user(bundle, pc) != 0) {
 		/* Probably never be here since pc is valid user address.*/
-		siginfo_t info = {
-			.si_signo = SIGSEGV,
-			.si_code = SEGV_MAPERR,
-			.si_addr = (void __user *)pc
-		};
+		siginfo_t info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGSEGV;
+		info.si_code = SEGV_MAPERR;
+		info.si_addr = (void __user *)pc;
+
 		pr_err("Couldn't read instruction at %p trying to step\n", pc);
 		trace_unhandled_signal("segfault in unalign fixup", regs,
 				       (unsigned long)info.si_addr, SIGSEGV);
diff --git a/kernel/signal.c b/kernel/signal.c
index 4976f05aa09b..f14492ff976f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3163,8 +3163,9 @@ do_send_specific(pid_t tgid, pid_t pid, int sig, struct siginfo *info)
 
 static int do_tkill(pid_t tgid, pid_t pid, int sig)
 {
-	struct siginfo info = {};
+	struct siginfo info;
 
+	clear_siginfo(&info);
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_TKILL;
-- 
2.14.1
