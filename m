From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 14/27] kprobes/x86: Don't call ->break_handler() in x86 kprobes
Date: Mon, 28 May 2018 16:06:27 +0900
Message-ID: <152749118700.15132.7596723824971269356.stgit@devbox>
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

Don't call ->break_handler() and remove break_handler
related code since that was only used by jprobe which
got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/kprobes.h   |    2 +-
 arch/x86/kernel/kprobes/common.h |   10 ----------
 arch/x86/kernel/kprobes/core.c   |    7 -------
 arch/x86/kernel/kprobes/ftrace.c |   16 ++--------------
 4 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 06782c2efa04..c8cec1b39b88 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -78,7 +78,7 @@ struct arch_specific_insn {
 	 * boostable = true: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
-	 * a post_handler or break_handler).
+	 * a post_handler).
 	 */
 	bool boostable;
 	bool if_modifier;
diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index ae38dccf0c8f..2b949f4fd4d8 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -105,14 +105,4 @@ static inline unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsig
 }
 #endif
 
-#ifdef CONFIG_KPROBES_ON_FTRACE
-extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-			   struct kprobe_ctlblk *kcb);
-#else
-static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-				  struct kprobe_ctlblk *kcb)
-{
-	return 0;
-}
-#endif
 #endif
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 1b2d1acba810..0ac16a0d93e5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -709,13 +709,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		regs->ip = (unsigned long)addr;
 		preempt_enable_no_resched();
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			if (!skip_singlestep(p, regs, kcb))
-				setup_singlestep(p, regs, kcb, 0);
-			return 1;
-		}
 	} /* else: not a kprobe fault; let the kernel handle it */
 
 	preempt_enable_no_resched();
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 8dc0161cec8f..c8696f2a583f 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -26,7 +26,7 @@
 #include "common.h"
 
 static nokprobe_inline
-void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+void skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_ip)
 {
 	/*
@@ -43,18 +43,6 @@ void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->ip = orig_ip;
 }
 
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p)) {
-		__skip_singlestep(p, regs, kcb, 0);
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -80,7 +68,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			__skip_singlestep(p, regs, kcb, orig_ip);
+			skip_singlestep(p, regs, kcb, orig_ip);
 			preempt_enable_no_resched();
 		}
 		/*
