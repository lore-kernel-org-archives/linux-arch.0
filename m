Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53248 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbgANUI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space pointer range check
Date: Tue, 14 Jan 2020 12:08:44 -0800
Message-ID: <20200114200846.29434-3-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-1-vgupta@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20200114200844.vwI_5oIXsCna_ym5JjPJmgL1X28G2KHyHzssrdPdXCI@z>

This came up when switching ARC to word-at-a-time interface and using
generic/optimized strncpy_from_user

It seems the existing code checks for user buffer/string range multiple
times and one of tem cn be avoided.

There's an open-coded range check which computes @max off of user_addr_max()
and thus typically way larger than the kernel buffer @count and subsequently
discarded in do_strncpy_from_user()

	if (max > count)
		max = count;

The canonical user_access_begin() => access_ok() follow anyways and even
with @count it should suffice for an intial range check as is true for
any copy_{to,from}_user()

And in case actual user space buffer is smaller than kernel dest pointer
(i.e. @max < @count) the usual string copy, null byte detection would
abort the process early anyways

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 lib/strncpy_from_user.c | 36 +++++++++++-------------------------
 lib/strnlen_user.c      | 28 +++++++---------------------
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index dccb95af6003..a1622d71f037 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -21,22 +21,15 @@
 /*
  * Do a strncpy, return length of string without final '\0'.
  * 'count' is the user-supplied count (return 'count' if we
- * hit it), 'max' is the address space maximum (and we return
- * -EFAULT if we hit it).
+ * hit it). If access fails, return -EFAULT.
  */
 static inline long do_strncpy_from_user(char *dst, const char __user *src,
-					unsigned long count, unsigned long max)
+					unsigned long count)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned long max = count;
 	unsigned long res = 0;
 
-	/*
-	 * Truncate 'max' to the user-specified limit, so that
-	 * we only have one limit we need to check in the loop
-	 */
-	if (max > count)
-		max = count;
-
 	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
@@ -72,7 +65,7 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
 	 * too? If so, that's ok - we got as much as the user asked for.
 	 */
-	if (res >= count)
+	if (res == count)
 		return res;
 
 	/*
@@ -103,25 +96,18 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
  */
 long strncpy_from_user(char *dst, const char __user *src, long count)
 {
-	unsigned long max_addr, src_addr;
-
 	if (unlikely(count <= 0))
 		return 0;
 
-	max_addr = user_addr_max();
-	src_addr = (unsigned long)untagged_addr(src);
-	if (likely(src_addr < max_addr)) {
-		unsigned long max = max_addr - src_addr;
+	kasan_check_write(dst, count);
+	check_object_size(dst, count, false);
+	if (user_access_begin(src, count)) {
 		long retval;
-
-		kasan_check_write(dst, count);
-		check_object_size(dst, count, false);
-		if (user_access_begin(src, max)) {
-			retval = do_strncpy_from_user(dst, src, count, max);
-			user_access_end();
-			return retval;
-		}
+		retval = do_strncpy_from_user(dst, src, count);
+		user_access_end();
+		return retval;
 	}
+
 	return -EFAULT;
 }
 EXPORT_SYMBOL(strncpy_from_user);
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6c0005d5dd5c..5ce61f303d6e 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -20,19 +20,13 @@
  * if it fits in a aligned 'long'. The caller needs to check
  * the return value against "> max".
  */
-static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+static inline long do_strnlen_user(const char __user *src, unsigned long count)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long align, res = 0;
+	unsigned long max = count;
 	unsigned long c;
 
-	/*
-	 * Truncate 'max' to the user-specified limit, so that
-	 * we only have one limit we need to check in the loop
-	 */
-	if (max > count)
-		max = count;
-
 	/*
 	 * Do everything aligned. But that means that we
 	 * need to also expand the maximum..
@@ -64,7 +58,7 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
 	 * too? If so, return the marker for "too long".
 	 */
-	if (res >= count)
+	if (res == count)
 		return count+1;
 
 	/*
@@ -98,22 +92,14 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
  */
 long strnlen_user(const char __user *str, long count)
 {
-	unsigned long max_addr, src_addr;
-
 	if (unlikely(count <= 0))
 		return 0;
 
-	max_addr = user_addr_max();
-	src_addr = (unsigned long)untagged_addr(str);
-	if (likely(src_addr < max_addr)) {
-		unsigned long max = max_addr - src_addr;
+	if (user_access_begin(str, count)) {
 		long retval;
-
-		if (user_access_begin(str, max)) {
-			retval = do_strnlen_user(str, count, max);
-			user_access_end();
-			return retval;
-		}
+		retval = do_strnlen_user(str, count);
+		user_access_end();
+		return retval;
 	}
 	return 0;
 }
-- 
2.20.1
