From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Wed, 22 Jul 2015 23:52:36 +0900
Message-ID: <1437576756-28388-1-git-send-email-ysato@users.sourceforge.jp>
References: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:61993 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbbGVOwo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2015 10:52:44 -0400
In-Reply-To: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Current implemantation ptr argument evaluate 2 times.
It'll be an unexpected result.

Changes v4:
Temporary pointer type change to const void*
Changes v3:
Some build error fix.
Changes v2:
Argument x protect.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/asm-generic/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 72d8803..f02e696 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -163,9 +163,10 @@ static inline __must_check long __copy_to_user(void __user *to,
 
 #define put_user(x, ptr)					\
 ({								\
+	const void *__p = (ptr);				\
 	might_fault();						\
-	access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?		\
-		__put_user(x, ptr) :				\
+	access_ok(VERIFY_WRITE, __p, sizeof(*ptr)) ?		\
+		__put_user((x), ((__typeof__(*(ptr)) *)__p)) :	\
 		-EFAULT;					\
 })
 
@@ -225,9 +226,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 
 #define get_user(x, ptr)					\
 ({								\
+	const void *__p = (ptr);				\
 	might_fault();						\
-	access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?		\
-		__get_user(x, ptr) :				\
+	access_ok(VERIFY_READ, __p, sizeof(*ptr)) ?		\
+		__get_user((x), (__typeof__(*(ptr)) *)__p) :	\
 		-EFAULT;					\
 })
 
-- 
2.1.4
