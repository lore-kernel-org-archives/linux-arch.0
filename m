Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9865 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828Ab1J1W1E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:04 -0400
Subject: [PATCH v3 17/34] mips/PCI: convert to pci_scan_root_bus() for correct
	root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:26:57 -0600
Message-ID: <20111028222657.30729.47680.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Deng-Cheng Zhu <dczhu@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20111028222657.hMhrpKN_9ScTIUwW2sp1tmVml01RIUpm2ttrKA6Zgro@z>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

Based on original patch by Deng-Cheng Zhu.

Reference: https://lkml.org/lkml/2011/8/26/89
CC: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 33bba7b..8152f99 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -80,6 +80,7 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 {
 	static int next_busno;
 	static int need_domain_info;
+	LIST_HEAD(resources);
 	struct pci_bus *bus;
 
 	if (!hose->iommu)
@@ -88,7 +89,13 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 	if (hose->get_busno && pci_probe_only)
 		next_busno = (*hose->get_busno)();
 
-	bus = pci_scan_bus(next_busno, hose->pci_ops, hose);
+	pci_add_resource(&resources, hose->mem_resource);
+	pci_add_resource(&resources, hose->io_resource);
+	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
+				&resources);
+	if (!bus)
+		pci_free_resource_list(&resources);
+
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
@@ -265,15 +272,11 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* Propagate hose info into the subordinate devices.  */
 
-	struct pci_controller *hose = bus->sysdata;
 	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
-	if (!dev) {
-		bus->resource[0] = hose->io_resource;
-		bus->resource[1] = hose->mem_resource;
-	} else if (pci_probe_only &&
-		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+	if (pci_probe_only && dev &&
+	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		pci_read_bridge_bases(bus);
 		pcibios_fixup_device_resources(dev, bus);
 	}

