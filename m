From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] asm-generic: Remove dead shift assignment in ffs/fls
Date: Wed, 10 Jun 2020 17:29:25 +0200
Message-ID: <20200610152925.11963-1-tklauser@distanz.ch>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:36876 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPfC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 11:35:02 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

The shift assignment in the last if block of ffs/fls is never read,
remove it.

Found using clang scan-build.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/asm-generic/bitops/ffs.h       | 4 +---
 include/asm-generic/bitops/fls.h       | 4 +---
 tools/include/asm-generic/bitops/fls.h | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index e81868b2c0f0..bc5f1a8f83ca 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -32,10 +32,8 @@ static inline int ffs(int x)
 		x >>= 2;
 		r += 2;
 	}
-	if (!(x & 1)) {
-		x >>= 1;
+	if (!(x & 1))
 		r += 1;
-	}
 	return r;
 }
 
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index b168bb10e1be..07e5cdfc3b98 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -32,10 +32,8 @@ static __always_inline int fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
-- 
2.27.0
