From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2 01/20] xtensa: fix access check in csum_and_copy_from_user
Date: Fri, 24 Jul 2020 02:25:27 +0100
Message-ID: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGXBZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:47 -0400
In-Reply-To: <20200724012512.GK2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

Commit d341659f470b ("xtensa: switch to providing
csum_and_copy_from_user()") introduced access check, but incorrectly
tested dst instead of src.
Fix access_ok argument in csum_and_copy_from_user.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: d341659f470b ("xtensa: switch to providing csum_and_copy_from_user()")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index d8292cc9ebdf..243a5fe79d3c 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -57,7 +57,7 @@ static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len, __wsum sum, int *err_ptr)
 {
-	if (access_ok(dst, len))
+	if (access_ok(src, len))
 		return csum_partial_copy_generic((__force const void *)src, dst,
 					len, sum, err_ptr, NULL);
 	if (len)
-- 
2.11.0
