From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH 2/2] include: Fix compile warning in include/linux/bitops.h
Date: Sun, 21 Aug 2011 00:12:32 +0900
Message-ID: <1313853152-1988-1-git-send-email-linkinjeon@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:51366 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab1HTPMy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2011 11:12:54 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>

The compile warning is caused by __const_hweight8 when using hweight_long with -Wsign-compare option.
The reason is that the default return value of this macro is signed. So need type casting to remove warning.

Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
---
 include/asm-generic/bitops/const_hweight.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bitops/const_hweight.h b/include/asm-generic/bitops/const_hweight.h
index fa2a50b..31b7fce 100644
--- a/include/asm-generic/bitops/const_hweight.h
+++ b/include/asm-generic/bitops/const_hweight.h
@@ -4,15 +4,15 @@
 /*
  * Compile time versions of __arch_hweightN()
  */
-#define __const_hweight8(w)		\
-      (	(!!((w) & (1ULL << 0))) +	\
-	(!!((w) & (1ULL << 1))) +	\
-	(!!((w) & (1ULL << 2))) +	\
-	(!!((w) & (1ULL << 3))) +	\
-	(!!((w) & (1ULL << 4))) +	\
-	(!!((w) & (1ULL << 5))) +	\
-	(!!((w) & (1ULL << 6))) +	\
-	(!!((w) & (1ULL << 7)))	)
+#define __const_hweight8(w)	(unsigned long)	\
+      	(	(!!((w) & (1ULL << 0))) +	\
+		(!!((w) & (1ULL << 1))) +	\
+		(!!((w) & (1ULL << 2))) +	\
+		(!!((w) & (1ULL << 3))) +	\
+		(!!((w) & (1ULL << 4))) +	\
+		(!!((w) & (1ULL << 5))) +	\
+		(!!((w) & (1ULL << 6))) +	\
+		(!!((w) & (1ULL << 7)))	)
 
 #define __const_hweight16(w) (__const_hweight8(w)  + __const_hweight8((w)  >> 8 ))
 #define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
-- 
1.7.4.4
