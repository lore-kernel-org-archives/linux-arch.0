From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 5/7] test_user_copy: Check __copy_{to,from}_user_inatomic()
Date: Wed, 5 Aug 2015 16:48:53 +0100
Message-ID: <1438789735-4643-6-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

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
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 310e796beef6..6cbdb0a15ca2 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -79,8 +79,12 @@ static int __init test_user_copy_init(void)
 		    "legitimate access_ok VERIFY_WRITE failed");
 	ret |= test(__copy_from_user(kmem, usermem, PAGE_SIZE),
 		    "legitimate __copy_from_user failed");
+	ret |= test(__copy_from_user_inatomic(kmem, usermem, PAGE_SIZE),
+		    "legitimate __copy_from_user_inatomic failed");
 	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate __copy_to_user failed");
+	ret |= test(__copy_to_user_inatomic(usermem, kmem, PAGE_SIZE),
+		    "legitimate __copy_to_user_inatomic failed");
 	ret |= test(__copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
 		    "legitimate __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)usermem),
@@ -137,12 +141,25 @@ static int __init test_user_copy_init(void)
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
 	ret |= test(!__copy_in_user((char __user *)kmem,
 				    (char __user *)(kmem + PAGE_SIZE),
 				    PAGE_SIZE),
@@ -193,9 +210,16 @@ static int __init test_user_copy_init(void)
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
 	ret |= test(__copy_in_user((char __user *)kmem,
 				   (char __user *)(kmem + PAGE_SIZE),
 				   PAGE_SIZE),
-- 
2.3.6
