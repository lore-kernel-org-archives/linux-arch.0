Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:33942 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbYB1AJO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 19:09:14 -0500
Message-Id: <20080228001052.551339419@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:39 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 2/6] ppc: make pcibios_enable_device() use pcibios_enable_resources()
Content-Disposition: inline; filename=ppc-pcibios_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

pcibios_enable_device() has an almost verbatim copy of
pcibios_enable_resources(), (the only difference is that
pcibios_enable_resources() turns on PCI_COMMAND_MEMORY if
there's a ROM resource).

The duplication might be intentional, but I don't see any callers
of pcibios_enable_resources() on ppc, so I think it's more
likely a historical accident.

This patch removes the duplication, making pcibios_enable_device()
simply call pcibios_enable_resources() as x86 does.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: work6/arch/ppc/kernel/pci.c
===================================================================
--- work6.orig/arch/ppc/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
+++ work6/arch/ppc/kernel/pci.c	2008-02-18 11:31:23.000000000 -0700
@@ -785,33 +785,11 @@
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
 	if (ppc_md.pcibios_enable_device_hook)
 		if (ppc_md.pcibios_enable_device_hook(dev, 0))
 			return -EINVAL;
-		
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx=0; idx<6; idx++) {
-		r = &dev->resource[idx];
-		if (r->flags & IORESOURCE_UNSET) {
-			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+
+	return pcibios_enable_resources(dev, mask);
 }
 
 struct pci_controller*

-- 
