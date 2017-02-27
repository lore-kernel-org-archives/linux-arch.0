From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 11/20] PCI: rockchip: update PCI config space remap function
Date: Mon, 27 Feb 2017 15:14:22 +0000
Message-ID: <20170227151436.18698-12-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-arch.vger.kernel.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 26ddd35..690a7b5 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -822,7 +822,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
 					    "axi-base");
-	rockchip->reg_base = devm_ioremap_resource(dev, regs);
+	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
 	if (IS_ERR(rockchip->reg_base))
 		return PTR_ERR(rockchip->reg_base);
 
-- 
2.10.0
