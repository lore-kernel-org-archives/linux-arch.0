Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9818 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab1J1W0u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:50 -0400
Subject: [PATCH v3 14/34] microblaze/PCI: make pcibios_setup_phb_resources()
	static
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:26:41 -0600
Message-ID: <20111028222641.30729.22745.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Message-ID: <20111028222641.vDWWPzg9mps3rfgoOcX796teWuXvfBJfealfjVwMNw0@z>

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci-bridge.h |    1 -
 arch/microblaze/pci/pci-common.c         |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microblaze/include/asm/pci-bridge.h
index 32764cd..e9834b2 100644
--- a/arch/microblaze/include/asm/pci-bridge.h
+++ b/arch/microblaze/include/asm/pci-bridge.h
@@ -140,7 +140,6 @@ extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
-extern void pcibios_setup_phb_resources(struct pci_controller *hose);
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_MICROBLAZE_PCI_BRIDGE_H */
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9df5e5b..9dde153 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1507,7 +1507,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
+static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 {
 	struct pci_bus *bus = hose->bus;
 	struct resource *res;

