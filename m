From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 12/12] PCI: x86: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:37 -0700
Message-ID: <20081209231237.18153.72370.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:35348 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbYLIXMi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:12:38 -0500
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/irq.c   |    4 ++--
 arch/x86/pci/visws.c |    7 +------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 6547497..1d6469b 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1069,7 +1069,7 @@ static void __init pcibios_fixup_irqs(void)
 				struct pci_dev *bridge = dev->bus->self;
 				int bus;
 
-				pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+				pin = pci_swizzle_interrupt_pin(dev, pin);
 				bus = bridge->bus->number;
 				irq = IO_APIC_get_PCI_irq_vector(bus,
 						PCI_SLOT(bridge->devfn), pin - 1);
@@ -1233,7 +1233,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
 				struct pci_dev *bridge = dev->bus->self;
 
-				pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+				pin = pci_swizzle_interrupt_pin(dev, pin);
 				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number,
 						PCI_SLOT(bridge->devfn), pin - 1);
 				if (irq >= 0)
diff --git a/arch/x86/pci/visws.c b/arch/x86/pci/visws.c
index 42f4cb1..6b5ed3d 100644
--- a/arch/x86/pci/visws.c
+++ b/arch/x86/pci/visws.c
@@ -25,17 +25,12 @@ static void pci_visws_disable_irq(struct pci_dev *dev) { }
 
 unsigned int pci_bus0, pci_bus1;
 
-static inline u8 bridge_swizzle(u8 pin, u8 slot) 
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 static u8 __init visws_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	u8 pin = *pinp;
 
 	while (dev->bus->self) {	/* Move up the chain of bridges. */
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		dev = dev->bus->self;
 	}
 	*pinp = pin;
