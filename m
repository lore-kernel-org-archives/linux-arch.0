Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfBVSFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:02 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/3] asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
Date: Fri, 22 Feb 2019 18:04:52 +0000
Message-ID: <20190222180454.5992-2-will.deacon@arm.com>
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20190222180452._s8zaz8sAI4rAu953NaSFcnPe6NKeepiJT28W_WyAlU@z>

The inX() and readX() I/O accessors must enforce ordering against
subsequent calls to the delay() routines, so that a read-back from a
device can be used to postpone a subsequent write to the same device.

On some architectures, including arm64, this ordering can only be
achieved by creating a dependency on the value returned by the I/O
accessor operation, so we need to pass the value we read to the
__io_par() and __io_ar() macros in these cases.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d356f802945a..303871651f8a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -32,9 +32,9 @@
 /* prevent prefetching of coherent DMA data ahead of a dma-complete */
 #ifndef __io_ar
 #ifdef rmb
-#define __io_ar()      rmb()
+#define __io_ar(v)      rmb()
 #else
-#define __io_ar()      barrier()
+#define __io_ar(v)      barrier()
 #endif
 #endif
 
@@ -65,7 +65,7 @@
 #endif
 
 #ifndef __io_par
-#define __io_par()     __io_ar()
+#define __io_par(v)     __io_ar(v)
 #endif
 
 
@@ -158,7 +158,7 @@ static inline u8 readb(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __raw_readb(addr);
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -171,7 +171,7 @@ static inline u16 readw(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le16_to_cpu(__raw_readw(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -184,7 +184,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le32_to_cpu(__raw_readl(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -198,7 +198,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le64_to_cpu(__raw_readq(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -471,7 +471,7 @@ static inline u8 inb(unsigned long addr)
 
 	__io_pbr();
 	val = __raw_readb(PCI_IOBASE + addr);
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -484,7 +484,7 @@ static inline u16 inw(unsigned long addr)
 
 	__io_pbr();
 	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -497,7 +497,7 @@ static inline u32 inl(unsigned long addr)
 
 	__io_pbr();
 	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
-- 
2.11.0
