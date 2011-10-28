Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35948 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933687Ab1J1W16 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:58 -0400
Subject: [PATCH v3 27/34] sh/PCI: convert to pci_scan_root_bus() for correct
	root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:48 -0600
Message-ID: <20111028222748.30729.8949.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20111028222748.pXxIvEoIXf-ONySW0vuSTrWkzBnyIB1HxPcOOySAK2M@z>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

CC: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/drivers/pci/pci.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 194231c..ff48c9e 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -35,9 +35,15 @@ static void __devinit pcibios_scanbus(struct pci_channel *hose)
 {
 	static int next_busno;
 	static int need_domain_info;
+	LIST_HEAD(resources);
+	int i;
 	struct pci_bus *bus;
 
-	bus = pci_scan_bus(next_busno, hose->pci_ops, hose);
+	for (i = 0; i < hose->nr_resources; i++)
+		pci_add_resource(&resources, hose->resources + i);
+
+	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
+				&resources);
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
@@ -54,6 +60,8 @@ static void __devinit pcibios_scanbus(struct pci_channel *hose)
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
 		pci_enable_bridges(bus);
+	} else {
+		pci_free_resource_list(&resources);
 	}
 }
 
@@ -161,16 +169,8 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
  */
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev = bus->self;
+	struct pci_dev *dev;
 	struct list_head *ln;
-	struct pci_channel *hose = bus->sysdata;
-
-	if (!dev) {
-		int i;
-
-		for (i = 0; i < hose->nr_resources; i++)
-			bus->resource[i] = hose->resources + i;
-	}
 
 	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
 		dev = pci_dev_b(ln);

