Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39808 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfBRLEv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 06:04:51 -0500
Date: Mon, 18 Feb 2019 11:53:40 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH 1/4] iomap: add missing function args identifier names
Message-ID: <99db3b9c5c87d7eb599b114013a24b478bb48d27.1550485787.git.hle@owl.eu.com>
References: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190218105340.3Hm10SeY4XFXSspGdmOjF1uhm83PRCbMTKTpXJmz9zw@z>

Add missing function arguments identifier names to asm-generic/iomap.h
definitions. This addresses multiple checkpatch.pl code style
warnings.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 include/asm-generic/iomap.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 5b63b94ef6b5..7e26f21b466f 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -26,24 +26,24 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
-extern unsigned int ioread8(void __iomem *);
-extern unsigned int ioread16(void __iomem *);
-extern unsigned int ioread16be(void __iomem *);
-extern unsigned int ioread32(void __iomem *);
-extern unsigned int ioread32be(void __iomem *);
+extern unsigned int ioread8(void __iomem *addr);
+extern unsigned int ioread16(void __iomem *addr);
+extern unsigned int ioread16be(void __iomem *addr);
+extern unsigned int ioread32(void __iomem *addr);
+extern unsigned int ioread32be(void __iomem *addr);
 #ifdef CONFIG_64BIT
-extern u64 ioread64(void __iomem *);
-extern u64 ioread64be(void __iomem *);
+extern u64 ioread64(void __iomem *addr);
+extern u64 ioread64be(void __iomem *addr);
 #endif
 
-extern void iowrite8(u8, void __iomem *);
-extern void iowrite16(u16, void __iomem *);
-extern void iowrite16be(u16, void __iomem *);
-extern void iowrite32(u32, void __iomem *);
-extern void iowrite32be(u32, void __iomem *);
+extern void iowrite8(u8 value, void __iomem *addr);
+extern void iowrite16(u16 value, void __iomem *addr);
+extern void iowrite16be(u16 value, void __iomem *addr);
+extern void iowrite32(u32 value, void __iomem *addr);
+extern void iowrite32be(u32 value, void __iomem *addr);
 #ifdef CONFIG_64BIT
-extern void iowrite64(u64, void __iomem *);
-extern void iowrite64be(u64, void __iomem *);
+extern void iowrite64(u64 value, void __iomem *addr);
+extern void iowrite64be(u64 value, void __iomem *addr);
 #endif
 
 /*
@@ -68,7 +68,7 @@ extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long cou
 #ifdef CONFIG_HAS_IOPORT_MAP
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
-extern void ioport_unmap(void __iomem *);
+extern void ioport_unmap(void __iomem *addr);
 #endif
 
 #ifndef ARCH_HAS_IOREMAP_WC
@@ -82,7 +82,7 @@ extern void ioport_unmap(void __iomem *);
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #elif defined(CONFIG_GENERIC_IOMAP)
 struct pci_dev;
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-- 
2.20.1
