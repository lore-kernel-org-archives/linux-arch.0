Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9747 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab1J1W00 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:26 -0400
Subject: [PATCH v3 10/34] frv/PCI: convert to pci_scan_root_bus() for correct
	root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:26:21 -0600
Message-ID: <20111028222621.30729.87373.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>
Message-ID: <20111028222621.6zFPFxSUza3UwPl_LyvJH9C_87i22ykwxC3TaNrg4B0@z>

Convert from pci_scan_bus() to pci_scan_root_bus() and remove root bus
resource fixups.  This fixes the problem of "early" and "header" quirks
seeing incorrect root bus resources.

Note that peer root buses are scanned with pci_scan_bus() (which is now
deprecated), so they have the default ioport_resource and iomem_resource
resources.  This is unchanged from before, but these resources are
incorrect, and I don't know how to discover the correct ones.

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/frv/mb93090-mb00/pci-vdk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index f8dd37e..6b0b82f 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -327,11 +327,6 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 	printk("### PCIBIOS_FIXUP_BUS(%d)\n",bus->number);
 #endif
 
-	if (bus->number == 0) {
-		bus->resource[0] = &pci_ioport_resource;
-		bus->resource[1] = &pci_iomem_resource;
-	}
-
 	pci_read_bridge_bases(bus);
 
 	if (bus->number == 0) {
@@ -357,6 +352,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
 int __init pcibios_init(void)
 {
 	struct pci_ops *dir = NULL;
+	LIST_HEAD(resources);
 
 	if (!mb93090_mb00_detected)
 		return -ENXIO;
@@ -420,7 +416,10 @@ int __init pcibios_init(void)
 	}
 
 	printk("PCI: Probing PCI hardware\n");
-	pci_root_bus = pci_scan_bus(0, pci_root_ops, NULL);
+	pci_add_resource(&resources, &pci_ioport_resource);
+	pci_add_resource(&resources, &pci_iomem_resource);
+	pci_root_bus = pci_scan_root_bus(NULL, 0, pci_root_ops, NULL,
+					 &resources);
 
 	pcibios_irq_init();
 	pcibios_fixup_peer_bridges();

