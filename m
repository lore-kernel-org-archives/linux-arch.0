From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 16/34] microblaze/PCI: use pci_scan_root_bus()
Date: Fri, 28 Oct 2011 16:26:52 -0600
Message-ID: <20111028222651.30729.58763.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

Microblaze doesn't need to replace pci_scan_child_bus() or do anything
special before pci_bus_add_devices(), so we can use the more generic PCI
path in pci_scan_root_bus().

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/pci/pci-common.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ec80f1e..5df4ca9 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1584,9 +1584,8 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 
 	pcibios_setup_phb_resources(hose, &resources);
 
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno, hose->ops,
-				  hose, &resources);
+	bus = pci_scan_root_bus(hose->parent, hose->first_busno,
+				hose->ops, hose, &resources);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
@@ -1596,8 +1595,7 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
-	/* Scan children */
-	hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+	hose->last_busno = bus->subordinate;
 }
 
 static int __init pcibios_init(void)
@@ -1611,8 +1609,6 @@ static int __init pcibios_init(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
 		pcibios_scan_phb(hose);
-		printk(KERN_INFO "calling pci_bus_add_devices()\n");
-		pci_bus_add_devices(hose->bus);
 		if (next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + 1;
 	}
