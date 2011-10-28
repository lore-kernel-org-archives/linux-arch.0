Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9819 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933616Ab1J1W0u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:50 -0400
Subject: [PATCH v3 15/34] microblaze/PCI: convert to pci_create_root_bus() for
	correct root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:26:46 -0600
Message-ID: <20111028222646.30729.93682.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Message-ID: <20111028222646.ctVcANobFFfFwawuetRn0C03nH54Bp1qf1AEclrdeGw@z>

Convert from pci_create_bus() to pci_create_root_bus().  This way the root
bus resources are correct immediately.  This patch doesn't fix a problem
because microblaze fixed the resources before scanning the bus, but it makes
microblaze more consistent with other architectures.  It also allows us to
use the pci_scan_root_bus() path safely.

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/pci/pci-common.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9dde153..ec80f1e 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1507,14 +1507,18 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
+static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
 {
-	struct pci_bus *bus = hose->bus;
 	struct resource *res;
 	int i;
 
 	/* Hookup PHB IO resource */
-	bus->resource[0] = res = &hose->io_resource;
+	res = &hose->io_resource;
+
+	/* Fixup IO space offset */
+	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
+	res->start = (res->start + io_offset) & 0xffffffffu;
+	res->end = (res->end + io_offset) & 0xffffffffu;
 
 	if (!res->flags) {
 		printk(KERN_WARNING "PCI: I/O resource not set for host"
@@ -1525,6 +1529,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 		res->end = res->start + IO_SPACE_LIMIT;
 		res->flags = IORESOURCE_IO;
 	}
+	pci_add_resource(resources, res);
 
 	pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
 		 (unsigned long long)res->start,
@@ -1547,7 +1552,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 			res->flags = IORESOURCE_MEM;
 
 		}
-		bus->resource[i+1] = res;
+		pci_add_resource(resources, res);
 
 		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n",
 			i, (unsigned long long)res->start,
@@ -1570,32 +1575,27 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 
 static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
-	unsigned long io_offset;
-	struct resource *res = &hose->io_resource;
 
 	pr_debug("PCI: Scanning PHB %s\n",
 		 node ? node->full_name : "<NO NAME>");
 
+	pcibios_setup_phb_resources(hose, &resources);
+
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	bus = pci_create_root_bus(hose->parent, hose->first_busno, hose->ops,
+				  hose, &resources);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
+		pci_free_resource_list(&resources);
 		return;
 	}
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
-	/* Fixup IO space offset */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	res->start = (res->start + io_offset) & 0xffffffffu;
-	res->end = (res->end + io_offset) & 0xffffffffu;
-
-	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose);
-
 	/* Scan children */
 	hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 }

