From: Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] asm-generic: page.h: fix comment typo
Date: Tue, 23 Aug 2016 08:33:59 +0100
Message-ID: <20160823073359.21690-1-lstoakes@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbcHWHeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2016 03:34:04 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch prefixes a '!' to a /* __ASSEMBLY__ */ comment following an #ifndef
__ASSEMBLY__ block.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/asm-generic/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 67cfb7d..8847a6e 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -92,7 +92,7 @@ extern unsigned long memory_end;
 #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
 				((void *)(kaddr) < (void *)memory_end))
 
-#endif /* __ASSEMBLY__ */
+#endif /* !__ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
-- 
2.9.3
