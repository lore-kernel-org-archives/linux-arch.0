From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 4/6] arm64: signal: Allocate extra sigcontext space as needed
Date: Wed, 12 Apr 2017 18:01:13 +0100
Message-ID: <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdDLRCr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 13:02:47 -0400
In-Reply-To: <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

This patch modifies the context block allocator to create an
extra_context expansion block as necessary, and adds the necessary
code to populate, parse and decode this block.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  27 ++++++++
 arch/arm64/kernel/signal.c               | 111 ++++++++++++++++++++++++++-----
 2 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 1328a2c..b5e2523 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -80,4 +80,31 @@ struct esr_context {
 	__u64 esr;
 };
 
+/*
+ * Pointer to extra space for additional structures that don't fit in
+ * sigcontext.__reserved[].  Note:
+ *
+ * 1) fpsimd_context, esr_context and extra_context must be placed in
+ * sigcontext.__reserved[] if present.  They cannot be placed in the
+ * extra space.  Any other record can be placed either in the extra
+ * space or in sigcontext.__reserved[].
+ *
+ * 2) There must not be more than one extra_context.
+ *
+ * 3) If extra_context is present, it must be followed immediately in
+ * sigcontext.__reserved[] by the terminating null _aarch64_ctx (i.e.,
+ * extra_context must be the last record in sigcontext.__reserved[]
+ * except for the terminator).
+ *
+ * 4) The extra space must itself be terminated with a null
+ * _aarch64_ctx.
+ */
+#define EXTRA_MAGIC	0x45585401
+
+struct extra_context {
+	struct _aarch64_ctx head;
+	void __user *data;	/* 16-byte aligned pointer to extra space */
+	__u32 size;		/* size in bytes of the extra space */
+};
+
 #endif /* _UAPI__ASM_SIGCONTEXT_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 47592af..95547e1 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/stddef.h>
 #include <linux/uaccess.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
@@ -56,18 +57,27 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long extra_offset;
 	unsigned long end_offset;
 };
 
+#define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
+#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
+#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+
 static void init_user_layout(struct rt_sigframe_user_layout *user)
 {
+	const size_t reserved_size =
+		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
+
 	memset(user, 0, sizeof(*user));
 	user->size = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved);
 
-	user->limit = user->size +
-		sizeof(user->sigframe->uc.uc_mcontext.__reserved) -
-		round_up(sizeof(struct _aarch64_ctx), 16);
-		/* ^ reserve space for terminator */
+	user->limit = user->size + reserved_size;
+
+	user->limit -= TERMINATOR_SIZE;
+	user->limit -= EXTRA_CONTEXT_SIZE;
+	/* Reserve space for extension and terminator ^ */
 }
 
 static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
@@ -75,6 +85,48 @@ static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
 	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
 }
 
+/* Sanity limit on the maximum size of signal frame we'll try to generate. */
+/* This is NOT ABI. */
+#define SIGFRAME_MAXSZ SZ_64K
+
+static int __sigframe_alloc(struct rt_sigframe_user_layout *user,
+			    unsigned long *offset, size_t size, bool extend)
+{
+	size_t padded_size = round_up(size, 16);
+
+	if (padded_size > user->limit - user->size &&
+	    !user->extra_offset &&
+	    extend) {
+		int ret;
+
+		ret = __sigframe_alloc(user, &user->extra_offset,
+				       sizeof(struct extra_context), false);
+		if (ret)
+			return ret;
+
+		/*
+		 * Further allocations must go after the fixed-size
+		 * part of the signal frame:
+		 */
+		user->size = BASE_SIGFRAME_SIZE;
+
+		/*
+		 * Allow expansion up to SIGFRAME_MAXSZ, ensuring space for
+		 * the terminator:
+		 */
+		user->limit = SIGFRAME_MAXSZ - TERMINATOR_SIZE;
+	}
+
+	/* Still not enough space?  Bad luck! */
+	if (padded_size > user->limit - user->size)
+		return -ENOMEM;
+
+	*offset = user->size;
+	user->size += padded_size;
+
+	return 0;
+}
+
 /*
  * Allocate space for an optional record of <size> bytes in the user
  * signal frame.  The offset from the signal frame base address to the
@@ -83,11 +135,24 @@ static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
 static int sigframe_alloc(struct rt_sigframe_user_layout *user,
 			  unsigned long *offset, size_t size)
 {
-	size_t padded_size = round_up(size, 16);
+	return __sigframe_alloc(user, offset, size, true);
+}
 
-	*offset = user->size;
-	user->size += padded_size;
+/* Allocate the null terminator record and prevent further allocations */
+static int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
+{
+	int ret;
+
+	/* Un-reserve the space reserved for the terminator: */
+	user->limit += TERMINATOR_SIZE;
+
+	ret = sigframe_alloc(user, &user->end_offset,
+			     sizeof(struct _aarch64_ctx));
+	if (ret)
+		return ret;
 
+	/* Prevent further allocation: */
+	user->limit = user->size;
 	return 0;
 }
 
@@ -314,17 +379,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 			return err;
 	}
 
-	/*
-	 * Allocate space for the terminator record.
-	 * HACK: here we undo the reservation of space for the end record.
-	 * This bodge should be replaced with a cleaner approach later on.
-	 */
-	user->limit = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved) +
-		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
-
-	err = sigframe_alloc(user, &user->end_offset,
-			     sizeof(struct _aarch64_ctx));
-	return err;
+	return sigframe_alloc_end(user);
 }
 
 
@@ -365,6 +420,26 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (err == 0 && user->extra_offset) {
+		struct extra_context __user *extra =
+			apply_user_offset(user, user->extra_offset);
+		struct _aarch64_ctx __user *end =
+			(struct _aarch64_ctx __user *)((char __user *)extra +
+				round_up(sizeof(*extra), 16));
+		void __user *extra_data =
+			apply_user_offset(user, BASE_SIGFRAME_SIZE);
+		u32 extra_size = round_up(user->size, 16) - BASE_SIGFRAME_SIZE;
+
+		__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
+		__put_user_error(sizeof(*extra), &extra->head.size, err);
+		__put_user_error(extra_data, &extra->data, err);
+		__put_user_error(extra_size, &extra->size, err);
+
+		/* Add the terminator */
+		__put_user_error(0, &end->magic, err);
+		__put_user_error(0, &end->size, err);
+	}
+
 	/* set the "end" magic */
 	if (err == 0) {
 		struct _aarch64_ctx __user *end =
-- 
2.1.4
