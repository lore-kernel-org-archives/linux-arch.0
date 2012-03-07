Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f74.google.com ([209.85.214.74]:50891 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965317Ab2CGWlB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:41:01 -0500
Received: by bkcjm19 with SMTP id jm19so247410bkc.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:40:59 -0800 (PST)
Subject: [PATCH v3 18/34] PCI: add generic pcibios_resource_to_bus()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:33:36 -0700
Message-ID: <20120307223336.25669.60286.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <20120307223336.8MqYn2-4PXXG4LzCUjhHwxN8kNusGDLJNGv6tT-Wkvk@z>

This replaces the generic versions of pcibios_resource_to_bus() and
pcibios_bus_to_resource() in asm-generic/pci.h with versions that use
pci_resource_to_bus() and pci_bus_to_resource().

The replacements are equivalent except that they can apply host
bridge window offsets when the arch has supplied them by using
pci_add_resource_offset().

Each arch can convert to using pci_add_resource_offset() individually by
removing its device resource fixups from pcibios_fixup_bus() and supplying
ARCH_HAS_GENERIC_PCI_OFFSETS.  ARCH_HAS_GENERIC_PCI_OFFSETS can be removed
after all have converted.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c       |   16 ++++++++++++++++
 include/asm-generic/pci.h |   24 +-----------------------
 include/linux/pci.h       |    4 ++++
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6713447..13fec71 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -118,6 +118,22 @@ void pci_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->end = region->end + offset;
 }
 
+#ifdef ARCH_HAS_GENERIC_PCI_OFFSETS
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	pci_resource_to_bus(dev, region, res);
+}
+EXPORT_SYMBOL(pcibios_resource_to_bus);
+
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	pci_bus_to_resource(dev, res, region);
+}
+EXPORT_SYMBOL(pcibios_bus_to_resource);
+#endif
+
 /*
  * PCI Bus Class
  */
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index 26373cf..0410346 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -6,29 +6,7 @@
 #ifndef _ASM_GENERIC_PCI_H
 #define _ASM_GENERIC_PCI_H
 
-/**
- * pcibios_resource_to_bus - convert resource to PCI bus address
- * @dev: device which owns this resource
- * @region: converted bus-centric region (start,end)
- * @res: resource to convert
- *
- * Convert a resource to a PCI device bus address or bus window.
- */
-static inline void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res)
-{
-	region->start = res->start;
-	region->end = res->end;
-}
-
-static inline void
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region)
-{
-	res->start = region->start;
-	res->end = region->end;
-}
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 419f78f..be58a51 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -648,6 +648,10 @@ void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
 
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res);
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
 extern struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);

