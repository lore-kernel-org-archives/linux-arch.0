From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 5/6] PCI: sh: use generic INTx swizzle from PCI core
Date: Tue, 16 Dec 2008 21:37:15 -0700
Message-ID: <20081217043715.8372.48656.stgit@bob.kio>
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

Note that pci_common_swizzle() loops based on dev->bus->self, not
dev->bus->parent as the sh simple_swizzle() did.  I think they
are equivalent for this purpose.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/sh/drivers/pci/pci.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index aea3b6b..e36c7b8 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -21,21 +21,6 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-static u8 __init simple_swizzle(struct pci_dev *dev, u8 *pinp)
-{
-	u8 pin = *pinp;
-
-	while (dev->bus->parent) {
-		pin = pci_swizzle_interrupt_pin(dev, pin);
-		/* Move up the chain of bridges. */
-		dev = dev->bus->self;
-	}
-	*pinp = pin;
-
-	/* The slot is the slot of the last bridge. */
-	return PCI_SLOT(dev->devfn);
-}
-
 static int __init pcibios_init(void)
 {
 	struct pci_channel *p;
@@ -56,7 +41,7 @@ static int __init pcibios_init(void)
 		busno = bus->subordinate + 1;
 	}
 
-	pci_fixup_irqs(simple_swizzle, pcibios_map_platform_irq);
+	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
 
 	return 0;
 }
