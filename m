Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j34K3DA01955
	for <linux-arch@vger.kernel.org>; Mon, 4 Apr 2005 16:03:13 -0400
Subject: [PATCH] introduce BE bus handlers for the io{read,write} operators
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 15:03:12 -0500
Message-Id: <1112644992.5813.79.camel@mulgrave>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

If you haven't been following it, there's been discussion on lkml and
linux-scsi about the need for BE versions of our MMIO functions (at the
moment, ioread/iowrite assume the values are written LE).  Further,
examples of BE busses or chips on LE systems that would actually make
use of this were also dredged up.

So the attached (updated---missing be32_to_cpu and other problems) patch
is my proposal to remedy this.  As far as I can tell, parisc is the only
arch that is actually affected (being the only one to do its own
implementation).

If this looks OK to everyone (and I haven't missed any arches other that
parisc that need updating to use it) then I'll send it to lkml.

James

===== arch/parisc/lib/iomap.c 1.1 vs edited =====
--- 1.1/arch/parisc/lib/iomap.c	2005-01-10 08:00:46 -06:00
+++ edited/arch/parisc/lib/iomap.c	2005-04-04 13:53:49 -05:00
@@ -43,10 +43,14 @@
 struct iomap_ops {
 	unsigned int (*read8)(void __iomem *);
 	unsigned int (*read16)(void __iomem *);
+	unsigned int (*read16be)(void __iomem *);
 	unsigned int (*read32)(void __iomem *);
+	unsigned int (*read32be)(void __iomem *);
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
+	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
+	void (*write32be)(u32, void __iomem *);
 	void (*read8r)(void __iomem *, void *, unsigned long);
 	void (*read16r)(void __iomem *, void *, unsigned long);
 	void (*read32r)(void __iomem *, void *, unsigned long);
@@ -122,9 +126,13 @@
 static const struct iomap_ops ioport_ops = {
 	ioport_read8,
 	ioport_read16,
+	ioport_read16,
+	ioport_read32,
 	ioport_read32,
 	ioport_write8,
 	ioport_write16,
+	ioport_write16,
+	ioport_write32,
 	ioport_write32,
 	ioport_read8r,
 	ioport_read16r,
@@ -146,11 +154,21 @@
 	return readw(addr);
 }
 
+static unsigned int iomem_read16be(void __iomem *addr)
+{
+	return __raw_readw(addr);
+}
+
 static unsigned int iomem_read32(void __iomem *addr)
 {
 	return readl(addr);
 }
 
+static unsigned int iomem_read32be(void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
 static void iomem_write8(u8 datum, void __iomem *addr)
 {
 	writeb(datum, addr);
@@ -161,11 +179,21 @@
 	writew(datum, addr);
 }
 
+static void iomem_write16be(u16 datum, void __iomem *addr)
+{
+	__raw_writew(datum, addr);
+}
+
 static void iomem_write32(u32 datum, void __iomem *addr)
 {
 	writel(datum, addr);
 }
 
+static void iomem_write32be(u32 datum, void __iomem *addr)
+{
+	__raw_writel(datum, addr);
+}
+
 static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
@@ -217,10 +245,14 @@
 static const struct iomap_ops iomem_ops = {
 	iomem_read8,
 	iomem_read16,
+	iomem_read16be,
 	iomem_read32,
+	iomem_read32be,
 	iomem_write8,
 	iomem_write16,
+	iomem_write16be,
 	iomem_write32,
+	iomem_write32be,
 	iomem_read8r,
 	iomem_read16r,
 	iomem_read32r,
@@ -253,6 +285,13 @@
 	return le16_to_cpup((u16 *)addr);
 }
 
+unsigned int ioread16be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read16be(addr);
+	return *((u16 *)addr);
+}
+
 unsigned int ioread32(void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
@@ -260,6 +299,13 @@
 	return le32_to_cpup((u32 *)addr);
 }
 
+unsigned int ioread32be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read32be(addr);
+	return *((u32 *)addr);
+}
+
 void iowrite8(u8 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -278,12 +324,30 @@
 	}
 }
 
+void iowrite16be(u16 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write16be(datum, addr);
+	} else {
+		*((u16 *)addr) = datum;
+	}
+}
+
 void iowrite32(u32 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->write32(datum, addr);
 	} else {
 		*((u32 *)addr) = cpu_to_le32(datum);
+	}
+}
+
+void iowrite32be(u32 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write32be(datum, addr);
+	} else {
+		*((u32 *)addr) = datum;
 	}
 }
 
===== include/asm-generic/iomap.h 1.3 vs edited =====
--- 1.3/include/asm-generic/iomap.h	2004-09-14 18:28:47 -05:00
+++ edited/include/asm-generic/iomap.h	2005-04-04 12:06:14 -05:00
@@ -2,6 +2,7 @@
 #define __GENERIC_IO_H
 
 #include <linux/linkage.h>
+#include <asm/byteorder.h>
 
 /*
  * These are the "generic" interfaces for doing new-style
@@ -26,11 +27,15 @@
  */
 extern unsigned int fastcall ioread8(void __iomem *);
 extern unsigned int fastcall ioread16(void __iomem *);
+extern unsigned int fastcall ioread16be(void __iomem *);
 extern unsigned int fastcall ioread32(void __iomem *);
+extern unsigned int fastcall ioread32be(void __iomem *);
 
 extern void fastcall iowrite8(u8, void __iomem *);
 extern void fastcall iowrite16(u16, void __iomem *);
+extern void fastcall iowrite16be(u16, void __iomem *);
 extern void fastcall iowrite32(u32, void __iomem *);
+extern void fastcall iowrite32be(u32, void __iomem *);
 
 /*
  * "string" versions of the above. Note that they
===== lib/iomap.c 1.6 vs edited =====
--- 1.6/lib/iomap.c	2004-10-28 02:39:50 -05:00
+++ edited/lib/iomap.c	2005-04-04 14:04:14 -05:00
@@ -58,13 +58,23 @@
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 }
+unsigned int fastcall ioread16be(void __iomem *addr)
+{
+	IO_COND(addr, return inw(port), return be16_to_cpu(__raw_readw(addr)));
+}
 unsigned int fastcall ioread32(void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 }
+unsigned int fastcall ioread32be(void __iomem *addr)
+{
+	IO_COND(addr, return inl(port), return be32_to_cpu(__raw_readl(addr)));
+}
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
+EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
+EXPORT_SYMBOL(ioread32be);
 
 void fastcall iowrite8(u8 val, void __iomem *addr)
 {
@@ -74,13 +84,23 @@
 {
 	IO_COND(addr, outw(val,port), writew(val, addr));
 }
+void fastcall iowrite16be(u16 val, void __iomem *addr)
+{
+	IO_COND(addr, outw(val,port), __raw_writew(cpu_to_be16(val), addr));
+}
 void fastcall iowrite32(u32 val, void __iomem *addr)
 {
 	IO_COND(addr, outl(val,port), writel(val, addr));
 }
+void fastcall iowrite32be(u32 val, void __iomem *addr)
+{
+	IO_COND(addr, outl(val,port), __raw_writel(cpu_to_be32(val), addr));
+}
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
+EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
+EXPORT_SYMBOL(iowrite32be);
 
 /*
  * These are the "repeat MMIO read/write" functions.
