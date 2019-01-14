From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 1/8] bitops: Introduce the for_each_set_clump8 macro
Date: Mon, 14 Jan 2019 15:19:51 +0900
Message-ID: <fa51dcdff980caabc284ccdac24b304743028778.1547445576.git.vilhelm.gray@gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547445576.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, William Breathitt Gray <vilhelm.gray@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

This macro iterates for each 8-bit group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to the
bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value8 and bitmap_set_value8 functions are introduced to
respectively get and set an 8-bit value in a bitmap memory region.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 14 ++++++
 include/linux/bitops.h            |  5 ++
 lib/find_bit.c                    | 81 +++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..9a76adff59c6 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+unsigned long bitmap_get_value8(const unsigned long *const bitmap,
+				const unsigned int size,
+				const unsigned int start);
+
+void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
+		       const unsigned long value, const unsigned int start);
+
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), 0, (size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..61c10f20079e 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..c2af1f013ea2 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -218,3 +218,84 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @size: bitmap size in number of bits
+ * @start: bit offset of the 8-bit value
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @bitmap
+ * memory region.
+ */
+unsigned long bitmap_get_value8(const unsigned long *const bitmap,
+				const unsigned int size,
+				const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
+				       BITS_PER_LONG - offset : 8;
+	const unsigned long low = bitmap[index] >> offset;
+	const unsigned long high = (low_width < 8 && start + 8 <= size) ?
+				   bitmap[index + 1] << low_width : 0;
+
+	return (low | high) & 0xFF;
+}
+EXPORT_SYMBOL(bitmap_get_value8);
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @bitmap: address to the bitmap memory region
+ * @size: bitmap size in number of bits
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value
+ */
+void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
+		       const unsigned long value, const unsigned int start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned int offset = start % BITS_PER_LONG;
+	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
+				       BITS_PER_LONG - offset : 8;
+	const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);
+	const unsigned int high_width = 8 - low_width;
+	const unsigned long high_mask = GENMASK(high_width - 1, 0);
+
+	/* set lower portion */
+	bitmap[index] &= ~low_mask;
+	bitmap[index] |= value << offset;
+
+	/* set higher portion if space available in bitmap */
+	if (high_width && start + 8 <= size) {
+		bitmap[index + 1] &= ~high_mask;
+		bitmap[index + 1] |= value >> low_width;
+	}
+}
+EXPORT_SYMBOL(bitmap_set_value8);
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @offset: bit offset at which to start searching
+ * @size: bitmap size in number of bits
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+unsigned int find_next_clump8(unsigned long *const clump,
+			      const unsigned long *const addr,
+			      unsigned int offset, const unsigned int size)
+{
+	for (; offset < size; offset += 8) {
+		*clump = bitmap_get_value8(addr, size, offset);
+		if (!*clump)
+			continue;
+
+		return offset;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.20.1
