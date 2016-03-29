From: Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Tue, 29 Mar 2016 13:23:00 -0500
Message-ID: <1459275781-3863-1-git-send-email-robh@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33352 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcC2SX3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2016 14:23:29 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Drivers shouldn't have to care about HAS_IOMEM to compile and having to
causes a Kconfig mess:

warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

Reuse the !MMU variants for !HAS_IOMEM as they are sufficient for our
needs. This fixes build errors for UM allyesconfig:

drivers/mfd/syscon.c:89:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
     iounmap(base);

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/asm-generic/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index eed3bbe..03160b0 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -753,7 +753,7 @@ static inline void *phys_to_virt(unsigned long address)
  * ioremap_*() variant as defined to itself to avoid the default NULL return.
  */
 
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) && defined(CONFIG_HAS_IOMEM)
 
 #ifndef ioremap_uc
 #define ioremap_uc ioremap_uc
-- 
2.5.0
