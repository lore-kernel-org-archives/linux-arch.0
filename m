From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 2/6] arm64: signal: factor frame layout and population into separate passes
Date: Wed, 12 Apr 2017 18:01:11 +0100
Message-ID: <1492016495-19689-2-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdDLRCF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 13:02:05 -0400
In-Reply-To: <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

In preparation for expanding the signal frame, this patch refactors
the signal frame setup code in setup_sigframe() into two separate
passes.

The first pass, setup_sigframe_layout(), determines the size of the
signal frame and its internal layout, including the presence and
location of optional records.  The resulting knowledge is used to
allocate and locate the user stack space required for the signal
frame and to determine which optional records to include.

The second pass, setup_sigframe(), is called once the stack frame
is allocated in order to populate it with the necessary context
information.

As a result of these changes, it becomes more natural to represent
locations in the signal frame by a base pointer and an offset,
since the absolute address of each location is not known during the
layout pass.  To be more consistent with this logic,
parse_user_sigframe() is refactored to describe signal frame
locations in the same way.  This enables a common representation
(struct rt_sigframe_user_layout) of the signal frame layout to be
used in all relevant code.

This change has no effect on the signal ABI, but will make it
easier to expand the signal frame in future patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 112 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d4c5e3e..6202753 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/stddef.h>
 #include <linux/uaccess.h>
+#include <linux/string.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
 
@@ -49,8 +50,39 @@ struct rt_sigframe {
 
 struct rt_sigframe_user_layout {
 	struct rt_sigframe __user *sigframe;
+
+	unsigned long size;	/* size of allocated sigframe data */
+	unsigned long limit;	/* largest allowed size */
+
+	unsigned long fpsimd_offset;
+	unsigned long esr_offset;
+	unsigned long end_offset;
 };
 
+static void init_user_layout(struct rt_sigframe_user_layout *user)
+{
+	memset(user, 0, sizeof(*user));
+	user->size = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved);
+
+	user->limit = user->size +
+		sizeof(user->sigframe->uc.uc_mcontext.__reserved) -
+		round_up(sizeof(struct _aarch64_ctx), 16);
+		/* ^ reserve space for terminator */
+}
+
+static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
+{
+	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
+}
+
+static void __user *apply_user_offset(
+	struct rt_sigframe_user_layout const *user, unsigned long offset)
+{
+	char __user *base = (char __user *)user->sigframe;
+
+	return base + offset;
+}
+
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
@@ -106,26 +138,35 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
 {
 	struct sigcontext __user *sc = &sf->uc.uc_mcontext;
-	struct _aarch64_ctx __user *head =
-		(struct _aarch64_ctx __user *)&sc->__reserved;
+	struct _aarch64_ctx __user *head;
+	char __user *base = (char __user *)&sc->__reserved;
 	size_t offset = 0;
+	size_t limit = sizeof(sc->__reserved);
 
 	user->fpsimd = NULL;
 
+	if (!IS_ALIGNED((unsigned long)base, 16))
+		goto invalid;
+
 	while (1) {
-		int err;
+		int err = 0;
 		u32 magic, size;
 
-		head = (struct _aarch64_ctx __user *)&sc->__reserved[offset];
-		if (!IS_ALIGNED((unsigned long)head, 16))
+		if (limit - offset < sizeof(*head))
 			goto invalid;
 
-		err = 0;
+		if (!IS_ALIGNED(offset, 16))
+			goto invalid;
+
+		head = (struct _aarch64_ctx __user *)(base + offset);
 		__get_user_error(magic, &head->magic, err);
 		__get_user_error(size, &head->size, err);
 		if (err)
 			return err;
 
+		if (limit - offset < size)
+			goto invalid;
+
 		switch (magic) {
 		case 0:
 			if (size)
@@ -137,9 +178,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->fpsimd)
 				goto invalid;
 
-			if (offset > sizeof(sc->__reserved) -
-					sizeof(*user->fpsimd) ||
-			    size < sizeof(*user->fpsimd))
+			if (size < sizeof(*user->fpsimd))
 				goto invalid;
 
 			user->fpsimd = (struct fpsimd_context __user *)head;
@@ -156,7 +195,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 		if (size < sizeof(*head))
 			goto invalid;
 
-		if (size > sizeof(sc->__reserved) - (sizeof(*head) + offset))
+		if (limit - offset < size)
 			goto invalid;
 
 		offset += size;
@@ -241,13 +280,30 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
+/* Determine the layout of optional records in the signal frame */
+static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
+{
+	user->fpsimd_offset = user->size;
+	user->size += round_up(sizeof(struct fpsimd_context), 16);
+
+	/* fault information, if valid */
+	if (current->thread.fault_code) {
+		user->esr_offset = user->size;
+		user->size += round_up(sizeof(struct esr_context), 16);
+	}
+
+	/* set the "end" magic */
+	user->end_offset = user->size;
+
+	return 0;
+}
+
+
 static int setup_sigframe(struct rt_sigframe_user_layout *user,
 			  struct pt_regs *regs, sigset_t *set)
 {
 	int i, err = 0;
 	struct rt_sigframe __user *sf = user->sigframe;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-	struct _aarch64_ctx *end;
 
 	/* set up the stack frame for unwinding */
 	__put_user_error(regs->regs[29], &sf->fp, err);
@@ -265,26 +321,29 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
 	if (err == 0) {
-		struct fpsimd_context *fpsimd_ctx =
-			container_of(aux, struct fpsimd_context, head);
+		struct fpsimd_context __user *fpsimd_ctx =
+			apply_user_offset(user, user->fpsimd_offset);
 		err |= preserve_fpsimd_context(fpsimd_ctx);
-		aux += sizeof(*fpsimd_ctx);
 	}
 
 	/* fault information, if valid */
-	if (current->thread.fault_code) {
-		struct esr_context *esr_ctx =
-			container_of(aux, struct esr_context, head);
+	if (err == 0 && user->esr_offset) {
+		struct esr_context __user *esr_ctx =
+			apply_user_offset(user, user->esr_offset);
+
 		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
 		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
-		aux += sizeof(*esr_ctx);
 	}
 
 	/* set the "end" magic */
-	end = aux;
-	__put_user_error(0, &end->magic, err);
-	__put_user_error(0, &end->size, err);
+	if (err == 0) {
+		struct _aarch64_ctx __user *end =
+			apply_user_offset(user, user->end_offset);
+
+		__put_user_error(0, &end->magic, err);
+		__put_user_error(0, &end->size, err);
+	}
 
 	return err;
 }
@@ -293,10 +352,15 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 			 struct ksignal *ksig, struct pt_regs *regs)
 {
 	unsigned long sp, sp_top;
+	int err;
 
-	sp = sp_top = sigsp(regs->sp, ksig);
+	init_user_layout(user);
+	err = setup_sigframe_layout(user);
+	if (err)
+		return err;
 
-	sp = (sp - sizeof(struct rt_sigframe)) & ~15;
+	sp = sp_top = sigsp(regs->sp, ksig);
+	sp = (sp & ~15) - sigframe_size(user);
 	user->sigframe = (struct rt_sigframe __user *)sp;
 
 	/*
-- 
2.1.4
