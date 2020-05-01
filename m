From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] asm-generic: remove an empty ifdef block from signal.h
Date: Fri,  1 May 2020 12:39:02 +0200
Message-ID: <20200501103902.2620910-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728545AbgEAKjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2020 06:39:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/signal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/signal.h b/include/asm-generic/signal.h
index c53984fa97614..663dd6d0795dc 100644
--- a/include/asm-generic/signal.h
+++ b/include/asm-generic/signal.h
@@ -5,8 +5,6 @@
 #include <uapi/asm-generic/signal.h>
 
 #ifndef __ASSEMBLY__
-#ifdef SA_RESTORER
-#endif
 
 #include <asm/sigcontext.h>
 #undef __HAVE_ARCH_SIG_BITOPS
-- 
2.26.2
