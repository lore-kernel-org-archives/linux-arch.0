From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 01/17] drivers: support PCIe in RISCV
Date: Tue,  6 Jun 2017 15:59:51 -0700
Message-ID: <20170606230007.19101-2-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33910 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdFFXBX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so10529660pgn.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:22 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>

From: "Wesley W. Terpstra" <wesley@sifive.com>

There are RISC-V systems that have been mapped to Xilinx FPGAs that have
their PCIe controllers on chip.  These build system changes allow RISC-V
systems to enable the Xilinx PCIe controller, and to setup PCIe IRQs.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/pci/Makefile     | 1 +
 drivers/pci/host/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 462c1f5f5546..a29d9ec05d13 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
 obj-$(CONFIG_TILE) += setup-irq.o
 obj-$(CONFIG_SPARC_LEON) += setup-irq.o
 obj-$(CONFIG_M68K) += setup-irq.o
+obj-$(CONFIG_RISCV) += setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7f47cd5e10a5..5148f3d3cab7 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -71,7 +71,7 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE
+	depends on ARCH_ZYNQ || MICROBLAZE || RISCV
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.13.0
