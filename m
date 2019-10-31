Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55990 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfJaAcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so4061053wmh.5
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] powerpc: make pcibios_vaddr_is_ioport() static
Date: Thu, 31 Oct 2019 01:31:53 +0100
Message-ID: <20191031003154.21969-5-linux@rasmusvillemoes.dk>
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20191031003153.KZCe94-P_0PxtmuxFAbCoyQit58YzximWYSk2_AFQX0@z>

The only caller of pcibios_vaddr_is_ioport() is in pci-common.c, so we
can make it static and move it into the same #ifndef block as its
caller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/pci-bridge.h | 9 ---------
 arch/powerpc/kernel/pci-common.c      | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ea6ec65970ef..deb29a1c9708 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -283,14 +283,5 @@ extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 extern void pcibios_free_controller_deferred(struct pci_host_bridge *bridge);
 
-#ifdef CONFIG_PCI
-extern int pcibios_vaddr_is_ioport(void __iomem *address);
-#else
-static inline int pcibios_vaddr_is_ioport(void __iomem *address)
-{
-	return 0;
-}
-#endif	/* CONFIG_PCI */
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d89a2426b405..928d7576c6c2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -277,7 +277,8 @@ static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 #endif
 }
 
-int pcibios_vaddr_is_ioport(void __iomem *address)
+#ifndef CONFIG_PPC_INDIRECT_PIO
+static int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	int ret = 0;
 	struct pci_controller *hose;
@@ -296,7 +297,6 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
 	return ret;
 }
 
-#ifndef CONFIG_PPC_INDIRECT_PIO
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if (isa_vaddr_is_ioport(addr))
-- 
2.23.0
