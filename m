From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech atcpit100 timer
Date: Mon, 27 Nov 2017 20:28:21 +0800
Message-ID: <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44465 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdK0MzX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 07:55:23 -0500
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: Rick Chen <rickchen36@gmail.com>, green.hu@gmail.com

From: Rick Chen <rickchen36@gmail.com>

Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
It often be used in Andestech AE3XX platform.

Signed-off-by: Rick Chen <rickchen36@gmail.com>
Signed-off-by: Greentime Hu <green.hu@gmail.com>
---
 drivers/clocksource/Kconfig  |    6 ++++++
 drivers/clocksource/Makefile |    1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cc60620..591362a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -615,4 +615,10 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config CLKSRC_ATCPIT100
+	bool "Clocksource for AE3XX platform" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
+	help
+	  This option enables support for the Andestech AE3XX platform timers.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 72711f1..7d072f5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -75,3 +75,4 @@ obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
+obj-$(CONFIG_CLKSRC_ATCPIT100)		+= timer-atcpit100.o
-- 
1.7.9.5
