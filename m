Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753636AbeE1HFU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:05:20 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 11/27] sh: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:04:54 +0900
Message-ID: <152749109389.15132.10242898017621579145.stgit@devbox>
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
Message-ID: <20180528070454.9SopdzS-4qsd413GXTB0AMr6cn-qDfnRB9DeuFiGKsw@z>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/sh.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
