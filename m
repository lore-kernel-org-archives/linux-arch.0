From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 06/34] PCI: convert pci_scan_bus_parented() to use
	pci_create_root_bus()
Date: Fri, 28 Oct 2011 16:26:00 -0600
Message-ID: <20111028222600.30729.13048.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35522 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab1J1W0C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:02 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org

This converts pci_scan_bus_parented() to use pci_create_root_bus()
instead of pci_create_bus().  The new bus still has the default (incorrect)
resources, so this patch doesn't help fix that problem, but it does remove
one more use of pci_create_bus().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246e32c..72261a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1646,11 +1646,16 @@ struct pci_bus *pci_create_bus(struct device *parent,
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *b;
 
-	b = pci_create_bus(parent, bus, ops, sysdata);
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
 	if (b)
 		b->subordinate = pci_scan_child_bus(b);
+	else
+		pci_free_resource_list(&resources);
 	return b;
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
