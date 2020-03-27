From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 02/14] x86_64: csum_..._copy_..._user(): switch to unsafe_..._user()
Date: Fri, 27 Mar 2020 23:31:05 +0000
Message-ID: <20200327233117.1031393-2-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35894 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC0XbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:19 -0400
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We already have stac/clac pair around the calls of csum_partial_copy_generic().
Stretch that area back, so that it covers the preceding loop (and convert
the loop body from __{get,put}_user() to unsafe_{get,put}_user()).
That brings the beginning of the areas to the earlier access_ok(),
which allows to convert them into user_access_{begin,end}() ones.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/lib/csum-wrappers_64.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 875c2f5968a0..90d02c82bb7a 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -27,7 +27,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 	might_sleep();
 	*errp = 0;
 
-	if (!likely(access_ok(src, len)))
+	if (!likely(user_access_begin(src, len)))
 		goto out_err;
 
 	/*
@@ -42,8 +42,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 		while (((unsigned long)src & 6) && len >= 2) {
 			__u16 val16;
 
-			if (__get_user(val16, (const __u16 __user *)src))
-				goto out_err;
+			unsafe_get_user(val16, (const __u16 __user *)src, out);
 
 			*(__u16 *)dst = val16;
 			isum = (__force __wsum)add32_with_carry(
@@ -53,15 +52,16 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 			len -= 2;
 		}
 	}
-	stac();
 	isum = csum_partial_copy_generic((__force const void *)src,
 				dst, len, isum, errp, NULL);
-	clac();
+	user_access_end();
 	if (unlikely(*errp))
 		goto out_err;
 
 	return isum;
 
+out:
+	user_access_end();
 out_err:
 	*errp = -EFAULT;
 	memset(dst, 0, len);
@@ -89,7 +89,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
 
 	might_sleep();
 
-	if (unlikely(!access_ok(dst, len))) {
+	if (unlikely(!user_access_begin(dst, len))) {
 		*errp = -EFAULT;
 		return 0;
 	}
@@ -100,9 +100,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
 
 			isum = (__force __wsum)add32_with_carry(
 					(__force unsigned)isum, val16);
-			*errp = __put_user(val16, (__u16 __user *)dst);
-			if (*errp)
-				return isum;
+			unsafe_put_user(val16, (__u16 __user *)dst, out);
 			src += 2;
 			dst += 2;
 			len -= 2;
@@ -110,11 +108,14 @@ csum_and_copy_to_user(const void *src, void __user *dst,
 	}
 
 	*errp = 0;
-	stac();
 	ret = csum_partial_copy_generic(src, (void __force *)dst,
 					len, isum, NULL, errp);
-	clac();
+	user_access_end();
 	return ret;
+out:
+	user_access_end();
+	*errp = -EFAULT;
+	return isum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
 
-- 
2.11.0
