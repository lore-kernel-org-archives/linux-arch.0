Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:40792 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009AbYCDS4U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:20 -0500
Message-Id: <20080304185820.921816757@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:52 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 06/16] ia64: use generic pci_enable_resources()
Content-Disposition: inline; filename=ia64-use-pci_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Use the generic pci_enable_resources() instead of the arch-specific code.

Unlike this arch-specific code, the generic version:
    - does not check for a NULL dev pointer
    - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/ia64/pci/pci.c
===================================================================
--- work8.orig/arch/ia64/pci/pci.c	2008-03-04 10:04:18.000000000 -0700
+++ work8/arch/ia64/pci/pci.c	2008-03-04 10:04:35.000000000 -0700
@@ -499,54 +499,12 @@
 	/* ??? FIXME -- record old value for shutdown.  */
 }
 
-static inline int
-pcibios_enable_resources (struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
-
-	if (!dev)
-		return -EINVAL;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx<PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the desired resources.  */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!(r->flags & type_mask))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			printk(KERN_ERR
-			       "PCI: Device %s not available because of resource collisions\n",
-			       pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int
 pcibios_enable_device (struct pci_dev *dev, int mask)
 {
 	int ret;
 
-	ret = pcibios_enable_resources(dev, mask);
+	ret = pci_enable_resources(dev, mask);
 	if (ret < 0)
 		return ret;
 

-- 
