From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
Date: Tue,  6 Jun 2017 15:59:52 -0700
Message-ID: <20170606230007.19101-3-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

These are numbered from 1.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/pci/host/pcie-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2fe2df51f9f8..8804145d399a 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
 			generic_handle_irq(irq_find_mapping(port->leg_domain,
-							    val));
+							    val + 1));
 		}
 	}
 
@@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
 						 &intx_domain_ops,
 						 port);
 	if (!port->leg_domain) {
-- 
2.13.0
