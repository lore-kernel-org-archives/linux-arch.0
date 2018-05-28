From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 09/27] MIPS: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:03:51 +0900
Message-ID: <152749103140.15132.10001281852618363102.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/mips.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/mips/include/asm/kprobes.h |   13 -----------
 arch/mips/kernel/kprobes.c      |   45 ---------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index ad1a99948f27..a72dfbf1babb 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -68,16 +68,6 @@ struct prev_kprobe {
 	unsigned long saved_epc;
 };
 
-#define MAX_JPROBES_STACK_SIZE 128
-#define MAX_JPROBES_STACK_ADDR \
-	(((unsigned long)current_thread_info()) + THREAD_SIZE - 32 - sizeof(struct pt_regs))
-
-#define MIN_JPROBES_STACK_SIZE(ADDR)					\
-	((((ADDR) + MAX_JPROBES_STACK_SIZE) > MAX_JPROBES_STACK_ADDR)	\
-		? MAX_JPROBES_STACK_ADDR - (ADDR)			\
-		: MAX_JPROBES_STACK_SIZE)
-
-
 #define SKIP_DELAYSLOT 0x0001
 
 /* per-cpu kprobe control block */
@@ -86,12 +76,9 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_old_SR;
 	unsigned long kprobe_saved_SR;
 	unsigned long kprobe_saved_epc;
-	unsigned long jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
 	/* Per-thread fields, used while emulating branches */
 	unsigned long flags;
 	unsigned long target_epc;
-	u8 jprobes_stack[MAX_JPROBES_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index f5c8bce70db2..efdcd0b1ce12 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -468,51 +468,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = regs->regs[29];
-
-	memcpy(kcb->jprobes_stack, (void *)kcb->jprobe_saved_sp,
-	       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-
-	regs->cp0_epc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-/* Defined in the inline asm below. */
-void jprobe_return_end(void);
-
-void __kprobes jprobe_return(void)
-{
-	/* Assembler quirk necessitates this '0,code' business.	 */
-	asm volatile(
-		"break 0,%0\n\t"
-		".globl jprobe_return_end\n"
-		"jprobe_return_end:\n"
-		: : "n" (BRK_KPROBE_BP) : "memory");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->cp0_epc >= (unsigned long)jprobe_return &&
-	    regs->cp0_epc <= (unsigned long)jprobe_return_end) {
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)kcb->jprobe_saved_sp, kcb->jprobes_stack,
-		       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-		preempt_enable_no_resched();
-
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Function return probe trampoline:
  *	- init_kprobes() establishes a probepoint here
