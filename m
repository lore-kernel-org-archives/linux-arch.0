From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 4/5] powerpc: make pcibios_vaddr_is_ioport() static
Date: Thu, 31 Oct 2019 01:31:53 +0100
Message-ID: <20191031003154.21969-5-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-arch.vger.kernel.org

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
