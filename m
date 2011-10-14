Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:50074 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab1JNE2Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 00:28:16 -0400
Subject: [PATCH v2 13/29] microblaze/PCI: use pci_scan_root_bus()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Oct 2011 22:28:13 -0600
Message-ID: <20111014042813.23504.39667.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Message-ID: <20111014042813.FFKONwmYAxsyWZZ6cfhz79PaBoZUENm8mIXF_x_3vsM@z>

Microblaze doesn't need to replace pci_scan_child_bus() or do anything
special before pci_bus_add_devices(), so we can use the more generic PCI
path in pci_scan_root_bus().

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/pci/pci-common.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9382869..c78c754 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1585,9 +1585,8 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	INIT_LIST_HEAD(&resources);
 	pcibios_setup_phb_resources(hose, &resources);
 
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno, hose->ops,
-				  hose, &resources);
+	bus = pci_scan_root_bus(hose->parent, hose->first_busno,
+				hose->ops, hose, &resources);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
@@ -1597,8 +1596,7 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
-	/* Scan children */
-	hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+	hose->last_busno = bus->subordinate;
 }
 
 static int __init pcibios_init(void)
@@ -1612,8 +1610,6 @@ static int __init pcibios_init(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
 		pcibios_scan_phb(hose);
-		printk(KERN_INFO "calling pci_bus_add_devices()\n");
-		pci_bus_add_devices(hose->bus);
 		if (next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + 1;
 	}

