From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 2/5] arm64: signal: Refactor sigcontext parsing in rt_sigreturn
Date: Thu, 15 Jun 2017 15:03:39 +0100
Message-ID: <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752406AbdFOOFF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 10:05:05 -0400
In-Reply-To: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Currently, rt_sigreturn does very limited checking on the
sigcontext coming from userspace.

Future additions to the sigcontext data will increase the potential
for surprises.  Also, it is not clear whether the sigcontext
extension records are supposed to occur in a particular order.

To allow the parsing code to be extended more easily, this patch
factors out the sigcontext parsing into a separate function, and
adds extra checks to validate the well-formedness of the sigcontext
structure.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 86 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 1e5ed3be..67769f6 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -23,6 +23,7 @@
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/freezer.h>
+#include <linux/stddef.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
@@ -101,12 +102,86 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+};
+
+static int parse_user_sigframe(struct user_ctxs *user,
+			       struct rt_sigframe __user *sf)
+{
+	struct sigcontext __user *const sc = &sf->uc.uc_mcontext;
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
@@ -125,12 +200,11 @@ static int restore_sigframe(struct pt_regs *regs,
 	regs->syscallno = ~0UL;
 
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
-- 
2.1.4
