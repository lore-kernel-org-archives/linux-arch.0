From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] m32r: fix readl/writel prototypes
Date: Tue,  2 Jan 2018 11:56:41 +0100
Message-ID: <20180102105653.1645748-1-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:54063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeABK46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 05:56:58 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

All other architectures use 'unsigned int' as the data in readl/write,
but m32r uses 'unsigned long', leading to lots of harmless build warnings
like:

drivers/mmc/host/dw_mmc.c: In function 'dw_mci_regs_show':
drivers/mmc/host/dw_mmc.c:168:31: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
  seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m32r/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 1b653bb16f9a..093486b5b931 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -108,9 +108,9 @@ static inline unsigned short _readw(unsigned long addr)
 	return *(volatile unsigned short __force *)addr;
 }
 
-static inline unsigned long _readl(unsigned long addr)
+static inline unsigned int _readl(unsigned long addr)
 {
-	return *(volatile unsigned long __force *)addr;
+	return *(volatile unsigned int __force *)addr;
 }
 
 static inline void _writeb(unsigned char b, unsigned long addr)
@@ -123,9 +123,9 @@ static inline void _writew(unsigned short w, unsigned long addr)
 	*(volatile unsigned short __force *)addr = w;
 }
 
-static inline void _writel(unsigned long l, unsigned long addr)
+static inline void _writel(unsigned long l, unsigned int addr)
 {
-	*(volatile unsigned long __force *)addr = l;
+	*(volatile unsigned int __force *)addr = l;
 }
 
 #define inb     _inb
-- 
2.9.0
