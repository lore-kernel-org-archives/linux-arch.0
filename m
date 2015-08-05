Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:32149 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbHEPt3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:49:29 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4/7] test_user_copy: Check __copy_in_user()/copy_in_user()
Date: Wed, 5 Aug 2015 16:48:52 +0100
Message-ID: <1438789735-4643-5-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150805154852.X4tNmMu_Ol3txJUouzE6fvPLdO4YAk5BPdGm4SQi3z0@z>

Add basic success/failure checking of copy_in_user() which copies data
from userspace to userspace (or kernel to kernel), and its unchecking
cousin __copy_in_user() which assumes that access_ok() has already been
used as appropriate.

The following cases are checked:
- __copy_in_user/copy_in_user from user to user should succeed.
- __copy_in_user/copy_in_user involving 1 or 2 kernel pointers should
  not succeed.
- __copy_in_user/copy_in_user from kernel to kernel should succeed when
  user address limit is set for kernel accesses.

New tests:
- legitimate copy_in_user
- legitimate __copy_in_user
- illegal all-kernel copy_in_user
- illegal copy_in_user to kernel
- illegal copy_in_user from kernel
- illegal all-kernel __copy_in_user
- illegal __copy_in_user to kernel
- illegal __copy_in_user from kernel
- legitimate all-kernel copy_in_user
- legitimate all-kernel __copy_in_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 4ec2cfa916c1..310e796beef6 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -64,6 +64,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate copy_from_user failed");
 	ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate copy_to_user failed");
+	ret |= test(copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate copy_in_user failed");
 	ret |= test(get_user(value, (unsigned long __user *)usermem),
 		    "legitimate get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)usermem),
@@ -79,6 +81,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate __copy_from_user failed");
 	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate __copy_to_user failed");
+	ret |= test(__copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)usermem),
 		    "legitimate __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)usermem),
@@ -99,6 +103,15 @@ static int __init test_user_copy_init(void)
 	ret |= test(!copy_to_user((char __user *)kmem, bad_usermem,
 				  PAGE_SIZE),
 		    "illegal reversed copy_to_user passed");
+	ret |= test(!copy_in_user((char __user *)kmem,
+				  (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "illegal all-kernel copy_in_user passed");
+	ret |= test(!copy_in_user((char __user *)kmem, usermem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user to kernel passed");
+	ret |= test(!copy_in_user(usermem, (char __user *)kmem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user from kernel passed");
 	ret |= test(!get_user(value, (unsigned long __user *)kmem),
 		    "illegal get_user passed");
 	ret |= test(!put_user(value, (unsigned long __user *)kmem),
@@ -130,6 +143,16 @@ static int __init test_user_copy_init(void)
 	ret |= test(!__copy_to_user((char __user *)kmem, bad_usermem,
 				    PAGE_SIZE),
 		    "illegal reversed __copy_to_user passed");
+	ret |= test(!__copy_in_user((char __user *)kmem,
+				    (char __user *)(kmem + PAGE_SIZE),
+				    PAGE_SIZE),
+		    "illegal all-kernel __copy_in_user passed");
+	ret |= test(!__copy_in_user((char __user *)kmem, usermem,
+				    PAGE_SIZE),
+		    "illegal __copy_in_user to kernel passed");
+	ret |= test(!__copy_in_user(usermem, (char __user *)kmem,
+				    PAGE_SIZE),
+		    "illegal __copy_in_user from kernel passed");
 	ret |= test(!__get_user(value, (unsigned long __user *)kmem),
 		    "illegal __get_user passed");
 	ret |= test(!__put_user(value, (unsigned long __user *)kmem),
@@ -152,6 +175,9 @@ static int __init test_user_copy_init(void)
 	ret |= test(copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				 PAGE_SIZE),
 		    "legitimate all-kernel copy_to_user failed");
+	ret |= test(copy_in_user((char __user *)kmem,
+				 (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "legitimate all-kernel copy_in_user failed");
 	ret |= test(get_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)kmem),
@@ -170,6 +196,10 @@ static int __init test_user_copy_init(void)
 	ret |= test(__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				   PAGE_SIZE),
 		    "legitimate all-kernel __copy_to_user failed");
+	ret |= test(__copy_in_user((char __user *)kmem,
+				   (char __user *)(kmem + PAGE_SIZE),
+				   PAGE_SIZE),
+		    "legitimate all-kernel __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)kmem),
-- 
2.3.6

