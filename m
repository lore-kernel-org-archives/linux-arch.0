From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arc: fix iounmap prototype
Date: Tue,  2 Jan 2018 12:01:24 +0100
Message-ID: <20180102110141.1853608-1-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:55971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeABLCJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 06:02:09 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org

The missing 'volatile' keyword on the iounmap argument leads to lots of
harmless warnings in an allmodconfig build:

sound/pci/echoaudio/echoaudio.c:1879:10: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier f
pointer target type [-Wdiscarded-qualifiers]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/io.h | 4 ++--
 arch/arc/mm/ioremap.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index c22b181e8206..2c9b98fabf82 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -30,11 +30,11 @@ static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 	return (void __iomem *)port;
 }
 
-static inline void ioport_unmap(void __iomem *addr)
+static inline void ioport_unmap(volatile void __iomem *addr)
 {
 }
 
-extern void iounmap(const void __iomem *addr);
+extern void iounmap(const volatile void __iomem *addr);
 
 #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
 #define ioremap_wc(phy, sz)		ioremap(phy, sz)
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 9881bd740ccc..94d0116063a8 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -95,7 +95,7 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
 EXPORT_SYMBOL(ioremap_prot);
 
 
-void iounmap(const void __iomem *addr)
+void iounmap(volatile const void __iomem *addr)
 {
 	/* weird double cast to handle phys_addr_t > 32 bits */
 	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
-- 
2.9.0
