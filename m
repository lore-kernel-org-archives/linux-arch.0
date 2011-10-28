From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 18/34] mn10300/PCI: convert to pci_scan_root_bus() for
	correct root bus resources
Date: Fri, 28 Oct 2011 16:27:02 -0600
Message-ID: <20111028222702.30729.65118.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35745 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828Ab1J1W1G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:06 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mn10300/unit-asb2305/pci.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index a4954fe..a7c5f08 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -380,11 +380,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
-	if (bus->number == 0) {
-		bus->resource[0] = &pci_ioport_resource;
-		bus->resource[1] = &pci_iomem_resource;
-	}
-
 	if (bus->self) {
 		pci_read_bridge_bases(bus);
 		pcibios_fixup_device_resources(bus->self);
@@ -402,6 +397,8 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
  */
 static int __init pcibios_init(void)
 {
+	LIST_HEAD(resources);
+
 	ioport_resource.start	= 0xA0000000;
 	ioport_resource.end	= 0xDFFFFFFF;
 	iomem_resource.start	= 0xA0000000;
@@ -423,7 +420,10 @@ static int __init pcibios_init(void)
 	printk(KERN_INFO "PCI: Probing PCI hardware [mempage %08x]\n",
 	       MEM_PAGING_REG);
 
-	pci_root_bus = pci_scan_bus(0, &pci_direct_ampci, NULL);
+	pci_add_resource(&resources, &pci_ioport_resource);
+	pci_add_resource(&resources, &pci_iomem_resource);
+	pci_root_bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL,
+					 &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();
