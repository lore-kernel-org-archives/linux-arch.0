From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 02/11] ARM: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:10 +0100
Message-ID: <20131031062958.576361964@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:39803 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3JaGaF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:05 -0400
Received: by mail-ea0-f171.google.com with SMTP id h10so1139042eak.16
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:03 -0700 (PDT)
Content-Disposition: inline; filename=arm-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Will Deacon <will.deacon@arm.com>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: ARM as a consumer of the machine reset hooks.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/kernel/process.c |   14 ++++++++------
 kernel/power/Kconfig      |    1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

Index: b/arch/arm/kernel/process.c
===================================================================
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -33,6 +33,7 @@
 #include <linux/cpuidle.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
+#include <linux/machine_reset.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
@@ -114,17 +115,13 @@ void soft_restart(unsigned long addr)
 	BUG();
 }
 
-static void null_restart(enum reboot_mode reboot_mode, const char *cmd)
-{
-}
-
 /*
  * Function pointers to optional machine specific functions
  */
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd) = null_restart;
+void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
 /*
@@ -217,6 +214,8 @@ void machine_power_off(void)
 
 	if (pm_power_off)
 		pm_power_off();
+	else
+		default_power_off();
 }
 
 /*
@@ -235,7 +234,10 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	arm_pm_restart(reboot_mode, cmd);
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+	else
+		default_restart(reboot_mode, cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -297,3 +297,4 @@ config CPU_PM
 config MACHINE_RESET
 	bool
 	default n
+	depends on ARM
