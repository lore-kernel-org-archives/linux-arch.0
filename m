Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:4219 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbYB1AJR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 19:09:17 -0500
Message-Id: <20080228001053.209248743@ldl.fc.hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:42 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 5/6] PARISC: move PERR & SERR enables out of pcibios_enable_resources()
Content-Disposition: inline; filename=parisc-pcibios_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Move PERR and SERR enables from pcibios_enable_resources() to
platform_pci_enable_device() so the former matches other
architectures and can be shared.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work6/arch/parisc/kernel/pci.c
===================================================================
--- work6.orig/arch/parisc/kernel/pci.c	2008-02-27 11:30:02.000000000 -0700
+++ work6/arch/parisc/kernel/pci.c	2008-02-27 11:38:11.000000000 -0700
@@ -281,9 +281,7 @@
  * A driver is enabling the device.  We make sure that all the appropriate
  * bits are set to allow the device to operate as the driver is expecting.
  * We enable the port IO and memory IO bits if the device has any BARs of
- * that type, and we enable the PERR and SERR bits unconditionally.
- * Drivers that do not need parity (eg graphics and possibly networking)
- * can clear these bits if they want.
+ * that type.
  */
 int pcibios_enable_resources(struct pci_dev *dev, int mask)
 {
@@ -305,8 +303,6 @@
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 
-	cmd |= (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
-
 #if 0
 	/* If bridge/bus controller has FBB enabled, child must too. */
 	if (dev->bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
@@ -317,9 +313,38 @@
 	return 0;
 }
 
+/*
+ * A driver is enabling the device.  We enable the PERR and SERR bits
+ * unconditionally.  Drivers that do not need parity (eg graphics and
+ * possibly networking) can clear these bits if they want.
+ */
+static int platform_pci_enable_device(struct pci_dev *dev)
+{
+	u16 cmd, old_cmd;
+	int idx;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+
+	cmd |= (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+
+	if (cmd != old_cmd) {
+		dev_info(&dev->dev, "enabling SERR and PARITY (%04x -> %04x)\n",
+			old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+
+	return 0;
+}
+
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
 
 /* PA-RISC specific */

-- 
