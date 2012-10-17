From: Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 1/4] asm-generic: io: remove {read,write} string functions
Date: Wed, 17 Oct 2012 16:45:01 +0100
Message-ID: <1350488704-3711-2-git-send-email-will.deacon@arm.com>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mike Frysinger <vapier@gentoo.org>, Ben Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

The {read,write}s{b,w,l} functions are not defined across all
architectures and therefore shouldn't be used by portable drivers. We
should encourage driver writers to use the io{read,write}{8,16,32}_rep
functions instead.

This patch removes the {read,write} string functions for the generic IO
header as they have no place in a new architecture port.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 448303b..3607921 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -217,36 +217,6 @@ static inline void outsl(unsigned long addr, const void *buffer, int count)
 }
 #endif
 
-static inline void readsl(const void __iomem *addr, void *buf, int len)
-{
-	insl(addr - PCI_IOBASE, buf, len);
-}
-
-static inline void readsw(const void __iomem *addr, void *buf, int len)
-{
-	insw(addr - PCI_IOBASE, buf, len);
-}
-
-static inline void readsb(const void __iomem *addr, void *buf, int len)
-{
-	insb(addr - PCI_IOBASE, buf, len);
-}
-
-static inline void writesl(const void __iomem *addr, const void *buf, int len)
-{
-	outsl(addr - PCI_IOBASE, buf, len);
-}
-
-static inline void writesw(const void __iomem *addr, const void *buf, int len)
-{
-	outsw(addr - PCI_IOBASE, buf, len);
-}
-
-static inline void writesb(const void __iomem *addr, const void *buf, int len)
-{
-	outsb(addr - PCI_IOBASE, buf, len);
-}
-
 #ifndef CONFIG_GENERIC_IOMAP
 #define ioread8(addr)		readb(addr)
 #define ioread16(addr)		readw(addr)
-- 
1.7.4.1
