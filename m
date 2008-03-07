Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50051 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005AbYCGKr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Mar 2008 05:47:29 -0500
Date: Fri, 7 Mar 2008 11:21:38 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 2/7] Orion: initialise mbus DRAM target info on boot
Message-ID: <20080307102138.GB11977@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080307101913.GA11918@xi.wantstofly.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Tzachi Perelstein <tzachi@marvell.com>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080307102138.9t6FUtsZjeShftDU8twy-Kx07BZlbCtbRkA9SAqx5iI@z>

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

Index: linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/addr-map.c
+++ linux-2.6.25-rc4/arch/arm/mach-orion/addr-map.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mbus.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include "common.h"
@@ -157,6 +158,9 @@
 #define SATA_WIN_BASE(win)	ORION_SATA_REG(0x34 + ((win) * 0x10))
 #define SATA_MAX_WIN		4
 
+
+struct mbus_dram_target_info orion_mbus_dram_info;
+
 static int __init orion_cpu_win_can_remap(int win)
 {
 	u32 dev, rev;
@@ -189,6 +193,7 @@ static void __init setup_cpu_win(int win
 void __init orion_setup_cpu_mbus_bridge(void)
 {
 	int i;
+	int cs;
 
 	/*
 	 * First, disable and clear windows.
@@ -213,6 +218,30 @@ void __init orion_setup_cpu_mbus_bridge(
 		TARGET_PCIE, ATTR_PCIE_MEM, -1);
 	setup_cpu_win(3, ORION_PCI_MEM_PHYS_BASE, ORION_PCI_MEM_SIZE,
 		TARGET_PCI, ATTR_PCI_MEM, -1);
+
+	/*
+	 * Setup MBUS dram target info.
+	 */
+	orion_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
+
+	for (i = 0, cs = 0; i < 4; i++) {
+		u32 base = readl(DDR_BASE_CS(i));
+		u32 size = readl(DDR_SIZE_CS(i));
+
+		/*
+		 * Chip select enabled?
+		 */
+		if (size & 1) {
+			struct mbus_dram_window *w;
+
+			w = &orion_mbus_dram_info.cs[cs++];
+			w->cs_index = i;
+			w->mbus_attr = 0xf & ~(1 << i);
+			w->base = base & 0xff000000;
+			w->size = (size | 0x00ffffff) + 1;
+		}
+	}
+	orion_mbus_dram_info.num_cs = cs;
 }
 
 void __init orion_setup_dev_boot_win(u32 base, u32 size)
Index: linux-2.6.25-rc4/arch/arm/mach-orion/common.h
===================================================================
--- linux-2.6.25-rc4.orig/arch/arm/mach-orion/common.h
+++ linux-2.6.25-rc4/arch/arm/mach-orion/common.h
@@ -14,6 +14,7 @@ void __init orion_init(void);
  * functions to map its interfaces and by the machine-setup to map its on-
  * board devices. Details in /mach-orion/addr-map.c
  */
+extern struct mbus_dram_target_info orion_mbus_dram_info;
 void orion_setup_cpu_mbus_bridge(void);
 void orion_setup_dev_boot_win(u32 base, u32 size);
 void orion_setup_dev0_win(u32 base, u32 size);
