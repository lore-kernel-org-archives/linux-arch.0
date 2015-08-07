Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:7220 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbHGPWl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:22:41 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 09/11] test_user_copy: Check user string accessors
Date: Fri, 7 Aug 2015 16:22:02 +0100
Message-ID: <1438960924-23628-10-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150807152202.ZeNK88nq8vtIg42IB7d3iNqSi_xQwoPCdXEE-IgSFP8@z>

Add basic success/failure checking of the user string functions which
copy or find the length of userland strings.

The following cases are checked:
- strncpy_from_user() with legitimate user to kernel addresses, illegal
  all-kernel and reversed addresses, and legitimate all-kernel
  addresses.
- strnlen_user() with a legitimate user address, an illegal kernel
  address, and a legitimate kernel address.

New tests:
- legitimate strncpy_from_user
- legitimate strnlen_user
- illegal all-kernel strncpy_from_user
- illegal reversed strncpy_from_user
- illegal strnlen_user
- legitimate all-kernel strncpy_from_user
- legitimate kernel strnlen_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v2:
- Drop strlen_user test. Microblaze doesn't define it, and nothing
  actually uses it. IMO it should be removed, and there's no point
  testing it in the mean time.
---
 lib/test_user_copy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 450b4c379c61..56af2439d2be 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -70,6 +70,10 @@ static int __init test_user_copy_init(void)
 		    "legitimate put_user failed");
 	ret |= test(clear_user(usermem, PAGE_SIZE) != 0,
 		    "legitimate clear_user passed");
+	ret |= test(strncpy_from_user(kmem, usermem, PAGE_SIZE) < 0,
+		    "legitimate strncpy_from_user failed");
+	ret |= test(strnlen_user(usermem, PAGE_SIZE) == 0,
+		    "legitimate strnlen_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -109,6 +113,14 @@ static int __init test_user_copy_init(void)
 		    "illegal put_user passed");
 	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
 		    "illegal kernel clear_user passed");
+	ret |= test(strncpy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				      PAGE_SIZE) >= 0,
+		    "illegal all-kernel strncpy_from_user passed");
+	ret |= test(strncpy_from_user(bad_usermem, (char __user *)kmem,
+				      PAGE_SIZE) >= 0,
+		    "illegal reversed strncpy_from_user passed");
+	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) != 0,
+		    "illegal strnlen_user passed");
 
 	/*
 	 * If unchecked user accesses (__*) on this architecture cannot access
@@ -175,6 +187,11 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel put_user failed");
 	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != 0,
 		    "legitimate kernel clear_user failed");
+	ret |= test(strncpy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				      PAGE_SIZE) < 0,
+		    "legitimate all-kernel strncpy_from_user failed");
+	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) == 0,
+		    "legitimate kernel strnlen_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
 		    "legitimate kernel access_ok VERIFY_READ failed");
-- 
2.3.6

