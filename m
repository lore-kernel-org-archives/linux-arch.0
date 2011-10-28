Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9945 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:20 -0400
Subject: [PATCH v3 21/34] parisc/PCI: lba: deal with LMMIO/PAT overlaps before
	creating PCI root bus
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:27:17 -0600
Message-ID: <20111028222717.30729.84926.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20111028222717.Ymms236ocV5a-eFCjLKxnpwKOodR-c88E3KCOvqSleE@z>

This moves the truncate_pat_collision() call out of the pcibios_fixup_bus()
path so that when a future patch builds a list of root bus resources for
pci_create_bus(), it can use the truncated LMMIO range.

truncate_pat_collision() used to be called in this path:

    pci_scan_bus_parented
      pci_create_bus
      pci_scan_child_bus
        pcibios_fixup_bus
	  lba_fixup_bus
	    truncate_pat_collision

All of the PAT and lba_dev resource setup must be done before we call
pci_scan_bus_parented(), so it should be safe to move the
truncate_pat_collision() to just before pci_scan_bus_parented().

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/lba_pci.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 3aeb327..2c7edf3 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -689,23 +689,7 @@ lba_fixup_bus(struct pci_bus *bus)
 				bus->resource[i++] = &(ldev->hba.elmmio_space);
 		}
 
-
-		/*   Overlaps with elmmio can (and should) fail here.
-		 *   We will prune (or ignore) the distributed range.
-		 *
-		 *   FIXME: SBA code should register all elmmio ranges first.
-		 *      that would take care of elmmio ranges routed
-		 *	to a different rope (already discovered) from
-		 *	getting registered *after* LBA code has already
-		 *	registered it's distributed lmmio range.
-		 */
-		if (truncate_pat_collision(&iomem_resource,
-				       	&(ldev->hba.lmmio_space))) {
-
-			printk(KERN_WARNING "LBA: lmmio_space [%lx/%lx] duplicate!\n",
-					(long)ldev->hba.lmmio_space.start,
-					(long)ldev->hba.lmmio_space.end);
-		} else {
+		if (ldev->hba.lmmio_space.flags) {
 			err = request_resource(&iomem_resource, &(ldev->hba.lmmio_space));
 			if (err < 0) {
 				printk(KERN_ERR "FAILED: lba_fixup_bus() request for "
@@ -1518,6 +1502,23 @@ lba_driver_probe(struct parisc_device *dev)
 	if (lba_dev->hba.bus_num.start < lba_next_bus)
 		lba_dev->hba.bus_num.start = lba_next_bus;
 
+	/*   Overlaps with elmmio can (and should) fail here.
+	 *   We will prune (or ignore) the distributed range.
+	 *
+	 *   FIXME: SBA code should register all elmmio ranges first.
+	 *      that would take care of elmmio ranges routed
+	 *	to a different rope (already discovered) from
+	 *	getting registered *after* LBA code has already
+	 *	registered it's distributed lmmio range.
+	 */
+	if (truncate_pat_collision(&iomem_resource,
+				   &(lba_dev->hba.lmmio_space))) {
+		printk(KERN_WARNING "LBA: lmmio_space [%lx/%lx] duplicate!\n",
+				(long)lba_dev->hba.lmmio_space.start,
+				(long)lba_dev->hba.lmmio_space.end);
+		lba_dev->hba.lmmio_space.flags = 0;
+	}
+
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
 		pci_scan_bus_parented(&dev->dev, lba_dev->hba.bus_num.start,

