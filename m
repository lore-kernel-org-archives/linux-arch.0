Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35910 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W1q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:46 -0400
Subject: [PATCH v3 26/34] powerpc/PCI: convert to pci_create_root_bus()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:43 -0600
Message-ID: <20111028222743.30729.97632.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20111028222743.TvGcApqEm3Fc3lAya3I-Oejm2_V7ChzAPBOQKQeMOUA@z>

Convert from pci_create_bus() to pci_create_root_bus().  This way the root
bus resources are correct immediately.  This patch doesn't fix a problem
because powerpc fixed the resources before scanning the bus, but it makes
powerpc more consistent with other architectures.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci-common.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 942ced2..8c47c57 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1554,14 +1554,13 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
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
 
 	if (!res->flags) {
 		printk(KERN_WARNING "PCI: I/O resource not set for host"
@@ -1579,6 +1578,7 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 		 (unsigned long long)res->start,
 		 (unsigned long long)res->end,
 		 (unsigned long)res->flags);
+	pci_add_resource(resources, res);
 
 	/* Hookup PHB Memory resources */
 	for (i = 0; i < 3; ++i) {
@@ -1596,12 +1596,12 @@ static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 			res->flags = IORESOURCE_MEM;
 #endif /* CONFIG_PPC32 */
 		}
-		bus->resource[i+1] = res;
 
 		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n", i,
 			 (unsigned long long)res->start,
 			 (unsigned long long)res->end,
 			 (unsigned long)res->flags);
+		pci_add_resource(resources, res);
 	}
 
 	pr_debug("PCI: PHB MEM offset     = %016llx\n",
@@ -1695,6 +1695,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
  */
 void __devinit pcibios_scan_phb(struct pci_controller *hose)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
 	int mode;
@@ -1702,22 +1703,24 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	pr_debug("PCI: Scanning PHB %s\n",
 		 node ? node->full_name : "<NO NAME>");
 
+	/* Get some IO space for the new PHB */
+	pcibios_setup_phb_io_space(hose);
+
+	/* Wire up PHB bus resources */
+	pcibios_setup_phb_resources(hose, &resources);
+
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	bus = pci_create_root_bus(hose->parent, hose->first_busno,
+				  hose->ops, hose, resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
+		pci_free_resource_list(&resources);
 		return;
 	}
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
-	/* Get some IO space for the new PHB */
-	pcibios_setup_phb_io_space(hose);
-
-	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose);
-
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
 	if (node && ppc_md.pci_probe_mode)

