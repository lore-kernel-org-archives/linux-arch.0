From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Tue, 21 Jul 2015 15:14:49 +0900
Message-ID: <1437459289-26553-1-git-send-email-ysato@users.sourceforge.jp>
References: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:23405 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbGUGO7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2015 02:14:59 -0400
In-Reply-To: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Current implemantation ptr argument evaluate 2 times.
It'll be an unexpected result.

Changes v3:
Some build error fix.
Changes v2:
Argument x protect.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/asm-generic/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 72d8803..d800a3f 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -163,9 +163,10 @@ static inline __must_check long __copy_to_user(void __user *to,
 
 #define put_user(x, ptr)					\
 ({								\
+	uintptr_t __uip = (uintptr_t)(ptr);			\
 	might_fault();						\
-	access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?		\
-		__put_user(x, ptr) :				\
+	access_ok(VERIFY_WRITE, __uip, sizeof(*ptr)) ?		\
+		__put_user((x), ((__typeof__(*ptr) *)__uip)) :	\
 		-EFAULT;					\
 })
 
@@ -225,9 +226,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 
 #define get_user(x, ptr)					\
 ({								\
+	uintptr_t __uip = (uintptr_t)(ptr);			\
 	might_fault();						\
-	access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?		\
-		__get_user(x, ptr) :				\
+	access_ok(VERIFY_READ, __uip, sizeof(*ptr)) ?		\
+		__get_user((x), (__typeof__(*ptr) *)__uip) :	\
 		-EFAULT;					\
 })
 
-- 
2.1.4
