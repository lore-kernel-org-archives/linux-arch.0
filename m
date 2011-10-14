From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 23/29] xen/PCI: use pci_create_root_bus() instead of
	pci_scan_bus_parented()
Date: Thu, 13 Oct 2011 22:29:04 -0600
Message-ID: <20111014042904.23504.36507.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-arch.vger.kernel.org

No functional change here; just converting from the deprecated
pci_scan_bus_parented() to pci_create_root_bus().

I don't see that Xen ever updates the root bus resources, but in
general, the default resources (ioport_resource and iomem_resource)
installed by pci_create_bus() are incorrect.

CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/xen-pcifront.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 6fa215a..3a07b33 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -470,8 +470,8 @@ static int __devinit pcifront_scan_root(struct pcifront_device *pdev,
 	}
 	pcifront_init_sd(sd, domain, bus, pdev);
 
-	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd);
+	b = pci_create_root_bus(&pdev->xdev->dev, bus, &pcifront_bus_ops, sd,
+				NULL);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
@@ -479,11 +479,12 @@ static int __devinit pcifront_scan_root(struct pcifront_device *pdev,
 		goto err_out;
 	}
 
+	b->subordinate = pci_scan_child_bus(b);
 	bus_entry->bus = b;
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
-	/* pci_scan_bus_parented skips devices which do not have a have
+	/* pci_scan_child_bus skips devices which do not have
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
 	err = pcifront_scan_bus(pdev, domain, bus, b);
 
