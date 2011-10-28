From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 30/34] x86/PCI: read Broadcom CNB20LE host bridge info
	before PCI scan
Date: Fri, 28 Oct 2011 16:28:03 -0600
Message-ID: <20111028222803.30729.90813.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35998 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W2P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:28:15 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>

We currently read the CNB20LE aperture information in a PCI quirk,
which happens after we've already created the root bus.  This patch
changes it to read the apertures earlier so we can create the root
bus with the correct resources.

I believe the CNB20LE lives at "pci 0000:00:00" based on
https://lkml.org/lkml/2010/8/13/220

CC: Ira W. Snyder <iws@ovro.caltech.edu>
CC: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/broadcom_bus.c |   62 +++++++++++++++++++++++++++----------------
 1 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index ab8269b..f3a7c56 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -15,10 +15,11 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <asm/pci_x86.h>
+#include <asm/pci-direct.h>
 
 #include "bus_numa.h"
 
-static void __devinit cnb20le_res(struct pci_dev *dev)
+static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
 {
 	struct pci_root_info *info;
 	struct resource res;
@@ -26,21 +27,12 @@ static void __devinit cnb20le_res(struct pci_dev *dev)
 	u8 fbus, lbus;
 	int i;
 
-#ifdef CONFIG_ACPI
-	/*
-	 * We should get host bridge information from ACPI unless the BIOS
-	 * doesn't support it.
-	 */
-	if (acpi_os_get_root_pointer())
-		return;
-#endif
-
 	info = &pci_root_info[pci_root_num];
 	pci_root_num++;
 
 	/* read the PCI bus numbers */
-	pci_read_config_byte(dev, 0x44, &fbus);
-	pci_read_config_byte(dev, 0x45, &lbus);
+	fbus = read_pci_config_byte(bus, slot, func, 0x44);
+	lbus = read_pci_config_byte(bus, slot, func, 0x45);
 	info->bus_min = fbus;
 	info->bus_max = lbus;
 
@@ -59,8 +51,8 @@ static void __devinit cnb20le_res(struct pci_dev *dev)
 	}
 
 	/* read the non-prefetchable memory window */
-	pci_read_config_word(dev, 0xc0, &word1);
-	pci_read_config_word(dev, 0xc2, &word2);
+	word1 = read_pci_config_16(bus, slot, func, 0xc0);
+	word2 = read_pci_config_16(bus, slot, func, 0xc2);
 	if (word1 != word2) {
 		res.start = (word1 << 16) | 0x0000;
 		res.end   = (word2 << 16) | 0xffff;
@@ -69,8 +61,8 @@ static void __devinit cnb20le_res(struct pci_dev *dev)
 	}
 
 	/* read the prefetchable memory window */
-	pci_read_config_word(dev, 0xc4, &word1);
-	pci_read_config_word(dev, 0xc6, &word2);
+	word1 = read_pci_config_16(bus, slot, func, 0xc4);
+	word2 = read_pci_config_16(bus, slot, func, 0xc6);
 	if (word1 != word2) {
 		res.start = (word1 << 16) | 0x0000;
 		res.end   = (word2 << 16) | 0xffff;
@@ -79,8 +71,8 @@ static void __devinit cnb20le_res(struct pci_dev *dev)
 	}
 
 	/* read the IO port window */
-	pci_read_config_word(dev, 0xd0, &word1);
-	pci_read_config_word(dev, 0xd2, &word2);
+	word1 = read_pci_config_16(bus, slot, func, 0xd0);
+	word2 = read_pci_config_16(bus, slot, func, 0xd2);
 	if (word1 != word2) {
 		res.start = word1;
 		res.end   = word2;
@@ -92,13 +84,37 @@ static void __devinit cnb20le_res(struct pci_dev *dev)
 	res.start = fbus;
 	res.end   = lbus;
 	res.flags = IORESOURCE_BUS;
-	dev_info(&dev->dev, "CNB20LE PCI Host Bridge (domain %04x %pR)\n",
-			    pci_domain_nr(dev->bus), &res);
+	printk(KERN_INFO "CNB20LE PCI Host Bridge (domain 0000 %pR)\n", &res);
 
 	for (i = 0; i < info->res_num; i++)
-		dev_info(&dev->dev, "host bridge window %pR\n", &info->res[i]);
+		printk(KERN_INFO "host bridge window %pR\n", &info->res[i]);
 }
 
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_LE,
-			cnb20le_res);
+static int __init broadcom_postcore_init(void)
+{
+	u8 bus = 0, slot = 0;
+	u32 id;
+	u16 vendor, device;
+
+#ifdef CONFIG_ACPI
+	/*
+	 * We should get host bridge information from ACPI unless the BIOS
+	 * doesn't support it.
+	 */
+	if (acpi_os_get_root_pointer())
+		return 0;
+#endif
+
+	id = read_pci_config(bus, slot, 0, PCI_VENDOR_ID);
+	vendor = id & 0xffff;
+	device = (id >> 16) & 0xffff;
+
+	if (vendor == PCI_VENDOR_ID_SERVERWORKS &&
+	    device == PCI_DEVICE_ID_SERVERWORKS_LE) {
+		cnb20le_res(bus, slot, 0);
+		cnb20le_res(bus, slot, 1);
+	}
+	return 0;
+}
 
+postcore_initcall(broadcom_postcore_init);
