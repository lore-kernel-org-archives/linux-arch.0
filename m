From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/6] PCI: add pci_common_swizzle() for INTx swizzling
Date: Tue, 16 Dec 2008 21:36:55 -0700
Message-ID: <20081217043655.8372.52729.stgit@bob.kio>
References: <20081217043443.8372.28890.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:12492 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYLQEg5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2008 23:36:57 -0500
In-Reply-To: <20081217043443.8372.28890.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

This patch adds pci_common_swizzle(), which swizzles INTx values all the
way up to a root bridge.

This common implementation can replace several architecture-specific
ones.  This should someday be combined with pci_get_interrupt_pin(),
but I left it separate for now to make reviewing easier.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pci/pci.c   |   20 ++++++++++++++++++++
 include/linux/pci.h |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 388a32a..6988089 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1369,6 +1369,26 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 }
 
 /**
+ * pci_common_swizzle - swizzle INTx all the way to root bridge
+ * @dev: the PCI device
+ * @pinp: pointer to the INTx pin value (1=INTA, 2=INTB, 3=INTD, 4=INTD)
+ *
+ * Perform INTx swizzling for a device.  This traverses through all PCI-to-PCI
+ * bridges all the way up to a PCI root bus.
+ */
+u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
+{
+	u8 pin = *pinp;
+
+	while (dev->bus->self) {
+		pin = pci_swizzle_interrupt_pin(dev, pin);
+		dev = dev->bus->self;
+	}
+	*pinp = pin;
+	return PCI_SLOT(dev->devfn);
+}
+
+/**
  *	pci_release_region - Release a PCI bar
  *	@pdev: PCI device whose resources were previously reserved by pci_request_region
  *	@bar: BAR to release
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4be596f..e89d0b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -529,6 +529,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
 u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
+u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
 extern void pci_dev_put(struct pci_dev *dev);
 extern void pci_remove_bus(struct pci_bus *b);
