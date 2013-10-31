From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 10/11] max8907: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:18 +0100
Message-ID: <20131031063000.859976312@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:44352 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab3JaGaK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:10 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so1130133eae.38
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:08 -0700 (PDT)
Content-Disposition: inline; filename=max8907-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: max8907 as provider of reset hooks.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 drivers/mfd/Kconfig   |    1 +
 drivers/mfd/max8907.c |   13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

Index: b/drivers/mfd/Kconfig
===================================================================
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -339,6 +339,7 @@ config MFD_MAX8907
 	tristate "Maxim Semiconductor MAX8907 PMIC Support"
 	select MFD_CORE
 	depends on I2C=y
+	select MACHINE_RESET
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	help
Index: b/drivers/mfd/max8907.c
===================================================================
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/machine_reset.h>
 
 static struct mfd_cell max8907_cells[] = {
 	{ .name = "max8907-regulator", },
@@ -176,9 +177,9 @@ static const struct regmap_irq_chip max8
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
-static struct max8907 *max8907_pm_off;
-static void max8907_power_off(void)
+static void max8907_power_off(void *dev)
 {
+	struct max8907 *max8907_pm_off = dev;
 	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CNFG,
 			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
 }
@@ -266,9 +267,11 @@ static int max8907_i2c_probe(struct i2c_
 		goto err_add_devices;
 	}
 
-	if (pm_off && !pm_power_off) {
-		max8907_pm_off = max8907;
-		pm_power_off = max8907_power_off;
+	if (pm_off) {
+		struct reset_hook hook;
+		reset_hook_init(&hook);
+		hook.power_off = max8907_power_off;
+		set_machine_reset(RESET_POWER_OFF, &hook, max8907);
 	}
 
 	return 0;
