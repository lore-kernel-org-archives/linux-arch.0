From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 06/11] ARM: vexpress: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:14 +0100
Message-ID: <20131031062959.813485972@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:63869 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab3JaGaQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:16 -0400
Received: by mail-ea0-f175.google.com with SMTP id l15so938785eak.34
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:15 -0700 (PDT)
Content-Disposition: inline; filename=arm-machine-reset-vexpress-hooks.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: vexpress as provider of reset hooks.

Platform hooks implementation.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 drivers/power/reset/Kconfig             |    1 +
 drivers/power/reset/vexpress-poweroff.c |   54 +++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 16 deletions(-)

Index: b/drivers/power/reset/Kconfig
===================================================================
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -41,6 +41,7 @@ config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
 	depends on POWER_RESET && VEXPRESS_CONFIG
+	select MACHINE_RESET
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
 	  Express boards.
Index: b/drivers/power/reset/vexpress-poweroff.c
===================================================================
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -19,7 +19,8 @@
 #include <linux/vexpress.h>
 #include <linux/machine_reset.h>
 
-#include <asm/system_misc.h>
+static enum reset_func vexpress_get_func(struct platform_device *pdev);
+static int vexpress_set_hook(struct platform_device *pdev);
 
 static void vexpress_reset_do(struct device *dev, const char *what)
 {
@@ -40,34 +41,40 @@ static void vexpress_reset_do(struct dev
 	dev_emerg(dev, "Unable to %s (%d)\n", what, err);
 }
 
-static struct device *vexpress_power_off_device;
-
-static void vexpress_power_off(void)
+static void vexpress_power_off(void *dev)
 {
-	vexpress_reset_do(vexpress_power_off_device, "power off");
+	vexpress_reset_do(dev, "power off");
 }
 
-static struct device *vexpress_restart_device;
-
-static void vexpress_restart(enum reboot_mode reboot_mode, const char *cmd)
+static void vexpress_restart(void *dev, enum reboot_mode reboot_mode,
+	const char *cmd)
 {
-	vexpress_reset_do(vexpress_restart_device, "restart");
+	vexpress_reset_do(dev, "restart");
 }
 
 static ssize_t vexpress_reset_active_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", vexpress_restart_device == dev);
+	struct platform_device *pdev;
+	enum reset_func func;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	func = vexpress_get_func(pdev);
+
+	return sprintf(buf, "%d\n", isset_machine_reset(func, dev));
 }
 
 static ssize_t vexpress_reset_active_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	long value;
+	struct platform_device *pdev;
 	int err = kstrtol(buf, 0, &value);
 
+	pdev = container_of(dev, struct platform_device, dev);
+
 	if (!err && value)
-		vexpress_restart_device = dev;
+		vexpress_set_hook(pdev);
 
 	return err ? err : count;
 }
@@ -90,7 +97,7 @@ static struct of_device_id vexpress_rese
 	{}
 };
 
-static int vexpress_reset_probe(struct platform_device *pdev)
+static enum reset_func vexpress_get_func(struct platform_device *pdev)
 {
 	enum reset_func func;
 	const struct of_device_id *match =
@@ -101,23 +108,38 @@ static int vexpress_reset_probe(struct p
 	else
 		func = pdev->id_entry->driver_data;
 
+	return func;
+}
+
+static int vexpress_set_hook(struct platform_device *pdev)
+{
+	enum reset_func func;
+	struct reset_hook hook;
+
+	func = vexpress_get_func(pdev);
+	reset_hook_init(&hook);
+
 	switch (func) {
 	case RESET_POWER_OFF:
-		vexpress_power_off_device = &pdev->dev;
-		pm_power_off = vexpress_power_off;
+		hook.power_off = vexpress_power_off;
 		break;
 	case RESET_RESTART:
-		vexpress_restart_device = &pdev->dev;
-		arm_pm_restart = vexpress_restart;
+		hook.restart = vexpress_restart;
 		device_create_file(&pdev->dev, &dev_attr_active);
 		break;
 	default:
 		return -EINVAL;
 	};
 
+	set_machine_reset(func, &hook, &pdev->dev);
 	return 0;
 }
 
+static int vexpress_reset_probe(struct platform_device *pdev)
+{
+	return vexpress_set_hook(pdev);
+}
+
 static const struct platform_device_id vexpress_reset_id_table[] = {
 	{ .name = "vexpress-reset", .driver_data = RESET_RESTART, },
 	{ .name = "vexpress-shutdown", .driver_data = RESET_POWER_OFF, },
