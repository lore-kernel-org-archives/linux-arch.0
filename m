Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f74.google.com ([209.85.212.74]:49454 "EHLO
	mail-vw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814Ab2CGWkB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:40:01 -0500
Received: by vbnl22 with SMTP id l22so866166vbn.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:40:01 -0800 (PST)
Subject: [PATCH v3 30/34] xtensa/PCI: get rid of device resource fixups
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:34:37 -0700
Message-ID: <20120307223437.25669.49157.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Chris Zankel <chris@zankel.net>
Message-ID: <20120307223437.JmmWs-ZQYidnYQO-gA2b8VrnPr6BUfKb7muVzWFr7Tc@z>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: Chris Zankel <chris@zankel.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 61045c1..eb30e35 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -153,7 +153,7 @@ static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
 	}
 	res->start += io_offset;
 	res->end += io_offset;
-	pci_add_resource(resources, res);
+	pci_add_resource_offset(resources, res, io_offset);
 
 	for (i = 0; i < 3; i++) {
 		res = &pci_ctrl->mem_resources[i];
@@ -200,24 +200,9 @@ subsys_initcall(pcibios_init);
 
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_controller *pci_ctrl = bus->sysdata;
-	struct resource *res;
-	unsigned long io_offset;
-	int i;
-
-	io_offset = (unsigned long)pci_ctrl->io_space.base;
 	if (bus->parent) {
 		/* This is a subordinate bridge */
 		pci_read_bridge_bases(bus);
-
-		for (i = 0; i < 4; i++) {
-			if ((res = bus->resource[i]) == NULL || !res->flags)
-				continue;
-			if (io_offset && (res->flags & IORESOURCE_IO)) {
-				res->start += io_offset;
-				res->end += io_offset;
-			}
-		}
 	}
 }
 

