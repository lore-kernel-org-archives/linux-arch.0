From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] bitmap: bitmap_equal memcmp optimization
Date: Tue,  7 Jun 2016 10:37:41 +0200
Message-ID: <201606070837.u578YJKt047781@mx0a-001b2d01.pphosted.com>
References: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465288661-3273-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

The bitmap_equal function has optimized code for small bitmaps with less
than BITS_PER_LONG bits. For larger bitmaps the out-of-line function
__bitmap_equal is called.

For a constant number of bits divisible by BITS_PER_LONG the memcmp
function can be used. For s390 gcc knows how to optimize this function,
memcmp calls with up to 256 bytes / 2048 bits are translated into a
single instruction.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/bitmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index e9b0b9a..27bfc0b 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -267,6 +267,10 @@ static inline int bitmap_equal(const unsigned long *src1,
 {
 	if (small_const_nbits(nbits))
 		return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+#ifdef CONFIG_S390
+	else if (__builtin_constant_p(nbits) && (nbits % BITS_PER_LONG) == 0)
+		return !memcmp(src1, src2, nbits / 8);
+#endif
 	else
 		return __bitmap_equal(src1, src2, nbits);
 }
-- 
2.6.6
