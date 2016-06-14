From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] ARM: socfpga: add PCIe to socfpga_defconfig
Date: Tue, 14 Jun 2016 10:30:14 +0800
Message-ID: <1465871414-3431-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0099.outbound.protection.outlook.com ([65.55.169.99]:41312
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932797AbcFNCa6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jun 2016 22:30:58 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>, Ley Foon Tan <lftan@altera.com>, Tien Hock Loh <thloh@altera.com>, Dinh Nguyen <dinguyen@opensource.altera.com>

Enable Altera PCIe host driver, Altera MSI driver and PCIe devices.

CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=y
CONFIG_BLK_DEV_NVME=m
CONFIG_E1000E=m
CONFIG_IGB=m
CONFIG_IXGBE=m

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Tien Hock Loh <thloh@altera.com>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>

---
update Dinh's email address
---
 arch/arm/configs/socfpga_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 753f1a5..419d758 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -19,6 +19,10 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_ARM_THUMBEE=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_ALTERA=y
+CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_AEABI=y
@@ -50,12 +54,16 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_E1000E=m
+CONFIG_IGB=m
+CONFIG_IXGBE=m
 CONFIG_STMMAC_ETH=y
 CONFIG_MICREL_PHY=y
 CONFIG_INPUT_EVDEV=y
-- 
1.8.2.1
