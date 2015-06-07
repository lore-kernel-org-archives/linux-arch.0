From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 18/19] ARC: Make way for pt_regs != user_regs_struct
Date: Sun, 7 Jun 2015 14:08:22 +0530
Message-ID: <1433666303-26112-19-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

These have been register compatible so far. However ARCv2 mandates
different pt_regs layout (due to h/w auto save). To keep pt_regs same
for both, we start by removing the assumption - used mainly for block
copies between the 2 structs in signal handling and ptrace

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/ptrace.c | 90 ++++++++++++++++++++++++++++++++++++++++++++----
 arch/arc/kernel/signal.c | 55 +++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index 13b3ffb27a38..4dd9e3a8c2da 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -47,10 +47,47 @@ static int genregs_get(struct task_struct *target,
 			offsetof(struct user_regs_struct, LOC) + 4);
 
 	REG_O_ZERO(pad);
-	REG_O_CHUNK(scratch, callee, ptregs);
+	REG_O_ONE(scratch.bta, &ptregs->bta);
+	REG_O_ONE(scratch.lp_start, &ptregs->lp_start);
+	REG_O_ONE(scratch.lp_end, &ptregs->lp_end);
+	REG_O_ONE(scratch.lp_count, &ptregs->lp_count);
+	REG_O_ONE(scratch.status32, &ptregs->status32);
+	REG_O_ONE(scratch.ret, &ptregs->ret);
+	REG_O_ONE(scratch.blink, &ptregs->blink);
+	REG_O_ONE(scratch.fp, &ptregs->fp);
+	REG_O_ONE(scratch.gp, &ptregs->r26);
+	REG_O_ONE(scratch.r12, &ptregs->r12);
+	REG_O_ONE(scratch.r11, &ptregs->r11);
+	REG_O_ONE(scratch.r10, &ptregs->r10);
+	REG_O_ONE(scratch.r9, &ptregs->r9);
+	REG_O_ONE(scratch.r8, &ptregs->r8);
+	REG_O_ONE(scratch.r7, &ptregs->r7);
+	REG_O_ONE(scratch.r6, &ptregs->r6);
+	REG_O_ONE(scratch.r5, &ptregs->r5);
+	REG_O_ONE(scratch.r4, &ptregs->r4);
+	REG_O_ONE(scratch.r3, &ptregs->r3);
+	REG_O_ONE(scratch.r2, &ptregs->r2);
+	REG_O_ONE(scratch.r1, &ptregs->r1);
+	REG_O_ONE(scratch.r0, &ptregs->r0);
+	REG_O_ONE(scratch.sp, &ptregs->sp);
+
 	REG_O_ZERO(pad2);
