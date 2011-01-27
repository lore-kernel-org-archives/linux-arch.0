From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -mm 4/6] arm: convert little-endian bitops macros to static inline functions
Date: Thu, 27 Jan 2011 22:56:21 +0900
Message-ID: <1296136583-13815-5-git-send-email-akinobu.mita@gmail.com>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

(This patch is intended to be folded into the patch in -mm:
arm-introduce-little-endian-bitops.patch)

The little-endian bitops on arm are written as preprocessor
macros with the cast to "unsigned long *".
This means that even non-pointers will be accepted without an error, and
that is a Very Bad Thing.

This converts the little-endian bitops macros to static inline functions
with proper prototypes.

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/bitops.h |   70 +++++++++++++++++++++++++++++------------
 1 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 56d6b54..f530d59 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -303,26 +303,56 @@ static inline int fls(int x)
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
-#define __set_bit_le(nr, p)			\
-	__set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define __clear_bit_le(nr, p)			\
-	__clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define __test_and_set_bit_le(nr, p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define test_and_set_bit_le(nr, p)          \
-		test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define __test_and_clear_bit_le(nr, p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define test_and_clear_bit_le(nr, p)	\
-		test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define test_bit_le(nr, p)			\
-		test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define find_first_zero_bit_le(p, sz)		\
-		_find_first_zero_bit_le(p, sz)
-#define find_next_zero_bit_le(p, sz, off)	\
-		_find_next_zero_bit_le(p, sz, off)
-#define find_next_bit_le(p, sz, off) \
-		_find_next_bit_le((unsigned long *)(p), sz, off)
+static inline void __set_bit_le(int nr, void *addr)
+{
+	__set_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline void __clear_bit_le(int nr, void *addr)
+{
+	__clear_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int __test_and_set_bit_le(int nr, void *addr)
+{
+	return __test_and_set_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int test_and_set_bit_le(int nr, void *addr)
+{
+	return test_and_set_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int __test_and_clear_bit_le(int nr, void *addr)
+{
+	return __test_and_clear_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int test_and_clear_bit_le(int nr, void *addr)
+{
+	return test_and_clear_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int test_bit_le(int nr, const void *addr)
+{
+	return test_bit(WORD_BITOFF_TO_LE(nr), addr);
+}
+
+static inline int find_first_zero_bit_le(const void *p, unsigned size)
+{
+	return _find_first_zero_bit_le(p, size);
+}
+
+static inline int find_next_zero_bit_le(const void *p, int size, int offset)
+{
+	return _find_next_zero_bit_le(p, size, offset);
+}
+
+static inline int find_next_bit_le(const void *p, int size, int offset)
+{
+	return _find_next_bit_le(p, size, offset);
+}
+
 /*
  * Ext2 is defined to use little-endian byte ordering.
  */
-- 
1.7.3.4
