From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 11:24:23 -0700
Message-ID: <200812111124.25026.bjorn.helgaas@hp.com>
References: <200812111103.10500.bjorn.helgaas@hp.com> <24742.1229016892@redhat.com> <25771.1229019295@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:14011 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbYLKSY3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 13:24:29 -0500
In-Reply-To: <25771.1229019295@redhat.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

On Thursday 11 December 2008 11:14:55 am David Howells wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > +/**
> > + * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> > + * @dev: the PCI device
> > + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> > + *
> > + * The PCI-to-PCI bridge specification, section 9.1, requires INTx swizzling
> > + * for devices behind bridges on add-in cards.  This performs the swizzle
> > + * for one level of bridge.
> > + */
> 
> That's okay.  It might be better to put the what before the why, though:
> 
>  * Perform INTx swizzling for a device behind one level of bridge.  This is
>  * required by section 9.1 of the PCI-to-PCI bridge specification for devices
>  * behind bridges on add-in cards.

That *is* much better.  Thanks for the wordsmithing.


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
index 46f6821..388a32a 100644
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
+ * Perform INTx swizzling for a device behind one level of bridge.  This is
+ * required by section 9.1 of the PCI-to-PCI bridge specification for devices
+ * behind bridges on add-in cards.
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
