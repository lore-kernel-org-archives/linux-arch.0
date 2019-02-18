Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42665 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfBRKyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 05:54:06 -0500
Date: Mon, 18 Feb 2019 11:54:02 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH 2/4] iomap: add missing const to ioread*/iowrite addr arg
Message-ID: <4b6808438be9262b8b68876bc4c4a03072b10d8e.1550485787.git.hle@owl.eu.com>
References: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190218105402.-04M-TR5EgZTcH9da6WcmP2-XmCHYsngtV2LVMO6wXE@z>

ioread* and iowrite* definitions from asm-generic/iomap.h and
lib/iomap.c are missing const qualifiers. This is inconsistent with
the definitions from asm-generic/io.h and results in compilation
warnings when compiling drivers.

Add missing const qualifiers.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 include/asm-generic/iomap.h | 20 ++++++++++----------
 lib/iomap.c                 | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 7e26f21b466f..cd92d32a4d87 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -26,14 +26,14 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
-extern unsigned int ioread8(void __iomem *addr);
-extern unsigned int ioread16(void __iomem *addr);
-extern unsigned int ioread16be(void __iomem *addr);
-extern unsigned int ioread32(void __iomem *addr);
-extern unsigned int ioread32be(void __iomem *addr);
+extern unsigned int ioread8(const void __iomem *addr);
+extern unsigned int ioread16(const void __iomem *addr);
+extern unsigned int ioread16be(const void __iomem *addr);
+extern unsigned int ioread32(const void __iomem *addr);
+extern unsigned int ioread32be(const void __iomem *addr);
 #ifdef CONFIG_64BIT
-extern u64 ioread64(void __iomem *addr);
-extern u64 ioread64be(void __iomem *addr);
+extern u64 ioread64(const void __iomem *addr);
+extern u64 ioread64be(const void __iomem *addr);
 #endif
 
 extern void iowrite8(u8 value, void __iomem *addr);
@@ -57,9 +57,9 @@ extern void iowrite64be(u64 value, void __iomem *addr);
  * memory across multiple ports, use "memcpy_toio()"
  * and friends.
  */
-extern void ioread8_rep(void __iomem *port, void *buf, unsigned long count);
-extern void ioread16_rep(void __iomem *port, void *buf, unsigned long count);
-extern void ioread32_rep(void __iomem *port, void *buf, unsigned long count);
+extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
+extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
 
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..8cc3270697e9 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -69,27 +69,27 @@ static void bad_io_access(unsigned long port, const char *access)
 #define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
 #endif
 
-unsigned int ioread8(void __iomem *addr)
+unsigned int ioread8(const void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
 	return 0xff;
 }
-unsigned int ioread16(void __iomem *addr)
+unsigned int ioread16(const void __iomem *addr)
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 	return 0xffff;
 }
-unsigned int ioread16be(void __iomem *addr)
+unsigned int ioread16be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 	return 0xffff;
 }
-unsigned int ioread32(void __iomem *addr)
+unsigned int ioread32(const void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 	return 0xffffffff;
 }
-unsigned int ioread32be(void __iomem *addr)
+unsigned int ioread32be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
 	return 0xffffffff;
@@ -193,15 +193,15 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
 }
 #endif
 
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
 }
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insw(port,dst,count), mmio_insw(addr, dst, count));
 }
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
 }
-- 
2.20.1
