From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] asm-generic/page.h: fix typo in #error text requiring a real asm/page.h
Date: Thu, 21 Feb 2019 13:36:31 +0200
Message-ID: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

Replace "need to prove a real asm/page.h" with "need to provide a real
asm/page.h"

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/asm-generic/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 27bf337..fe801f0 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -7,7 +7,7 @@
  */
 
 #ifdef CONFIG_MMU
-#error need to prove a real asm/page.h
+#error need to provide a real asm/page.h
 #endif
 
 
-- 
2.7.4
