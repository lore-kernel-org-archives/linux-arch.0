Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57002 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab0KWNj3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2010 08:39:29 -0500
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 04/22] arm: introduce little-endian bitops
Date: Tue, 23 Nov 2010 22:38:06 +0900
Message-ID: <1290519504-3958-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
References: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20101123133806.I9itsRy33DUMDOU0z8nFh9JJ_LM6P8MvakDMkcS23K4@z>

Introduce little-endian bit operations by renaming native ext2 bit
operations. The ext2 bit operations are kept as wrapper macros using
little-endian bit operations to maintain bisectability until the
conversions are finished.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
No change from previous submission
 arch/arm/include/asm/bitops.h |   46 +++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 338ff19..29adaca 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -303,41 +303,61 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
+#define __set_le_bit(nr, p)			\
+	__set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __clear_le_bit(nr, p)			\
+	__clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_set_le_bit(nr, p)			\
+		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_set_le_bit(nr, p)          \
+		test_and_set_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define __test_and_clear_le_bit(nr, p)			\
+		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_and_clear_le_bit(nr, p)	\
+		test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define test_le_bit(nr, p)			\
+		test_bit(WORD_BITOFF_TO_LE(nr), (p))
+#define find_first_zero_le_bit(p, sz)		\
+		_find_first_zero_bit_le(p, sz)
+#define find_next_zero_le_bit(p, sz, off)	\
+		_find_next_zero_bit_le(p, sz, off)
+#define find_next_le_bit(p, sz, off) \
+		_find_next_bit_le(p, sz, off)
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_le_bit(nr, (unsigned long *)(p))
 #define ext2_set_bit_atomic(lock,nr,p)          \
-                test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_set_le_bit(nr, (unsigned long *)(p))
 #define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define ext2_clear_bit_atomic(lock,nr,p)        \
-                test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define ext2_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_le_bit(nr, (unsigned long *)(p))
 #define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_le_bit((unsigned long *)(p), sz)
 #define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
+		find_next_zero_le_bit((unsigned long *)(p), sz, off)
 #define ext2_find_next_bit(p, sz, off) \
-		_find_next_bit_le(p, sz, off)
+		find_next_le_bit((unsigned long *)(p), sz, off)
 
 /*
  * Minix is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
 #define minix_set_bit(nr,p)			\
-		__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__set_le_bit(nr, (unsigned long *)(p))
 #define minix_test_bit(nr,p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		test_le_bit(nr, (unsigned long *)(p))
 #define minix_test_and_set_bit(nr,p)		\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_set_le_bit(nr, (unsigned long *)(p))
 #define minix_test_and_clear_bit(nr,p)		\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
+		__test_and_clear_le_bit(nr, (unsigned long *)(p))
 #define minix_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
+		find_first_zero_le_bit((unsigned long *)(p), sz)
 
 #endif /* __KERNEL__ */
 
-- 
1.7.3.2

