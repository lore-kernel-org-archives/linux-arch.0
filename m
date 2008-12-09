From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:02 -0700
Message-ID: <20081209231202.18153.60227.stgit@bob.kio>
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

This patch adds pci_swizzle_interrupt_pin(), which implements the
INTx swizzling algorithm specified in Table 9-1 of the "PCI-to-PCI
Bridge Architecture Specification," revision 1.2.

There are many architecture-specific implementations of this
swizzle that can be replaced by this common one.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pci/pci.c   |    8 +++++++-
 include/linux/pci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46f6821..5a882cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1337,6 +1337,12 @@ void pci_enable_ari(struct pci_dev *dev)
 	bridge->ari_enabled = 1;
 }
 
+u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
+{
+	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */
+	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+}
+
 int
 pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 {
@@ -1347,7 +1353,7 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 		return -1;
 
 	while (dev->bus->self) {
-		pin = (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		dev = dev->bus->self;
 	}
 	*bridge = dev;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index feb4657..4be596f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -527,6 +527,7 @@ int __must_check pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
+u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
