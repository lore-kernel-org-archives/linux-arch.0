From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 30/35] net: faraday add nds32 support.
Date: Mon, 27 Nov 2017 20:28:17 +0800
Message-ID: <1aa759dbbb1032dd20e5fadbb0ce5aa4b8b22690.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
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
