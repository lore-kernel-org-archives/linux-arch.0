From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 05/11] ARM: vexpress: consolidate machine reset func
Date: Thu, 31 Oct 2013 07:27:13 +0100
Message-ID: <20131031062959.454193773@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:40224 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab3JaGaG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:06 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so1146035eaj.27
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:05 -0700 (PDT)
Content-Disposition: inline; filename=arm-machine-reset-vexpress-enum.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: vexpress as provider of reset hooks.

Enum consolidation.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 drivers/power/reset/vexpress-poweroff.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

Index: b/drivers/power/reset/vexpress-poweroff.c
===================================================================
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/stat.h>
 #include <linux/vexpress.h>
+#include <linux/machine_reset.h>
 
 #include <asm/system_misc.h>
 
@@ -75,58 +76,52 @@ DEVICE_ATTR(active, S_IRUGO | S_IWUSR, v
 		vexpress_reset_active_store);
 
 
-enum vexpress_reset_func { FUNC_RESET, FUNC_SHUTDOWN, FUNC_REBOOT };
-
 static struct of_device_id vexpress_reset_of_match[] = {
 	{
 		.compatible = "arm,vexpress-reset",
-		.data = (void *)FUNC_RESET,
+		.data = (void *) RESET_RESTART,
 	}, {
 		.compatible = "arm,vexpress-shutdown",
-		.data = (void *)FUNC_SHUTDOWN
+		.data = (void *) RESET_POWER_OFF,
 	}, {
 		.compatible = "arm,vexpress-reboot",
-		.data = (void *)FUNC_REBOOT
+		.data = (void *) RESET_RESTART,
 	},
 	{}
 };
 
 static int vexpress_reset_probe(struct platform_device *pdev)
 {
-	enum vexpress_reset_func func;
+	enum reset_func func;
 	const struct of_device_id *match =
 			of_match_device(vexpress_reset_of_match, &pdev->dev);
 
 	if (match)
-		func = (enum vexpress_reset_func)match->data;
+		func = (enum reset_func) match->data;
 	else
 		func = pdev->id_entry->driver_data;
 
 	switch (func) {
-	case FUNC_SHUTDOWN:
+	case RESET_POWER_OFF:
 		vexpress_power_off_device = &pdev->dev;
 		pm_power_off = vexpress_power_off;
 		break;
-	case FUNC_RESET:
-		if (!vexpress_restart_device)
-			vexpress_restart_device = &pdev->dev;
-		arm_pm_restart = vexpress_restart;
-		device_create_file(&pdev->dev, &dev_attr_active);
-		break;
-	case FUNC_REBOOT:
+	case RESET_RESTART:
 		vexpress_restart_device = &pdev->dev;
 		arm_pm_restart = vexpress_restart;
 		device_create_file(&pdev->dev, &dev_attr_active);
 		break;
+	default:
+		return -EINVAL;
 	};
 
 	return 0;
 }
 
 static const struct platform_device_id vexpress_reset_id_table[] = {
-	{ .name = "vexpress-reset", .driver_data = FUNC_RESET, },
-	{ .name = "vexpress-shutdown", .driver_data = FUNC_SHUTDOWN, },
-	{ .name = "vexpress-reboot", .driver_data = FUNC_REBOOT, },
+	{ .name = "vexpress-reset", .driver_data = RESET_RESTART, },
+	{ .name = "vexpress-shutdown", .driver_data = RESET_POWER_OFF, },
+	{ .name = "vexpress-reboot", .driver_data = RESET_RESTART, },
 	{}
 };
 
