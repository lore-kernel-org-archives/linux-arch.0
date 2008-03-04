Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:36314 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932983AbYCDS4M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:12 -0500
Message-Id: <20080304185819.885549413@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:47 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 01/16] PCI: add generic pci_enable_resources()
Content-Disposition: inline; filename=add-pci_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Each architecture has its own pcibios_enable_resources() implementation.
These differ in many minor ways that have nothing to do with actual
architectural differences.  Follow-on patches will make most arches
use this generic version instead.

This version is based on powerpc, which seemed most up-to-date.  The only
functional difference from the x86 version is that this uses "!r->parent"
to check for resource collisions instead of "!r->start && r->end".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/drivers/pci/setup-res.c
===================================================================
--- work8.orig/drivers/pci/setup-res.c	2008-03-04 09:56:53.000000000 -0700
+++ work8/drivers/pci/setup-res.c	2008-03-04 09:56:56.000000000 -0700
@@ -263,3 +263,46 @@
 		}
 	}
 }
+
+int pci_enable_resources(struct pci_dev *dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int i;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		if (!(mask & (1 << i)))
+			continue;
+
+		r = &dev->resource[i];
+
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if ((i == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
+
+		if (!r->parent) {
+			dev_err(&dev->dev, "device not available because of "
+				"BAR %d [%llx:%llx] collisions\n", i,
+				(unsigned long long) r->start,
+				(unsigned long long) r->end);
+			return -EINVAL;
+		}
+
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	if (cmd != old_cmd) {
+		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
+			 old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
Index: work8/include/linux/pci.h
===================================================================
--- work8.orig/include/linux/pci.h	2008-03-04 09:56:45.000000000 -0700
+++ work8/include/linux/pci.h	2008-03-04 09:56:56.000000000 -0700
@@ -616,6 +616,7 @@
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *);
+int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2

-- 
