From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 6/6] PCI: x86/visws: use generic INTx swizzle from PCI core
Date: Tue, 16 Dec 2008 21:37:20 -0700
Message-ID: <20081217043720.8372.22899.stgit@bob.kio>
References: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081217043443.8372.28890.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

Use the generic pci_common_swizzle() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/visws.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/visws.c b/arch/x86/pci/visws.c
index 6b5ed3d..fd7b76f 100644
--- a/arch/x86/pci/visws.c
+++ b/arch/x86/pci/visws.c
@@ -25,19 +25,6 @@ static void pci_visws_disable_irq(struct pci_dev *dev) { }
 
 unsigned int pci_bus0, pci_bus1;
 
-static u8 __init visws_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	u8 pin = *pinp;
-
-	while (dev->bus->self) {	/* Move up the chain of bridges. */
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		dev = dev->bus->self;
-	}
-	*pinp = pin;
-
-	return PCI_SLOT(dev->devfn);
-}
-
 static int __init visws_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq, bus = dev->bus->number;
@@ -102,7 +89,7 @@ int __init pci_visws_init(void)
 	raw_pci_ops = &pci_direct_conf1;
 	pci_scan_bus_with_sysdata(pci_bus0);
 	pci_scan_bus_with_sysdata(pci_bus1);
-	pci_fixup_irqs(visws_swizzle, visws_map_irq);
+	pci_fixup_irqs(pci_common_swizzle, visws_map_irq);
 	pcibios_resource_survey();
 	return 0;
 }
