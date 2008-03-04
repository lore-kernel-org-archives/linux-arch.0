Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:40790 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932896AbYCDS4f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Mar 2008 13:56:35 -0500
Message-Id: <20080304185822.741869974@ldl.fc.hp.com>
References: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:57:01 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 15/16] x86: use generic pci_enable_resources()
Content-Disposition: inline; filename=x86-use-pci_enable_resources
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

Use the generic pci_enable_resources() instead of the arch-specific code.

Unlike this arch-specific code, the generic version:
    - checks for resource collisions with "!r->parent"

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/arch/x86/pci/common.c
===================================================================
--- work8.orig/arch/x86/pci/common.c	2008-03-04 10:12:42.000000000 -0700
+++ work8/arch/x86/pci/common.c	2008-03-04 10:12:51.000000000 -0700
@@ -527,7 +527,7 @@
 {
 	int err;
 
-	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+	if ((err = pci_enable_resources(dev, mask)) < 0)
 		return err;
 
 	if (!dev->msi_enabled)
Index: work8/arch/x86/pci/i386.c
===================================================================
--- work8.orig/arch/x86/pci/i386.c	2008-03-04 10:12:56.000000000 -0700
+++ work8/arch/x86/pci/i386.c	2008-03-04 10:13:03.000000000 -0700
@@ -238,44 +238,6 @@
  */
 fs_initcall(pcibios_assign_resources);
 
-int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = &dev->resource[idx];
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-				"because of resource %d collisions\n",
-				pci_name(dev), idx);
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-			pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: work8/arch/x86/pci/pci.h
===================================================================
--- work8.orig/arch/x86/pci/pci.h	2008-03-04 10:13:08.000000000 -0700
+++ work8/arch/x86/pci/pci.h	2008-03-04 10:13:12.000000000 -0700
@@ -44,7 +44,6 @@
 extern unsigned int pcibios_max_latency;
 
 void pcibios_resource_survey(void);
-int pcibios_enable_resources(struct pci_dev *, int);
 
 /* pci-pc.c */
 

-- 
