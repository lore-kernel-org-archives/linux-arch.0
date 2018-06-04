From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:51:24 +0900
Message-ID: <152812748464.10068.10380156315388629319.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/arm64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kprobes.h   |    1 -
 arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 6deb8d726041..d5a44cf859e9 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -48,7 +48,6 @@ struct kprobe_ctlblk {
 	unsigned long saved_irqflag;
 	struct prev_kprobe prev_kprobe;
 	struct kprobe_step_ctx ss_ctx;
-	struct pt_regs jprobe_saved_regs;
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..3ca2351109a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,74 +465,6 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	/*
-	 * Since we can't be sure where in the stack frame "stacked"
-	 * pass-by-value arguments are stored we just don't try to
-	 * duplicate any of the stack. Do not use jprobes on functions that
-	 * use more than 64 bytes (after padding each to an 8 byte boundary)
-	 * of arguments, or pass individual arguments larger than 16 bytes.
-	 */
-
-	instruction_pointer_set(regs, (unsigned long) jp->entry);
-	preempt_disable();
-	pause_graph_tracing();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/*
-	 * Jprobe handler return by entering break exception,
-	 * encoded same as kprobe, but with following conditions
-	 * -a special PC to identify it from the other kprobes.
-	 * -restore stack addr to original saved pt_regs
-	 */
-	asm volatile("				mov sp, %0	\n"
-		     "jprobe_return_break:	brk %1		\n"
-		     :
-		     : "r" (kcb->jprobe_saved_regs.sp),
-		       "I" (BRK64_ESR_KPROBES)
-		     : "memory");
-
-	unreachable();
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.sp;
-	long orig_sp = kernel_stack_pointer(regs);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	extern const char jprobe_return_break[];
-
-	if (instruction_pointer(regs) != (u64) jprobe_return_break)
-		return 0;
-
-	if (orig_sp != stack_addr) {
-		struct pt_regs *saved_regs =
-		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
-		pr_err("current sp %lx does not match saved sp %lx\n",
-		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
-		__show_regs(saved_regs);
-		pr_err("Current registers\n");
-		__show_regs(regs);
-		BUG();
-	}
-	unpause_graph_tracing();
-	*regs = kcb->jprobe_saved_regs;
-	preempt_enable_no_resched();
-	return 1;
-}
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	if ((addr >= (unsigned long)__kprobes_text_start &&
