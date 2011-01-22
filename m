Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52422 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab1AVNN5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jan 2011 08:13:57 -0500
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 08/27] arm: introduce little-endian bitops
Date: Sat, 22 Jan 2011 22:13:40 +0900
Message-ID: <1295702039-23186-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Message-ID: <20110122131340.leNBUGoBO7NUcdC3NqnkGxX1wDQSqMU3qLL6owkIvAo@z>

Introduce little-endian bit operations by renaming native ext2 bit
operations.  The ext2 and minix bit operations are kept as wrapper
macros using little-endian bit operations to maintain bisectability
until the conversions are finished.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - add casts in the macro to take any pointer types
 - drop acked-by line because enough changes has been made

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 arch/arm/include/asm/bitops.h |   61 +++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 7b1bb2b..872d502 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -303,41 +303,50 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
+#define __set_bit_le(nr, p)			\
+	__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define __clear_bit_le(nr, p)			\
+	__clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define __test_and_set_bit_le(nr, p)			\
+		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define test_and_set_bit_le(nr, p)          \
+		test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define __test_and_clear_bit_le(nr, p)			\
+		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define test_and_clear_bit_le(nr, p)	\
+		test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define test_bit_le(nr, p)			\
+		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+#define find_first_zero_bit_le(p, sz)		\
+		_find_first_zero_bit_le(p, sz)
+#define find_next_zero_bit_le(p, sz, off)	\
+		_find_next_zero_bit_le(p, sz, off)
+#define find_next_bit_le(p, sz, off) \
+		_find_next_bit_le((unsigned long *)(p), sz, off)
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
-#define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_set_bit_atomic(lock,nr,p)          \
-                test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_clear_bit_atomic(lock,nr,p)        \
-                test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
-#define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
-#define ext2_find_next_bit(p, sz, off) \
-		_find_next_bit_le(p, sz, off)
+#define ext2_set_bit __test_and_set_bit_le
+#define ext2_set_bit_atomic(lock, nr, p)	\
+		test_and_set_bit_le(nr, p)
+#define ext2_clear_bit __test_and_clear_bit_le
+#define ext2_clear_bit_atomic(lock, nr, p)	\
+		test_and_clear_bit_le(nr, p)
+#define ext2_test_bit test_bit_le
+#define ext2_find_first_zero_bit find_first_zero_bit_le
+#define ext2_find_next_zero_bit find_next_zero_bit_le
+#define ext2_find_next_bit find_next_bit_le
 
 /*
  * Minix is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
-#define minix_set_bit(nr,p)			\
-		__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define minix_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define minix_test_and_set_bit(nr,p)		\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define minix_test_and_clear_bit(nr,p)		\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define minix_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+#define minix_set_bit __set_bit_le
+#define minix_test_bit test_bit_le
+#define minix_test_and_set_bit __test_and_set_bit_le
+#define minix_test_and_clear_bit __test_and_clear_bit_le
+#define minix_find_first_zero_bit find_first_zero_bit_le
 
 #endif /* __KERNEL__ */
 
-- 
1.7.3.4

