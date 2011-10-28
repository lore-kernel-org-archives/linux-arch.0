From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 33/34] xtensa/PCI: convert to pci_scan_root_bus() for
	correct root bus resources
Date: Fri, 28 Oct 2011 16:28:19 -0600
Message-ID: <20111028222819.30729.1845.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:36008 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699Ab1J1W2V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:28:21 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

This arch was unusual because it filled in bus->resource[0..3] in
pcibios_init(), then overwrote them, applied io_space.offset and
checked for unset resources in pcibios_fixup_bus().  I moved all of
that to a new pci_controller_apertures() that we can use before
scanning the root bus.

CC: Chris Zankel <chris@zankel.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |   85 +++++++++++++++++++++++-----------------------
 1 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index cd10269..48ec2a8 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -134,9 +134,46 @@ struct pci_controller * __init pcibios_alloc_controller(void)
 	return pci_ctrl;
 }
 
+static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
+					    struct list_head *resources)
+{
+	struct resource *res;
+	unsigned long io_offset;
+	int i;
+
+	io_offset = (unsigned long)pci_ctrl->io_space.base;
+	res = &pci_ctrl->io_resource;
+	if (!res->flags) {
+		if (io_offset)
+			printk (KERN_ERR "I/O resource not set for host"
+				" bridge %d\n", pci_ctrl->index);
+		res->start = 0;
+		res->end = IO_SPACE_LIMIT;
+		res->flags = IORESOURCE_IO;
+	}
+	res->start += io_offset;
+	res->end += io_offset;
+	pci_add_resource(resources, res);
+
+	for (i = 0; i < 3; i++) {
+		res = &pci_ctrl->mem_resources[i];
+		if (!res->flags) {
+			if (i > 0)
+				continue;
+			printk(KERN_ERR "Memory resource not set for "
+			       "host bridge %d\n", pci_ctrl->index);
+			res->start = 0;
+			res->end = ~0U;
+			res->flags = IORESOURCE_MEM;
+		}
+		pci_add_resource(resources, res);
+	}
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *pci_ctrl;
+	struct list_head resources;
 	struct pci_bus *bus;
 	int next_busno = 0, i;
 
@@ -145,19 +182,10 @@ static int __init pcibios_init(void)
 	/* Scan all of the recorded PCI controllers.  */
 	for (pci_ctrl = pci_ctrl_head; pci_ctrl; pci_ctrl = pci_ctrl->next) {
 		pci_ctrl->last_busno = 0xff;
-		bus = pci_scan_bus(pci_ctrl->first_busno, pci_ctrl->ops,
-				   pci_ctrl);
-		if (pci_ctrl->io_resource.flags) {
-			unsigned long offs;
-
-			offs = (unsigned long)pci_ctrl->io_space.base;
-			pci_ctrl->io_resource.start += offs;
-			pci_ctrl->io_resource.end += offs;
-			bus->resource[0] = &pci_ctrl->io_resource;
-		}
-		for (i = 0; i < 3; ++i)
-			if (pci_ctrl->mem_resources[i].flags)
-				bus->resource[i+1] =&pci_ctrl->mem_resources[i];
+		INIT_LIST_HEAD(&resources);
+		pci_controller_apertures(pci_ctrl, &resources);
+		bus = pci_scan_root_bus(NULL, pci_ctrl->first_busno,
+					pci_ctrl->ops, pci_ctrl, &resources);
 		pci_ctrl->bus = bus;
 		pci_ctrl->last_busno = bus->subordinate;
 		if (next_busno <= pci_ctrl->last_busno)
@@ -178,36 +206,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 	int i;
 
 	io_offset = (unsigned long)pci_ctrl->io_space.base;
-	if (bus->parent == NULL) {
-		/* this is a host bridge - fill in its resources */
-		pci_ctrl->bus = bus;
-
-		bus->resource[0] = res = &pci_ctrl->io_resource;
-		if (!res->flags) {
-			if (io_offset)
-				printk (KERN_ERR "I/O resource not set for host"
-					" bridge %d\n", pci_ctrl->index);
-			res->start = 0;
-			res->end = IO_SPACE_LIMIT;
-			res->flags = IORESOURCE_IO;
-		}
-		res->start += io_offset;
-		res->end += io_offset;
-
-		for (i = 0; i < 3; i++) {
-			res = &pci_ctrl->mem_resources[i];
-			if (!res->flags) {
-				if (i > 0)
-					continue;
-				printk(KERN_ERR "Memory resource not set for "
-				       "host bridge %d\n", pci_ctrl->index);
-				res->start = 0;
-				res->end = ~0U;
-				res->flags = IORESOURCE_MEM;
-			}
-			bus->resource[i+1] = res;
-		}
-	} else {
+	if (bus->parent) {
 		/* This is a subordinate bridge */
 		pci_read_bridge_bases(bus);
 
