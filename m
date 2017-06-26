From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2] arm64: signal: Make parse_user_sigframe() independent of rt_sigframe layout
Date: Mon, 26 Jun 2017 10:25:24 +0100
Message-ID: <1498469124-10308-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbdFZJZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jun 2017 05:25:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-arch@vger.kernel.org

ILP32 support uses the same struct sigcontext as the native ABI (i.e.,
LP64), but a different layout for the rest of the signal frame (since
siginfo_t and ucontext_t are both ABI-dependent).

Since the purpose of parse_user_sigframe() is really to parse sigcontext
and not the whole signal frame, the function does not need to depend
on the layout of rt_sigframe -- the only purpose of the rt_sigframe
pointer is for use as a base to measure the signal frame size.

So, this patch renames the function to make it clear that only the
sigcontext is really being parsed, and makes the sigframe base pointer
generic.  A macro is defined to provide a suitable duck-typed interface
that can be used with both sigframe definitions.

Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e47cd3a..f040893 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -223,16 +223,16 @@ struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
 };
 
-static int parse_user_sigframe(struct user_ctxs *user,
-			       struct rt_sigframe __user *sf)
+static int __parse_user_sigcontext(struct user_ctxs *user,
+				   struct sigcontext __user const *sc,
+				   void __user const *sigframe_base)
 {
-	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
 	struct _aarch64_ctx __user *head;
 	char __user *base = (char __user *)&sc->__reserved;
 	size_t offset = 0;
 	size_t limit = sizeof(sc->__reserved);
 	bool have_extra_context = false;
-	char const __user *const sfp = (char const __user *)sf;
+	char const __user *const sfp = (char const __user *)sigframe_base;
 
 	user->fpsimd = NULL;
 
@@ -366,6 +366,9 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	return -EINVAL;
 }
 
+#define parse_user_sigcontext(user, sf)					\
+	__parse_user_sigcontext(user, &(sf)->uc.uc_mcontext, sf)
+
 static int restore_sigframe(struct pt_regs *regs,
 			    struct rt_sigframe __user *sf)
 {
@@ -391,7 +394,7 @@ static int restore_sigframe(struct pt_regs *regs,
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 	if (err == 0)
-		err = parse_user_sigframe(&user, sf);
+		err = parse_user_sigcontext(&user, sf);
 
 	if (err == 0)
 		err = restore_fpsimd_context(user.fpsimd);
-- 
2.1.4
