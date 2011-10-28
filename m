From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 02/34] PCI: show host bridges and root bus resources
Date: Fri, 28 Oct 2011 16:25:40 -0600
Message-ID: <20111028222540.30729.36688.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Show the bus number and resources for every root bus we create.  This
will become more interesting when we supply the correct resources
instead of using the defaults (ioport_resource and iomem_resource).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6ab6bd3..465d302 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1531,9 +1531,10 @@ unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 struct pci_bus * pci_create_bus(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {
-	int error;
+	int error, i;
 	struct pci_bus *b, *b2;
 	struct device *dev;
+	struct resource *res;
 
 	b = pci_alloc_bus();
 	if (!b)
@@ -1586,6 +1587,16 @@ struct pci_bus * pci_create_bus(struct device *parent,
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 
+	if (parent)
+		dev_info(parent, "PCI host bridge to bus %s\n", dev_name(&b->dev));
+	else
+		printk(KERN_INFO "PCI host bridge to bus %s\n", dev_name(&b->dev));
+
+	pci_bus_for_each_resource(b, res, i) {
+		if (res)
+			dev_info(&b->dev, "root bus resource %pR\n", res);
+	}
+
 	return b;
 
 class_dev_reg_err:
