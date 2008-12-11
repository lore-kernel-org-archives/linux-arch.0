From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 11:03:09 -0700
Message-ID: <200812111103.10500.bjorn.helgaas@hp.com>
References: <200812110948.20563.bjorn.helgaas@hp.com> <23213.1229007624@redhat.com> <24742.1229016892@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:43356 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYLKSDR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 13:03:17 -0500
In-Reply-To: <24742.1229016892@redhat.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

On Thursday 11 December 2008 10:34:52 am David Howells wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > +/**
> > + * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> > + * @dev: the PCI device
> > + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> > + *
> > + * The PCI-to-PCI bridge specification requires INTx swizzling for
> > + * devices behind bridges on add-in cards.  This performs the swizzle
> > + * for one level of bridge.
> > + */
> 
> Better.
> 
> > +u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
> > +{
> > +	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */
> 
> I'd recommend merging this comment into the banner.

OK.  How's this?  I suck at writing comments.

PCI: add pci_swizzle_interrupt_pin()

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds pci_swizzle_interrupt_pin(), which implements the
INTx swizzling algorithm specified in Table 9-1 of the "PCI-to-PCI
Bridge Architecture Specification," revision 1.2.

There are many architecture-specific implementations of this
swizzle that can be replaced by this common one.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pci/pci.c   |   16 +++++++++++++++-
 include/linux/pci.h |    1 +
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46f6821..dfa26d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1337,6 +1337,20 @@ void pci_enable_ari(struct pci_dev *dev)
 	bridge->ari_enabled = 1;
 }
 
+/**
+ * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
+ * @dev: the PCI device
+ * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
+ *
+ * The PCI-to-PCI bridge specification, section 9.1, requires INTx swizzling
+ * for devices behind bridges on add-in cards.  This performs the swizzle
+ * for one level of bridge.
+ */
+u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
+{
+	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
+}
+
 int
 pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 {
@@ -1347,7 +1361,7 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
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
