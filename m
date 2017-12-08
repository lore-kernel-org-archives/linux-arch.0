From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 33/33] net: faraday add nds32 support.
Date: Fri,  8 Dec 2017 17:12:16 +0800
Message-ID: <67c8b321ea628cded53b7205de3f17f16dcfc3ce.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36449 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbdLHJkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 04:40:00 -0500
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: green.hu@gmail.com

From: Greentime Hu <greentime@andestech.com>

This patch is used to support nds32 architecture to use these faraday
mac IP.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/net/ethernet/faraday/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 040c7f1..1bdaffc 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -18,7 +18,7 @@ if NET_VENDOR_FARADAY
 
 config FTMAC100
 	tristate "Faraday FTMAC100 10/100 Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
 	select MII
 	---help---
 	  This driver supports the FTMAC100 10/100 Ethernet controller
@@ -27,7 +27,7 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
 	select PHYLIB
 	---help---
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-- 
1.7.9.5
