Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9881 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828Ab1J1W1K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:10 -0400
Subject: [PATCH v3 19/34] parisc/PCI: dino: use pci_create_bus() instead of
	pci_scan_bus_parented()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:07 -0600
Message-ID: <20111028222707.30729.18812.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20111028222707.4YR2_PoJIyxGFpAhR79N42ZfNvatWTJ5up2vQF7EWtg@z>

No functional change here; just converting from pci_scan_bus_parented()
to pci_create_bus() to make a future patch simpler.

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/dino.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index bcd5d54..90252c0 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -1007,22 +1007,24 @@ static int __init dino_probe(struct parisc_device *dev)
 	** It's not used to avoid chicken/egg problems
 	** with configuration accessor functions.
 	*/
-	dino_dev->hba.hba_bus = bus = pci_scan_bus_parented(&dev->dev,
+	dino_dev->hba.hba_bus = bus = pci_create_bus(&dev->dev,
 			 dino_current_bus, &dino_cfg_ops, NULL);
-
-	if(bus) {
-		/* This code *depends* on scanning being single threaded
-		 * if it isn't, this global bus number count will fail
-		 */
-		dino_current_bus = bus->subordinate + 1;
-		pci_bus_assign_resources(bus);
-		pci_bus_add_devices(bus);
-	} else {
+	if (!bus) {
 		printk(KERN_ERR "ERROR: failed to scan PCI bus on %s (duplicate bus number %d?)\n",
 		       dev_name(&dev->dev), dino_current_bus);
 		/* increment the bus number in case of duplicates */
 		dino_current_bus++;
+		return 0;
 	}
+
+	bus->subordinate = pci_scan_child_bus(bus);
+
+	/* This code *depends* on scanning being single threaded
+	 * if it isn't, this global bus number count will fail
+	 */
+	dino_current_bus = bus->subordinate + 1;
+	pci_bus_assign_resources(bus);
+	pci_bus_add_devices(bus);
 	return 0;
 }
 

