From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 11/12] PCI: sh: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:32 -0700
Message-ID: <20081209231232.18153.20376.stgit@bob.kio>
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
 arch/sh/drivers/pci/ops-cayman.c |    9 ++-------
 arch/sh/drivers/pci/pci.c        |    7 +------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/sh/drivers/pci/ops-cayman.c b/arch/sh/drivers/pci/ops-cayman.c
index 5ccf9ea..38ef762 100644
--- a/arch/sh/drivers/pci/ops-cayman.c
+++ b/arch/sh/drivers/pci/ops-cayman.c
@@ -5,11 +5,6 @@
 #include <cpu/irq.h>
 #include "pci-sh5.h"
 
-static inline u8 bridge_swizzle(u8 pin, u8 slot)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 int __init pcibios_map_platform_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int result = -1;
@@ -42,7 +37,7 @@ int __init pcibios_map_platform_irq(struct pci_dev *dev, u8 slot, u8 pin)
 	while (dev->bus->number > 0) {
 
 		slot = path[i].slot = PCI_SLOT(dev->devfn);
-		pin = path[i].pin = bridge_swizzle(pin, slot);
+		pin = path[i].pin = pci_swizzle_interrupt_pin(dev, pin);
 		dev = dev->bus->self;
 		i++;
 		if (i > 3) panic("PCI path to root bus too long!\n");
@@ -56,7 +51,7 @@ int __init pcibios_map_platform_irq(struct pci_dev *dev, u8 slot, u8 pin)
 	if ((slot < 3) || (i == 0)) {
 		/* Bus 0 (incl. PCI-PCI bridge itself) : perform the final
 		   swizzle now. */
-		result = IRQ_INTA + bridge_swizzle(pin, slot) - 1;
+		result = IRQ_INTA + pci_swizzle_interrupt_pin(dev, pin) - 1;
 	} else {
 		i--;
 		slot = path[i].slot;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index d3839e6..aea3b6b 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -21,17 +21,12 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-static inline u8 bridge_swizzle(u8 pin, u8 slot)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 static u8 __init simple_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	u8 pin = *pinp;
 
 	while (dev->bus->parent) {
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		/* Move up the chain of bridges. */
 		dev = dev->bus->self;
 	}
