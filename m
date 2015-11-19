From: Jia He <hejianet@gmail.com>
Subject: [PATCH v3 3/3] linux/bitmap: Replace find_fisrt_{zero_}bit with the new lightweight api
Date: Thu, 19 Nov 2015 14:48:44 +0800
Message-ID: <1447915724-29709-4-git-send-email-hejianet@gmail.com>
References: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>
List-Id: linux-arch.vger.kernel.org

This is to replace find_fisrt_{zero_}bit with the new lightweight api 
all_bit_is_{one,zero} in bitmap_{full,empty}

Signed-off-by: Jia He <hejianet@gmail.com>
---
 include/linux/bitmap.h | 4 ++--
 include/linux/bitops.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 15524f6..8877a68 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -281,7 +281,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
 
-	return find_first_bit(src, nbits) == nbits;
+	return all_bit_is_zero(src, nbits);
 }
 
 static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
@@ -289,7 +289,7 @@ static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
 
-	return find_first_zero_bit(src, nbits) == nbits;
+	return all_bit_is_one(src, nbits);
 }
 
 static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index b881028..e34f2ff 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -214,6 +214,9 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+extern unsigned int all_bit_is_one(const unsigned long *addr, unsigned size);
+extern unsigned int all_bit_is_zero(const unsigned long *addr, unsigned size);
+
 #ifdef __KERNEL__
 
 #ifndef set_mask_bits
-- 
2.5.0
