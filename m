From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 10/11] test_user_copy: Check user compatibility accessors
Date: Fri, 7 Aug 2015 16:22:03 +0100
Message-ID: <1438960924-23628-11-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Add basic success/failure checking of user accessors used by 32-bit
compatibility code. This includes copy_in_user() which copies data from
userspace to userspace (or kernel to kernel), its unchecking friend
__copy_in_user which assume that access_ok() has already been used,
and __get_user_unaligned() / __put_user_unaligned().

These might not be provided for architectures which don't need 32-bit
compatibility syscalls, so they are tested conditional upon
CONFIG_COMPAT.

The following cases are checked:
- __copy_in_user/copy_in_user from user to user should succeed.
- __copy_in_user/copy_in_user involving 1 or 2 kernel pointers should
  not succeed.
- __copy_in_user/copy_in_user from kernel to kernel should succeed when
  user address limit is set for kernel accesses.
- __get_user_unaligned/__put_user_unaligned with user pointer should
  succeed.
- __get_user_unaligned/__put_user_unaligned with kernel pointer should
  not succeed.
- __get_user_unaligned/__put_user_unaligned with kernel pointer succeed
  when user address limit is set for kernel accesses.

New tests:
- legitimate copy_in_user
- legitimate __copy_in_user
- legitimate __get_user_unaligned
- legitimate __put_user_unaligned
- illegal all-kernel copy_in_user
- illegal copy_in_user to kernel
- illegal copy_in_user from kernel
- illegal all-kernel __copy_in_user
- illegal __copy_in_user to kernel
- illegal __copy_in_user from kernel
- illegal __get_user_unaligned
- illegal __put_user_unaligned
- legitimate all-kernel copy_in_user
- legitimate all-kernel __copy_in_user
- legitimate kernel __get_user_unaligned
- legitimate kernel __put_user_unaligned

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v2:
- Conditionalise on CONFIG_COMPAT, otherwise it breaks build on some
  32-bit arches e.g. i386 (kbuild test robot).
- Add testing of _unaligned accessors, which are also conditional upon
  CONFIG_COMPAT.
---
 lib/test_user_copy.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 56af2439d2be..ebaa28d2c8bd 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -74,6 +74,10 @@ static int __init test_user_copy_init(void)
 		    "legitimate strncpy_from_user failed");
 	ret |= test(strnlen_user(usermem, PAGE_SIZE) == 0,
 		    "legitimate strnlen_user failed");
+#ifdef CONFIG_COMPAT
+	ret |= test(copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate copy_in_user failed");
+#endif
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -93,6 +97,16 @@ static int __init test_user_copy_init(void)
 		    "legitimate __put_user failed");
 	ret |= test(__clear_user(usermem, PAGE_SIZE) != 0,
 		    "legitimate __clear_user passed");
+#ifdef CONFIG_COMPAT
+	ret |= test(__copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate __copy_in_user failed");
+	ret |= test(__get_user_unaligned(value,
+					 (unsigned long __user *)(usermem + 1)),
+		    "legitimate __get_user_unaligned failed");
+	ret |= test(__put_user_unaligned(value,
+					 (unsigned long __user *)(usermem + 1)),
+		    "legitimate __put_user_unaligned failed");
+#endif
 
 	/* Invalid usage: none of these should succeed. */
 	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
@@ -121,6 +135,17 @@ static int __init test_user_copy_init(void)
 		    "illegal reversed strncpy_from_user passed");
 	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) != 0,
 		    "illegal strnlen_user passed");
+#ifdef CONFIG_COMPAT
+	ret |= test(!copy_in_user((char __user *)kmem,
+				  (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "illegal all-kernel copy_in_user passed");
+	ret |= test(!copy_in_user((char __user *)kmem, usermem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user to kernel passed");
+	ret |= test(!copy_in_user(usermem, (char __user *)kmem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user from kernel passed");
+#endif
 
 	/*
 	 * If unchecked user accesses (__*) on this architecture cannot access
@@ -165,6 +190,24 @@ static int __init test_user_copy_init(void)
 		    "illegal __put_user passed");
 	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
 		    "illegal kernel __clear_user passed");
+#ifdef CONFIG_COMPAT
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
+	ret |= test(!__get_user_unaligned(value,
+					  (unsigned long __user *)(kmem + 1)),
+		    "illegal __get_user_unaligned passed");
+	ret |= test(!__put_user_unaligned(value,
+					  (unsigned long __user *)(kmem + 1)),
+		    "illegal __put_user_unaligned passed");
+#endif
 #endif
 
 	/*
@@ -192,6 +235,11 @@ static int __init test_user_copy_init(void)
 		    "legitimate all-kernel strncpy_from_user failed");
 	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) == 0,
 		    "legitimate kernel strnlen_user failed");
+#ifdef CONFIG_COMPAT
+	ret |= test(copy_in_user((char __user *)kmem,
+				 (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "legitimate all-kernel copy_in_user failed");
+#endif
 
 	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
 		    "legitimate kernel access_ok VERIFY_READ failed");
@@ -217,6 +265,18 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel __put_user failed");
 	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != 0,
 		    "legitimate kernel __clear_user failed");
+#ifdef CONFIG_COMPAT
+	ret |= test(__copy_in_user((char __user *)kmem,
+				   (char __user *)(kmem + PAGE_SIZE),
+				   PAGE_SIZE),
+		    "legitimate all-kernel __copy_in_user failed");
+	ret |= test(__get_user_unaligned(value,
+					 (unsigned long __user *)(kmem + 1)),
+		    "legitimate kernel __get_user_unaligned failed");
+	ret |= test(__put_user_unaligned(value,
+					 (unsigned long __user *)(kmem + 1)),
+		    "legitimate kernel __put_user_unaligned failed");
+#endif
 
 	/* Restore previous address limit. */
 	set_fs(fs);
-- 
2.3.6
