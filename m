From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 05/34] PCI: convert pci_scan_bus() to use
	pci_create_root_bus()
Date: Fri, 28 Oct 2011 16:25:55 -0600
Message-ID: <20111028222555.30729.79880.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35509 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab1J1WZ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:25:57 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

I plan to deprecate pci_scan_bus_parented(), so use pci_create_root_bus()
directly instead.  pci_scan_bus() itself will be removed as soon as all
callers are gone, so this is just an interim step.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   18 ++++++++++++++++++
 include/linux/pci.h |   10 +---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f1a1cc1..246e32c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1655,6 +1655,24 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
+struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
+					void *sysdata)
+{
+	LIST_HEAD(resources);
+	struct pci_bus *b;
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
+	if (b) {
+		b->subordinate = pci_scan_child_bus(b);
+		pci_bus_add_devices(b);
+	} else {
+		pci_free_resource_list(&resources);
+	}
+	return b;
+}
+
 #ifdef CONFIG_HOTPLUG
 /**
  * pci_rescan_bus - scan a PCI bus for devices.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8de221b..e7315c5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -659,15 +659,7 @@ extern struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
 				      struct pci_ops *ops, void *sysdata);
-static inline struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
-					   void *sysdata)
-{
-	struct pci_bus *root_bus;
-	root_bus = pci_scan_bus_parented(NULL, bus, ops, sysdata);
-	if (root_bus)
-		pci_bus_add_devices(root_bus);
-	return root_bus;
-}
+struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
