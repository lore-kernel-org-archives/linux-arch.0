Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:10104 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W2E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:28:04 -0400
Subject: [PATCH v3 29/34] sparc32,
	leon/PCI: convert to pci_scan_root_bus() for correct root bus
	resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:58 -0600
Message-ID: <20111028222758.30729.18670.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20111028222758.99-f46eXxBoPV-G9fIT-tZFp4IF3hRACAzTPcixF8LU@z>

Convert from pci_scan_bus_parented() to pci_scan_root_bus() and remove root
bus resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

pci_scan_root_bus() also includes the pci_bus_add_devices() so we don't
need to do that separately.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/leon_pci.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index a8a9a27..b288d83 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -18,22 +18,22 @@
  */
 void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *root_bus;
 
-	root_bus = pci_scan_bus_parented(&ofdev->dev, 0, info->ops, info);
-	if (root_bus) {
-		root_bus->resource[0] = &info->io_space;
-		root_bus->resource[1] = &info->mem_space;
-		root_bus->resource[2] = NULL;
-
-		/* Init all PCI devices into PCI tree */
-		pci_bus_add_devices(root_bus);
+	pci_add_resource(&resources, &info->io_space);
+	pci_add_resource(&resources, &info->mem_space);
 
+	root_bus = pci_scan_root_bus(&ofdev->dev, 0, info->ops, info,
+				     &resources);
+	if (root_bus) {
 		/* Setup IRQs of all devices using custom routines */
 		pci_fixup_irqs(pci_common_swizzle, info->map_irq);
 
 		/* Assign devices with resources */
 		pci_assign_unassigned_resources();
+	} else {
+		pci_free_resource_list(&resources);
 	}
 }
 
@@ -82,15 +82,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 	int i, has_io, has_mem;
 	u16 cmd;
 
-	/* Generic PCI bus probing sets these to point at
-	 * &io{port,mem}_resouce which is wrong for us.
-	 */
-	if (pbus->self == NULL) {
-		pbus->resource[0] = &info->io_space;
-		pbus->resource[1] = &info->mem_space;
-		pbus->resource[2] = NULL;
-	}
-
 	list_for_each_entry(dev, &pbus->devices, bus_list) {
 		/*
 		 * We can not rely on that the bootloader has enabled I/O

