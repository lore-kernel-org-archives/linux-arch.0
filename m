From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 1/6] arm64: signal: Refactor sigcontext parsing in rt_sigreturn
Date: Wed, 12 Apr 2017 18:01:10 +0100
Message-ID: <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdDLRBp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 13:01:45 -0400
In-Reply-To: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Currently, rt_sigreturn does very limited checking on the
sigcontext coming from userspace.

Future additions of extra dynamic sigcontext data will increase the
potential for surprises.  Also, it is not clear whether the
sigcontext extension records are supposed to occur in a particular
order.

This patch factors out the sigcontext parsing into a separate
function, and adds extra checks to validate the well-formedness of
the sigcontext structure.

To help with this, an abstraction for the signal frame layout is
also added, using offsets to track the location of different
records in the frame.  Although trivial, this provides a base to
extend upon in order to track more complex layouts.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 121 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index afed8f5..d4c5e3e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -19,9 +19,11 @@
 
 #include <linux/compat.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/freezer.h>
+#include <linux/stddef.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
@@ -45,6 +47,10 @@ struct rt_sigframe {
 	u64 lr;
 };
 
+struct rt_sigframe_user_layout {
+	struct rt_sigframe __user *sigframe;
+};
+
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
@@ -92,12 +98,86 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+};
+
+static int parse_user_sigframe(struct user_ctxs *user,
+			       struct rt_sigframe __user *sf)
+{
+	struct sigcontext __user *sc = &sf->uc.uc_mcontext;
+	struct _aarch64_ctx __user *head =
+		(struct _aarch64_ctx __user *)&sc->__reserved;
+	size_t offset = 0;
+
+	user->fpsimd = NULL;
+
+	while (1) {
+		int err;
+		u32 magic, size;
+
+		head = (struct _aarch64_ctx __user *)&sc->__reserved[offset];
+		if (!IS_ALIGNED((unsigned long)head, 16))
+			goto invalid;
+
+		err = 0;
+		__get_user_error(magic, &head->magic, err);
+		__get_user_error(size, &head->size, err);
+		if (err)
+			return err;
+
+		switch (magic) {
+		case 0:
+			if (size)
+				goto invalid;
+
+			goto done;
+
+		case FPSIMD_MAGIC:
+			if (user->fpsimd)
+				goto invalid;
+
+			if (offset > sizeof(sc->__reserved) -
+					sizeof(*user->fpsimd) ||
+			    size < sizeof(*user->fpsimd))
+				goto invalid;
+
+			user->fpsimd = (struct fpsimd_context __user *)head;
+			break;
+
+		case ESR_MAGIC:
+			/* ignore */
+			break;
+
+		default:
+			goto invalid;
+		}
+
+		if (size < sizeof(*head))
+			goto invalid;
+
+		if (size > sizeof(sc->__reserved) - (sizeof(*head) + offset))
+			goto invalid;
+
+		offset += size;
+	}
+
+done:
+	if (!user->fpsimd)
+		goto invalid;
+
+	return 0;
+
+invalid:
+	return -EINVAL;
+}
+
 static int restore_sigframe(struct pt_regs *regs,
 			    struct rt_sigframe __user *sf)
 {
 	sigset_t set;
 	int i, err;
-	void *aux = sf->uc.uc_mcontext.__reserved;
+	struct user_ctxs user;
 
 	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
 	if (err == 0)
@@ -116,12 +196,11 @@ static int restore_sigframe(struct pt_regs *regs,
 	zap_syscall(regs);
 
 	err |= !valid_user_regs(&regs->user_regs, current);
+	if (err == 0)
+		err = parse_user_sigframe(&user, sf);
 
-	if (err == 0) {
-		struct fpsimd_context *fpsimd_ctx =
-			container_of(aux, struct fpsimd_context, head);
-		err |= restore_fpsimd_context(fpsimd_ctx);
-	}
+	if (err == 0)
+		err = restore_fpsimd_context(user.fpsimd);
 
 	return err;
 }
@@ -162,10 +241,11 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
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
 
@@ -209,33 +289,32 @@ static int setup_sigframe(struct rt_sigframe __user *sf,
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
 
 	sp = (sp - sizeof(struct rt_sigframe)) & ~15;
-	frame = (struct rt_sigframe __user *)sp;
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
+	regs->sp = (unsigned long)user->sigframe;
 	regs->regs[29] = regs->sp + offsetof(struct rt_sigframe, fp);
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
@@ -250,20 +329,22 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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
