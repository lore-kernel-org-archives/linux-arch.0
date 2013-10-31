From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 07/11] ARM: bcm2835: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:15 +0100
Message-ID: <20131031063000.108307682@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:48671 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3JaGaI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:08 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so1141969ead.33
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:07 -0700 (PDT)
Content-Disposition: inline; filename=arm-machine-reset-bcm2835.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Stephen Warren <swarren@wwwdotorg.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: bcm2835 as provider of reset hooks.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/mach-bcm2835/Kconfig   |    1 +
 arch/arm/mach-bcm2835/bcm2835.c |   30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

Index: b/arch/arm/mach-bcm2835/Kconfig
===================================================================
--- a/arch/arm/mach-bcm2835/Kconfig
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -8,6 +8,7 @@ config ARCH_BCM2835
 	select CLKSRC_OF
 	select CPU_V6
 	select GENERIC_CLOCKEVENTS
+	select MACHINE_RESET
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
Index: b/arch/arm/mach-bcm2835/bcm2835.c
===================================================================
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/clk/bcm2835.h>
 #include <linux/clocksource.h>
+#include <linux/machine_reset.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -36,7 +37,8 @@
 #define BCM2835_PERIPH_VIRT	0xf0000000
 #define BCM2835_PERIPH_SIZE	SZ_16M
 
-static void __iomem *wdt_regs;
+static void bcm2835_restart(void *dev, enum reboot_mode mode, const char *cmd);
+static void bcm2835_power_off(void *dev);
 
 /*
  * The machine restart method can be called from an atomic context so we won't
@@ -44,21 +46,28 @@ static void __iomem *wdt_regs;
  */
 static void bcm2835_setup_restart(void)
 {
+	struct reset_hook hook;
+	void __iomem *wdt_regs;
 	struct device_node *np = of_find_compatible_node(NULL, NULL,
 						"brcm,bcm2835-pm-wdt");
 	if (WARN(!np, "unable to setup watchdog restart"))
 		return;
 
 	wdt_regs = of_iomap(np, 0);
-	WARN(!wdt_regs, "failed to remap watchdog regs");
+	if (WARN(!wdt_regs, "failed to remap watchdog regs"))
+		return;
+
+	reset_hook_init(&hook);
+	hook.restart = bcm2835_restart;
+	set_machine_reset(RESET_RESTART, &hook, wdt_regs);
+	hook.power_off = bcm2835_power_off;
+	set_machine_reset(RESET_POWER_OFF, &hook, wdt_regs);
 }
 
-static void bcm2835_restart(enum reboot_mode mode, const char *cmd)
+static void bcm2835_restart(void *dev, enum reboot_mode mode, const char *cmd)
 {
 	u32 val;
-
-	if (!wdt_regs)
-		return;
+	void __iomem *wdt_regs = dev;
 
 	/* use a timeout of 10 ticks (~150us) */
 	writel_relaxed(10 | PM_PASSWORD, wdt_regs + PM_WDOG);
@@ -76,9 +85,10 @@ static void bcm2835_restart(enum reboot_
  * indicate to bootcode.bin not to reboot, then most of the chip will be
  * powered off.
  */
-static void bcm2835_power_off(void)
+static void bcm2835_power_off(void *dev)
 {
 	u32 val;
+	void __iomem *wdt_regs = dev;
 
 	/*
 	 * We set the watchdog hard reset bit here to distinguish this reset
@@ -91,7 +101,7 @@ static void bcm2835_power_off(void)
 	writel_relaxed(val, wdt_regs + PM_RSTS);
 
 	/* Continue with normal reset mechanism */
-	bcm2835_restart(REBOOT_HARD, "");
+	bcm2835_restart(dev, REBOOT_HARD, "");
 }
 
 static struct map_desc io_map __initdata = {
@@ -111,9 +121,6 @@ static void __init bcm2835_init(void)
 	int ret;
 
 	bcm2835_setup_restart();
-	if (wdt_regs)
-		pm_power_off = bcm2835_power_off;
-
 	bcm2835_init_clocks();
 
 	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
@@ -135,6 +142,5 @@ DT_MACHINE_START(BCM2835, "BCM2835")
 	.handle_irq = bcm2835_handle_irq,
 	.init_machine = bcm2835_init,
 	.init_time = clocksource_of_init,
-	.restart = bcm2835_restart,
 	.dt_compat = bcm2835_compat
 MACHINE_END
