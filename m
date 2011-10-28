From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 34/34] PCI: remove pci_create_bus()
Date: Fri, 28 Oct 2011 16:28:24 -0600
Message-ID: <20111028222824.30729.42883.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:10160 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699Ab1J1W21 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:28:27 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

All users of pci_create_bus() have been converted to pci_create_root_bus(),
so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   14 --------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2863865..f732a9a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1629,20 +1629,6 @@ struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-struct pci_bus *pci_create_bus(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (!b)
-		pci_free_resource_list(&resources);
-	return b;
-}
-
 /* Deprecated; use pci_scan_root_bus() instead */
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e7315c5..d99ef35 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -666,8 +666,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
-struct pci_bus *pci_create_bus(struct device *parent, int bus,
-			       struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
