From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/6] PCI: arm: use generic INTx swizzle from PCI core
Date: Tue, 16 Dec 2008 21:37:05 -0700
Message-ID: <20081217043705.8372.82025.stgit@bob.kio>
References: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:32304 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYLQEhJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2008 23:37:09 -0500
In-Reply-To: <20081217043443.8372.28890.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_common_swizzle() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/arm/include/asm/mach/pci.h |    2 +-
 arch/arm/kernel/bios32.c        |   27 ---------------------------
 2 files changed, 1 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 32da1ae..a38bdc7 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -42,7 +42,7 @@ struct pci_sys_data {
 /*
  * This is the standard PCI-PCI bridge swizzling algorithm.
  */
-u8 pci_std_swizzle(struct pci_dev *dev, u8 *pinp);
+#define pci_std_swizzle pci_common_swizzle
 
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5c5a0bc..8096819 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -480,33 +480,6 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
 #endif
 
 /*
- * This is the standard PCI-PCI bridge swizzling algorithm:
- *
- *   Dev: 0  1  2  3
- *    A   A  B  C  D
- *    B   B  C  D  A
- *    C   C  D  A  B
- *    D   D  A  B  C
- *        ^^^^^^^^^^ irq pin on bridge
- */
-u8 __devinit pci_std_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	int pin = *pinp;
-
-	while (dev->bus->self) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		/*
-		 * move up the chain of bridges,
-		 * swizzling as we go.
-		 */
-		dev = dev->bus->self;
-	}
-	*pinp = pin;
-
-	return PCI_SLOT(dev->devfn);
-}
-
-/*
  * Swizzle the device pin each time we cross a bridge.
  * This might update pin and returns the slot number.
  */
