From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH 7/7] Orion: leave peripheral window programming up to drivers
Date: Fri, 7 Mar 2008 11:23:33 +0100
Message-ID: <20080307102333.GG11977@xi.wantstofly.org>
References: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dale Farnsworth <dale-1viX+2+OPRFcxvNqPlePQg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>

Pass in Orion's mbus_dram_info to the common instantiation of the
EHCI, ethernet and SATA peripherals, and remove the remaining
peripheral window setting code and assorted defines from Orion's
addr-map.c (leaving only the CPU outbound window setting code.)

Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Index: linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/addr-map.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
@@ -34,11 +34,7 @@
  * Non-CPU Masters address decoding --
  * Unlike the CPU, we setup the access from Orion's master interfaces to DDR
  * banks only (the typical use case).
- * Setup access for each master to DDR is issued by common.c.
- *
- * Note: although orion_setbits() and orion_clrbits() are not atomic
- * no locking is necessary here since code in this file is only called
- * at boot time when there is no concurrency issues.
+ * Setup access for each master to DDR is issued by platform device setup.
  */
 
 /*
@@ -48,10 +44,6 @@
 #define TARGET_PCI		3
 #define TARGET_PCIE		4
 #define TARGET_DEV_BUS		1
-#define ATTR_DDR_CS(n)		(((n) ==0) ? 0xe :	\
-				((n) == 1) ? 0xd :	\
-				((n) == 2) ? 0xb :	\
-				((n) == 3) ? 0x7 : 0xf)
 #define ATTR_PCIE_MEM		0x59
 #define ATTR_PCIE_IO		0x51
 #define ATTR_PCIE_WA		0x79
@@ -61,17 +53,12 @@
 #define ATTR_DEV_CS1		0x1d
 #define ATTR_DEV_CS2		0x1b
 #define ATTR_DEV_BOOT		0xf
-#define WIN_EN			1
 
 /*
- * Helpers to get DDR banks info
+ * Helpers to get DDR bank info
  */
-#define DDR_BASE_CS(n)		ORION_DDR_REG(0x1500 + ((n) * 8))
-#define DDR_SIZE_CS(n)		ORION_DDR_REG(0x1504 + ((n) * 8))
-#define DDR_MAX_CS		4
-#define DDR_REG_TO_SIZE(reg)	(((reg) | 0xffffff) + 1)
-#define DDR_REG_TO_BASE(reg)	((reg) & 0xff000000)
-#define DDR_BANK_EN		1
+#define DDR_BASE_CS(n)		ORION_DDR_REG(0x1500 + ((n) << 3))
+#define DDR_SIZE_CS(n)		ORION_DDR_REG(0x1504 + ((n) << 3))
 
 /*
  * CPU Address Decode Windows registers
@@ -81,32 +68,6 @@
 #define CPU_WIN_REMAP_LO(n)	ORION_BRIDGE_REG(0x008 | ((n) << 4))
 #define CPU_WIN_REMAP_HI(n)	ORION_BRIDGE_REG(0x00c | ((n) << 4))
 
-/*
- * Gigabit Ethernet Address Decode Windows registers
- */
-#define ETH_WIN_BASE(win)	ORION_ETH_REG(0x200 + ((win) * 8))
-#define ETH_WIN_SIZE(win)	ORION_ETH_REG(0x204 + ((win) * 8))
-#define ETH_WIN_REMAP(win)	ORION_ETH_REG(0x280 + ((win) * 4))
-#define ETH_WIN_EN		ORION_ETH_REG(0x290)
-#define ETH_WIN_PROT		ORION_ETH_REG(0x294)
-#define ETH_MAX_WIN		6
-#define ETH_MAX_REMAP_WIN	4
-
-/*
- * USB Address Decode Windows registers
- */
-#define USB_WIN_CTRL(i, w)	((i == 0) ? ORION_USB0_REG(0x320 + ((w) << 4)) \
-					: ORION_USB1_REG(0x320 + ((w) << 4)))
-#define USB_WIN_BASE(i, w)	((i == 0) ? ORION_USB0_REG(0x324 + ((w) << 4)) \
-					: ORION_USB1_REG(0x324 + ((w) << 4)))
-#define USB_MAX_WIN		4
-
-/*
- * SATA Address Decode Windows registers
- */
-#define SATA_WIN_CTRL(win)	ORION_SATA_REG(0x30 + ((win) * 0x10))
-#define SATA_WIN_BASE(win)	ORION_SATA_REG(0x34 + ((win) * 0x10))
-#define SATA_MAX_WIN		4
 
 
 struct mbus_dram_target_info orion_mbus_dram_info;
