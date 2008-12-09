From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/12] x86/PCI: use config space encoding for interrupt pins
Date: Tue, 09 Dec 2008 16:11:51 -0700
Message-ID: <20081209231151.18153.21917.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:31161 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYLIXL4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:11:56 -0500
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Keep "pin" encoded as it is in the "Interrupt Pin" value in PCI config
space, i.e., 0=device doesn't use interrupts, 1=INTA, ..., 4=INTD.

This makes the bridge INTx swizzle match other architectures.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/irq.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 15c3e69..5d1ce1c 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -888,7 +888,6 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
 	}
-	pin = pin - 1;
 
 	/* Find IRQ routing entry */
 
@@ -898,17 +897,17 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	info = pirq_get_info(dev);
 	if (!info) {
 		dev_dbg(&dev->dev, "PCI INT %c not found in routing table\n",
-			'A' + pin);
+			'A' + pin - 1);
 		return 0;
 	}
-	pirq = info->irq[pin].link;
-	mask = info->irq[pin].bitmap;
+	pirq = info->irq[pin - 1].link;
+	mask = info->irq[pin - 1].bitmap;
 	if (!pirq) {
-		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + pin);
+		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + pin - 1);
 		return 0;
 	}
 	dev_dbg(&dev->dev, "PCI INT %c -> PIRQ %02x, mask %04x, excl %04x",
-		'A' + pin, pirq, mask, pirq_table->exclusive_irqs);
+		'A' + pin - 1, pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
 	/* Work around broken HP Pavilion Notebooks which assign USB to
@@ -950,7 +949,7 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 				newirq = i;
 		}
 	}
-	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + pin, newirq);
+	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + pin - 1, newirq);
 
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
@@ -978,18 +977,18 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 			return 0;
 		}
 	}
-	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n", msg, 'A' + pin, irq);
+	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n", msg, 'A' + pin - 1, irq);
 
 	/* Update IRQ for all devices with the same pirq value */
 	while ((dev2 = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev2)) != NULL) {
 		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin);
 		if (!pin)
 			continue;
-		pin--;
+
 		info = pirq_get_info(dev2);
 		if (!info)
 			continue;
-		if (info->irq[pin].link == pirq) {
+		if (info->irq[pin - 1].link == pirq) {
 			/*
 			 * We refuse to override the dev->irq
 			 * information. Give a warning!
@@ -1056,9 +1055,8 @@ static void __init pcibios_fixup_irqs(void)
 			/*
 			 * interrupt pins are numbered starting from 1
 			 */
-			pin--;
 			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
-				PCI_SLOT(dev->devfn), pin);
+				PCI_SLOT(dev->devfn), pin - 1);
 			/*
 			 * Busses behind bridges are typically not listed in the
 			 * MP-table.  In this case we have to look up the IRQ
@@ -1071,22 +1069,22 @@ static void __init pcibios_fixup_irqs(void)
 				struct pci_dev *bridge = dev->bus->self;
 				int bus;
 
-				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
 				bus = bridge->bus->number;
 				irq = IO_APIC_get_PCI_irq_vector(bus,
-						PCI_SLOT(bridge->devfn), pin);
+						PCI_SLOT(bridge->devfn), pin - 1);
 				if (irq >= 0)
 					dev_warn(&dev->dev,
 						"using bridge %s INT %c to "
 							"get IRQ %d\n",
 						 pci_name(bridge),
-						 'A' + pin, irq);
+						 'A' + pin - 1, irq);
 			}
 			if (irq >= 0) {
 				dev_info(&dev->dev,
 					"PCI->APIC IRQ transform: INT %c "
 						"-> IRQ %d\n",
-					'A' + pin, irq);
+					'A' + pin - 1, irq);
 				dev->irq = irq;
 			}
 		}
@@ -1221,12 +1219,10 @@ static int pirq_enable_irq(struct pci_dev *dev)
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg = "";
 
-		pin--; /* interrupt pins are numbered starting from 1 */
-
 		if (io_apic_assign_pci_irqs) {
 			int irq;
 
-			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin - 1);
 			/*
 			 * Busses behind bridges are typically not listed in the MP-table.
 			 * In this case we have to look up the IRQ based on the parent bus,
@@ -1237,20 +1233,20 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
 				struct pci_dev *bridge = dev->bus->self;
 
-				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
 				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number,
-						PCI_SLOT(bridge->devfn), pin);
+						PCI_SLOT(bridge->devfn), pin - 1);
 				if (irq >= 0)
 					dev_warn(&dev->dev, "using bridge %s "
 						 "INT %c to get IRQ %d\n",
-						 pci_name(bridge), 'A' + pin,
+						 pci_name(bridge), 'A' + pin - 1,
 						 irq);
 				dev = bridge;
 			}
 			dev = temp_dev;
 			if (irq >= 0) {
 				dev_info(&dev->dev, "PCI->APIC IRQ transform: "
-					 "INT %c -> IRQ %d\n", 'A' + pin, irq);
+					 "INT %c -> IRQ %d\n", 'A' + pin - 1, irq);
 				dev->irq = irq;
 				return 0;
 			} else
@@ -1269,7 +1265,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			return 0;
 
 		dev_warn(&dev->dev, "can't find IRQ for PCI INT %c%s\n",
-			 'A' + pin, msg);
+			 'A' + pin - 1, msg);
 	}
 	return 0;
 }
