From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 09/11] ARM: tps65910: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:17 +0100
Message-ID: <20131031063000.608298078@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:55835 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3JaGaK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:10 -0400
Received: by mail-ee0-f53.google.com with SMTP id e51so1112664eek.40
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:09 -0700 (PDT)
Content-Disposition: inline; filename=tps65910-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: tps65910 as provider of reset hooks.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 drivers/mfd/Kconfig    |    1 +
 drivers/mfd/tps65910.c |   16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

Index: b/drivers/mfd/Kconfig
===================================================================
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -769,6 +769,7 @@ config TPS65010
 	tristate "TI TPS6501x Power Management chips"
 	depends on I2C && GPIOLIB
 	default y if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_OSK
+	select MACHINE_RESET
 	help
 	  If you say yes here you get support for the TPS6501x series of
 	  Power Management chips.  These include voltage regulators,
Index: b/drivers/mfd/tps65910.c
===================================================================
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -26,6 +26,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of_device.h>
+#include <linux/machine_reset.h>
 
 static struct resource rtc_resources[] = {
 	{
@@ -438,12 +439,9 @@ struct tps65910_board *tps65910_parse_dt
 }
 #endif
 
-static struct i2c_client *tps65910_i2c_client;
-static void tps65910_power_off(void)
+static void tps65910_power_off(void *dev)
 {
-	struct tps65910 *tps65910;
-
-	tps65910 = dev_get_drvdata(&tps65910_i2c_client->dev);
+	struct tps65910 *tps65910 = dev_get_drvdata(dev);
 
 	if (tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 			DEVCTRL_PWR_OFF_MASK) < 0)
@@ -501,9 +499,11 @@ static int tps65910_i2c_probe(struct i2c
 	tps65910_ck32k_init(tps65910, pmic_plat_data);
 	tps65910_sleepinit(tps65910, pmic_plat_data);
 
-	if (pmic_plat_data->pm_off && !pm_power_off) {
-		tps65910_i2c_client = i2c;
-		pm_power_off = tps65910_power_off;
+	if (pmic_plat_data->pm_off) {
+		struct reset_hook hook;
+		reset_hook_init(&hook);
+		hook.power_off = tps65910_power_off;
+		set_machine_reset(RESET_POWER_OFF, &hook, &i2c->dev);
 	}
 
 	ret = mfd_add_devices(tps65910->dev, -1,
