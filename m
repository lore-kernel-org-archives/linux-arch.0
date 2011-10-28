From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 03/34] PCI: add pci_create_root_bus() that accepts resource
	list
Date: Fri, 28 Oct 2011 16:25:45 -0600
Message-ID: <20111028222545.30729.12259.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35487 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1J1WZv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:25:51 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Deng-Cheng Zhu <dczhu@mips.com>

pci_create_bus() assigns ioport_resource and iomem_resource as the default
bus resources, i.e., the entire address space.  Architectures fix these
later, typically in pcibios_fixup_bus() or after pci_scan_bus_parented()
returns, but code that runs in the interim sees incorrect resource
information.

This patch adds a new pci_create_root_bus() that sets the bus resources
correctly from a supplied list of resources.

I intend to remove pci_create_bus() after changing all callers.

Based on original patch by Deng-Cheng Zhu.

Reference: http://www.spinics.net/lists/mips/msg41654.html
Reference: https://lkml.org/lkml/2011/8/26/88
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   25 +++++++++++++++++++++----
 include/linux/pci.h |    3 +++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 465d302..e150d48 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1528,12 +1528,13 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 	return max;
 }
 
-struct pci_bus * pci_create_bus(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error, i;
 	struct pci_bus *b, *b2;
 	struct device *dev;
+	struct pci_bus_resource *bus_res, *n;
 	struct resource *res;
 
 	b = pci_alloc_bus();
@@ -1584,8 +1585,10 @@ struct pci_bus * pci_create_bus(struct device *parent,
 	pci_create_legacy_files(b);
 
 	b->number = b->secondary = bus;
-	b->resource[0] = &ioport_resource;
-	b->resource[1] = &iomem_resource;
+
+	/* Add initial resources to the bus */
+	list_for_each_entry_safe(bus_res, n, resources, list)
+		list_move_tail(&bus_res->list, &b->resources);
 
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
@@ -1611,6 +1614,20 @@ err_out:
 	return NULL;
 }
 
+struct pci_bus *pci_create_bus(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata)
+{
+	LIST_HEAD(resources);
+	struct pci_bus *b;
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
+	if (!b)
+		pci_free_resource_list(&resources);
+	return b;
+}
+
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b7d1365..bbce214 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -668,6 +668,9 @@ static inline struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *o
 		pci_bus_add_devices(root_bus);
 	return root_bus;
 }
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+				    struct pci_ops *ops, void *sysdata,
+				    struct list_head *resources);
 struct pci_bus *pci_create_bus(struct device *parent, int bus,
 			       struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
