From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 11/27] sh: kprobes: Remove jprobe implementation
Date: Wed, 20 Jun 2018 01:09:28 +0900
Message-ID: <152942456877.15209.5482537226935729621.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/sh.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/kprobes.h |    4 ---
 arch/sh/kernel/kprobes.c      |   51 -----------------------------------------
 2 files changed, 55 deletions(-)

diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index 85d8bcaa8493..6171682f7798 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -27,7 +27,6 @@ struct kprobe;
 
 void arch_remove_kprobe(struct kprobe *);
 void kretprobe_trampoline(void);
-void jprobe_return_end(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
@@ -43,9 +42,6 @@ struct prev_kprobe {
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
-	unsigned long jprobe_saved_r15;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 52a5e11247d1..2b5e58873b96 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -523,57 +523,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_r15 = regs->regs[15];
-	addr = kcb->jprobe_saved_r15;
-
-	/*
-	 * TBD: As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 */
-	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *) addr,
-	       MIN_STACK_SIZE(addr));
-
-	regs->pc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	asm volatile ("trapa #0x3a\n\t" "jprobe_return_end:\n\t" "nop\n\t");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack_addr = kcb->jprobe_saved_r15;
-	u8 *addr = (u8 *)regs->pc;
-
-	if ((addr >= (u8 *)jprobe_return) &&
-	    (addr <= (u8 *)jprobe_return_end)) {
-		*regs = kcb->jprobe_saved_regs;
-
-		memcpy((kprobe_opcode_t *)stack_addr, kcb->jprobes_stack,
-		       MIN_STACK_SIZE(stack_addr));
-
-		kcb->kprobe_status = KPROBE_HIT_SS;
-		preempt_enable_no_resched();
-		return 1;
-	}
-
-	return 0;
-}
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *)&kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
