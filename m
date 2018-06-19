From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 25/27] kprobes/x86: Do not disable preempt on int3 path
Date: Wed, 20 Jun 2018 01:16:17 +0900
Message-ID: <152942497779.15209.2879580696589868291.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since int3 and debug exception(for singlestep) are run with
IRQ disabled and while running single stepping we drop IF
from regs->flags, that path must not be preemptible. So we
can remove the preempt disable/enable calls from that path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
---
 Changes in v3:
  - Split user-side changes to another patch
 Changes in v2:
  - Include user-side changes.
---
 Documentation/kprobes.txt      |   11 +++++------
 arch/x86/kernel/kprobes/core.c |   18 ++++--------------
 arch/x86/kernel/kprobes/opt.c  |    1 -
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 907a3017c0f2..3e9e99ea751b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -566,12 +566,11 @@ the same handler) may run concurrently on different CPUs.
 Kprobes does not use mutexes or allocate memory except during
 registration and unregistration.
 
-Probe handlers are run with preemption disabled.  Depending on the
-architecture and optimization state, handlers may also run with
-interrupts disabled (e.g., kretprobe handlers and optimized kprobe
-handlers run without interrupt disabled on x86/x86-64).  In any case,
-your handler should not yield the CPU (e.g., by attempting to acquire
-a semaphore).
+Probe handlers are run with preemption disabled or interrupt disabled,
+which depends on the architecture and optimization state.  (e.g.,
+kretprobe handlers and optimized kprobe handlers run without interrupt
+disabled on x86/x86-64).  In any case, your handler should not yield
+the CPU (e.g., by attempting to acquire a semaphore, or waiting I/O).
 
 Since a return probe is implemented by replacing the return
 address with the trampoline's address, stack backtraces and calls
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 814e26b7c8a2..f7104b256de7 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -594,7 +594,6 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		 * stepping.
 		 */
 		regs->ip = (unsigned long)p->ainsn.insn;
-		preempt_enable_no_resched();
 		return;
 	}
 #endif
@@ -667,12 +666,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 
 	addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));
 	/*
-	 * We don't want to be preempted for the entire
-	 * duration of kprobe processing. We conditionally
-	 * re-enable preemption at the end of this function,
-	 * and also in reenter_kprobe() and setup_singlestep().
+	 * We don't want to be preempted for the entire duration of kprobe
+	 * processing. Since int3 and debug trap disables irqs and we clear
+	 * IF while singlestepping, it must be no preemptible.
 	 */
-	preempt_disable();
 
 	kcb = get_kprobe_ctlblk();
 	p = get_kprobe(addr);
@@ -694,10 +691,8 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
-			else {
+			else
 				reset_current_kprobe();
-				preempt_enable_no_resched();
-			}
 			return 1;
 		}
 	} else if (*addr != BREAKPOINT_INSTRUCTION) {
@@ -711,11 +706,9 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		 * the original instruction.
 		 */
 		regs->ip = (unsigned long)addr;
-		preempt_enable_no_resched();
 		return 1;
 	} /* else: not a kprobe fault; let the kernel handle it */
 
-	preempt_enable_no_resched();
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
@@ -966,8 +959,6 @@ int kprobe_debug_handler(struct pt_regs *regs)
 	}
 	reset_current_kprobe();
 out:
-	preempt_enable_no_resched();
-
 	/*
 	 * if somebody else is singlestepping across a probe point, flags
 	 * will have TF set, in which case, continue the remaining processing
@@ -1014,7 +1005,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 			restore_previous_kprobe(kcb);
 		else
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
 		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
 		/*
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 203d398802a3..eaf02f2e7300 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -491,7 +491,6 @@ int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter)
 		regs->ip = (unsigned long)op->optinsn.insn + TMPL_END_IDX;
 		if (!reenter)
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 	return 0;
