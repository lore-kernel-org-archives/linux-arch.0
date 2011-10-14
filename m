Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:21722 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587Ab1JNE32 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 00:29:28 -0400
Subject: [PATCH v2 27/29] mn10300/PCI: convert to pci_scan_root_bus() for
	correct root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Oct 2011 22:29:25 -0600
Message-ID: <20111014042925.23504.24786.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <20111014042925.0ASF6FLF8bDXg8123TM-Cb-wwXA2tsYVsS4nwPTqBCQ@z>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mn10300/unit-asb2305/pci.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index a4954fe..4cc7136 100644
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
+	struct list_head resources;
+
 	ioport_resource.start	= 0xA0000000;
 	ioport_resource.end	= 0xDFFFFFFF;
 	iomem_resource.start	= 0xA0000000;
@@ -423,7 +420,12 @@ static int __init pcibios_init(void)
 	printk(KERN_INFO "PCI: Probing PCI hardware [mempage %08x]\n",
 	       MEM_PAGING_REG);
 
-	pci_root_bus = pci_scan_bus(0, &pci_direct_ampci, NULL);
+	INIT_LIST_HEAD(&resources);
+	pci_add_resource(&resources, &pci_ioport_resource);
+	pci_add_resource(&resources, &pci_iomem_resource);
+
+	pci_root_bus = pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL,
+					 &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_irqs();

