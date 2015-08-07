From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 07/11] test_user_copy: Check __copy_{to,from}_user_inatomic()
Date: Fri, 7 Aug 2015 16:22:00 +0100
Message-ID: <1438960924-23628-8-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:46955 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbbHGPWk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:22:40 -0400
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Andrew Morton <akpm@linux-foundation.org>

Add basic success/failure checking of __copy_to_user_inatomic() and
__copy_from_user_inatomic(). For testing purposes these are similar to
their non-atomic non-checking friends, so the new tests match those for
__copy_to_user() and __copy_from_user().

New tests:
- legitimate __copy_from_user_inatomic
- legitimate __copy_to_user_inatomic
- illegal all-kernel __copy_from_user_inatomic
- illegal reversed __copy_from_user_inatomic
- illegal all-kernel __copy_to_user_inatomic
- illegal reversed __copy_to_user_inatomic
- legitimate all-kernel __copy_from_user_inatomic
- legitimate all-kernel __copy_to_user_inatomic

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 23fb9d15f50c..c002fc1286bd 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -75,8 +75,12 @@ static int __init test_user_copy_init(void)
 		    "legitimate access_ok VERIFY_WRITE failed");
 	ret |= test(__copy_from_user(kmem, usermem, PAGE_SIZE),
 		    "legitimate __copy_from_user failed");
+	ret |= test(__copy_from_user_inatomic(kmem, usermem, PAGE_SIZE),
+		    "legitimate __copy_from_user_inatomic failed");
 	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate __copy_to_user failed");
+	ret |= test(__copy_to_user_inatomic(usermem, kmem, PAGE_SIZE),
+		    "legitimate __copy_to_user_inatomic failed");
 	ret |= test(__get_user(value, (unsigned long __user *)usermem),
 		    "legitimate __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)usermem),
@@ -118,12 +122,25 @@ static int __init test_user_copy_init(void)
 	ret |= test(!__copy_from_user(bad_usermem, (char __user *)kmem,
 				      PAGE_SIZE),
 		    "illegal reversed __copy_from_user passed");
+	ret |= test(!__copy_from_user_inatomic(kmem,
+					(char __user *)(kmem + PAGE_SIZE),
+					PAGE_SIZE),
+		    "illegal all-kernel __copy_from_user_inatomic passed");
+	ret |= test(!__copy_from_user_inatomic(bad_usermem, (char __user *)kmem,
+					       PAGE_SIZE),
+		    "illegal reversed __copy_from_user_inatomic passed");
 	ret |= test(!__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				    PAGE_SIZE),
 		    "illegal all-kernel __copy_to_user passed");
 	ret |= test(!__copy_to_user((char __user *)kmem, bad_usermem,
 				    PAGE_SIZE),
 		    "illegal reversed __copy_to_user passed");
+	ret |= test(!__copy_to_user_inatomic((char __user *)kmem,
+					     kmem + PAGE_SIZE, PAGE_SIZE),
+		    "illegal all-kernel __copy_to_user_inatomic passed");
+	ret |= test(!__copy_to_user_inatomic((char __user *)kmem, bad_usermem,
+					     PAGE_SIZE),
+		    "illegal reversed __copy_to_user_inatomic passed");
 	ret |= test(!__get_user(value, (unsigned long __user *)kmem),
 		    "illegal __get_user passed");
 	ret |= test(!__put_user(value, (unsigned long __user *)kmem),
@@ -157,9 +174,16 @@ static int __init test_user_copy_init(void)
 	ret |= test(__copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
 				     PAGE_SIZE),
 		    "legitimate all-kernel __copy_from_user failed");
+	ret |= test(__copy_from_user_inatomic(kmem,
+					      (char __user *)(kmem + PAGE_SIZE),
+					      PAGE_SIZE),
+		    "legitimate all-kernel __copy_from_user_inatomic failed");
 	ret |= test(__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				   PAGE_SIZE),
 		    "legitimate all-kernel __copy_to_user failed");
+	ret |= test(__copy_to_user_inatomic((char __user *)kmem,
+					    kmem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate all-kernel __copy_to_user_inatomic failed");
 	ret |= test(__get_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)kmem),
-- 
2.3.6
