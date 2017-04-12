From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 5/6] arm64: signal: Parse extra_context during sigreturn
Date: Wed, 12 Apr 2017 18:01:14 +0100
Message-ID: <1492016495-19689-5-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdDLRDI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 13:03:08 -0400
In-Reply-To: <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

If extra_context is present, parse it.

To avoid abuse by userspace, this patch attempts to ensure that:
 * no more than one extra_context is accepted;
 * the extra_context is a sensible size;
 * the extra context data is properly aligned.

The extra_context data is required to start immediately after
struct rt_sigframe (as during signal delivery).  This serves as a
sanity-check that the signal frame has not been moved or copied
without taking the extra data into account.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  6 ++++-
 arch/arm64/kernel/signal.c               | 46 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index b5e2523..a2f7211 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -96,7 +96,11 @@ struct esr_context {
  * extra_context must be the last record in sigcontext.__reserved[]
  * except for the terminator).
  *
- * 4) The extra space must itself be terminated with a null
+ * 4) The extra space to which data points must start at the first
+ * 16-byte aligned address immediately after the end of the sigcontext
+ * strucutre.
+ *
+ * 5) The extra space must itself be terminated with a null
  * _aarch64_ctx.
  */
 #define EXTRA_MAGIC	0x45585401
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 95547e1..983cddf 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -223,6 +223,10 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	char __user *base = (char __user *)&sc->__reserved;
 	size_t offset = 0;
 	size_t limit = sizeof(sc->__reserved);
+	bool have_extra_context = false;
+
+	/* Expected location of extra_data (if present): */
+	char __user *const extra_base = (char __user *)sf + BASE_SIGFRAME_SIZE;
 
 	user->fpsimd = NULL;
 
@@ -232,6 +236,9 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	while (1) {
 		int err = 0;
 		u32 magic, size;
+		struct extra_context const __user *extra;
+		void __user *extra_data;
+		u32 extra_size;
 
 		if (limit - offset < sizeof(*head))
 			goto invalid;
@@ -269,6 +276,45 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* ignore */
 			break;
 
+		case EXTRA_MAGIC:
+			if (have_extra_context)
+				goto invalid;
+
+			if (size < sizeof(*extra))
+				goto invalid;
+
+			extra = (struct extra_context const __user *)head;
+			__get_user_error(extra_data, &extra->data, err);
+			__get_user_error(extra_size, &extra->size, err);
+			if (err)
+				return err;
+
+			/* Prevent looping/repeated parsing of extra_conext */
+			have_extra_context = true;
+
+			/*
+			 * Rely on the __user accessors to reject bogus
+			 * pointers.
+			 */
+			base = extra_data;
+			if (!IS_ALIGNED((unsigned long)base, 16))
+				goto invalid;
+
+			if (extra_data != extra_base)
+				goto invalid;
+
+			/* Reject "unreasonably large" frames: */
+			limit = extra_size;
+			if (limit > SIGFRAME_MAXSZ - sizeof(sc->__reserved))
+				goto invalid;
+
+			/*
+			 * Ignore trailing terminator in __reserved[]
+			 * and start parsing extra_data:
+			 */
+			offset = 0;
+			continue;
+
 		default:
 			goto invalid;
 		}
-- 
2.1.4
