Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36748 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeAOF45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 00:56:57 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 36/36] net: faraday add nds32 support.
Date: Mon, 15 Jan 2018 13:53:44 +0800
Message-ID: <74b1aceeb4a8718657cb60e717b7108783f3241f.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
Message-ID: <20180115055344._ePYLjoA697ek37Jzl59j89y1e_dsNkh2YsEuvtPeQ0@z>

From: Greentime Hu <greentime@andestech.com>

This patch is used to support nds32 architecture to use these faraday
mac IP.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/net/ethernet/faraday/Kconfig |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 040c7f1..0fb8df6 100644
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
 
@@ -18,7 +18,8 @@ if NET_VENDOR_FARADAY
 
 config FTMAC100
 	tristate "Faraday FTMAC100 10/100 Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
+	depends on !64BIT || BROKEN
 	select MII
 	---help---
 	  This driver supports the FTMAC100 10/100 Ethernet controller
@@ -27,7 +28,8 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
+	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-- 
1.7.9.5
