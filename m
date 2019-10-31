Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfJaAcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so4125099wms.3
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:04 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/5] powerpc: move pci_iounmap() from iomap.c to pci-common.c
Date: Thu, 31 Oct 2019 01:31:52 +0100
Message-ID: <20191031003154.21969-4-linux@rasmusvillemoes.dk>
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20191031003152.CiZU86hLNG340EikI67glGloMKmbDMbKXj6VOtAFFzU@z>

As preparation for making iowrite32 and friends static inlines, move
the definition of pci_iounmap() from iomap.c to pci-common.c. This
definition of pci_iounmap() is compiled in when
!CONFIG_PPC_INDIRECT_PIO && CONFIG_PCI - we're just interchanging
which condition is in the Kbuild logic and which is in the .c file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/kernel/iomap.c      | 13 -------------
 arch/powerpc/kernel/pci-common.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 5ac84efc6ede..b22fa8db5068 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -182,16 +182,3 @@ void ioport_unmap(void __iomem *addr)
 }
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
-
-#ifdef CONFIG_PCI
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	if (isa_vaddr_is_ioport(addr))
-		return;
-	if (pcibios_vaddr_is_ioport(addr))
-		return;
-	iounmap(addr);
-}
-
-EXPORT_SYMBOL(pci_iounmap);
-#endif /* CONFIG_PCI */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1c448cf25506..d89a2426b405 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
@@ -295,6 +296,18 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
+#ifndef CONFIG_PPC_INDIRECT_PIO
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	if (isa_vaddr_is_ioport(addr))
+		return;
+	if (pcibios_vaddr_is_ioport(addr))
+		return;
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+#endif /* CONFIG_PPC_INDIRECT_PIO */
+
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller *hose;
-- 
2.23.0
