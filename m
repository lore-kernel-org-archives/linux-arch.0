From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 03/11] ARM64: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:11 +0100
Message-ID: <20131031062958.848317356@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:61448 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3JaGaE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:04 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so1153915eaj.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:02 -0700 (PDT)
Content-Disposition: inline; filename=arm64-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: ARM64 as a consumer of the machine reset hooks.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm64/kernel/process.c |    5 +++++
 kernel/power/Kconfig        |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -297,4 +297,4 @@ config CPU_PM
 config MACHINE_RESET
 	bool
 	default n
-	depends on ARM
+	depends on ARM || ARM64
Index: b/arch/arm64/kernel/process.c
===================================================================
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/user.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/machine_reset.h>
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
 #include <linux/init.h>
@@ -120,6 +121,8 @@ void machine_power_off(void)
 	machine_shutdown();
 	if (pm_power_off)
 		pm_power_off();
+	else
+		default_power_off();
 }
 
 void machine_restart(char *cmd)
@@ -133,6 +136,8 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		default_restart(reboot_mode, cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
