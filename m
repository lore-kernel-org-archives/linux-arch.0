From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH] fixup! arm64: signal: Allow expansion of the signal frame
Date: Tue, 20 Jun 2017 17:24:36 +0100
Message-ID: <1497975876-7055-1-git-send-email-Dave.Martin@arm.com>
References: <20170619110346.GB3024@e104818-lin.cambridge.arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdFTQYw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 12:24:52 -0400
In-Reply-To: <20170619110346.GB3024@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Convert extra_context.data to a u64 for better ABI independence.
data is renamed to "datap" to give a stronger clue that it is
a pointer.

The binary interface is unchanged.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

I've build-tested this fixup only.

The only change here is to replace the name "data" with "datap" in
appropriate places and change void __user * to u64 appropriately, with
casts in the two places where this value enters and exits the kernel.

 arch/arm64/include/uapi/asm/sigcontext.h |  6 +++---
 arch/arm64/kernel/signal.c               | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 303a48c..f0a76b9 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -98,7 +98,7 @@ struct esr_context {
  * 3) If extra_context is present, it must be followed immediately in
  * sigcontext.__reserved[] by the terminating null _aarch64_ctx.
  *
- * 4) The extra space to which data points must start at the first
+ * 4) The extra space to which datap points must start at the first
  * 16-byte aligned address immediately after the terminating null
  * _aarch64_ctx that follows the extra_context structure in
  * __reserved[].  The extra space may overrun the end of __reserved[],
@@ -111,8 +111,8 @@ struct esr_context {
 
 struct extra_context {
 	struct _aarch64_ctx head;
-	void __user *data;	/* 16-byte aligned pointer to extra space */
-	__u32 size;		/* size in bytes of the extra space */
+	__u64 datap; /* 16-byte aligned pointer to extra space cast to __u64 */
+	__u32 size; /* size in bytes of the extra space */
 	__u32 __reserved[3];
 };
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3602fb7..cb0d008 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -244,7 +244,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 		u32 magic, size;
 		char const __user *userp;
 		struct extra_context const __user *extra;
-		void __user *extra_data;
+		u64 extra_datap;
 		u32 extra_size;
 		struct _aarch64_ctx const __user *end;
 		u32 end_magic, end_size;
@@ -297,7 +297,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			extra = (struct extra_context const __user *)userp;
 			userp += size;
 
-			__get_user_error(extra_data, &extra->data, err);
+			__get_user_error(extra_datap, &extra->datap, err);
 			__get_user_error(extra_size, &extra->size, err);
 			if (err)
 				return err;
@@ -321,14 +321,14 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* Prevent looping/repeated parsing of extra_context */
 			have_extra_context = true;
 
-			base = extra_data;
+			base = (void __user *)extra_datap;
 			if (!IS_ALIGNED((unsigned long)base, 16))
 				goto invalid;
 
 			if (!IS_ALIGNED(extra_size, 16))
 				goto invalid;
 
-			if (extra_data != userp)
+			if (base != userp)
 				goto invalid;
 
 			/* Reject "unreasonably large" frames: */
@@ -337,7 +337,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 
 			/*
 			 * Ignore trailing terminator in __reserved[]
-			 * and start parsing extra_data:
+			 * and start parsing extra data:
 			 */
 			offset = 0;
 			limit = extra_size;
@@ -501,7 +501,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 
 		struct extra_context __user *extra;
 		struct _aarch64_ctx __user *end;
-		void __user *extra_data;
+		u64 extra_datap;
 		u32 extra_size;
 
 		extra = (struct extra_context __user *)userp;
@@ -510,12 +510,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		end = (struct _aarch64_ctx __user *)userp;
 		userp += TERMINATOR_SIZE;
 
-		extra_data = userp;
+		extra_datap = (u64)userp;
 		extra_size = sfp + round_up(user->size, 16) - userp;
 
 		__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
 		__put_user_error(EXTRA_CONTEXT_SIZE, &extra->head.size, err);
-		__put_user_error(extra_data, &extra->data, err);
+		__put_user_error(extra_datap, &extra->datap, err);
 		__put_user_error(extra_size, &extra->size, err);
 
 		/* Add the terminator */
-- 
2.1.4
