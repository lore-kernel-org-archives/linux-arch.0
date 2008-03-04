Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:39141 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858AbYCDS43 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:29 -0500
Message-Id: <20080304185822.152813696@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:58 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 12/16] sh: use generic pci_enable_resources()
Content-Disposition: inline; filename=sh-use-pci_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Use the generic pci_enable_resources() instead of the arch-specific code.

Unlike this arch-specific code, the generic version:
    - checks PCI_NUM_RESOURCES (11), not 6, resources
    - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
    - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/sh/drivers/pci/pci.c
===================================================================
--- work8.orig/arch/sh/drivers/pci/pci.c	2008-03-04 10:10:44.000000000 -0700
+++ work8/arch/sh/drivers/pci/pci.c	2008-03-04 10:11:04.000000000 -0700
@@ -133,34 +133,7 @@
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
-		if (!(mask & (1 << idx)))
-			continue;
-		r = &dev->resource[idx];
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because "
-			       "of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
-	if (cmd != old_cmd) {
-		printk(KERN_INFO "PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 /*

-- 
