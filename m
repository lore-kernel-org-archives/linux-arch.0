From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] fix generic get_user and put_user
Date: Tue, 17 May 2011 14:35:49 -0400
Message-ID: <1305657349-2783-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364Ab1EQSfx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 May 2011 14:35:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org

The generic uaccess.h implements get_user() and put_user() as macros. The
current version of these do not properly handle pointers passed in with
post-increment and the like. In the case of put_user(0, ptr++), ptr gets
incremented twice. Once for the call to access_ok() and once in __put_user().
This patch creates a local copy of the pointer so that it is safe to use
post/pre increment/decrement on the pointer arg.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/uaccess.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 1d0fdf8..5079335 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -162,9 +162,10 @@ static inline __must_check long __copy_to_user(void __user *to,
 
 #define put_user(x, ptr)					\
 ({								\
+	__typeof__(*(ptr)) *__pu_ptr = (ptr);			\
 	might_sleep();						\
-	access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?		\
-		__put_user(x, ptr) :				\
+	access_ok(VERIFY_WRITE, __pu_ptr, sizeof(*ptr)) ?	\
+		__put_user(x, __pu_ptr) :			\
 		-EFAULT;					\
 })
 
@@ -218,9 +219,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 
 #define get_user(x, ptr)					\
 ({								\
+	__typeof__(*(ptr)) *__gu_ptr = (ptr);			\
 	might_sleep();						\
-	access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?		\
-		__get_user(x, ptr) :				\
+	access_ok(VERIFY_READ, __gu_ptr, sizeof(*ptr)) ?	\
+		__get_user(x, __gu_ptr) :			\
 		-EFAULT;					\
 })
 
-- 
1.6.2.5
