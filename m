From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
Date: Tue,  6 Jun 2017 15:59:52 -0700
Message-ID: <20170606230007.19101-3-palmer__4742.72081996805$1496790306$gmane$org@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34462 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdFFXBY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id u1so728159pfg.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:23 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>

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
