From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/7] test_user_copy: Check legit kernel accesses
Date: Wed, 5 Aug 2015 16:48:49 +0100
Message-ID: <1438789735-4643-2-git-send-email-james.hogan@imgtec.com>
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

Check that the use of the user accessors for accessing kernel memory
succeed as expected after set_fs(get_ds()) is used to increases the
address limit, as used by the kernel to directly invoke system call code
with kernel pointers.

The tests are basically the same as the tests normally expected to be
treated as invalid, but without any user addresses (no reversed copies),
and with the result inverted such that they should succeed instead.

New tests:
- legitimate all-kernel copy_from_user
- legitimate all-kernel copy_to_user
- legitimate kernel get_user
- legitimate kernel put_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 0ecef3e4690e..445ca92b0b80 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -41,6 +41,7 @@ static int __init test_user_copy_init(void)
 	char *bad_usermem;
 	unsigned long user_addr;
 	unsigned long value = 0x5A;
+	mm_segment_t fs = get_fs();
 
 	kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
 	if (!kmem)
@@ -86,6 +87,28 @@ static int __init test_user_copy_init(void)
 	ret |= test(!put_user(value, (unsigned long __user *)kmem),
 		    "illegal put_user passed");
 
+	/*
+	 * Test access to kernel memory by adjusting address limit.
+	 * This is used by the kernel to invoke system calls with kernel
+	 * pointers.
+	 */
+	set_fs(get_ds());
+
+	/* Legitimate usage: none of these should fail. */
+	ret |= test(copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				   PAGE_SIZE),
+		    "legitimate all-kernel copy_from_user failed");
+	ret |= test(copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
+				 PAGE_SIZE),
+		    "legitimate all-kernel copy_to_user failed");
+	ret |= test(get_user(value, (unsigned long __user *)kmem),
+		    "legitimate kernel get_user failed");
+	ret |= test(put_user(value, (unsigned long __user *)kmem),
+		    "legitimate kernel put_user failed");
+
+	/* Restore previous address limit. */
+	set_fs(fs);
+
 	vm_munmap(user_addr, PAGE_SIZE * 2);
 	kfree(kmem);
 
-- 
2.3.6
