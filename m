From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 1/8] bitops: Introduce the for_each_set_clump macro
Date: Tue, 15 May 2018 12:22:26 -0400
Message-ID: <87c7edee3bd6789345bd1cc6fd0cb91c2d508eda.1526400945.git.vilhelm.gray@gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1526400945.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

This macro iterates for each group of bits (clump) with set bits, within
a bitmap memory region. For each iteration, "clump" is set to the found
clump index, "index" is set to the word index of the bitmap containing
the found clump, and "offset" is set to the bit offset of the found
clump within the respective bitmap word.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h |  9 +++++++
 include/linux/bitops.h            |  7 ++++++
 lib/find_bit.c                    | 40 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..3d3b2fc34908 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
+#include <linux/types.h>
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -80,4 +82,11 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+size_t find_next_clump(size_t *const index, unsigned int *const offset,
+		       const unsigned long *const bits, const size_t size,
+		       const size_t clump_index, const unsigned int clump_size);
+
+#define find_first_clump(index, offset, bits, size, clump_size) \
+	find_next_clump((index), (offset), (bits), (size), 0, (clump_size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..cfaff6a14406 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -59,6 +59,13 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump(clump, index, offset, bits, size, clump_size) \
+	for ((clump) = find_first_clump(&(index), &(offset), (bits), (size), \
+					(clump_size)); \
+	     (clump) < (size); \
+	     (clump) = find_next_clump(&(index), &(offset), (bits), (size), \
+				       (clump) + 1, (clump_size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..1d547fe9304f 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,43 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * find_next_clump - find next clump with set bits in a memory region
+ * @index: location to store bitmap word index of found clump
+ * @offset: bits offset of the found clump within the respective bitmap word
+ * @bits: address to base the search on
+ * @size: bitmap size in number of clumps
+ * @clump_index: clump index at which to start searching
+ * @clump_size: clump size in bits
+ *
+ * Returns the clump index for the next clump with set bits; the respective
+ * bitmap word index is stored at the location pointed by @index, and the bits
+ * offset of the found clump within the respective bitmap word is stored at the
+ * location pointed by @offset. If no bits are set, returns @size.
+ */
+size_t find_next_clump(size_t *const index, unsigned int *const offset,
+		       const unsigned long *const bits, const size_t size,
+		       const size_t clump_index, const unsigned int clump_size)
+{
+	size_t i;
+	unsigned int bits_offset;
+	unsigned long word_mask;
+	const unsigned long clump_mask = GENMASK(clump_size - 1, 0);
+
+	for (i = clump_index; i < size; i++) {
+		bits_offset = i * clump_size;
+
+		*index = BIT_WORD(bits_offset);
+		*offset = bits_offset % BITS_PER_LONG;
+
+		word_mask = bits[*index] & (clump_mask << *offset);
+		if (!word_mask)
+			continue;
+
+		return i;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_clump);
-- 
2.17.0
