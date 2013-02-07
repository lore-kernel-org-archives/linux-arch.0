From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] asm-generic: io: Fix ioread16/32be and iowrite16/32be
Date: Thu,  7 Feb 2013 15:18:48 +0100
Message-ID: <1360246728-3490-1-git-send-email-michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fix ioreadXXbe and iowriteXXbe functions which did
additional little endian conversion on native big endian systems.
Using be_to_cpu (cpu_to_be) conversions with __raw_read/write
functions have resolved it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arch@vger.kernel.org
---
 include/asm-generic/io.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 33bbbae..8823581 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -225,15 +225,15 @@ static inline void outsl(unsigned long addr, const void *buffer, int count)
 #ifndef CONFIG_GENERIC_IOMAP
 #define ioread8(addr)		readb(addr)
 #define ioread16(addr)		readw(addr)
-#define ioread16be(addr)	be16_to_cpu(ioread16(addr))
+#define ioread16be(addr)	__be16_to_cpu(__raw_readw(addr))
 #define ioread32(addr)		readl(addr)
-#define ioread32be(addr)	be32_to_cpu(ioread32(addr))
+#define ioread32be(addr)	__be32_to_cpu(__raw_readl(addr))
 
 #define iowrite8(v, addr)	writeb((v), (addr))
 #define iowrite16(v, addr)	writew((v), (addr))
-#define iowrite16be(v, addr)	iowrite16(be16_to_cpu(v), (addr))
+#define iowrite16be(v, addr)	__raw_writew(__cpu_to_be16(v), addr)
 #define iowrite32(v, addr)	writel((v), (addr))
-#define iowrite32be(v, addr)	iowrite32(be32_to_cpu(v), (addr))
+#define iowrite32be(v, addr)	__raw_writel(__cpu_to_be32(v), addr)
 
 #define ioread8_rep(p, dst, count) \
 	insb((unsigned long) (p), (dst), (count))
-- 
1.7.0.4
