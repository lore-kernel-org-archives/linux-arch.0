From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] asm-generic/io.h: remove unnecessary include of linux/vmalloc.h
Date: Tue,  5 Sep 2017 13:27:27 +0200
Message-ID: <20170905112727.13668-1-tklauser@distanz.ch>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:36850 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdIELcd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Sep 2017 07:32:33 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Including linux/vmalloc.h in asm-generic/io.h isn't necessary since none
of the definitions are used in the header itself. Remove the include in
order to avoid potential header dependency problems if other headers
rely on implict inclusion of linux/vmalloc.h which means that changes
there could break unrelated parts.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3b2120..d2d3bd163f5f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 #ifndef CONFIG_GENERIC_IOMAP
-- 
2.13.0
