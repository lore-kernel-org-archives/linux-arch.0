From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] asm-generic: Add spaces around & operator
Date: Sun, 25 Nov 2018 17:30:45 +0800
Message-ID: <1543138245-3673-1-git-send-email-liu.xiang6@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-arch.vger.kernel.org

Add spaces around '&' to follow kernel coding style.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 include/asm-generic/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3..d6e8da3 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -18,7 +18,7 @@
 #include <linux/bug.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & PAGE_MASK)) >> PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 /*
-- 
1.9.1
