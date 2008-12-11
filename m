From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 09:48:19 -0700
Message-ID: <200812110948.20563.bjorn.helgaas@hp.com>
References: <20081209231202.18153.60227.stgit@bob.kio> <20081209231037.18153.86962.stgit@bob.kio> <23213.1229007624@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <23213.1229007624@redhat.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Thursday 11 December 2008 08:00:24 am David Howells wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> >  
> > +u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
> > +{
> > +	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */
> > +	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
> > +}
> > +
> 
> Can you please add a banner comment to this function that gives at least a
> quick description of what this function is meant to do?  Feel free to use
> kerneldoc.

I'm not really a fan of comments that are bigger than the code
and add little or no information, but if you like the following
better, use it instead :-)


PCI: add pci_swizzle_interrupt_pin()

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds pci_swizzle_interrupt_pin(), which implements the
INTx swizzling algorithm specified in Table 9-1 of the "PCI-to-PCI
Bridge Architecture Specification," revision 1.2.

There are many architecture-specific implementations of this
swizzle that can be replaced by this common one.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pci/pci.c   |   17 ++++++++++++++++-
 include/linux/pci.h |    1 +
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46f6821..c14a6b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1337,6 +1337,21 @@ void pci_enable_ari(struct pci_dev *dev)
 	bridge->ari_enabled = 1;
 }
 
+/**
+ * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
+ * @dev: the PCI device
+ * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
+ *
+ * The PCI-to-PCI bridge specification requires INTx swizzling for
+ * devices behind bridges on add-in cards.  This performs the swizzle
+ * for one level of bridge.
+ */
+u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
+{
+	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */
+	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+}
+
 int
 pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 {
@@ -1347,7 +1362,7 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
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
