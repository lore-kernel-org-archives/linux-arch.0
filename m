Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9896 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W1P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:15 -0400
Subject: [PATCH v3 20/34] parisc/PCI: dino: convert to pci_create_root_bus()
	for correct root bus resources
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:12 -0600
Message-ID: <20111028222712.30729.63585.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20111028222712.O_ezWF9piIVRpKFRZ5RY4vMB-yCymvoGNaa1MV8ZYA8@z>

Supply root bus resources to pci_create_root_bus() so they're correct
immediately.  This fixes the problem of "early" and "header" quirks seeing
incorrect root bus resources.

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/dino.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 90252c0..7ff10c1 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -562,19 +562,6 @@ dino_fixup_bus(struct pci_bus *bus)
 	/* Firmware doesn't set up card-mode dino, so we have to */
 	if (is_card_dino(&dino_dev->hba.dev->id)) {
 		dino_card_setup(bus, dino_dev->hba.base_addr);
-	} else if(bus->parent == NULL) {
-		/* must have a dino above it, reparent the resources
-		 * into the dino window */
-		int i;
-		struct resource *res = &dino_dev->hba.lmmio_space;
-
-		bus->resource[0] = &(dino_dev->hba.io_space);
-		for(i = 0; i < DINO_MAX_LMMIO_RESOURCES; i++) {
-			if(res[i].flags == 0)
-				break;
-			bus->resource[i+1] = &res[i];
-		}
-
 	} else if (bus->parent) {
 		int i;
 
@@ -927,6 +914,7 @@ static int __init dino_probe(struct parisc_device *dev)
 	const char *version = "unknown";
 	char *name;
 	int is_cujo = 0;
+	LIST_HEAD(resources);
 	struct pci_bus *bus;
 	unsigned long hpa = dev->hpa.start;
 
@@ -1003,15 +991,24 @@ static int __init dino_probe(struct parisc_device *dev)
 
 	dev->dev.platform_data = dino_dev;
 
+	pci_add_resource(&resources, &dino_dev->hba.io_space);
+	if (dino_dev->hba.lmmio_space.flags)
+		pci_add_resource(&resources, &dino_dev->hba.lmmio_space);
+	if (dino_dev->hba.elmmio_space.flags)
+		pci_add_resource(&resources, &dino_dev->hba.elmmio_space);
+	if (dino_dev->hba.gmmio_space.flags)
+		pci_add_resource(&resources, &dino_dev->hba.gmmio_space);
+
 	/*
 	** It's not used to avoid chicken/egg problems
 	** with configuration accessor functions.
 	*/
-	dino_dev->hba.hba_bus = bus = pci_create_bus(&dev->dev,
-			 dino_current_bus, &dino_cfg_ops, NULL);
+	dino_dev->hba.hba_bus = bus = pci_create_root_bus(&dev->dev,
+			 dino_current_bus, &dino_cfg_ops, NULL, &resources);
 	if (!bus) {
 		printk(KERN_ERR "ERROR: failed to scan PCI bus on %s (duplicate bus number %d?)\n",
 		       dev_name(&dev->dev), dino_current_bus);
+		pci_free_resource_list(&resources);
 		/* increment the bus number in case of duplicates */
 		dino_current_bus++;
 		return 0;

