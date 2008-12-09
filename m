Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:31477 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbYLIXMZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:12:25 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/12] PCI: parisc: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:22 -0700
Message-ID: <20081209231222.18153.28604.stgit@bob.kio>
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
Message-ID: <20081209231222.CzuKVrjMLDveP-gX0oFuQ-d4g0JqIj95apGoCH1SBDY@z>

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/parisc/dino.c    |    4 ++--
 drivers/parisc/iosapic.c |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 3bc54b3..77cc8bf 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -547,7 +547,7 @@ dino_card_fixup(struct pci_dev *dev)
 	** The additional "-1" adjusts for skewing the IRQ<->slot.
 	*/
 	dino_cfg_read(dev->bus, dev->devfn, PCI_INTERRUPT_PIN, 1, &irq_pin); 
-	dev->irq = (irq_pin + PCI_SLOT(dev->devfn) - 1) % 4 ;
+	dev->irq = pci_swizzle_interrupt_pin(dev, irq_pin) - 1;
 
 	/* Shouldn't really need to do this but it's in case someone tries
 	** to bypass PCI services and look at the card themselves.
@@ -672,7 +672,7 @@ dino_fixup_bus(struct pci_bus *bus)
 			
 			dino_cfg_read(dev->bus, dev->devfn, 
 				      PCI_INTERRUPT_PIN, 1, &irq_pin);
-			irq_pin = (irq_pin + PCI_SLOT(dev->devfn) - 1) % 4 ;
+			irq_pin = pci_swizzle_interrupt_pin(dev, irq_pin) - 1;
 			printk(KERN_WARNING "Device %s has undefined IRQ, "
 					"setting to %d\n", pci_name(dev), irq_pin);
 			dino_cfg_write(dev->bus, dev->devfn, 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 7beffca..f011ff5 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -519,8 +519,7 @@ iosapic_xlate_pin(struct iosapic_info *isi, struct pci_dev *pcidev)
 		**
 		** Advantage is it's really easy to implement.
 		*/
-		intr_pin = ((intr_pin-1)+PCI_SLOT(pcidev->devfn)) % 4;
-		intr_pin++;	/* convert back to INTA-D (1-4) */
+		intr_pin = pci_swizzle_interrupt_pin(pcidev, intr_pin);
 #endif /* PCI_BRIDGE_FUNCS */
 
 		/*

