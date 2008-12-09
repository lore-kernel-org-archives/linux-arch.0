From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/12] PCI: use config space encoding in
	pci_get_interrupt_pin()
Date: Tue, 09 Dec 2008 16:11:46 -0700
Message-ID: <20081209231146.18153.51158.stgit@bob.kio>
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

This patch makes pci_get_interrupt_pin() return values encoded
the same way as the "Interrupt Pin" value in PCI config space,
i.e., 1=INTA, ..., 4=INTD.

pirq_bios_set() is the only in-tree caller of pci_get_interrupt_pin()
and pci_get_interrupt_pin() is not exported.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/irq.c |    2 +-
 drivers/pci/pci.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index bf69dbe..15c3e69 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -534,7 +534,7 @@ static int pirq_bios_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
 {
 	struct pci_dev *bridge;
 	int pin = pci_get_interrupt_pin(dev, &bridge);
-	return pcibios_set_irq_routing(bridge, pin, irq);
+	return pcibios_set_irq_routing(bridge, pin - 1, irq);
 }
 
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 061d1ee..46f6821 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1345,9 +1345,9 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 	pin = dev->pin;
 	if (!pin)
 		return -1;
-	pin--;
+
 	while (dev->bus->self) {
-		pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+		pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
 		dev = dev->bus->self;
 	}
 	*bridge = dev;
