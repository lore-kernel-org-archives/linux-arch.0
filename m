Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35944 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933687Ab1J1W15 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:57 -0400
Subject: [PATCH v3 28/34] sparc/PCI: convert to pci_create_root_bus()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:53 -0600
Message-ID: <20111028222753.30729.30573.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20111028222753.6BnqCq8CrmSiK2VJAkRU0viIw38DExJxrbWnbsboxg0@z>

Convert from pci_create_bus() to pci_create_root_bus().  This way the root
bus resources are correct immediately.  This patch doesn't fix a problem
because sparc fixed the resources before scanning the bus, but it makes
sparc more consistent with other architectures.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 8aa0d44..b5ae3d0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -685,23 +685,25 @@ static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
 struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 					    struct device *parent)
 {
+	LIST_HEAD(resources);
 	struct device_node *node = pbm->op->dev.of_node;
 	struct pci_bus *bus;
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
-	bus = pci_create_bus(parent, pbm->pci_first_busno, pbm->pci_ops, pbm);
+	pci_add_resource(&resources, &pbm->io_space);
+	pci_add_resource(&resources, &pbm->mem_space);
+	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
+				  pbm, resources);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
+		pci_free_resource_list(&resources);
 		return NULL;
 	}
 	bus->secondary = pbm->pci_first_busno;
 	bus->subordinate = pbm->pci_last_busno;
 
-	bus->resource[0] = &pbm->io_space;
-	bus->resource[1] = &pbm->mem_space;
-
 	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
 	pci_bus_register_of_sysfs(bus);
@@ -711,13 +713,6 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 {
-	struct pci_pbm_info *pbm = pbus->sysdata;
-
-	/* Generic PCI bus probing sets these to point at
-	 * &io{port,mem}_resouce which is wrong for us.
-	 */
-	pbus->resource[0] = &pbm->io_space;
-	pbus->resource[1] = &pbm->mem_space;
 }
 
 void pcibios_update_irq(struct pci_dev *pdev, int irq)

