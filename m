From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 40/41] regset(): kill ->get_size()
Date: Mon, 29 Jun 2020 19:26:27 +0100
Message-ID: <20200629182628.529995-40-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

not used anymore

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/kernel/ptrace.c | 13 -------------
 include/linux/regset.h     | 48 +---------------------------------------------
 2 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8745aecffcae..5fb2623b7f13 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -740,18 +740,6 @@ static unsigned int sve_size_from_header(struct user_sve_header const *header)
 	return ALIGN(header->size, SVE_VQ_BYTES);
 }
 
-static unsigned int sve_get_size(struct task_struct *target,
-				 const struct user_regset *regset)
-{
-	struct user_sve_header header;
-
-	if (!system_supports_sve())
-		return 0;
-
-	sve_init_header_from_task(&header, target);
-	return sve_size_from_header(&header);
-}
-
 static int sve_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   struct membuf to)
@@ -1130,7 +1118,6 @@ static const struct user_regset aarch64_regsets[] = {
 		.align = SVE_VQ_BYTES,
 		.get2 = sve_get,
 		.set = sve_set,
-		.get_size = sve_get_size,
 	},
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
diff --git a/include/linux/regset.h b/include/linux/regset.h
index eeabf5cbbbd7..d82bb32e434c 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -133,28 +133,6 @@ typedef int user_regset_writeback_fn(struct task_struct *target,
 				     int immediate);
 
 /**
- * user_regset_get_size_fn - type of @get_size function in &struct user_regset
- * @target:	thread being examined
- * @regset:	regset being examined
- *
- * This call is optional; usually the pointer is %NULL.
- *
- * When provided, this function must return the current size of regset
- * data, as observed by the @get function in &struct user_regset.  The
- * value returned must be a multiple of @size.  The returned size is
- * required to be valid only until the next time (if any) @regset is
- * modified for @target.
- *
- * This function is intended for dynamically sized regsets.  A regset
- * that is statically sized does not need to implement it.
- *
- * This function should not be called directly: instead, callers should
- * call regset_size() to determine the current size of a regset.
- */
-typedef unsigned int user_regset_get_size_fn(struct task_struct *target,
-					     const struct user_regset *regset);
-
-/**
  * struct user_regset - accessible thread CPU state
  * @n:			Number of slots (registers).
  * @size:		Size in bytes of a slot (register).
@@ -165,7 +143,6 @@ typedef unsigned int user_regset_get_size_fn(struct task_struct *target,
  * @set:		Function to store values.
  * @active:		Function to report if regset is active, or %NULL.
  * @writeback:		Function to write data back to user memory, or %NULL.
- * @get_size:		Function to return the regset's size, or %NULL.
  *
  * This data structure describes a machine resource we call a register set.
  * This is part of the state of an individual thread, not necessarily
@@ -173,12 +150,7 @@ typedef unsigned int user_regset_get_size_fn(struct task_struct *target,
  * similar slots, given by @n.  Each slot is @size bytes, and aligned to
  * @align bytes (which is at least @size).  For dynamically-sized
  * regsets, @n must contain the maximum possible number of slots for the
- * regset, and @get_size must point to a function that returns the
- * current regset size.
- *
- * Callers that need to know only the current size of the regset and do
- * not care about its internal structure should call regset_size()
- * instead of inspecting @n or calling @get_size.
+ * regset.
  *
  * For backward compatibility, the @get and @set methods must pad to, or
  * accept, @n * @size bytes, even if the current regset size is smaller.
@@ -218,7 +190,6 @@ struct user_regset {
 	user_regset_set_fn		*set;
 	user_regset_active_fn		*active;
 	user_regset_writeback_fn	*writeback;
-	user_regset_get_size_fn		*get_size;
 	unsigned int			n;
 	unsigned int 			size;
 	unsigned int 			align;
@@ -422,21 +393,4 @@ static inline int copy_regset_from_user(struct task_struct *target,
 	return regset->set(target, regset, offset, size, NULL, data);
 }
 
-/**
- * regset_size - determine the current size of a regset
- * @target:	thread to be examined
- * @regset:	regset to be examined
- *
- * Note that the returned size is valid only until the next time
- * (if any) @regset is modified for @target.
- */
-static inline unsigned int regset_size(struct task_struct *target,
-				       const struct user_regset *regset)
-{
-	if (!regset->get_size)
-		return regset->n * regset->size;
-	else
-		return regset->get_size(target, regset);
-}
-
 #endif	/* <linux/regset.h> */
-- 
2.11.0
