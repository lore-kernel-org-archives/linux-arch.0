From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/6] PCI: alpha: use generic INTx swizzle from PCI core
Date: Tue, 16 Dec 2008 21:37:00 -0700
Message-ID: <20081217043700.8372.19362.stgit@bob.kio>
References: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:12514 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYLQEhA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2008 23:37:00 -0500
In-Reply-To: <20081217043443.8372.28890.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_common_swizzle() instead of arch-specific code.

Note that pci_common_swizzle() loops based on dev->bus->self, not
dev->bus->parent as the alpha common_swizzle() did.  I think they
are equivalent for this purpose.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/alpha/kernel/pci.c      |   18 ------------------
 arch/alpha/kernel/pci_impl.h |    4 ++--
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index b03d9f4..a3b9388 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -320,24 +320,6 @@ pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-/* Most Alphas have straight-forward swizzling needs.  */
-
-u8 __init
-common_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	u8 pin = *pinp;
-
-	while (dev->bus->parent) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		/* Move up the chain of bridges. */
-		dev = dev->bus->self;
-        }
-	*pinp = pin;
-
-	/* The slot is the slot of the last bridge. */
-	return PCI_SLOT(dev->devfn);
-}
-
 void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res)
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index 7336651..00edd04 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -107,7 +107,7 @@ struct pci_iommu_arena;
  *   Thus, each swizzle is ((pin-1) + (device#-4)) % 4
  *
  *   pci_swizzle_interrupt_pin() swizzles for exactly one bridge.  The routine
- *   common_swizzle below handles multiple bridges.  But there are a
+ *   pci_common_swizzle() handles multiple bridges.  But there are a
  *   couple boards that do strange things.
  */
 
@@ -179,7 +179,7 @@ extern int pci_probe_only;
 extern unsigned long alpha_agpgart_size;
 
 extern void common_init_pci(void);
-extern u8 common_swizzle(struct pci_dev *, u8 *);
+#define common_swizzle pci_common_swizzle
 extern struct pci_controller *alloc_pci_controller(void);
 extern struct resource *alloc_resource(void);
 
