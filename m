From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 22/34] parisc/PCI: lba: use pci_create_bus() instead of
	pci_scan_bus_parented()
Date: Fri, 28 Oct 2011 16:27:22 -0600
Message-ID: <20111028222722.30729.59772.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

No functional change here; just converting from pci_scan_bus_parented()
to pci_create_bus() to make a future patch simpler.

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/lba_pci.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 2c7edf3..e5dfa25 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1521,8 +1521,12 @@ lba_driver_probe(struct parisc_device *dev)
 
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
-		pci_scan_bus_parented(&dev->dev, lba_dev->hba.bus_num.start,
-				cfg_ops, NULL);
+		pci_create_bus(&dev->dev, lba_dev->hba.bus_num.start,
+			       cfg_ops, NULL);
+	if (!lba_bus)
+		return 0;
+
+	lba_bus->subordinate = pci_scan_child_bus(lba_bus);
 
 	/* This is in lieu of calling pci_assign_unassigned_resources() */
 	if (is_pdc_pat()) {
@@ -1552,10 +1556,8 @@ lba_driver_probe(struct parisc_device *dev)
 		lba_dev->flags |= LBA_FLAG_SKIP_PROBE;
 	}
 
-	if (lba_bus) {
-		lba_next_bus = lba_bus->subordinate + 1;
-		pci_bus_add_devices(lba_bus);
-	}
+	lba_next_bus = lba_bus->subordinate + 1;
+	pci_bus_add_devices(lba_bus);
 
 	/* Whew! Finally done! Tell services we got this one covered. */
 	return 0;