@@ -218,112 +179,3 @@ void __init orion_setup_pcie_wa_win(u32 
 {
 	setup_cpu_win(7, base, size, TARGET_PCIE, ATTR_PCIE_WA, -1);
 }
-
-
-void __init orion_setup_usb_wins(void)
-{
-	int i;
-	u32 usb_if, dev, rev;
-	u32 max_usb_if = 1;
-
-	orion_pcie_id(&dev, &rev);
-	if (dev == MV88F5182_DEV_ID)
-		max_usb_if = 2;
-
-	for (usb_if = 0; usb_if < max_usb_if; usb_if++) {
-		/*
-		 * First, disable and clear windows
-		 */
-		for (i = 0; i < USB_MAX_WIN; i++) {
-			orion_write(USB_WIN_BASE(usb_if, i), 0);
-			orion_write(USB_WIN_CTRL(usb_if, i), 0);
-		}
-
-		/*
-		 * Setup windows for DDR banks.
-		 */
-		for (i = 0; i < DDR_MAX_CS; i++) {
-			u32 base, size;
-			size = orion_read(DDR_SIZE_CS(i));
-			base = orion_read(DDR_BASE_CS(i));
-			if (size & DDR_BANK_EN) {
-				base = DDR_REG_TO_BASE(base);
-				size = DDR_REG_TO_SIZE(size);
-				orion_write(USB_WIN_CTRL(usb_if, i),
-						((size-1) & 0xffff0000) |
-						(ATTR_DDR_CS(i) << 8) |
-						(TARGET_DDR << 4) | WIN_EN);
-				orion_write(USB_WIN_BASE(usb_if, i),
-						base & 0xffff0000);
-			}
-		}
-	}
-}
-
-void __init orion_setup_eth_wins(void)
-{
-	int i;
-
-	/*
-	 * First, disable and clear windows
-	 */
-	for (i = 0; i < ETH_MAX_WIN; i++) {
-		orion_write(ETH_WIN_BASE(i), 0);
-		orion_write(ETH_WIN_SIZE(i), 0);
-		orion_setbits(ETH_WIN_EN, 1 << i);
-		orion_clrbits(ETH_WIN_PROT, 0x3 << (i * 2));
-		if (i < ETH_MAX_REMAP_WIN)
-			orion_write(ETH_WIN_REMAP(i), 0);
-	}
-
-	/*
-	 * Setup windows for DDR banks.
-	 */
-	for (i = 0; i < DDR_MAX_CS; i++) {
-		u32 base, size;
-		size = orion_read(DDR_SIZE_CS(i));
-		base = orion_read(DDR_BASE_CS(i));
-		if (size & DDR_BANK_EN) {
-			base = DDR_REG_TO_BASE(base);
-			size = DDR_REG_TO_SIZE(size);
-			orion_write(ETH_WIN_SIZE(i), (size-1) & 0xffff0000);
-			orion_write(ETH_WIN_BASE(i), (base & 0xffff0000) |
-					(ATTR_DDR_CS(i) << 8) |
-					TARGET_DDR);
-			orion_clrbits(ETH_WIN_EN, 1 << i);
-			orion_setbits(ETH_WIN_PROT, 0x3 << (i * 2));
-		}
-	}
-}
-
-void __init orion_setup_sata_wins(void)
-{
-	int i;
-
-	/*
-	 * First, disable and clear windows
-	 */
-	for (i = 0; i < SATA_MAX_WIN; i++) {
-		orion_write(SATA_WIN_BASE(i), 0);
-		orion_write(SATA_WIN_CTRL(i), 0);
-	}
-
-	/*
-	 * Setup windows for DDR banks.
-	 */
-	for (i = 0; i < DDR_MAX_CS; i++) {
-		u32 base, size;
-		size = orion_read(DDR_SIZE_CS(i));
-		base = orion_read(DDR_BASE_CS(i));
-		if (size & DDR_BANK_EN) {
-			base = DDR_REG_TO_BASE(base);
-			size = DDR_REG_TO_SIZE(size);
-			orion_write(SATA_WIN_CTRL(i),
-					((size-1) & 0xffff0000) |
-					(ATTR_DDR_CS(i) << 8) |
-					(TARGET_DDR << 4) | WIN_EN);
-			orion_write(SATA_WIN_BASE(i),
-					base & 0xffff0000);
-		}
-	}
-}
Index: linux-2.6.25-rc4/arch/arm/mach-orion/common.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/common.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/common.c
@@ -14,12 +14,15 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/mbus.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
+#include <linux/ata_platform.h>
 #include <asm/page.h>
 #include <asm/timex.h>
 #include <asm/mach/map.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/platform.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -146,6 +149,10 @@ static struct resource orion_ehci1_resou
 	},
 };
 
