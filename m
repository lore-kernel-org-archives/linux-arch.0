From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 1/5] arm64: signal: split frame link record from sigcontext structure
Date: Thu, 15 Jun 2017 15:03:38 +0100
Message-ID: <1497535442-11586-2-git-send-email-Dave.Martin@arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFOOEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 10:04:44 -0400
In-Reply-To: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

In order to be able to increase the amount of the data currently
written to the __reserved[] array in the signal frame, it is
necessary to overwrite the locations currently occupied by the
{fp,lr} frame link record pushed at the top of the signal stack.

In order for this to work, this patch detaches the frame link
record from struct rt_sigframe and places it separately at the top
of the signal stack.  This will allow subsequent patches to insert
data between it and __reserved[].

This change relies on the non-ABI status of the placement of the
frame record with respect to struct sigframe: this status is
undocumented, but the placement is not declared or described in the
user headers, and known unwinder implementations (libgcc,
libunwind, gdb) appear not to rely on it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 50 +++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c7b6de6..1e5ed3be 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -19,6 +19,7 @@
 
 #include <linux/compat.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/freezer.h>
@@ -41,10 +42,18 @@
 struct rt_sigframe {
 	struct siginfo info;
 	struct ucontext uc;
+};
+
+struct frame_record {
 	u64 fp;
 	u64 lr;
 };
 
+struct rt_sigframe_user_layout {
+	struct rt_sigframe __user *sigframe;
+	struct frame_record __user *next_frame;
+};
+
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
@@ -162,16 +171,17 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
-static int setup_sigframe(struct rt_sigframe __user *sf,
+static int setup_sigframe(struct rt_sigframe_user_layout *user,
 			  struct pt_regs *regs, sigset_t *set)
 {
 	int i, err = 0;
+	struct rt_sigframe __user *sf = user->sigframe;
 	void *aux = sf->uc.uc_mcontext.__reserved;
 	struct _aarch64_ctx *end;
 
 	/* set up the stack frame for unwinding */
-	__put_user_error(regs->regs[29], &sf->fp, err);
-	__put_user_error(regs->regs[30], &sf->lr, err);
+	__put_user_error(regs->regs[29], &user->next_frame->fp, err);
+	__put_user_error(regs->regs[30], &user->next_frame->lr, err);
 
 	for (i = 0; i < 31; i++)
 		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
@@ -209,34 +219,36 @@ static int setup_sigframe(struct rt_sigframe __user *sf,
 	return err;
 }
 
-static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
-					       struct pt_regs *regs)
+static int get_sigframe(struct rt_sigframe_user_layout *user,
+			 struct ksignal *ksig, struct pt_regs *regs)
 {
 	unsigned long sp, sp_top;
-	struct rt_sigframe __user *frame;
 
 	sp = sp_top = sigsp(regs->sp, ksig);
 
-	sp = (sp - sizeof(struct rt_sigframe)) & ~15;
-	frame = (struct rt_sigframe __user *)sp;
+	sp = round_down(sp - sizeof(struct frame_record), 16);
+	user->next_frame = (struct frame_record __user *)sp;
+
+	sp = round_down(sp - sizeof(struct rt_sigframe), 16);
+	user->sigframe = (struct rt_sigframe __user *)sp;
 
 	/*
 	 * Check that we can actually write to the signal frame.
 	 */
-	if (!access_ok(VERIFY_WRITE, frame, sp_top - sp))
-		frame = NULL;
+	if (!access_ok(VERIFY_WRITE, user->sigframe, sp_top - sp))
+		return -EFAULT;
 
-	return frame;
+	return 0;
 }
 
 static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
-			 void __user *frame, int usig)
+			 struct rt_sigframe_user_layout *user, int usig)
 {
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
-	regs->sp = (unsigned long)frame;
-	regs->regs[29] = regs->sp + offsetof(struct rt_sigframe, fp);
+	regs->sp = (unsigned long)user->sigframe;
+	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
 	if (ka->sa.sa_flags & SA_RESTORER)
@@ -250,20 +262,22 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
+	struct rt_sigframe_user_layout user;
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ksig, regs);
-	if (!frame)
+	if (get_sigframe(&user, ksig, regs))
 		return 1;
 
+	frame = user.sigframe;
+
 	__put_user_error(0, &frame->uc.uc_flags, err);
 	__put_user_error(NULL, &frame->uc.uc_link, err);
 
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(frame, regs, set);
+	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, frame, usig);
+		setup_return(regs, &ksig->ka, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
-- 
2.1.4
