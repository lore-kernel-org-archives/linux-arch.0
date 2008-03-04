Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:19948 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932984AbYCDS4N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:13 -0500
Message-Id: <20080304185820.125200297@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:48 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 02/16] alpha: use generic pci_enable_resources()
Content-Disposition: inline; filename=alpha-use-pci_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Use the generic pci_enable_resources() instead of the arch-specific code.

Unlike this arch-specific code, the generic version:
    - skips resources unless requested in "mask"
    - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/alpha/kernel/pci.c
===================================================================
--- work8.orig/arch/alpha/kernel/pci.c	2008-03-04 09:58:07.000000000 -0700
+++ work8/arch/alpha/kernel/pci.c	2008-03-04 09:58:54.000000000 -0700
@@ -372,28 +372,7 @@
 int
 pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		else if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-		/* Enable the appropriate bits in the PCI command register.  */
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 /*

-- 
