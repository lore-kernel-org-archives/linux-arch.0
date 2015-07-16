Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:54673 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbGPFgg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 01:36:36 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Thu, 16 Jul 2015 14:15:22 +0900
Message-ID: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org
Message-ID: <20150716051522.JP0luqPyMJWQ41PH0bad4bSpU6O8ZvQZBHVwOjA61Aw@z>

Current implemantation ptr argument evaluate 2 times.
It'll be an unexpected result.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/asm-generic/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 72d8803..1b813fb 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -163,9 +163,10 @@ static inline __must_check long __copy_to_user(void __user *to,
 
 #define put_user(x, ptr)					\
 ({								\
+	__typeof__((ptr)) __p = (ptr);				\
 	might_fault();						\
-	access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?		\
-		__put_user(x, ptr) :				\
+	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?		\
+		__put_user(x, __p) :				\
 		-EFAULT;					\
 })
 
@@ -225,9 +226,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 
 #define get_user(x, ptr)					\
 ({								\
+	__typeof__((ptr)) __p = (ptr);				\
 	might_fault();						\
-	access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?		\
-		__get_user(x, ptr) :				\
+	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?		\
+		__get_user(x, __p) :				\
 		-EFAULT;					\
 })
 
-- 
2.1.4

