Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfDWQij (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:38:39 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] asm-generic: don't include <asm/segment.h> from <asm/uaccess.h>
Date: Tue, 23 Apr 2019 18:38:06 +0200
Message-Id: <20190423163809.9962-2-hch@lst.de>
In-Reply-To: <20190423163809.9962-1-hch@lst.de>
References: <20190423163809.9962-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

<asm/segment.h> is an odd x86 legacy that we shouldn't force on other
architectures.  arc used it to bring in mm_context_t, but we can do
that inside the arc code easily.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/include/asm/uaccess.h | 1 +
 include/asm-generic/uaccess.h  | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index eabc3efa6c6d..526418543379 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -742,6 +742,7 @@ extern long arc_strnlen_user_noinline(const char __user *src, long n);
 
 #endif
 
+#include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
 #endif
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index b3d2241e03f8..aac336831204 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -9,8 +9,6 @@
  */
 #include <linux/string.h>
 
-#include <asm/segment.h>
-
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
 #ifndef KERNEL_DS
-- 
2.20.1
