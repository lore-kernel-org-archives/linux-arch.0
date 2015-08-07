From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 11/11] test_user_copy: Check user checksum functions
Date: Fri, 7 Aug 2015 16:22:04 +0100
Message-ID: <1438960924-23628-12-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

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
Changes in v2:
- Only test csum_partial_copy_from_user #ifndef
  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER, fixing powerpc64 build (Stephen
  Rothwell)
---
 lib/test_user_copy.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index ebaa28d2c8bd..b9cf1d5b77ef 100644
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
 	ret |= test(copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
 		    "legitimate copy_in_user failed");
 #endif
+	err = 0;
+	csum_and_copy_from_user(usermem, kmem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_and_copy_from_user failed");
+	err = 0;
+	csum_and_copy_to_user(kmem, usermem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_and_copy_to_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -107,6 +115,11 @@ static int __init test_user_copy_init(void)
 					 (unsigned long __user *)(usermem + 1)),
 		    "legitimate __put_user_unaligned failed");
 #endif
+#ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+	err = 0;
+	csum_partial_copy_from_user(usermem, kmem, PAGE_SIZE, 0, &err);
+	ret |= test(err, "legitimate csum_partial_copy_from_user failed");
+#endif
 
 	/* Invalid usage: none of these should succeed. */
 	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
@@ -146,6 +159,22 @@ static int __init test_user_copy_init(void)
 				  PAGE_SIZE),
 		    "illegal copy_in_user from kernel passed");
 #endif
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
@@ -208,6 +237,18 @@ static int __init test_user_copy_init(void)
 					  (unsigned long __user *)(kmem + 1)),
 		    "illegal __put_user_unaligned passed");
 #endif
+#ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
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
+#endif
 #endif
 
 	/*
@@ -240,6 +281,14 @@ static int __init test_user_copy_init(void)
 				 (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
 		    "legitimate all-kernel copy_in_user failed");
 #endif
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
@@ -277,6 +326,13 @@ static int __init test_user_copy_init(void)
 					 (unsigned long __user *)(kmem + 1)),
 		    "legitimate kernel __put_user_unaligned failed");
 #endif
+#ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+	err = 0;
+	csum_partial_copy_from_user((char __user *)(kmem + PAGE_SIZE), kmem,
+				    PAGE_SIZE, 0, &err);
+	ret |= test(err,
+		    "legitimate kernel csum_partial_copy_from_user failed");
+#endif
 
 	/* Restore previous address limit. */
 	set_fs(fs);
-- 
2.3.6
