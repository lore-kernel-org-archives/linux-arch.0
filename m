Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50049 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbYCGKra (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Mar 2008 05:47:30 -0500
Date: Fri, 7 Mar 2008 11:22:25 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 4/7] ehci-orion: mbus decode window support
Message-ID: <20080307102225.GD11977@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918@xi.wantstofly.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Tzachi Perelstein <tzachi@marvell.com>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080307102225.a4ToJQKlJLJhbFgOCY32UprNEYYloSEU3brnt2wUq2c@z>

Make it possible to pass mbus_dram_target_info to the ehci-orion
driver via the platform data, and make the ehci-orion driver
program the window registers based on this data if it is passed in.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

Index: linux-2.6.25-rc4/drivers/usb/host/ehci-orion.c
===================================================================
--- linux-2.6.25-rc4.orig/drivers/usb/host/ehci-orion.c
+++ linux-2.6.25-rc4/drivers/usb/host/ehci-orion.c
@@ -11,15 +11,19 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/mbus.h>
 #include <asm/arch/orion.h>
+#include <asm/arch/platform.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
 
-#define USB_CAUSE		0x310
-#define USB_MASK		0x314
 #define USB_CMD			0x140
 #define USB_MODE		0x1a8
+#define USB_CAUSE		0x310
+#define USB_MASK		0x314
+#define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
+#define USB_WINDOW_BASE(i)	(0x324 + ((i) << 4))
 #define USB_IPG			0x360
 #define USB_PHY_PWR_CTRL	0x400
 #define USB_PHY_TX_CTRL		0x420
@@ -162,8 +166,30 @@ static const struct hc_driver ehci_orion
 	.bus_resume = ehci_bus_resume,
 };
 
+static void __init
+ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
+				struct mbus_dram_target_info *dram)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		wrl(USB_WINDOW_CTRL(i), 0);
+		wrl(USB_WINDOW_BASE(i), 0);
+	}
+
+	for (i = 0; i < dram->num_cs; i++) {
+		struct mbus_dram_window *cs = dram->cs + i;
+
+		wrl(USB_WINDOW_CTRL(i), ((cs->size - 1) & 0xffff0000) |
+					(cs->mbus_attr << 8) |
+					(dram->mbus_dram_target_id << 4) | 1);
+		wrl(USB_WINDOW_BASE(i), cs->base);
+	}
+}
+
 static int __init ehci_orion_drv_probe(struct platform_device *pdev)
 {
+	struct orion_ehci_data *pd = pdev->dev.platform_data;
 	struct resource *res;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
@@ -227,6 +253,12 @@ static int __init ehci_orion_drv_probe(s
 	ehci->sbrn = 0x20;
 
 	/*
+	 * (Re-)program MBUS remapping windows if we are asked to.
+	 */
+	if (pd != NULL && pd->dram != NULL)
+		ehci_orion_conf_mbus_windows(hcd, pd->dram);
+
+	/*
 	 * setup Orion USB controller
 	 */
 	orion_usb_setup(hcd);
Index: linux-2.6.25-rc4/include/asm-arm/arch-orion/platform.h
===================================================================
--- linux-2.6.25-rc4.orig/include/asm-arm/arch-orion/platform.h
+++ linux-2.6.25-rc4/include/asm-arm/arch-orion/platform.h
@@ -12,6 +12,14 @@
 #define __ASM_ARCH_PLATFORM_H__
 
 /*
+ * Orion EHCI platform driver data.
+ */
+struct orion_ehci_data {
+	struct mbus_dram_target_info	*dram;
+};
+
+
+/*
  * Device bus NAND private data
  */
 struct orion_nand_data {
@@ -22,4 +30,5 @@ struct orion_nand_data {
 	u8 width;	/* buswidth */
 };
 
+
 #endif
