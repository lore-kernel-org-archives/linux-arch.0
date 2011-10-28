From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 23/34] parisc/PCI: lba: convert to pci_create_root_bus()
	for correct root bus resources
Date: Fri, 28 Oct 2011 16:27:27 -0600
Message-ID: <20111028222727.30729.43687.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35876 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W13 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:27:29 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org

Supply root bus resources to pci_create_root_bus() so they're correct
immediately.  This fixes the problem of "early" and "header" quirks seeing
incorrect root bus resources.

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/lba_pci.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index e5dfa25..d5f3d75 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -653,7 +653,7 @@ lba_fixup_bus(struct pci_bus *bus)
 		}
 	} else {
 		/* Host-PCI Bridge */
-		int err, i;
+		int err;
 
 		DBG("lba_fixup_bus() %s [%lx/%lx]/%lx\n",
 			ldev->hba.io_space.name,
@@ -669,9 +669,6 @@ lba_fixup_bus(struct pci_bus *bus)
 			lba_dump_res(&ioport_resource, 2);
 			BUG();
 		}
-		/* advertize Host bridge resources to PCI bus */
-		bus->resource[0] = &(ldev->hba.io_space);
-		i = 1;
 
 		if (ldev->hba.elmmio_space.start) {
 			err = request_resource(&iomem_resource,
@@ -685,8 +682,7 @@ lba_fixup_bus(struct pci_bus *bus)
 
 				/* lba_dump_res(&iomem_resource, 2); */
 				/* BUG(); */
-			} else
-				bus->resource[i++] = &(ldev->hba.elmmio_space);
+			}
 		}
 
 		if (ldev->hba.lmmio_space.flags) {
@@ -696,8 +692,7 @@ lba_fixup_bus(struct pci_bus *bus)
 					"lmmio_space [%lx/%lx]\n",
 					(long)ldev->hba.lmmio_space.start,
 					(long)ldev->hba.lmmio_space.end);
-			} else
-				bus->resource[i++] = &(ldev->hba.lmmio_space);
+			}
 		}
 
 #ifdef CONFIG_64BIT
@@ -712,7 +707,6 @@ lba_fixup_bus(struct pci_bus *bus)
 				lba_dump_res(&iomem_resource, 2);
 				BUG();
 			}
-			bus->resource[i++] = &(ldev->hba.gmmio_space);
 		}
 #endif
 
@@ -1388,6 +1382,7 @@ static int __init
 lba_driver_probe(struct parisc_device *dev)
 {
 	struct lba_device *lba_dev;
+	LIST_HEAD(resources);
 	struct pci_bus *lba_bus;
 	struct pci_ops *cfg_ops;
 	u32 func_class;
@@ -1519,12 +1514,22 @@ lba_driver_probe(struct parisc_device *dev)
 		lba_dev->hba.lmmio_space.flags = 0;
 	}
 
+	pci_add_resource(&resources, &lba_dev->hba.io_space);
+	if (lba_dev->hba.elmmio_space.start)
+		pci_add_resource(&resources, &lba_dev->hba.elmmio_space);
+	if (lba_dev->hba.lmmio_space.flags)
+		pci_add_resource(&resources, &lba_dev->hba.lmmio_space);
+	if (lba_dev->hba.gmmio_space.flags)
+		pci_add_resource(&resources, &lba_dev->hba.gmmio_space);
+
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
-		pci_create_bus(&dev->dev, lba_dev->hba.bus_num.start,
-			       cfg_ops, NULL);
-	if (!lba_bus)
+		pci_create_root_bus(&dev->dev, lba_dev->hba.bus_num.start,
+				    cfg_ops, NULL, &resources);
+	if (!lba_bus) {
+		pci_free_resource_list(&resources);
 		return 0;
+	}
 
 	lba_bus->subordinate = pci_scan_child_bus(lba_bus);
 
