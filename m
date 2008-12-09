From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/12] PCI: mips: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:17 -0700
Message-ID: <20081209231217.18153.85615.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:44652 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbYLIXMS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:12:18 -0500
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/mips/pci/pci-ip27.c |    6 ------
 arch/mips/pci/pci.c      |    9 +--------
 2 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index f97ab14..dda6f20 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -146,12 +146,6 @@ int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return 0;
 }
 
-/* Most MIPS systems have straight-forward swizzling needs.  */
-static inline u8 bridge_swizzle(u8 pin, u8 slot)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 static inline struct pci_dev *bridge_root_dev(struct pci_dev *dev)
 {
 	while (dev->bus->parent) {
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index a377e9d..dfad63c 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -149,19 +149,12 @@ out:
 	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
-/* Most MIPS systems have straight-forward swizzling needs.  */
-
-static inline u8 bridge_swizzle(u8 pin, u8 slot)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 static u8 __init common_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	u8 pin = *pinp;
 
 	while (dev->bus->parent) {
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		/* Move up the chain of bridges. */
 		dev = dev->bus->self;
         }
