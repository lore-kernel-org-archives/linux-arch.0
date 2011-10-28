From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 04/34] PCI: add pci_scan_root_bus() that accepts resource
	list
Date: Fri, 28 Oct 2011 16:25:50 -0600
Message-ID: <20111028222550.30729.13182.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35492 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab1J1WZw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:25:52 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

"Early" and "header" quirks often use incorrect bus resources because they
see the default resources assigned by pci_create_bus(), before the
architecture fixes them up (typically in pcibios_fixup_bus()).  Regions
reserved by these quirks end up with the wrong parents.

Here's the standard path for scanning a PCI root bus:

  pci_scan_bus or pci_scan_bus_parented
    pci_create_bus                     <-- A create with default resources
    pci_scan_child_bus
      pci_scan_slot
        pci_scan_single_device
          pci_scan_device
            pci_setup_device
              pci_fixup_device(early)  <-- B
          pci_device_add
            pci_fixup_device(header)   <-- C
      pcibios_fixup_bus                <-- D fill in correct resources

Early and header quirks at B and C use the default (incorrect) root bus
resources rather than those filled in at D.

This patch adds a new pci_scan_root_bus() function that sets the bus
resources correctly from a supplied list of resources.

I intend to remove pci_scan_bus() and pci_scan_bus_parented() after
fixing all callers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   15 +++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e150d48..f1a1cc1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1614,6 +1614,21 @@ err_out:
 	return NULL;
 }
 
+struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_bus *b;
+
+	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
+	if (!b)
+		return NULL;
+
+	b->subordinate = pci_scan_child_bus(b);
+	pci_bus_add_devices(b);
+	return b;
+}
+EXPORT_SYMBOL(pci_scan_root_bus);
+
 struct pci_bus *pci_create_bus(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bbce214..8de221b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -671,6 +671,9 @@ static inline struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *o
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
+struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
+					     struct pci_ops *ops, void *sysdata,
+					     struct list_head *resources);
 struct pci_bus *pci_create_bus(struct device *parent, int bus,
 			       struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
