From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] xtensa: shut up gcc-8 warnings
Date: Tue,  2 Jan 2018 12:00:22 +0100
Message-ID: <20180102110035.1806925-1-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeABLAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 06:00:39 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

Many uses of strncpy() on xtensa causes  a warning like

arch/xtensa/include/asm/string.h:56:42: warning: array subscript is above array bounds [-Warray-bounds]
   : "0" (__dest), "1" (__src), "r" (__src+__n)

This avoids the warning by turning the pointer arithmetic into an
integer operation that does not get checked the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/include/asm/string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/string.h b/arch/xtensa/include/asm/string.h
index 586bad9fe187..89b51a0c752f 100644
--- a/arch/xtensa/include/asm/string.h
+++ b/arch/xtensa/include/asm/string.h
@@ -53,7 +53,7 @@ static inline char *strncpy(char *__dest, const char *__src, size_t __n)
 		"bne	%1, %5, 1b\n"
 		"2:"
 		: "=r" (__dest), "=r" (__src), "=&r" (__dummy)
-		: "0" (__dest), "1" (__src), "r" (__src+__n)
+		: "0" (__dest), "1" (__src), "r" ((uintptr_t)__src+__n)
 		: "memory");
 
 	return __xdest;
@@ -101,7 +101,7 @@ static inline int strncmp(const char *__cs, const char *__ct, size_t __n)
 		"2:\n\t"
 		"sub	%2, %2, %3"
 		: "=r" (__cs), "=r" (__ct), "=&r" (__res), "=&r" (__dummy)
-		: "0" (__cs), "1" (__ct), "r" (__cs+__n));
+		: "0" (__cs), "1" (__ct), "r" ((uintptr_t)__cs+__n));
 
 	return __res;
 }
-- 
2.9.0
