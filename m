From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 11/11] ARM: sp805: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:19 +0100
Message-ID: <20131031063001.088351233@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:58102 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab3JaGaL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:11 -0400
Received: by mail-ee0-f45.google.com with SMTP id e50so1113058eek.4
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:10 -0700 (PDT)
Content-Disposition: inline; filename=sp805-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Wim Van Sebroeck <wim@iguana.be>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: sp805 as provider of reset hooks.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 drivers/watchdog/Kconfig     |    9 ++++++++
 drivers/watchdog/sp805_wdt.c |   48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

Index: b/drivers/watchdog/Kconfig
===================================================================
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -110,11 +110,20 @@ config WM8350_WATCHDOG
 config ARM_SP805_WATCHDOG
 	tristate "ARM SP805 Watchdog"
 	depends on ARM && ARM_AMBA
+	select MACHINE_RESET
 	select WATCHDOG_CORE
 	help
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
 	  the timeout is reached.
 
+config ARM_SP805_WATCHDOG_RESTART_HOOK
+	bool "ARM SP805 system restart hook"
+	depends on ARM_SP805_WATCHDOG
+	help
+	  Register hook to reboot the system based on the SP805 Watchdog.
+
+	  This can be overriden with cmdline option restart_hook=0.
+
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on ARCH_AT91RM9200
Index: b/drivers/watchdog/sp805_wdt.c
===================================================================
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -28,6 +28,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
+#include <linux/machine_reset.h>
+#include <linux/delay.h>
 
 /* default timeout in seconds */
 #define DEFAULT_TIMEOUT		60
@@ -77,6 +79,11 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Set to 1 to keep watchdog running after device release");
 
+static bool restart_hook = IS_ENABLED(CONFIG_ARM_SP805_WATCHDOG_RESTART_HOOK);
+module_param(restart_hook, bool, 0);
+MODULE_PARM_DESC(restart_hook,
+		"Set to 1 to install a machine restart handler based on this watchdog");
+
 /* This routine finds load value that will reset system in required timout */
 static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
@@ -189,6 +196,33 @@ static int wdt_disable(struct watchdog_d
 	return 0;
 }
 
+/* trigger watchdog timer */
+static void wdt_atomic_trigger(struct watchdog_device *wdd)
+{
+	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	spin_lock(&wdt->lock);
+
+	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
+	writel_relaxed(0, wdt->base + WDTCONTROL);
+	udelay(20);
+	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
+	udelay(20);
+
+	/* Expire after 5 cycles */
+	writel_relaxed(5, wdt->base + WDTLOAD);
+
+	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
+	writel_relaxed(LOCK, wdt->base + WDTLOCK);
+
+	/* Flush posted writes. */
+	readl_relaxed(wdt->base + WDTLOCK);
+	spin_unlock(&wdt->lock);
+
+	/* Wait the bite */
+	udelay(400);
+}
+
 static const struct watchdog_info wdt_info = {
 	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = MODULE_NAME,
@@ -201,8 +235,15 @@ static const struct watchdog_ops wdt_ops
 	.ping		= wdt_ping,
 	.set_timeout	= wdt_setload,
 	.get_timeleft	= wdt_timeleft,
+/*	.atomic_trigger	= wdt_atomic_trigger, */
 };
 
+static void sp805_wdt_machine_restart(void *wdd, enum reboot_mode mode,
+	const char *cmd)
+{
+	wdt_atomic_trigger(wdd);
+}
+
 static int
 sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -247,6 +288,13 @@ sp805_wdt_probe(struct amba_device *adev
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 	wdt_setload(&wdt->wdd, DEFAULT_TIMEOUT);
 
+	if (restart_hook) {
+		struct reset_hook hook;
+		reset_hook_init(&hook);
+		hook.restart = sp805_wdt_machine_restart;
+		set_machine_reset(RESET_RESTART, &hook, &wdt->wdd);
+	}
+
 	ret = watchdog_register_device(&wdt->wdd);
 	if (ret) {
 		dev_err(&adev->dev, "watchdog_register_device() failed: %d\n",
