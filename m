From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2] asm-generic/io.h: Fix sparse warnings on big-endian architectures
Date: Tue,  4 Aug 2020 12:54:37 +0900
Message-ID: <20200804035437.3920009-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbgHDDyo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 23:54:44 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On big-endian architectures like OpenRISC, sparse outputs below warnings on
asm-generic/io.h.  This is due to io statements like:

  __raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);

The __raw_writel() function expects native endianness, however
cpu_to_le32() returns __le32.  On little-endian machines these match up
and there is no issue.  However, on big-endian we get warnings, for IO
that is defined as little-endian the mismatch is expected.

The fix I propose is to __force to native endian.

Warnings:

./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:215:22: warning: incorrect type in argument 1 (different base types)
./include/asm-generic/io.h:215:22:    expected unsigned short [usertype] value
./include/asm-generic/io.h:215:22:    got restricted __le16 [usertype]
./include/asm-generic/io.h:225:22: warning: incorrect type in argument 1 (different base types)
./include/asm-generic/io.h:225:22:    expected unsigned int [usertype] value
./include/asm-generic/io.h:225:22:    got restricted __le32 [usertype]

Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes since v1:
 - Remove white space between casts and right hand value. That matches all of
   the other casts.

 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 30a3aab312e6..dabf8cb7203b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -163,7 +163,7 @@ static inline u16 readw(const volatile void __iomem *addr)
 	u16 val;
 
 	__io_br();
-	val = __le16_to_cpu(__raw_readw(addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
 	return val;
 }
@@ -176,7 +176,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 	u32 val;
 
 	__io_br();
-	val = __le32_to_cpu(__raw_readl(addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
 	return val;
 }
@@ -212,7 +212,7 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writew(cpu_to_le16(value), addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
 }
 #endif
@@ -222,7 +222,7 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writel(__cpu_to_le32(value), addr);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
 }
 #endif
@@ -474,7 +474,7 @@ static inline u16 _inw(unsigned long addr)
 	u16 val;
 
 	__io_pbr();
-	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -487,7 +487,7 @@ static inline u32 _inl(unsigned long addr)
 	u32 val;
 
 	__io_pbr();
-	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -508,7 +508,7 @@ static inline void _outb(u8 value, unsigned long addr)
 static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
@@ -518,7 +518,7 @@ static inline void _outw(u16 value, unsigned long addr)
 static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
+	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
-- 
2.26.2
