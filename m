From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/6] PCI: mips: use generic INTx swizzle from PCI core
Date: Tue, 16 Dec 2008 21:37:10 -0700
Message-ID: <20081217043710.8372.4708.stgit@bob.kio>
References: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:32330 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYLQEhL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2008 23:37:11 -0500
In-Reply-To: <20081217043443.8372.28890.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_common_swizzle() instead of arch-specific code.

Note that pci_common_swizzle() loops based on dev->bus->self, not
dev->bus->parent as the mips common_swizzle() did.  I think they
are equivalent for this purpose.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/mips/pci/pci.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index fa63dc2..b0eb9e7 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -149,21 +149,6 @@ out:
 	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
-static u8 __init common_swizzle(struct pci_dev *dev, u8 *pinp)
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
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose;
@@ -172,7 +157,7 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(common_swizzle, pcibios_map_irq);
+	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
 
 	pci_initialized = 1;
 
