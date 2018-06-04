From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 04/27] ARC: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:50:26 +0900
Message-ID: <152812742672.10068.6794442189016791113.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/kprobes.h |    2 --
 arch/arc/kernel/kprobes.c      |   38 ++------------------------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/arc/include/asm/kprobes.h b/arch/arc/include/asm/kprobes.h
index 2e52d18e6bc7..2c1b479d5aea 100644
--- a/arch/arc/include/asm/kprobes.h
+++ b/arch/arc/include/asm/kprobes.h
@@ -45,8 +45,6 @@ struct prev_kprobe {
 
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 42b05046fad9..7811a6bbe8f0 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -225,10 +225,8 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 
 		/* If we have no pre-handler or it returned 0, we continue with
 		 * normal processing. If we have a pre-handler and it returned
-		 * non-zero - which is expected from setjmp_pre_handler for
-		 * jprobe, we return without single stepping and leave that to
-		 * the break-handler which is invoked by a kprobe from
-		 * jprobe_return
+		 * non-zero - which means user handler setup registers to exit
+		 * to another instruction, we must skip the single stepping.
 		 */
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			setup_singlestep(p, regs);
@@ -386,38 +384,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr = regs->sp;
-
-	kcb->jprobe_saved_regs = *regs;
-	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
-	regs->ret = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	__asm__ __volatile__("unimp_s");
-	return;
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr;
-
-	*regs = kcb->jprobe_saved_regs;
-	sp_addr = regs->sp;
-	memcpy((void *)sp_addr, kcb->jprobes_stack, MIN_STACK_SIZE(sp_addr));
-	preempt_enable_no_resched();
-
-	return 1;
-}
-
 static void __used kretprobe_trampoline_holder(void)
 {
 	__asm__ __volatile__(".global kretprobe_trampoline\n"
