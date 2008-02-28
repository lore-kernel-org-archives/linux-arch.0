Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:33964 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043AbYB1AJP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 19:09:15 -0500
Message-Id: <20080228001053.013269726@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:41 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
Content-Disposition: inline; filename=arm-pcibios_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Move bridge enable from pcibios_enable_resources() to
platform_pci_enable_device() so the former matches other
architectures and can be shared.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/arch/arm/kernel/bios32.c
===================================================================
--- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
+++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
@@ -683,15 +683,32 @@
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 
+	if (cmd != old_cmd) {
+		printk("PCI: enabling device %s (%04x -> %04x)\n",
+		       pci_name(dev), old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+static int platform_pci_enable_device(struct pci_dev *dev)
+{
+	u16 cmd, old_cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
 	/*
-	 * Bridges (eg, cardbus bridges) need to be fully enabled
+	 * Bridges (eg, cardbus bridges) need to be fully enabled.
+	 * Most architectures do this in pci_enable_bridges(), not
+	 * in the pci_enable_device() path.
 	 */
 	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 
 	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		dev_info(&dev->dev, "enabling bridge device (%04x -> %04x)\n",
+		       old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
@@ -699,7 +716,12 @@
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	return pcibios_enable_resources(dev, mask);
+	int err;
+
+	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+		return err;
+
+	return platform_pci_enable_device(dev);
 }
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,

-- 
