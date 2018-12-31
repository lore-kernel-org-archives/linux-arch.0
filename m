From: guoren@kernel.org
Subject: [PATCH 10/14] csky: remove unused members in processor.h
Date: Mon, 31 Dec 2018 23:33:01 +0800
Message-ID: <1546270384-4590-9-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Cleanup struct cpuinfo_csky and struct thread_struct, remove all esp0
related code. We could get pt_regs from sp and backtrace could use fp
in switch_stack.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/processor.h | 12 ------------
 arch/csky/kernel/asm-offsets.c    |  1 -
 arch/csky/kernel/entry.S          | 12 ------------
 arch/csky/kernel/ptrace.c         |  4 ----
 arch/csky/kernel/signal.c         |  2 --
 arch/csky/kernel/traps.c          |  6 ------
 arch/csky/mm/fault.c              |  3 ---
 7 files changed, 40 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 5ac3f32..8f45481 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -17,14 +17,7 @@
 #endif
 
 struct cpuinfo_csky {
-	unsigned long udelay_val;
 	unsigned long asid_cache;
-	/*
-	 * Capability and feature descriptor structure for CSKY CPU
-	 */
-	unsigned long options;
-	unsigned int processor_id[4];
-	unsigned int fpu_id;
 } __aligned(SMP_CACHE_BYTES);
 
 extern struct cpuinfo_csky cpu_data[];
@@ -50,11 +43,6 @@ extern struct cpuinfo_csky cpu_data[];
 struct thread_struct {
 	unsigned long  ksp;       /* kernel stack pointer */
 	unsigned long  sr;        /* saved status register */
-	unsigned long  esp0;      /* points to SR of stack frame */
-
-	/* Other stuff associated with the thread. */
-	unsigned long address;      /* Last user fault */
-	unsigned long error_code;
 
 	/* FPU regs */
 	struct user_fp __aligned(16) user_fp;
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 2f07670..9b48b1b 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -20,7 +20,6 @@ int main(void)
 	/* offsets into the thread struct */
 	DEFINE(THREAD_KSP,        offsetof(struct thread_struct, ksp));
 	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
-	DEFINE(THREAD_ESP0,       offsetof(struct thread_struct, esp0));
 	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
 	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
 	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index de378e4..5137ed9 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -122,16 +122,6 @@ ENTRY(csky_systemcall)
 
 	psrset  ee, ie
 
-	/* Stack frame for syscall, origin call set_esp0 */
-	mov     r12, sp
-
-	bmaski  r11, 13
-	andn    r12, r11
-	bgeni   r11, 9
-	addi    r11, 32
-	addu    r12, r11
-	st      sp, (r12, 0)
-
 	lrw     r11, __NR_syscalls
 	cmphs   syscallid, r11		/* Check nr of syscall */
 	bt      ret_from_exception
@@ -230,8 +220,6 @@ resume_userspace:
 1:  RESTORE_ALL
 
 exit_work:
-	mov	a0, sp			/* Stack address is arg[0] */
-	jbsr	set_esp0		/* Call C level */
 	btsti	r8, TIF_NEED_RESCHED
 	bt	work_resched
 	/* If thread_info->flag is empty, RESTORE_ALL */
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index eb62e07..57f1afe 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -50,15 +50,11 @@ static void singlestep_enable(struct task_struct *tsk)
  */
 void user_enable_single_step(struct task_struct *child)
 {
-	if (child->thread.esp0 == 0)
-		return;
 	singlestep_enable(child);
 }
 
 void user_disable_single_step(struct task_struct *child)
 {
-	if (child->thread.esp0 == 0)
-		return;
 	singlestep_disable(child);
 }
 
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 66e1b72..e680dc1 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -238,8 +238,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	if (!user_mode(regs))
 		return;
 
-	current->thread.esp0 = (unsigned long)regs;
-
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index a8368ed..f487a9b 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -106,7 +106,6 @@ void buserr(struct pt_regs *regs)
 	pr_err("User mode Bus Error\n");
 	show_regs(regs);
 
-	current->thread.esp0 = (unsigned long) regs;
 	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc, current);
 }
 
@@ -162,8 +161,3 @@ asmlinkage void trap_c(struct pt_regs *regs)
 	}
 	send_sig(sig, current, 0);
 }
-
-asmlinkage void set_esp0(unsigned long ssp)
-{
-	current->thread.esp0 = ssp;
-}
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 6a94661..d6f4b66 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -172,8 +172,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		tsk->thread.address = address;
-		tsk->thread.error_code = write;
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
@@ -207,6 +205,5 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	if (!user_mode(regs))
 		goto no_context;
 
-	tsk->thread.address = address;
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 }
-- 
2.7.4
