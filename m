From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3/7] test_user_copy: Check __clear_user()/clear_user()
Date: Wed, 5 Aug 2015 16:48:51 +0100
Message-ID: <1438789735-4643-4-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Add basic success/failure checking of __clear_user() and clear_user(),
which zero an area of user or kernel memory and return the number of
bytes left to clear.

This catches a couple of bugs in the MIPS Enhanced Virtual Memory (EVA)
implementation (which have already been fixed):
test_user_copy: legitimate kernel clear_user failed
test_user_copy: legitimate kernel __clear_user failed

Due to neither function checking the user address limit, and both
resorting to user access unconditionally.

New tests:
- legitimate clear_user
- legitimate __clear_user
- illegal kernel clear_user
- illegal kernel __clear_user
- legitimate kernel clear_user
- legitimate kernel __clear_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 23fb9d15f50c..4ec2cfa916c1 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -68,6 +68,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)usermem),
 		    "legitimate put_user failed");
+	ret |= test(clear_user(usermem, PAGE_SIZE) != 0,
+		    "legitimate clear_user passed");
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -81,6 +83,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)usermem),
 		    "legitimate __put_user failed");
+	ret |= test(__clear_user(usermem, PAGE_SIZE) != 0,
+		    "legitimate __clear_user passed");
 
 	/* Invalid usage: none of these should succeed. */
 	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
@@ -99,6 +103,8 @@ static int __init test_user_copy_init(void)
 		    "illegal get_user passed");
 	ret |= test(!put_user(value, (unsigned long __user *)kmem),
 		    "illegal put_user passed");
+	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
+		    "illegal kernel clear_user passed");
 
 	/*
 	 * If unchecked user accesses (__*) on this architecture cannot access
@@ -128,6 +134,8 @@ static int __init test_user_copy_init(void)
 		    "illegal __get_user passed");
 	ret |= test(!__put_user(value, (unsigned long __user *)kmem),
 		    "illegal __put_user passed");
+	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
+		    "illegal kernel __clear_user passed");
 #endif
 
 	/*
@@ -148,6 +156,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel put_user failed");
+	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != 0,
+		    "legitimate kernel clear_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
 		    "legitimate kernel access_ok VERIFY_READ failed");
@@ -164,6 +174,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel __put_user failed");
+	ret |= test(__clear_user((char __user *)kmem, PAGE_SIZE) != 0,
+		    "legitimate kernel __clear_user failed");
 
 	/* Restore previous address limit. */
 	set_fs(fs);
-- 
2.3.6
