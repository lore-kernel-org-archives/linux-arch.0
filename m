From: Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 04/11] MIPS: use the common machine reset handling
Date: Thu, 31 Oct 2013 07:27:12 +0100
Message-ID: <20131031062959.169063871@linux.com>
References: <20131031062708.520968323@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51566 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab3JaGaG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:30:06 -0400
Received: by mail-ee0-f49.google.com with SMTP id e52so1102249eek.36
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2013 23:30:05 -0700 (PDT)
Content-Disposition: inline; filename=mips-machine-reset.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>, Domenico Andreoli <domenico.andreoli@linux.com>

From: Domenico Andreoli <domenico.andreoli@linux.com>

Proof of concept: MIPS as a consumer of the machine reset hooks.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/mips/kernel/reset.c |    7 +++++++
 kernel/power/Kconfig     |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

Index: b/arch/mips/kernel/reset.c
===================================================================
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <linux/types.h>
 #include <linux/reboot.h>
+#include <linux/machine_reset.h>
 
 #include <asm/reboot.h>
 
@@ -29,16 +30,22 @@ void machine_restart(char *command)
 {
 	if (_machine_restart)
 		_machine_restart(command);
+	else
+		default_restart(reboot_mode, command);
 }
 
 void machine_halt(void)
 {
 	if (_machine_halt)
 		_machine_halt();
+	else
+		default_halt();
 }
 
 void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		default_power_off();
 }
Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -297,4 +297,4 @@ config CPU_PM
 config MACHINE_RESET
 	bool
 	default n
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || MIPS
