From: Jia He <hejianet@gmail.com>
Subject: [PATCH 3/3] linux/bitmap: Replace find_fisrt_{zero_}bit with the new lightweight api
Date: Thu, 19 Nov 2015 10:31:54 +0800
Message-ID: <1447900314-5727-4-git-send-email-hejianet@gmail.com>
References: <1447900314-5727-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:32875 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbbKSCcY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2015 21:32:24 -0500
In-Reply-To: <1447900314-5727-1-git-send-email-hejianet@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>

This is to replace find_fisrt_{zero_}bit with the new lightweight api 
all_bit_is_{one,zero} in bitmap_{full,empty}

Signed-off-by: Jia He <hejianet@gmail.com>
---
 include/asm-generic/bitops/find.h | 3 +++
 include/linux/bitmap.h            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 998d4d5..1ec1d45 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -59,4 +59,7 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+extern unsigned int all_bit_is_one(const unsigned long *addr, unsigned size);
+extern unsigned int all_bit_is_zero(const unsigned long *addr, unsigned size);
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
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
-- 
2.5.0
