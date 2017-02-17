From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH] asm-generic: Force cast get_user() setting x to 0
Date: Fri, 17 Feb 2017 08:52:29 -0800
Message-ID: <20170217165229.17768-1-stephen.boyd@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35446 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934113AbdBQQwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2017 11:52:31 -0500
Received: by mail-pg0-f48.google.com with SMTP id t188so16925784pgt.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Feb 2017 08:52:31 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

If we call get_user() with an __le* or __be* type sparse will
complain when we assign the result to 0 on the faulting path.
Let's force cast here so that sparse doesn't complain. This
mirrors what we do in __get_user() as well.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

I made a similar fix to arm64 headers, and it looks like asm-generic
would need the same fix.

 include/asm-generic/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index cc6bb319e464..6352d61df7eb 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -227,7 +227,7 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 	might_fault();						\
 	access_ok(VERIFY_READ, __p, sizeof(*ptr)) ?		\
 		__get_user((x), (__typeof__(*(ptr)) *)__p) :	\
-		((x) = (__typeof__(*(ptr)))0,-EFAULT);		\
+		((x) = (__force __typeof__(*(ptr)))0, -EFAULT);	\
 })
 
 #ifndef __get_user_fn
-- 
2.10.0.297.gf6727b0
