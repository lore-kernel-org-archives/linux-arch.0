Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:36348 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990AbYCDS4O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:14 -0500
Message-Id: <20080304185820.325773560@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:49 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 03/16] arm: use generic pci_enable_resources()
Content-Disposition: inline; filename=arm-use-pci_enable_resources
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

Index: work8/arch/arm/kernel/bios32.c
===================================================================
--- work8.orig/arch/arm/kernel/bios32.c	2008-03-04 09:59:24.000000000 -0700
+++ work8/arch/arm/kernel/bios32.c	2008-03-04 10:01:40.000000000 -0700
@@ -660,28 +660,15 @@
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	int err;
 	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
+
+	err = pci_enable_resources(dev, mask);
+	if (err < 0)
+		return err;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = dev->resource + idx;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
 
 	/*
 	 * Bridges (eg, cardbus bridges) need to be fully enabled
@@ -690,8 +677,8 @@
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 
 	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		dev_info(&dev->dev, "enabling bridge device (%04x -> %04x)\n",
+		       old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;

-- 
