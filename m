From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 12/27] sparc64: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:05:25 +0900
Message-ID: <152749112496.15132.2606036082593246054.stgit@devbox>
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
from arch/sparc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/sparc/include/asm/kprobes.h |    1 -
 arch/sparc/kernel/kprobes.c      |   47 --------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 3704490b4488..bfcaa6326c20 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -44,7 +44,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_orig_tnpc;
 	unsigned long kprobe_orig_tstate_pil;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index ab4ba4347941..f555711da8f1 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -441,53 +441,6 @@ asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 	exception_exit(prev_state);
 }
 
-/* Jprobes support.  */
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&(kcb->jprobe_saved_regs), regs, sizeof(*regs));
-
-	regs->tpc  = (unsigned long) jp->entry;
-	regs->tnpc = ((unsigned long) jp->entry) + 0x4UL;
-	regs->tstate |= TSTATE_PIL;
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	register unsigned long orig_fp asm("g1");
-
-	orig_fp = kcb->jprobe_saved_regs.u_regs[UREG_FP];
-	__asm__ __volatile__("\n"
-"1:	cmp		%%sp, %0\n\t"
-	"blu,a,pt	%%xcc, 1b\n\t"
-	" restore\n\t"
-	".globl		jprobe_return_trap_instruction\n"
-"jprobe_return_trap_instruction:\n\t"
-	"ta		0x70"
-	: /* no outputs */
-	: "r" (orig_fp));
-}
-
-extern void jprobe_return_trap_instruction(void);
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	u32 *addr = (u32 *) regs->tpc;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (addr == (u32 *) jprobe_return_trap_instruction) {
-		memcpy(regs, &(kcb->jprobe_saved_regs), sizeof(*regs));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 /* The value stored in the return address register is actually 2
  * instructions before where the callee will return to.
  * Sequences usually look something like this
