From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 4/6] MIPS: Use update{,_tsk}_thread_flag()
Date: Thu, 19 Apr 2018 11:58:46 +0100
Message-ID: <1524135528-28561-5-git-send-email-Dave.Martin@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This patch uses the new update_thread_flag() helpers to simplify a
couple of if () set; else clear; constructs.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/mips/kernel/elf.c     | 10 ++--------
 arch/mips/kernel/process.c | 15 ++++++---------
 arch/mips/kernel/ptrace.c  |  5 +----
 arch/mips/kernel/syscall.c | 10 ++--------
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 731325a..2351509 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -267,14 +267,8 @@ int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
 
 static inline void set_thread_fp_mode(int hybrid, int regs32)
 {
-	if (hybrid)
-		set_thread_flag(TIF_HYBRID_FPREGS);
-	else
-		clear_thread_flag(TIF_HYBRID_FPREGS);
-	if (regs32)
-		set_thread_flag(TIF_32BIT_FPREGS);
-	else
-		clear_thread_flag(TIF_32BIT_FPREGS);
+	update_thread_flag(TIF_HYBRID_FPREGS, hybrid);
+	update_thread_flag(TIF_32BIT_FPREGS, regs32);
 }
 
 void mips_set_personality_fp(struct arch_elf_state *state)
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index b9e9bf6..4bdecb6 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -763,18 +763,15 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	 */
 	for_each_thread(task, t) {
 		/* Update desired FP register width */
-		if (value & PR_FP_MODE_FR) {
-			clear_tsk_thread_flag(t, TIF_32BIT_FPREGS);
-		} else {
-			set_tsk_thread_flag(t, TIF_32BIT_FPREGS);
+		update_tsk_thread_flag(t, TIF_32BIT_REGS,
+				       !(value & PR_FP_MODE_FR));
+
+		if (!(value & PR_FP_MODE_FR))
 			clear_tsk_thread_flag(t, TIF_MSA_CTX_LIVE);
-		}
 
 		/* Update desired FP single layout */
-		if (value & PR_FP_MODE_FRE)
-			set_tsk_thread_flag(t, TIF_HYBRID_FPREGS);
-		else
-			clear_tsk_thread_flag(t, TIF_HYBRID_FPREGS);
+		update_tsk_thread_flag(t, TIF_HYBRID_FPREGS,
+				       value & PR_FP_MODE_FRE);
 	}
 
 	/* Allow threads to use FP again */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0b23b1a..b218812 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -279,10 +279,7 @@ int ptrace_set_watch_regs(struct task_struct *child,
 		child->thread.watch.mips3264.watchhi[i] = ht[i];
 	}
 
-	if (watch_active)
-		set_tsk_thread_flag(child, TIF_LOAD_WATCH);
-	else
-		clear_tsk_thread_flag(child, TIF_LOAD_WATCH);
+	update_tsk_thread_flag(child, TIF_LOAD_WATCH, watch_active);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 69c17b5..e9fa130 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -209,14 +209,8 @@ SYSCALL_DEFINE3(sysmips, long, cmd, long, arg1, long, arg2)
 		if (arg1 & ~3)
 			return -EINVAL;
 
-		if (arg1 & 1)
-			set_thread_flag(TIF_FIXADE);
-		else
-			clear_thread_flag(TIF_FIXADE);
-		if (arg1 & 2)
-			set_thread_flag(TIF_LOGADE);
-		else
-			clear_thread_flag(TIF_LOGADE);
+		update_thread_flag(TIF_FIXADE, arg1 & 1);
+		update_thread_flag(TIF_LOGADE, arg1 & 2);
 
 		return 0;
 
-- 
2.1.4
