From: David Miller <davem@davemloft.net>
Subject: [PATCH 1/3] sparc: Increase portability of strncpy_from_user()
 implementation.
Date: Wed, 23 May 2012 23:34:30 -0400 (EDT)
Message-ID: <20120523.233430.1084831063018998232.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:35989 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116Ab2EXDec (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 23:34:32 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org


Hide details of maximum user address calculation in a new
asm/uaccess.h interface named user_addr_max().

Provide little-endian implementation in find_zero(), which should work
but can probably be improved.

Guard alignment check using CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess.h |    3 +++
 arch/sparc/lib/usercopy.c        |   28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uaccess.h
index 42a28cf..20c2acb 100644
--- a/arch/sparc/include/asm/uaccess.h
+++ b/arch/sparc/include/asm/uaccess.h
@@ -6,6 +6,9 @@
 #include <asm/uaccess_32.h>
 #endif
 
+#define user_addr_max() \
+	(segment_eq(get_fs(), USER_DS) ? STACK_TOP : ~0UL)
+
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 #endif
diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 87f9645..9ba59ef 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 
+#include <asm/byteorder.h>
+
 void copy_from_user_overflow(void)
 {
 	WARN(1, "Buffer overflow detected!\n");
@@ -14,6 +16,8 @@ EXPORT_SYMBOL(copy_from_user_overflow);
 static inline long find_zero(unsigned long mask)
 {
 	long byte = 0;
+
+#ifdef __BIG_ENDIAN
 #ifdef CONFIG_64BIT
 	if (mask >> 32)
 		mask >>= 32;
@@ -25,6 +29,19 @@ static inline long find_zero(unsigned long mask)
 	else
 		byte += 2;
 	return (mask >> 8) ? byte : byte + 1;
+#else
+#ifdef CONFIG_64BIT
+	if (!((unsigned int) mask)) {
+		mask >>= 32;
+		byte = 4;
+	}
+#endif
+	if (!(mask & 0xffff)) {
+		mask >>= 16;
+		byte += 2;
+	}
+	return (mask & 0xff) ? byte : byte + 1;
+#endif
 }
 
 /*
@@ -45,10 +62,10 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 	 */
 	if (max > count)
 		max = count;
-
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	if (((long) dst | (long) src) & (sizeof(long) - 1))
 		goto byte_at_a_time;
-
+#endif
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, v, rhs;
 
@@ -66,8 +83,9 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 byte_at_a_time:
+#endif
 	while (max) {
 		char c;
 
@@ -119,9 +137,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
-	max_addr = ~0UL;
-	if (likely(segment_eq(get_fs(), USER_DS)))
-		max_addr = STACK_TOP;
+	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-- 
1.7.10
