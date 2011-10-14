Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:20999 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab1JNE1x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 00:27:53 -0400
Subject: [PATCH v2 07/29] powerpc/PCI: make pcibios_setup_phb_resources()
	static
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Oct 2011 22:27:42 -0600
Message-ID: <20111014042742.23504.77418.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org
Message-ID: <20111014042742.Cf3kawatZ_mHn-f3VjopMB9aQgNLqUxW3qxazduGNls@z>

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    1 -
 arch/powerpc/kernel/pci-common.c      |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 56b879a..31bf836 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -222,7 +222,6 @@ extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
-extern void pcibios_setup_phb_resources(struct pci_controller *hose);
 
 #ifdef CONFIG_PCI
 extern int pcibios_vaddr_is_ioport(void __iomem *address);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 32656f1..942ced2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1554,7 +1554,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
+static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 {
 	struct pci_bus *bus = hose->bus;
 	struct resource *res;

