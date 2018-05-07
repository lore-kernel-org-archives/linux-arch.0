From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/7] bitops: Introduce the for_each_set_port_word macro
Date: Mon,  7 May 2018 11:35:18 -0400
Message-ID: <7b704b1feb2f2cdb6c3a3061fa5f5d804954d15d.1525704095.git.vilhelm.gray@gmail.com>
References: <cover.1525704095.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525704095.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

This macro iterates for each group of bits (port word) with set bits,
within a bitmap memory region. For each iteration, "port_word" is set to
the found port word index, "word_index" is set to the word index of the
bitmap containing the found port word, and "word_offset" is set to the
bit offset of the found port word within the respective bitmap word.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 24 ++++++++++++++++++++++++
 include/linux/bitops.h            |  9 +++++++++
 lib/find_bit.c                    | 28 ++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..b24f3f92642b 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,28 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+/**
+ * find_next_port_word - find next port word with set bits in a memory region
+ * @word_index: location to store bitmap word index of found port word
+ * @word_offset: bits offset of the found port word in respective bitmap word
+ * @bits: address to base the search on
+ * @size: bitmap size in number of ports
+ * @offset: port word index to start searching at
+ * @port_size: port word size in bits
+ *
+ * Returns the port index for the next port word with set bits; the respective
+ * bitmap word index is stored at the location pointed by @word_index, and the
+ * bits offset of the found port word within the respective bitmap word is
+ * stored at the location pointed by @word_offset. If no bits are set, returns
+ * @size.
+ */
+size_t find_next_port_word(size_t *const word_index,
+			   unsigned int *const word_offset,
+			   const unsigned long *const bits, const size_t size,
+			   const size_t offset, const unsigned int port_size);
+
+#define find_first_port_word(word_index, word_offset, bits, size, port_size) \
+	find_next_port_word((word_index), (word_offset), (bits), (size), 0, \
+			    (port_size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..c3b7caf4ad2d 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -59,6 +59,15 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_port_word(port_word, word_index, word_offset, bits, size, \
+			       port_size) \
+	for ((port_word) = find_first_port_word(&(word_index), &(word_offset), \
+					   (bits), (size), (port_size)); \
+	     (port_word) < (size); \
+	     (port_word) = find_next_port_word(&(word_index), &(word_offset), \
+					  (bits), (size), (port_word) + 1, \
+					  (port_size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..628c94d63d6b 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -20,6 +20,7 @@
 #include <linux/bitmap.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) || \
 		!defined(find_next_and_bit)
@@ -218,3 +219,30 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+size_t find_next_port_word(size_t *const word_index,
+			   unsigned int *const word_offset,
+			   const unsigned long *const bits, const size_t size,
+			   const size_t offset, const unsigned int port_size)
+{
+	size_t i;
+	unsigned int bits_offset;
+	unsigned long word_mask;
+	const unsigned long port_mask = GENMASK(port_size - 1, 0);
+
+	for (i = offset; i < size; i++) {
+		bits_offset = i * port_size;
+
+		*word_index = BIT_WORD(bits_offset);
+		*word_offset = bits_offset % BITS_PER_LONG;
+
+		word_mask = bits[*word_index] & (port_mask << *word_offset);
+		if (!word_mask)
+			continue;
+
+		return i;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_port_word);
-- 
2.17.0
