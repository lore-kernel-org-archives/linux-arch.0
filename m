From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 04/34] arm/PCI: remove arch pci_flags definition
Date: Wed, 07 Mar 2012 15:32:24 -0700
Message-ID: <20120307223224.25669.89103.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:39069 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030436Ab2CGWc1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 17:32:27 -0500
Received: by wejx9 with SMTP id x9so269745wej.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2012 14:32:25 -0800 (PST)
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>

The PCI core provides a pci_flags definition (currently __weak), so drop
the arm definition in favor of that.

arm previously had EXPORT_SYMBOL(pci_flags), but no other architecture does
this, and no modules reference it, so I removed the export.

CC: Rob Herring <rob.herring@calxeda.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    1 +
 arch/arm/mm/iomap.c      |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f58ba35..d13b6c2 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -525,6 +525,7 @@ void __init pci_common_init(struct hw_pci *hw)
 
 	INIT_LIST_HEAD(&hw->buses);
 
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
 	pcibios_init_hw(hw);
diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index e62956e..4614208 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -32,9 +32,6 @@ EXPORT_SYMBOL(pcibios_min_io);
 unsigned long pcibios_min_mem = 0x01000000;
 EXPORT_SYMBOL(pcibios_min_mem);
 
-unsigned int pci_flags = PCI_REASSIGN_ALL_RSRC;
-EXPORT_SYMBOL(pci_flags);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if ((unsigned long)addr >= VMALLOC_START &&
