From: Jia He <hejianet@gmail.com>
Subject: [PATCH v2 1/3] linux/bitmap: Move 2 mask macro from bitmap.h to bitops.h
Date: Thu, 19 Nov 2015 14:48:42 +0800
Message-ID: <1447915724-29709-2-git-send-email-hejianet@gmail.com>
References: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>
List-Id: linux-arch.vger.kernel.org

This patch moves the mask macro to bitops.h and then the new introduced
api in find_bit.c can use it.

Signed-off-by: Jia He <hejianet@gmail.com>
---
 include/linux/bitmap.h | 3 ---
 include/linux/bitops.h | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 9653fdb..15524f6 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -172,9 +172,6 @@ extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int
 extern int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
-
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2b8ed12..b881028 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -24,6 +24,10 @@
 #define GENMASK_ULL(h, l) \
 	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
+/* For bitmap ops*/
+#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
-- 
2.5.0
