From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 08/11] ARM: u300: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:16 +0100
Message-ID: <20131031063000.361406973@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:44414 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab3JaGaH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:07 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1111195eak.8
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:06 -0700 (PDT)
Content-Disposition: inline; filename=arm-machine-reset-u300.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: u300 as provider of reset hooks.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/mach-u300/regulator.c |   23 ++++++++++++++---------
 drivers/regulator/Kconfig      |    1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

Index: b/drivers/regulator/Kconfig
===================================================================
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -106,6 +106,7 @@ config REGULATOR_AB3100
 	tristate "ST-Ericsson AB3100 Regulator functions"
 	depends on AB3100_CORE
 	default y if AB3100_CORE
+	select MACHINE_RESET
 	help
 	 These regulators correspond to functionality in the
 	 AB3100 analog baseband dealing with power regulators
Index: b/arch/arm/mach-u300/regulator.c
===================================================================
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/machine_reset.h>
 
 /* Power Management Control 16bit (R/W) */
 #define U300_SYSCON_PMCR					(0x50)
@@ -24,20 +25,14 @@
 #define U300_SYSCON_PMCR_PWR_MGNT_ENABLE			(0x0001)
 
 /*
- * Regulators that power the board and chip and which are
- * not copuled to specific drivers are hogged in these
- * instances.
- */
-static struct regulator *main_power_15;
-
-/*
  * This function is used from pm.h to shut down the system by
  * resetting all regulators in turn and then disable regulator
  * LDO D (main power).
  */
-void u300_pm_poweroff(void)
+void u300_pm_poweroff(void *dev)
 {
 	sigset_t old, all;
+	struct regulator *main_power_15 = dev;
 
 	sigfillset(&all);
 	if (!sigprocmask(SIG_BLOCK, &all, &old)) {
@@ -51,6 +46,11 @@ void u300_pm_poweroff(void)
 	return;
 }
 
+static void u300_reset_hook_release(void *dev)
+{
+	regulator_put(dev);
+}
+
 /*
  * Hog the regulators needed to power up the board.
  */
@@ -58,7 +58,9 @@ static int __init __u300_init_boardpower
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *syscon_np;
+	struct regulator *main_power_15;
 	struct regmap *regmap;
+	struct reset_hook hook;
 	int err;
 
 	pr_info("U300: setting up board power\n");
@@ -98,7 +100,10 @@ static int __init __u300_init_boardpower
 			   U300_SYSCON_PMCR_DCON_ENABLE, 0);
 
 	/* Register globally exported PM poweroff hook */
-	pm_power_off = u300_pm_poweroff;
+	reset_hook_init(&hook);
+	hook.power_off = u300_pm_poweroff;
+	hook.release = u300_reset_hook_release;
+	set_machine_reset(RESET_POWER_OFF, &hook, main_power_15);
 
 	return 0;
 }