-	REG_O_CHUNK(callee, efa, cregs);
-	REG_O_CHUNK(efa, stop_pc, &target->thread.fault_address);
+
+	REG_O_ONE(callee.r25, &cregs->r25);
+	REG_O_ONE(callee.r24, &cregs->r24);
+	REG_O_ONE(callee.r23, &cregs->r23);
+	REG_O_ONE(callee.r22, &cregs->r22);
+	REG_O_ONE(callee.r21, &cregs->r21);
+	REG_O_ONE(callee.r20, &cregs->r20);
+	REG_O_ONE(callee.r19, &cregs->r19);
+	REG_O_ONE(callee.r18, &cregs->r18);
+	REG_O_ONE(callee.r17, &cregs->r17);
+	REG_O_ONE(callee.r16, &cregs->r16);
+	REG_O_ONE(callee.r15, &cregs->r15);
+	REG_O_ONE(callee.r14, &cregs->r14);
+	REG_O_ONE(callee.r13, &cregs->r13);
+
+	REG_O_ONE(efa, &target->thread.fault_address);
 
 	if (!ret) {
 		if (in_brkpt_trap(ptregs)) {
@@ -97,12 +134,51 @@ static int genregs_set(struct task_struct *target,
 			offsetof(struct user_regs_struct, LOC) + 4);
 
 	REG_IGNORE_ONE(pad);
-	/* TBD: disallow updates to STATUS32 etc*/
-	REG_IN_CHUNK(scratch, pad2, ptregs);	/* pt_regs[bta..sp] */
+
+	REG_IN_ONE(scratch.bta, &ptregs->bta);
+	REG_IN_ONE(scratch.lp_start, &ptregs->lp_start);
+	REG_IN_ONE(scratch.lp_end, &ptregs->lp_end);
+	REG_IN_ONE(scratch.lp_count, &ptregs->lp_count);
+
+	REG_IGNORE_ONE(scratch.status32);
+
+	REG_IN_ONE(scratch.ret, &ptregs->ret);
+	REG_IN_ONE(scratch.blink, &ptregs->blink);
+	REG_IN_ONE(scratch.fp, &ptregs->fp);
+	REG_IN_ONE(scratch.gp, &ptregs->r26);
+	REG_IN_ONE(scratch.r12, &ptregs->r12);
+	REG_IN_ONE(scratch.r11, &ptregs->r11);
+	REG_IN_ONE(scratch.r10, &ptregs->r10);
+	REG_IN_ONE(scratch.r9, &ptregs->r9);
+	REG_IN_ONE(scratch.r8, &ptregs->r8);
+	REG_IN_ONE(scratch.r7, &ptregs->r7);
+	REG_IN_ONE(scratch.r6, &ptregs->r6);
+	REG_IN_ONE(scratch.r5, &ptregs->r5);
+	REG_IN_ONE(scratch.r4, &ptregs->r4);
+	REG_IN_ONE(scratch.r3, &ptregs->r3);
+	REG_IN_ONE(scratch.r2, &ptregs->r2);
+	REG_IN_ONE(scratch.r1, &ptregs->r1);
+	REG_IN_ONE(scratch.r0, &ptregs->r0);
+	REG_IN_ONE(scratch.sp, &ptregs->sp);
+
 	REG_IGNORE_ONE(pad2);
-	REG_IN_CHUNK(callee, efa, cregs);	/* callee_regs[r25..r13] */
+
+	REG_IN_ONE(callee.r25, &cregs->r25);
+	REG_IN_ONE(callee.r24, &cregs->r24);
+	REG_IN_ONE(callee.r23, &cregs->r23);
+	REG_IN_ONE(callee.r22, &cregs->r22);
+	REG_IN_ONE(callee.r21, &cregs->r21);
+	REG_IN_ONE(callee.r20, &cregs->r20);
+	REG_IN_ONE(callee.r19, &cregs->r19);
+	REG_IN_ONE(callee.r18, &cregs->r18);
+	REG_IN_ONE(callee.r17, &cregs->r17);
+	REG_IN_ONE(callee.r16, &cregs->r16);
+	REG_IN_ONE(callee.r15, &cregs->r15);
+	REG_IN_ONE(callee.r14, &cregs->r14);
+	REG_IN_ONE(callee.r13, &cregs->r13);
+
 	REG_IGNORE_ONE(efa);			/* efa update invalid */
-	REG_IGNORE_ONE(stop_pc);			/* PC updated via @ret */
+	REG_IGNORE_ONE(stop_pc);		/* PC updated via @ret */
 
 	return ret;
 }
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 2251fb4bbfd7..b99dbbb63239 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -67,7 +67,33 @@ stash_usr_regs(struct rt_sigframe __user *sf, struct pt_regs *regs,
 	       sigset_t *set)
 {
 	int err;
-	err = __copy_to_user(&(sf->uc.uc_mcontext.regs.scratch), regs,
+	struct user_regs_struct uregs;
+
+	uregs.scratch.bta	= regs->bta;
+	uregs.scratch.lp_start	= regs->lp_start;
+	uregs.scratch.lp_end	= regs->lp_end;
+	uregs.scratch.lp_count	= regs->lp_count;
+	uregs.scratch.status32	= regs->status32;
+	uregs.scratch.ret	= regs->ret;
+	uregs.scratch.blink	= regs->blink;
+	uregs.scratch.fp	= regs->fp;
+	uregs.scratch.gp	= regs->r26;
+	uregs.scratch.r12	= regs->r12;
+	uregs.scratch.r11	= regs->r11;
+	uregs.scratch.r10	= regs->r10;
+	uregs.scratch.r9	= regs->r9;
+	uregs.scratch.r8	= regs->r8;
+	uregs.scratch.r7	= regs->r7;
+	uregs.scratch.r6	= regs->r6;
+	uregs.scratch.r5	= regs->r5;
+	uregs.scratch.r4	= regs->r4;
+	uregs.scratch.r3	= regs->r3;
+	uregs.scratch.r2	= regs->r2;
+	uregs.scratch.r1	= regs->r1;
+	uregs.scratch.r0	= regs->r0;
+	uregs.scratch.sp	= regs->sp;
+
+	err = __copy_to_user(&(sf->uc.uc_mcontext.regs.scratch), &uregs.scratch,
 			     sizeof(sf->uc.uc_mcontext.regs.scratch));
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(sigset_t));
 
@@ -78,14 +104,39 @@ static int restore_usr_regs(struct pt_regs *regs, struct rt_sigframe __user *sf)
 {
 	sigset_t set;
 	int err;
+	struct user_regs_struct uregs;
 
 	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
 	if (!err)
 		set_current_blocked(&set);
 
-	err |= __copy_from_user(regs, &(sf->uc.uc_mcontext.regs.scratch),
+	err |= __copy_from_user(&uregs.scratch, &(sf->uc.uc_mcontext.regs.scratch),
 				sizeof(sf->uc.uc_mcontext.regs.scratch));
 
+	regs->bta	= uregs.scratch.bta;
+	regs->lp_start	= uregs.scratch.lp_start;
+	regs->lp_end	= uregs.scratch.lp_end;
+	regs->lp_count	= uregs.scratch.lp_count;
+	regs->status32	= uregs.scratch.status32;
+	regs->ret	= uregs.scratch.ret;
+	regs->blink	= uregs.scratch.blink;
+	regs->fp	= uregs.scratch.fp;
+	regs->r26	= uregs.scratch.gp;
+	regs->r12	= uregs.scratch.r12;
+	regs->r11	= uregs.scratch.r11;
+	regs->r10	= uregs.scratch.r10;
+	regs->r9	= uregs.scratch.r9;
+	regs->r8	= uregs.scratch.r8;
+	regs->r7	= uregs.scratch.r7;
+	regs->r6	= uregs.scratch.r6;
+	regs->r5	= uregs.scratch.r5;
+	regs->r4	= uregs.scratch.r4;
+	regs->r3	= uregs.scratch.r3;
+	regs->r2	= uregs.scratch.r2;
+	regs->r1	= uregs.scratch.r1;
+	regs->r0	= uregs.scratch.r0;
+	regs->sp	= uregs.scratch.sp;
+
 	return err;
 }
 
-- 
1.9.1
