From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 7/7] test_user_copy: Check user checksum functions
Date: Wed, 5 Aug 2015 16:48:55 +0100
Message-ID: <1438789735-4643-8-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:1850 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbHEPtb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:49:31 -0400
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>

Add basic success/failure checking of the combined user copy and
checksum functions which copy data between user and kernel space while
also checksumming that data. Some architectures have optimised versions
of these which combine both operations into a single pass.

The following cases are checked:
- csum_partial_copy_from_user() with legitimate user to kernel
  addresses, illegal all-kernel and reversed addresses (for
  implementations where this is safe to test, as this function does not
  perform an access_ok() check), and legitimate all-kernel addresses.
- csum_and_copy_from_user() with legitimate user to kernel addresses,
  illegal all-kernel and reversed addresses, and legitimate all-kernel
  addresses.
- csum_partial_copy_from_user() with legitimate kernel to user
  addresses, illegal all-kernel and reversed addresses, and legitimate
  all-kernel addresses.

New tests:
- legitimate csum_and_copy_from_user
- legitimate csum_and_copy_to_user
- legitimate csum_partial_copy_from_user
- illegal all-kernel csum_and_copy_from_user
- illegal reversed csum_and_copy_from_user
- illegal all-kernel csum_and_copy_to_user
- illegal reversed csum_and_copy_to_user
- illegal all-kernel csum_partial_copy_from_user
- illegal reversed csum_partial_copy_from_user
- legitimate kernel csum_and_copy_from_user
- legitimate kernel csum_and_copy_to_user
- legitimate kernel csum_partial_copy_from_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 6d05ec5f6cfa..76e0c1c25cd2 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <net/checksum.h>
 
 #define test(condition, msg)		\
 ({					\
@@ -41,6 +42,7 @@ static int __init test_user_copy_init(void)
 	char *bad_usermem;
 	unsigned long user_addr;
 	unsigned long value = 0x5A;
+	int err;
 	mm_segment_t fs = get_fs();
 
 	kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
@@ -78,6 +80,12 @@ static int __init test_user_copy_init(void)
 		    "legitimate strnlen_user failed");
 	ret |= test(strlen_user(usermem) == 0,
 		    "legitimate strlen_user failed");
+	err = 0;
+	csum_and_copy_from_user(usermem, kmem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_and_copy_from_user failed");
+	err = 0;
+	csum_and_copy_to_user(kmem, usermem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_and_copy_to_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -99,6 +107,9 @@ static int __init test_user_copy_init(void)
 		    "legitimate __put_user failed");
 	ret |= test(__clear_user(usermem, PAGE_SIZE) != 0,
 		    "legitimate __clear_user passed");
+	err = 0;
+	csum_partial_copy_from_user(usermem, kmem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_partial_copy_from_user failed");
 
 	/* Invalid usage: none of these should succeed. */
 	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
@@ -138,6 +149,22 @@ static int __init test_user_copy_init(void)
 		    "illegal strnlen_user passed");
 	ret |= test(strlen_user((char __user *)kmem) != 0,
 		    "illegal strlen_user passed");
+	err = 0;
+	csum_and_copy_from_user((char __user *)(kmem + PAGE_SIZE), kmem,
+				PAGE_SIZE, 0, &err);
+	ret |= test(!err, "illegal all-kernel csum_and_copy_from_user passed");
+	err = 0;
+	csum_and_copy_from_user((char __user *)kmem, bad_usermem,
+				PAGE_SIZE, 0, &err);
+	ret |= test(!err, "illegal reversed csum_and_copy_from_user passed");
+	err = 0;
+	csum_and_copy_to_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+			      PAGE_SIZE, 0, &err);
+	ret |= test(!err, "illegal all-kernel csum_and_copy_to_user passed");
+	err = 0;
+	csum_and_copy_to_user(bad_usermem, (char __user *)kmem, PAGE_SIZE, 0,
+			      &err);
+	ret |= test(!err, "illegal reversed csum_and_copy_to_user passed");
 
 	/*
 	 * If unchecked user accesses (__*) on this architecture cannot access
@@ -192,6 +219,16 @@ static int __init test_user_copy_init(void)
 		    "illegal __put_user passed");
 	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
 		    "illegal kernel __clear_user passed");
+	err = 0;
+	csum_partial_copy_from_user((char __user *)(kmem + PAGE_SIZE), kmem,
+				    PAGE_SIZE, 0, &err);
+	ret |= test(!err,
+		    "illegal all-kernel csum_partial_copy_from_user passed");
+	err = 0;
+	csum_partial_copy_from_user((char __user *)kmem, bad_usermem, PAGE_SIZE,
+				    0, &err);
+	ret |= test(!err,
+		    "illegal reversed csum_partial_copy_from_user passed");
 #endif
 
 	/*
@@ -224,6 +261,14 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel strnlen_user failed");
 	ret |= test(strlen_user((char __user *)kmem) == 0,
 		    "legitimate kernel strlen_user failed");
+	err = 0;
+	csum_and_copy_from_user((char __user *)(kmem + PAGE_SIZE), kmem,
+				PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate kernel csum_and_copy_from_user failed");
+	err = 0;
+	csum_and_copy_to_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+			      PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate kernel csum_and_copy_to_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
 		    "legitimate kernel access_ok VERIFY_READ failed");
@@ -253,6 +298,11 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel __put_user failed");
 	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != 0,
 		    "legitimate kernel __clear_user failed");
+	err = 0;
+	csum_partial_copy_from_user((char __user *)(kmem + PAGE_SIZE), kmem,
+				    PAGE_SIZE, 0, &err);
+	ret |= test(err,
+		    "legitimate kernel csum_partial_copy_from_user failed");
 
 	/* Restore previous address limit. */
 	set_fs(fs);
-- 
2.3.6