+static struct orion_ehci_data orion_ehci_data = {
+	.dram		= &orion_mbus_dram_info,
+};
+
 static u64 ehci_dmamask = 0xffffffffUL;
 
 static struct platform_device orion_ehci0 = {
@@ -154,6 +161,7 @@ static struct platform_device orion_ehci
 	.dev		= {
 		.dma_mask		= &ehci_dmamask,
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &orion_ehci_data,
 	},
 	.resource	= orion_ehci0_resources,
 	.num_resources	= ARRAY_SIZE(orion_ehci0_resources),
@@ -165,6 +173,7 @@ static struct platform_device orion_ehci
 	.dev		= {
 		.dma_mask		= &ehci_dmamask,
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &orion_ehci_data,
 	},
 	.resource	= orion_ehci1_resources,
 	.num_resources	= ARRAY_SIZE(orion_ehci1_resources),
@@ -185,6 +194,7 @@ static struct resource orion_eth_shared_
 
 struct mv643xx_eth_shared_platform_data orion_eth_shared_data = {
 	.t_clk		= ORION_TCLK,
+	.dram		= &orion_mbus_dram_info,
 };
 
 static struct platform_device orion_eth_shared = {
@@ -288,6 +298,7 @@ static struct platform_device orion_sata
 
 void __init orion_sata_init(struct mv_sata_platform_data *sata_data)
 {
+	sata_data->dram = &orion_mbus_dram_info;
 	orion_sata.dev.platform_data = sata_data;
 	platform_device_register(&orion_sata);
 }
@@ -340,10 +351,6 @@ void __init orion_init(void)
 	 * Setup Orion address map
 	 */
 	orion_setup_cpu_mbus_bridge();
-	orion_setup_usb_wins();
-	orion_setup_eth_wins();
-	if (dev == MV88F5182_DEV_ID)
-		orion_setup_sata_wins();
 
 	/*
 	 * REgister devices
Index: linux-2.6.25-rc4/arch/arm/mach-orion/common.h
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/common.h
+++ linux-2.6.25-rc4/arch/arm/mach-orion/common.h
@@ -21,9 +21,6 @@ void orion_setup_dev0_win(u32 base, u32 
 void orion_setup_dev1_win(u32 base, u32 size);
 void orion_setup_dev2_win(u32 base, u32 size);
 void orion_setup_pcie_wa_win(u32 base, u32 size);
-void orion_setup_eth_wins(void);
-void orion_setup_usb_wins(void);
-void orion_setup_sata_wins(void);
 
 /*
  * Shared code used internally by other Orion core functions.
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
