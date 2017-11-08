From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 31/31] net: faraday add nds32 support.
Date: Wed,  8 Nov 2017 13:55:19 +0800
Message-ID: <20c6d5d39d49397d2e7ba597072495ae1c7a816f.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/net/ethernet/faraday/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 040c7f1..0ae6e9a 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM
+	depends on ARM || NDS32
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -18,7 +18,7 @@ if NET_VENDOR_FARADAY
 
 config FTMAC100
 	tristate "Faraday FTMAC100 10/100 Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32
 	select MII
 	---help---
 	  This driver supports the FTMAC100 10/100 Ethernet controller
@@ -27,7 +27,7 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32
 	select PHYLIB
 	---help---
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-- 
1.7.9.5
