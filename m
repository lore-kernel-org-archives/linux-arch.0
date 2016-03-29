From: Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] mfd: remove dependency on HAS_IOMEM
Date: Tue, 29 Mar 2016 13:23:01 -0500
Message-ID: <1459275781-3863-2-git-send-email-robh@kernel.org>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34136 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbcC2SX3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2016 14:23:29 -0400
In-Reply-To: <1459275781-3863-1-git-send-email-robh@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Lots of drivers select MFD_SYSCON which depends on HAS_IOMEM and causes
this kbuild warning if HAS_IOMEM is not enabled:

warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

Now that we have ioremap/iounmap variants for !HAS_IOMEM, remove this
dependency from MFD to fix this warning.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index eea61e3..8999d38 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2,7 +2,6 @@
 # Multifunction miscellaneous devices
 #
 
-if HAS_IOMEM
 menu "Multifunction device drivers"
 
 config MFD_CORE
@@ -1579,4 +1578,3 @@ config MFD_VEXPRESS_SYSREG
 	  on the ARM Ltd. Versatile Express board.
 
 endmenu
-endif
-- 
2.5.0
