From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH v1 01/18] PCI: don't publish new root bus until it's fully
	initialized
Date: Mon, 30 Jan 2012 09:57:14 -0700
Message-ID: <20120130165714.3231.65354.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When pci_create_root_bus() adds the new struct pci_bus to the global
pci_root_buses list, the bus becomes visible to other parts of the
kernel, so it should be fully initialized.

This patch delays adding the bus to the pci_root_buses list until after
all the struct pci_bus initialization is finished.
---
 drivers/pci/probe.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..da0d655 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1551,10 +1551,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	dev->parent = parent;
 	dev->release = pci_release_bus_bridge_dev;
 	dev_set_name(dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -1594,6 +1590,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 			dev_info(&b->dev, "root bus resource %pR\n", res);
 	}
 
+	down_write(&pci_bus_sem);
+	list_add_tail(&b->node, &pci_root_buses);
+	up_write(&pci_bus_sem);
+
 	return b;
 
 class_dev_reg_err:
