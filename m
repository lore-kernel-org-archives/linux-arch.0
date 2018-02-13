From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 31/37] MAINTAINERS: Add nds32
Date: Tue, 13 Feb 2018 17:09:35 +0800
Message-ID: <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Add a maintainer information for the nds32(Andes) architecture.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..bf7c2ac6bb5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -868,6 +868,17 @@ X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
+ANDES ARCHITECTURE
+M:	Greentime Hu <green.hu@gmail.com>
+M:	Vincent Chen <deanbo422@gmail.com>
+T:	git https://github.com/andestech/linux.git
+S:	Supported
+F:	arch/nds32
+F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
+F:	Documentation/devicetree/bindings/nds32
+K:	nds32
+N:	nds32
+
 ANDROID CONFIG FRAGMENTS
 M:	Rob Herring <robh@kernel.org>
 S:	Supported
-- 
2.16.1
