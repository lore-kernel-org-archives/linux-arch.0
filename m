From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 01/34] PCI: add helpers for building PCI bus resource lists
Date: Fri, 28 Oct 2011 16:25:35 -0600
Message-ID: <20111028222535.30729.73281.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35453 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1J1WZh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:25:37 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

We'd like to supply a list of resources when we create a new PCI bus,
e.g., the root bus under a PCI host bridge.  These are helpers for
constructing that list.

These are exported because the plan is to replace this exported interface:
    pci_scan_bus_parented()
with this one:
    pci_add_resource(resources, ...)
    pci_scan_root_bus(..., resources)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c   |   32 +++++++++++++++++++++++++++-----
 include/linux/pci.h |    2 ++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 1e2ad92..398f5d8 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,6 +18,32 @@
 
 #include "pci.h"
 
+void pci_add_resource(struct list_head *resources, struct resource *res)
+{
+	struct pci_bus_resource *bus_res;
+
+	bus_res = kzalloc(sizeof(struct pci_bus_resource), GFP_KERNEL);
+	if (!bus_res) {
+		printk(KERN_ERR "PCI: can't add bus resource %pR\n", res);
+		return;
+	}
+
+	bus_res->res = res;
+	list_add_tail(&bus_res->list, resources);
+}
+EXPORT_SYMBOL(pci_add_resource);
+
+void pci_free_resource_list(struct list_head *resources)
+{
+	struct pci_bus_resource *bus_res, *tmp;
+
+	list_for_each_entry_safe(bus_res, tmp, resources, list) {
+		list_del(&bus_res->list);
+		kfree(bus_res);
+	}
+}
+EXPORT_SYMBOL(pci_free_resource_list);
+
 void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
 			  unsigned int flags)
 {
@@ -52,16 +78,12 @@ EXPORT_SYMBOL_GPL(pci_bus_resource_n);
 
 void pci_bus_remove_resources(struct pci_bus *bus)
 {
-	struct pci_bus_resource *bus_res, *tmp;
 	int i;
 
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		bus->resource[i] = NULL;
 
-	list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
-		list_del(&bus_res->list);
-		kfree(bus_res);
-	}
+	pci_free_resource_list(&bus->resources);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1b1ca1..b7d1365 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -909,6 +909,8 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
+void pci_add_resource(struct list_head *resources, struct resource *res);
+void pci_free_resource_list(struct list_head *resources);
 void pci_bus_add_resource(struct pci_bus *bus, struct resource *res, unsigned int flags);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
 void pci_bus_remove_resources(struct pci_bus *bus);
