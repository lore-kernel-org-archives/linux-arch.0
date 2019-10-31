Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJaAcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id v3so5398352wmh.1
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:02 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/5] asm-generic: move pcu_iounmap from iomap.h to pci_iomap.h
Date: Thu, 31 Oct 2019 01:31:50 +0100
Message-ID: <20191031003154.21969-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20191031003150.MKbDj-AgEadnzO0425gms-o7NqGWCEt5JS7bo3E3dtI@z>

pci_iounmap seems misplaced in iomap.h. Move it to where its cousins
live. Since iomap.h includes pci_iomap.h, anybody relying on getting
the declaration through iomap.h will still get it.

It would be natural to put the static inline version inside the

#elif defined(CONFIG_GENERIC_PCI_IOMAP)

Since GENERIC_IOMAP selects GENERIC_PCI_IOMAP, that would be ok for
those who select GENERIC_IOMAP. However, I fear there are some that
select GENERIC_PCI_IOMAP without GENERIC_IOMAP, and which perhaps have
their own pci_iounmap stub definition somewhere. So for now at least,
define the static inline version under the same conditions as it were
in iomap.h.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/iomap.h     | 10 ----------
 include/asm-generic/pci_iomap.h |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index a008f504a2d0..5f8321e8fea9 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -101,16 +101,6 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap_nocache
 #endif
 
-#ifdef CONFIG_PCI
-/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#elif defined(CONFIG_GENERIC_IOMAP)
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{ }
-#endif
-
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index d4f16dcc2ed7..c2f78db2420e 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,8 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -52,4 +54,9 @@ static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 }
 #endif
 
+#if !defined(CONFIG_PCI) && defined(CONFIG_GENERIC_IOMAP)
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{ }
+#endif
+
 #endif /* __ASM_GENERIC_IO_H */
-- 
2.23.0
