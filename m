Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdB0PP5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Feb 2017 10:15:57 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 18/20] PCI: tegra: update PCI config space remap function
Date: Mon, 27 Feb 2017 15:14:29 +0000
Message-ID: <20170227151436.18698-19-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20170227151429.cCcueG2uwa3w8A3WKhunllqnT6l7tHlwI8iSxZOOX_c@z>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use correct memory mapping attributes to map config space
regions to enforce configuration space non-posted writes behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pci/host/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index ed8a93f..2618f87 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -380,7 +380,7 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
 	struct device *dev = pcie->dev;
-	pgprot_t prot = pgprot_device(PAGE_KERNEL);
+	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
 	phys_addr_t cs = pcie->cs->start;
 	struct tegra_pcie_bus *bus;
 	unsigned int i;
@@ -1962,7 +1962,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		rp->pcie = pcie;
 		rp->np = port;
 
-		rp->base = devm_ioremap_resource(dev, &rp->regs);
+		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
-- 
2.10.0
