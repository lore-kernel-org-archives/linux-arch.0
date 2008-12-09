From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/12] PCI: arm: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:12 -0700
Message-ID: <20081209231212.18153.63913.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/arm/kernel/bios32.c       |    6 +++---
 arch/arm/mach-integrator/pci.c |   11 ++---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a59b6..5c5a0bc 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -491,17 +491,17 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  */
 u8 __devinit pci_std_swizzle(struct pci_dev *dev, u8 *pinp)
 {
-	int pin = *pinp - 1;
+	int pin = *pinp;
 
 	while (dev->bus->self) {
-		pin = (pin + PCI_SLOT(dev->devfn)) & 3;
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		/*
 		 * move up the chain of bridges,
 		 * swizzling as we go.
 		 */
 		dev = dev->bus->self;
 	}
-	*pinp = pin + 1;
+	*pinp = pin;
 
 	return PCI_SLOT(dev->devfn);
 }
diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index af7d3ff..2fdb954 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -63,13 +63,7 @@
  *
  * Where A = pin 1, B = pin 2 and so on and pin=0 = default = A.
  * Thus, each swizzle is ((pin-1) + (device#-4)) % 4
- *
- * The following code swizzles for exactly one bridge.  
  */
-static inline int bridge_swizzle(int pin, unsigned int slot) 
-{
-	return (pin + slot) & 3;
-}
 
 /*
  * This routine handles multiple bridges.
@@ -81,15 +75,14 @@ static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
 	if (pin == 0)
 		pin = 1;
 
-	pin -= 1;
 	while (dev->bus->self) {
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		/*
 		 * move up the chain of bridges, swizzling as we go.
 		 */
 		dev = dev->bus->self;
 	}
-	*pinp = pin + 1;
+	*pinp = pin;
 
 	return PCI_SLOT(dev->devfn);
 }
